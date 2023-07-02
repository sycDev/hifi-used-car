# HiFi-Used-Car

Hi-Fi Used Car Sales Portal is a Java application developed using the [Spring Boot 2.7.12](https://spring.io/guides/gs/spring-boot) framework and built using [Maven](https://spring.io/guides/gs/maven).

## Features

There are two roles: User & Administrator
> **Note**
> User accounts are registered through the signup page that is open for anyone, while Administrator accounts are registered through the Admin Dashboard.

---

#### User Module
- [x] Registration (User & Administrator) [Both]
  - [ ] Confirmation email upon registration
- [ ] Forgot Password [Both]
- [x] Authentication & Authorization
- [x] View list of registered users [Admin]
- [ ] View Public Profile (Listing History & Bid History) [Both]
- [ ] Update Profile [Both]
  - [ ] Change username
  - [ ] Change password
  - [ ] Upload profile picture
- [x] Delete user account [Admin]
  - [ ] Deactivate user account [Admin]
- [X] Make a user as Administrator [Admin]

---

#### Car Posting Module
- [x] Post car for sale with picture upload [User]
  - [ ] Multiple images upload
  - [ ] Admin approval before post listing
- [x] Search for cars by Make, Model [Both]
- [ ] Filter car by Registration Year & Price Range [Both]
- [ ] Sorting for ongoing auction
  - [x] By 'Ending Soon'
  - [ ] By 'Newly Listed'
  - [ ] By 'Lowest Mileage'
- [ ] Sorting for past auction
  - [x] By 'Recently Ended'
  - [ ] By 'Lowest Mileage'
  - [ ] By 'Highest Mileage'
  - [ ] By 'Lowest Bid'
  - [ ] BY 'Highest Bid'
- [x] View car information [Both]
- [x] Activate/Deactivate car sale (Hide public visibility) [User]
- [ ] Extending car sale that not having the status 'Sold'

---

#### Bidding Module
- [x] Place a bid [User]
- [x] Keep track of the latest highest bid [Both]

---

#### Admin Module [Admin]
- [x] View all bid records
  - [ ] Filter by listing
- [ ] Transact the sales that having winner
- [ ] Update listing status to 'Sold'
- [x] View all listing records
- [x] Activate/Deactivate listing (Hide public visibility)
- [ ] Statistics & Reporting
  - [x] Total number of users registered, listings & bid
  - [ ] Daily Summary on bidding & sales

---

### Coming Soon

#### Appointment Module
- [ ] Place test drive appointment booking [User]
- [ ] Approve or deny appointments [Admin]

---

#### Notification Module
- [ ] Notify for own listings having new bid
- [ ] Reminder for own listing ending soon or ended
- [ ] Reminder for listing that placed bid ending soon or ended
- [ ] Notify if the bid placed is not in the highest ranking
- [ ] Bidding result via notification and email <br>
      (Winner gets the instructions for payment or necessary paperwork)
- [ ] Able to watch a listing by save it as favourite

---

#### Social Module
- [ ] QnA section with seller
- [ ] Comment section for each listing
- [ ] Chat system among users

---

#### Payment Module
- [ ] Transact sales in the system

---

## Pages

### Public

- Home
- About Us
- Contact Us
- Sign Up
- Login
- Terms of Use
- Privacy Policy

### Protected

- Sell Car
- Car Listing
  * Ongoing Auction
  * Past Auction
  * My Listings
- Search Cars
  * Search by Make & Model
  * Filter by Registration Year Range and Price Range
- Car Details & Place Bid
- Profile Page (Listing History, Bid History)
- Update Profile

#### Admin Access Only

- Manage Users
  * Register Admin Account
  * Edit User (Assign role & Change username)
  * Delete User
- Manage Listings
  * Activate/Deactivate existing listing
  * Transact Sales
- Manage Bids
  * Filter by listing

---

## Prerequisites:

- Java 8 or higher
- MySQL

---

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

---

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
<br>
The database SQL script is located under the directory `src/main/resources/sql`.

#### Physical Model Database Design

![image](https://github.com/sycDev/hifi-used-car/assets/33170649/94a4b712-6333-443d-bb8a-b39b8eb9f492)
