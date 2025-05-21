# VetTrack - Sistema Web para Gestión de Mascotas

Este proyecto es una aplicación web Java que permite registrar y listar mascotas usando una arquitectura en 3 capas: presentación (JSP + API), lógica (servicios Java) y datos (MySQL).
---
La aplicación VetTrack fue estructurada utilizando una arquitectura en tres capas claramente separadas para garantizar un desarrollo modular y mantenible. La capa de presentación está compuesta por páginas JSP que interactúan con el usuario final y presentan la información mediante HTML y Bootstrap. La capa lógica se encarga del procesamiento de datos y la comunicación entre la interfaz y la base de datos, implementada mediante clases Java que manejan la lógica del negocio. Finalmente, la capa de datos está formada por clases DAO (como MascotaDAO) que realizan las operaciones directamente sobre la base de datos MySQL a través de JDBC, asegurando así una separación de responsabilidades y facilitando la escalabilidad de la aplicación.
---

## ⚙️ Tecnologías Utilizadas

- Java 21 (OpenJDK - Adoptium)
- Apache Tomcat 11
- JSP + Bootstrap 5
- MySQL 8
- JDBC (MySQL Connector)
- NetBeans con Ant

---

## 🚀 Despliegue en Servidor Ubuntu (EC2)

### 1. 📦 Requisitos previos

- Instancia EC2 con Ubuntu 22.04+
- Puerto 8080 y 4503 abiertos en el grupo de seguridad
- Base de datos MySQL accesible remotamente

---

### 2. 🧰 Instalar OpenJDK 21

```bash
cd /opt
wget https://github.com/adoptium/temurin21-binaries/releases/download/jdk-21.0.7%2B6/OpenJDK21U-jdk_x64_linux_hotspot_21.0.7_6.tar.gz
tar -xvf OpenJDK21U-jdk_x64_linux_hotspot_21.0.7_6.tar.gz
sudo mv jdk-21.0.7+6 /opt/openjdk-21
export JAVA_HOME=/opt/openjdk-21
export PATH=$JAVA_HOME/bin:$PATH
source ~/.bashrc
java -version
```

---

### 3. 🐱 Instalar Apache Tomcat 11

```bash
cd /opt
sudo wget https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.7/bin/apache-tomcat-11.0.7.tar.gz
sudo tar -xvzf apache-tomcat-11.0.7.tar.gz
sudo mv apache-tomcat-11.0.7 tomcat
sudo chmod +x /opt/tomcat/bin/*.sh
sudo nano /opt/tomcat/conf/tomcat-users.xml
```
```ini
<role rolename="manager-gui"/>
<role rolename="admin-gui"/>
<user username="admin" password="admin123" roles="manager-gui,admin-gui"/>
```
```bash
sudo nano /opt/tomcat/webapps/manager/META-INF/context.xml
```
```ini
<!--
<Valve className="org.apache.catalina.valves.RemoteAddrValve"
       allow="127\.\d+\.\d+\.\d+|::1"/>
-->
```
```bash
sudo systemctl restart tomcat.service
```

---

### 4. 🧩 Instalar el driver JDBC MySQL y GSON

```bash
wget https://cdn.mysql.com//Downloads/Connector-J/mysql-connector-j-9.3.0.zip
sudo apt install unzip 
unzip mysql-connector-j-9.3.0.zip
sudo cp mysql-connector-j-9.3.0/mysql-connector-j-9.3.0.jar /opt/tomcat/lib/
sudo wget https://repo1.maven.org/maven2/com/google/code/gson/gson/2.13.1/gson-2.13.1.jar
sudo cp gson-2.13.1.jar /opt/tomcat/lib/
```

---

### 5. ⚙️ Crear servicio para Tomcat

Archivo: `/etc/systemd/system/tomcat.service`

```bash
sudo nano /etc/systemd/system/tomcat.servic
```

```ini
[Unit]
Description=Apache Tomcat 11 Web Application Container
After=network.target

[Service]
Type=forking

Environment=JAVA_HOME=/opt/openjdk-21
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh


[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl start tomcat.service
```

---

### 6. 📁 Subir la aplicación

Sube tu archivo `.war` generado por NetBeans a:

```bash
sudo cp VetTrack.war /opt/tomcat/webapps/
```

Luego accede desde:

```
http://44.202.127.132:8080/VetTrack/
```

---

## 🚀 Despliegue en Servidor Ubuntu (EC2)

### 1. 🐬 Base de datos MySQL

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install mysql-server -y
sudo mysql_secure_installation
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
```
```ini
  port = 4503
  bind-address = 44.202.127.132
```
```bash
sudo systemctl restart mysql
sudo mysql

```
```sql
CREATE DATABASE vettrackdb;
USE vettrackdb;

CREATE TABLE mascotas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    dueno VARCHAR(100)
);

CREATE USER 'vetuser'@'44.202.127.132' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON vettrackdb.* TO 'vetuser'@'%';
FLUSH PRIVILEGES;
```
```bash
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow from 44.202.127.132 to any port 4503 proto tcp
```
---

### 2. 🔄 Variables importantes de conexión

En `MascotaDAO.java`:

```java
private final String url = "jdbc:mysql://100.24.67.113:4503/vettrack?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
private final String user = "vetuser";
private final String password = "admin";
```

---

## ✅ Resultado

La aplicación permite:

- Registrar mascotas con nombre y dueño
- Listar mascotas registradas
- Interfaz HTML con Bootstrap y JSP

---

## 📌 Autor

Desarrollado por **Víctor Siguas** para el sistema **VetTrack**.
