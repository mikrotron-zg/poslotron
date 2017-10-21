# poslotron
Poslotron is Apache OfBiz localized by http://www.mikrotron.hr/ to language and laws of Republic of Croatia.

It includes a ecommerce visual theme named 'mikrotron', featured at http://www.diykits.eu/

By default, it uses PostgreSQL database.

QUICK START (linux)

1) createuser ofbiz

2) create database(s): 
- createdb ofbizdb -O ofbiz
- createdb ofbizolap -O ofbiz
- createdb ofbiztenant -O ofbiz

3) fetch the database driver:
./ant download-PG-JDBC

4) build it:
./ant build

5) configure database connection:
look up CHANGEME in ./framework/entity/config/entityengine.xml

6) load initial data:
./ant load-demo
OR
./ant load-seed

7) start:
./ant start

Access it by connecting to http://localhost:8080/catalog and logging in as admin with password ofbiz.
Access web shop on http://localhost:8080/

Before deployment, you will also need to modify framework/common/config/general.properties, framework/webapp/config/url.properties, and probably applications/accounting/config/payment.properties.
To reconfigure embeded Tomcat, edit ./framework/catalina/ofbiz-component.xml.

MORE TO COME!
