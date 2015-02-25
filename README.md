# README

[![Build Status](https://travis-ci.org/craftninja/emily-and-luke.svg)](https://travis-ci.org/craftninja/emily-and-luke)

#### How the hex do you set this up?

* Fork, Clone, Bundle
* `$ rails s`
* Use rails console to add a admin (user)
* Manage guests, registries and photos as an admin user
* Non guests / users can see photos, registries
* Guests in the database will have access
  * RSVP for their entire family
  * Optionally add dietary restrictions for each family member
  * Add or update their Family address


#### Things to do:

* Have wedding details only accessible by Guests (move to rsvp contoller?)
* limit routes to ones needed
* ~~limit visibility of rsvp to invitees~~
* ~~secret code belongs to a family~~
* ~~add address~~, phone, email updater to rsvp form
* ~~add dietary restrictions to rsvp~~
* ~~if user is not found, error gracefully~~
* ~~if user uses RSVP index or any other controller, session[:secret_code] is null~~
* ~~session[:secret_code] is validated for every action EXCEPT index (and find_user) in the RSVP controller~~
* ~~page-header everywhere~~
* ~~make update dietary restrictions a button~~
* ~~Admin can log in and add families with family members~~
  * ~~differentiate between properly logged in admin and temp logged in rsvp-er~~
  * ~~admin logs in at /login, then has new navbar with guest management path available~~
  * also has access to all /photos, ~~/registries paths~~
