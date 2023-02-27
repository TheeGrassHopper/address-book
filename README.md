# README

This README would normally document whatever steps are necessary to get the
application up and running. I will also highlight some of the things I worked on.
- Remote deployment: [https://address-book.herokuapp.com/]
Things you may want to cover:

## System dependencies

- Ruby version 2.5
- Rails version 6.1.7.2
- Psql
- Bcrypt
- faker
- rubocop
- factory_bot_rails
- jquery-rails
- pry
- rspec-rails
- BootStrap - Responsive
- Deployed to Heroku

## Database steps

- rails db:create
- rails db:migrate
- rails db:seed

## How to run the test suite

- rspec spec

## How to run the app locally

- rails server
- `localhost:3000`

## Features:

- Models: User, Person, Address, Email, Phone Number.

* Active record relationship one to many.
* Validations in place. e.g on (email, ssn)
* Bootstrap styling in place although not the prettiest, responsive.
* Authorization: ['Admin', 'Guest] with flashing errors messages.
  - Admin: can create, edit, destroy, update, show, index
  - Guest: can show or index

* Authentication
  -  `Homer` with `homer@simpsons.com` with a `Admin` role and a password of `123456789`
  -  `Marge` with `marge@simpsons.com` with a `Guest` role and a password of `987654321`
  - Note a any wrong login credentials will flash appropriate error message.
* Testing `rspec spec` or `bundle exec rspec spec`
* AJAX
  - Due to my personal time constraint I was only able to implement two AJAX calls in `application.js` but the idea is the same.
  - `get - /people` - `index`
  - `post - /people` - `create`
* Application should also work as an API and accept / send requests / responses via JSON. I thought this could be achieved under one resource utilizing nested attributes.
  - Using Postman
  - `get - /people` - `index`
  - `get - people/10` - `show` need the `id:`
  - `post - /people` - `create`
  - `put - people/10` - `update` need the `id:` field in the body for updates
  - `delete - people/10` - `destroy`
  - people's controller accepts nested attributes in the request body  e.g

- `POST - /people`
Request Body: 
```
{
  "person": {
      "salutation": "Mr.",
      "first_name": "Timothy",
      "middle_name": "Quigley",
      "last_name": "Swift",
      "ssn": "711566710",
      "birth_date": "2023-02-16",
      "comment": "I am confound.",
      "emails_attributes": [
          {
            "email": "joye.wintheiser@cartwright-keebler.net",
            "comment": "Somebody told me it was frightening how much topsoil we are losing each year, but I told that story around the campfire and nobody got scared."
          },
          {
            "email": "stuart@satterfield.io",
            "comment": "Whenever you read a good book, it's like the author is right there, in the room talking to you, which is why I don't like to read good books."
          }
      ],
      "phone_numbers_attributes": [
          {
            "number": "975-934-5776 x37669",
            "comment": "Holy Taj Mahal"
          },
          {
            "number": "977-210-2315 x406",
            "comment": "Holy Hailstorm"
          },
          {
            "number": "(520) 305-8198",
            "comment": ""
          }
      ],
      "addresses_attributes": [
          {
            "street": "7195 Jay Gardens",
            "town": "Lake",
            "zip_code": "77066",
            "state": "Ohio",
            "country": "Canada"
          },
          {
            "street": "968 Lashonda Extension",
            "town": "South",
            "zip_code": "62652",
            "state": "Oklahoma",
            "country": "Germany"
          },
          {
            "street": "4802 Fort Moultrie Lane",
            "town": "AUSTIN",
            "zip_code": "78754",
            "state": "TX",
            "country": "USA"
          }
      ]
  }
}
```

I appreciate the opportunity and open to feedback. 
Best Regards,
Al    
