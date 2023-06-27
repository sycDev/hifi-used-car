# HiFi-Used-Car

Hi-Fi Used Car Sales Portal is a Java application developed using the [Spring Boot 2.7.12](https://spring.io/guides/gs/spring-boot) framework and built using [Maven](https://spring.io/guides/gs/maven).

## Features

There are two roles: User & Administrator

User Module
- [] Registration (User & Administrator) [Both]
- [] Authentication & Authorization
- [] View list of registered users [Admin]
- [] Update Profile [Both]
- [] Deactivate user account [Admin]
- [] Make a user as Administrator [Admin]

Car Posting Module
- [] Post car for sale with picture upload [User]
- [] Search for cars by Make, Model, Registration Year & Price Range [Both]
- [] View car information [Both]

Bidding Module
- [] Place a bid [User]
- [] Keep track of latest highest bid [Both]
- [] Deactivate car sale to lock the highest bid price (or automatically after end time) [Admin]

## Pages

Public
- Home
- About Us
- Contact Us
- Login
- Register

Protected
- Sell Car
- Car Listing
- Search Cars
- Car Detail & Bidding
- Profile Page (My Listing, Bid History)
- Update Profile

Admin Access Only
- Manage Users
- Manage Car Sale Post
- Manage Bidding

## Prerequisites:

- Java 8 or higher
- MySQL

## Running Locally

You can create a jar file of the application using Maven and run it from the command line.

```
git clone https://github.com/sycDev/hifi-used-car.git
cd hifi-used-car
./mvnw package
java -jar target/*.jar
```

To access the application, you can navigate to http://localhost:8080/ in your web browser.

Alternatively, you may execute it directly from Maven utilizing the Spring Boot Maven plugin. By doing so, any 
modifications made in the project will be immediately detected (compilation is necessary for changes made to Java 
source files, which is typically done using an IDE).

```
./mvnw spring-boot:run
```

## Database Configuration

The application uses MySQL as its primary database. You can configure the database connection properties in the 
`application.properties` file located in the `src/main/resources` directory:

```properties
# database
spring.datasource.url=jdbc:mysql://localhost:3306/db_hificars
spring.datasource.username=root
spring.datasource.password=admin
```

You can modify these properties to match your database configuration.

Note: Make sure you have MySQL installed and running on your machine before starting the application.
