# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you need to do before starting the application:

* Ruby version: 2.3.3
* Rails version: 5.2.3
* Install the required gems using "bundle install"
* Use "rails db:migrate" to create database
* Use "rails db:seed" to initialize the database with sample data
* Start the rails server

Brief idea about the Application:

* It is a Classified Website to sell items. This will be an online marketplace platform      where the users can show their items and sell it to the customers. Both buying and         selling will be occurred.

* Different user access control will be there like Admin, Regular users including (Buyers    and Sellers).

* The admin will be able to access the entire website by creating different categories of    markets for selling items or giving advertisement like Real Estate, Cars, Electronics,     Furniture, Books, Services etc.

* The admin can approve and reject the posts. Admin features should be under “/admin” path,  After admin’s approval of ratings / reviews then only it should be publicly visible, for   this feature you should save reference of admin user in approved_by column.

* The regular users will be able to post advertisements in free. For which they need to      fill up a form. A form will have the following fields like Ad Title, Select Category       (this will be a category drop-down made by admin), Ad Description, User Name, Phone        Number, City and then they will be able to submit the form.

* Also the user can create an account with Username, Email Id and Password. Once the         account will be created the user can post an ad, contact other users via message. The      user account will have message for internal communication with those users who respond     to the ad. There will be settings on the account to change the email and password. Also,   the users can login to the account via Google and Facebook authentication.

* The Homepage will show the search bar to find the ad, list of categories will be shown     over there and add a field for location.

* To post advertisements, the users can upload photos of the items. On the ad show page      the photos of the ad can be shown along with some thumbnail views.

* Elastic Search functionality needs to be implemented. Items can be searched based on the   filtrations like category, locations etc.

* Once the user will get any response to their ad, they will receive an email notification   with the customer details like Name, email id, location etc.