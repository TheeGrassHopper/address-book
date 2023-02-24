# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

## System dependencies
* Ruby version 2.5
* Rails version 6.1.7.2
* Psql
* Bcrypt
* BootStrap - Responsive
* Deployed to Heroku

## Database steps
* rails db:create
* rails db:migrate
* rails db:seed

## How to run the test suite
* rspec spec

## Features:
 * Models: Person, Address, Email, Phone Number, 
 - active record relationships in place,
 - Validations in place
 - Styling although not the prettiest.
  - authorization ['Admin', 'Guest], Admin: can create, edit, destroy, update, show, Guest: can show, index - Authorization validations in place with flashing errors.
  - `Homer` with `homer@simpsons.com` with a `Admin` role and a password of `123456789`
  - `Marge` with `marge@simpsons.com` with a `Guest` role and a password of `987654321`
  - authentication
  - Testing TBA
  - AJAX TBA
  - Application should also work as an API and accept / send requests / responses via JSON
  - - `get - /people` - `index`
  - - `get - people/10.json` - `show`
  - - `post PUT - people/10` - `create`
  - - `put - people/10` - `update`
  - - `delete - people/10` - `destroy`
  - - Request body of with update the whole resource through the uses of nested attributes in rails e.g
  ```
{ 
    "person": {
        "id": 10,
        "salutation": "Mr.",
        "first_name": "Timothy",
        "middle_name": "Quigley",
        "last_name": "Swift",
        "ssn": "711566710",
        "birth_date": "2023-02-16",
        "comment": "I am confound.",
        "emails_attributes": [
            {
                "id": 19,
                "email": "joye.wintheiser@cartwright-keebler.net",
                "comment": "Somebody told me it was frightening how much topsoil we are losing each year, but I told that story around the campfire and nobody got scared."
            },
            {
                "id": 20,
                "email": "stuart@satterfield.io",
                "comment": "Whenever you read a good book, it's like the author is right there, in the room talking to you, which is why I don't like to read good books."
            }
        ],
        "phone_numbers_attributes": [
            {
                "id": 19,
                "number": "975-934-5776 x37669",
                "comment": "Holy Taj Mahal"
            },
            {
                "id": 20,
                "number": "977-210-2315 x406",
                "comment": "Holy Hailstorm"
            },
            {
                "id": 21,
                "number": "(520) 305-8198",
                "comment": ""
            }
        ],
        "addresses_attributes": [
            {
                "id": 19,
                "street": "7195 Jay Gardens",
                "town": "Lake",
                "zip_code": "77066",
                "state": "Ohio",
                "country": "Canada"
            },
            {
                "id": 20,
                "street": "968 Lashonda Extension",
                "town": "South",
                "zip_code": "62652",
                "state": "Oklahoma",
                "country": "Germany"
            },
            {
                "id": 26,
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


