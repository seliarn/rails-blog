# Simple Blog example by Popov Serhii

This is my first posted Ruby on Rails project. I've tried to show how I would develop a blog using this framework.


For deploy this project you should do these steps:
1. Install Ruby (prefer 3.2.2 version) following guide https://www.ruby-lang.org/en/documentation/installation/
2. Install PostgreSQL following guide https://www.postgresql.org/download/
3. Install Node and NPM https://docs.npmjs.com/downloading-and-installing-node-js-and-npm
3. Create new user and database:

   `$ sudo -u postgres createuser <username>`

   `$ sudo -u postgres createdb <dbname>`

4. Setup connection to the DB server in config/database.yml
5. Execute migrations: 

    `db:migrate`
6. Build project:

`npm build`
7. Start the Rails server:

     `bin/rails server`
8. Open in your browser http://127.0.0.1:3000/