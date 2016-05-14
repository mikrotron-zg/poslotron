# poslotron
Poslotron is Apache OfBiz localized by http://www.mikrotron.hr/ to language and laws of Republic of Croatia.

It includes a ecommerce visual theme named 'mikrotron', featured at http://www.diykits.eu/

By default, it uses PostgreSQL database.

QUICK START (linux)

1) create user ofbiz

2) create database(s): 
- createdb ofbizdb -O ofbiz
- createdb ofbizolap -O ofbiz
- createdb ofbiztenant -O ofbiz

3) fetch the database driver:
./ant download-PG-JDBC

4) configure database connection:
look up CHANGEME in ./framework/entity/config/entityengine.xml

5) load initial data:
./ant load-demo
OR
./ant load-seed

6) start:
./ant start

Access it by connecting to localhost:8080/catalog and logging in as admin with password ofbiz.

MORE TO COME!