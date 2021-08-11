# README - Save Their Bacon

## The Problem
There are several animal sanctuaries around the world who allow people to sponsor one of their rescued animals, however, they all have their own individual website and provide little incentive to actually become a sponsor. 

## Why does this problem need solving?
To sponsor an animal, currently someone may have to visit several websites before finding an animal to sponsor. If it was easier and incentives were higher, then potentially more rescued animals around the world would have their living expenses covered. 
## Heroku Link
[View this App on Heroku](https://save-their-bacon.herokuapp.com/)
## Github Link
[View this App's Repo on Github](https://github.com/daniel-walters/save-their-bacon)
## Website Description
 * ### Purpose
    To provide a website that can connect animal sanctuaries with potential sponsors, while providing a platform to upload media that is exclusive to an animals sponsor.  

 * ### Functionality/Features
    * There are 2 types of users, Sponsors and Sanctuaries. A user can sign up as either from the landing page 
    * Only Sanctuaries can post an animal to the website, but only once their account is approved by and admin. 
    * An admin can do this through the admin dashboard once logged in. 
    * An admin can also create, edit and delete articles from the home page or when viewing an article.
    * Sponsors can immedietly sponsor an animal without approval, they can use the search feature on the All Animals page to find one.
    * After payment the sponsor has access to a chat with the sanctuary and media that can be uploaded by the sanctuary. This is accessible from the specific animals page which can be found on the all animals page or the sponsors or sanctuaries account page.

 * ### Sitemap
    ![Sitemap](/docs/stb-sitemap.png "Sitemap")
 * ### Screenshots
    * Landing Page
    ![Landing-Page](/docs/landing.png "Landing Page")
    * Home Page
    ![Home-Page](/docs/home.png "Home Page")
    * Admin Page
    ![Admin-Page](/docs/admin.png "Admin Page")
    * All Animals
    ![All-Animals-Page](/docs/animalall.png "All Animals Page")
    * Show Animal
    ![Show-Animal-Page](/docs/animalshow.png "Show Animal Page")
 * ### Target Audience
    Animal Sanctuaries and those interested in sponsoring an animal.
 * ### Tech Stack (e.g. html,css, deployment platform etc)
    * App Create with Ruby on Rails
    * Web Pages built with html.erb
    * Backend built with Ruby
    * CSS used for styling (Bootstrap 4)
    * Stripe for payments
    * js.erb used for Stripe Integration
    * Deployed on Heroku
    * Amazon S3 for photo storage
    * Devise for User Authentication
## User Stories
* As a Sanctuary I want to post my animals so they can be sponsored
* As an Admin I want to make posts to keep website users up to date
* As a Sponsor I want to be able to view photos of my sponsored animal to see how they're going
* As a Sponsor I want to be able to ask the owner of the animal questions so I know how the animal is doing
* As an Admin I want to make sure sanctuaries are legitimate before allowing them to post so nobody gets scammed
* As a Sponsor I want to filter through animals to find one I want to sponsor
* As a sanctuary I want to be able to upload photos of my animal to give the sponsor something in return
## Wireframes
![Wireframes](/docs/wireframe.png "Wireframes")
## Original ERD
![Original-ERD](/docs/erd.jpeg "ERD")
## High Level Components
* ### Pages Controller & Views  
   Takes care of most the authorization through before_actions and handle actions/views that aren't attached to a model. The controller also grabs data from the database to be viewed, e.g. A users animals on their account page and a list of articles on the home page.
   * #### Admin Features
      The Admin Dashboard allows admins to view all users signed up to the app. The admin can view and delete users, and approve users accounts.
   
* ### Payments Controller & Views
   The payments controller sets up a stripe session for the user and animal they want to sponsor. It then sends them to a successful purchase page. 
   
   * #### Webhook
      The webhook post request logic is handled in the payments controller. This is called whenever a payment is successful. It sets up a sponsorship model between the user and animal, and updates the animals sponsored status.
* ### Animals Controller & Views
   Controllers and views to do with handling CRUD operations for the animals model. 
   * #### Search Feature
      A search feature is implemented as part of the show all animals (index) page. The controller queries the animals model based on options selected in the view. The results are then presented to the user in the view. 
   * #### Media Attachments
      As an animal can have multiple image attachments, extra actions were set up to allow a user to add and delete specific images without having to edit the whole record.
* ### Articles Controller & Views
   Controller and views to do with handling CRUD operations for the articles model.
* ### Navbar Partial  
   The navbar partial contains logic to determine what links a user should be able to see and click on.
## Third Party Services
* Stripe for payment
* Amazon S3 for storage
* Devise for Authentication
* Bootstrap for Styling
## Models and their Active Record Associations
A User has exactly 1 adrress, which has exactly 1 state, which has exactly 1 country.

A user can optionally have many animals, sponsorships, and messages.

An animal is required to belong to a category, which can have 0 or many animals in it. 
An animal is required to have one owner (user).

A sponsorship is required to have 2 users - an owner and a sponsor, and 1 animal. A user can have as many sponsorships as they like, but an animal can only belong to one. 

A chat is created alongside every sponsorship, meaning a chat belongs to a sponsorship which can only ever have one chat. Chats can have many messages, and these messages are required to belong to only 1 chat and 1 user (the sender).

Articles are not dependant on any other model. In this app only admins have the ability to create an article so keeping track of who specifically wrote it is unimportant. For this reason Articles have no relationships with any other model.
## Database Relations
   ### Users
   * Store authentication provided by Devise
   * Has an enum which represents what role the User is, 0 = sponsor, 1 = sanctuary, 2 = admin.
   * Sanctuary accounts must be admin-approved so an approved boolean is also stored
   * A users address is kept track of via a foreign key to the addresses table.
   ### Addresses
   * Keeps track of street name, number, suburb and postcode
   * Foreign key to states table to avoid multipe entries for the same state
   ### States
   * Has state name and a foreign key to the countries table to avoid multiple entries for the same country.
   ### Countries
   * Just stores country name and id
   ### Animals
   * General information about the animal stored: name, year born, weight, species, a biography. 
   * Cost to sponsor the animal as well as a boolean to keep track of if the animal has been sponsored or not.
   * Foreign key 'owner_id' which links to the users table
   * Foreign key to the categories table
   ### Categories
   * Just stores category name and id
   ### Sponsorships
   * Stores a receipt url generated by Stripe
   * Foreign key to the animals table for the sponsored animal.
   * 2 Foreign keys to the users table, one for the owner and one for the sponsor
   ### Chats
   * Foreign key to the sponsorship the chat belongs to
   ### Messages
   * Foreign keys to the chat the message belongs to and the user who wrote the message.
   * A text vairable to store the body of the message
   ### Articles
   * Title of the article which will be displayed on the home page
   * body text of the article which would be displayed on the articles 'show' page
## Final Database Schema Design
![ERD](/docs/erdfinal.png "Final Schema")
In terms of the relations present in the original ERD, nothing changed and the implementation went smoothly. The project scope increased over time to include a messaging system and news articles which are represented in the final ERD.
## Task Management
   Task Management was handled through trello. Tasks were designated as part of the MVP, extra functionality, bug fixes, code refactors, or styling/page content. MVP tasks were prioritised over the rest.

   Screenshots:

   * Start(26/7): ![26/7](/docs/trello/start-26:7.png "26/7")
   * 27/7: ![27/7](/docs/trello/27:7.png "27/7")
   * 28/7: ![28/7](/docs/trello/28:7.png "28/7")
   * 1/8: ![1/8](/docs/trello/1:08.png "1/8")
   * 2/8: ![1/8](/docs/trello/2:8.png "2/8")
   * 8/8: ![8/8](/docs/trello/08:08.png "8/8")