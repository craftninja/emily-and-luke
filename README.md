# README

#### How the hex do you set this up?

* Fork, Clone, Bundle
* `$ rails s`
* Follow the pattern to create seeds for your entire invitee list


#### Things to do:

* limit routes to ones needed
* seed with invitee data
* ~~limit visibility of rsvp to invitees~~
* secret code is array of short words?
* ~~add address~~, phone, email updater to rsvp form
* ~~add dietary restrictions to rsvp~~
* ~~if user is not found, error gracefully~~
* ~~if user uses RSVP index or any other controller, session[:secret_code] is null~~
* ~~session[:secret_code] is validated for every action EXCEPT index (and find_user) in the RSVP controller~~
* ~~page-header everywhere~~
* ~~secret code is a password field~~
* ~~make update dietary restrictions a button~~
* if a user ????
* Admin can log in and add families with family members
  * differentiate between properly logged in admin and temp logged in rsvp-er
  * admin logs in at /admin, then has new navbar with all /users paths available
  * also has access to all /photos, /registries paths
