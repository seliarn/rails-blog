# Simple Blog example by Popov Serhii

This is my first posted Ruby on Rails project. I've tried to show how I would develop a blog using this framework.


For deploy this project you should do these steps:
1. Install Ruby (prefer 3.2.2 version) following guide https://www.ruby-lang.org/en/documentation/installation/
2. Install PostgreSQL following guide https://www.postgresql.org/download/
3. Install Node and NPM https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
4. Create new user and database:

   `$ sudo -u postgres createuser <username>`

   `$ sudo -u postgres createdb <dbname>`

5. Setup connection to the DB server in **config/database.yml**
6. Execute migrations: 

    `rails db:migrate`

7. Build project:

   `npm build`

8. Start the Rails server:

     `rails server`

9. Open in your browser http://127.0.0.1:3000/