# cutouts

> Sign up, and start adding the articles that you have read and want to remember! Deployed [here][11]!

[![Build Status][9]][10]

You can find the Firefox companion add-on [here][8]


### TOC

- [What?][1]
- [Why?][2]
- [Local Setup][14]
  - [Creating a local test user][18]
- [Manual Test Plan][3]
- [API Documentation][7]
- [Release Notes][4]
  - [v1.0 - 2018-12-07][5]
- [TODO][6]

## What?

- Simple form with just two compulsary questions: Link and a Quote from the article that you want to remember
- As simple as it can get. Nothing fancy. Vanilla bootstrap. Vanilla font awesome.
- List public cutouts at profile page
- Share a single cutout with friends and family by emailing it to them
- Share a cutout on social media by copying it's permalink

## Why?

The internet has a lot of good content, blog posts, articles, etc etc. I read a lot
of stuff, and then could not find them again when I wanted to. Pocket is good for saving
for later, Delicious and Pinterest are overkill for something as simple. Hence, this
project!

## Local Setup

**Note:** These steps were tested on a machine running Ubuntu 18.04 LTS.

- Install `rbenv`
- Install ruby version `2.3.1`
  - If you see an error message asking you to intall `libssl-dev`, install
  `libssl1.0-dev` using `apt-get` and then run `rbenv install 2.3.1` again.
    - [Discussion on an issue in the rbenv/ruby-build repository][15]
- Install bundler version `1.16.0`
- Run `bundle install`
  - If you see an [error regarding][16] the `ffi` gem, then install `libffi-dev`
  - If you see an [error regarding][17] the `pg` gem, then install `libpq-dev`
  - If you see an error regarding the `sqlite3` gem, then install
  `libsqlite3-dev`
- [TEST] Run `./bin/rails --version`
  - This ensures that you have the rails gem installed locally
- Install `zeus` (the recommended development server)
    - `gem install zeus`
    - Run `zeus start` in a window to start the zeus server
    - Run `zeus rake db:migrate RAILS_ENV=development` to migrate all the tables
    onto your local sqlite3 database
    - Run `zeus server` to start the server on http://localhost:3000
    - Visit the server link to check out your app

### Creating a local test user

- Go to http://localhost:3000
- Create a user using the `Sign Up` button
- Now, you will be shown a prompt on the home page saying you must confirm your
user by clicking the confirmation link in your email.
- To do this process directly on the database, you can do:
  - Go into the rails console: `zeus console`
  - Get your user: `User.all` or `User.first`
  - Confirm your user: `user.confirm`
- After confirming a user, you should be able to login to your account locally.

A log of the commands to run and their output:

```irb
irb(main):007:0> User.first
  User Load (0.5ms)  SELECT  "users".* FROM "users"  ORDER BY "users"."id" ASC LIMIT 1
=> #<User id: 1, email: "a@example.com", username: "a1", created_at: "2019-09-14 04:29:01", updated_at: "2019-09-14 04:29:01">
irb(main):009:0> User.first.confirm
  User Load (0.5ms)  SELECT  "users".* FROM "users"  ORDER BY "users"."id" ASC LIMIT 1
   (0.2ms)  begin transaction
  SQL (0.7ms)  UPDATE "users" SET "confirmed_at" = ?, "updated_at" = ? WHERE "users"."id" = ?  [["confirmed_at", "2019-09-14 04:32:42.534172"], ["updated_at", "2019-09-14 04:32:42.542307"], ["id", 1]]
   (6.1ms)  commit transaction
=> true
```

You can use this process to confirm all locally created users.

## Manual Test Plan

- sign-up
  - confirm a new user using: `User.find(...).confirm`
- login and logout
- login, add a public cutout, check that it is accessible without login, logout
- login, add an unlisted cutout, check that it is accessible without login,
  logout
- login, add a private cutout, ensure that it isn't accessibly without login,
  logout
- edit an cutout's visibility and check if the changes are reflected

## API Documentation

> Check the [routes][13] file for the latest available routes

All responses are JSON formatted.

### `GET /api/v1/feed`

- Returns the list of top 20 articles from the public feed
- Public
- Auth not required
- Rate limited

### `GET /api/v1/feed/:username`

- Returns the top 20 public articles of the given user
- Public
- Auth not required
- Rate limited

## Release Notes

### v1.0 - 2018-02-07

- Add, update, delete cutouts
- Tag cutouts and then search the cutouts in a particular tag
- List all the cutouts you have stored in the past
- Export all your cutouts to UTF8 encoded HTML or JSON
- Share the permalink for an article that has the title of the article, the
    quote, the author and it's tags

    ![img](./img/v1_1.png)

- Email a Cutout to friends and family (maximum 5 at once)

    ![img](./img/v1_2.png)

- Add an alias while emailing so that recipients know the cutout is from you
- Display tags as Bootstrap buttons

    ![img](./img/v1_3.png)

- A link to the archives of the page that has the Cutout
- A companion
    [Firefox add-on][8]
    to make it easier to Cutout articles from Firefox

## TODO

> In descending order of priority

- [x] Create a good homepage that has a few words about why this project at all
- [ ] User must be able to login with both username as well as email
	- Override devise? (Devise procedure [here][12] seems extremely long)
- [ ] Fix the word limit on quote (50 words?)
- [x] Fix the sign-in and sign-up form UI
- [x] Fix the horrible UI to make it usable at the very least (copy medium, that interface is too good!)
- [x] A system to tag articles (single words)
- [x] A system to search for articles (single search bar, user search, tag search, author search, quote search)
- [x] Ability for users to export their articles into a Markdown file for local storage (A JSON file for import too?)
- [ ] A rating system for self, no sharing as yet
- [ ] Probably friendship and the ability to follow other users

[![forthebadge](http://forthebadge.com/images/badges/made-with-ruby.svg)](http://forthebadge.com)

Code inside this repo is licensed under MIT.

Copyright (c) 2015-2019 [Siddharth Kannan](http://icyflame.github.io) All Rights Reserved.

[1]: #what
[2]: #why
[3]: #manual-test-plan
[4]: #release-notes
[5]: #v10---2018-02-07
[6]: #todo
[7]: #api-documentation
[8]: https://addons.mozilla.org/en-US/firefox/addon/cutouts-firefox-extension/
[9]: https://travis-ci.org/icyflame/cutouts.svg?branch=master
[10]: https://travis-ci.org/icyflame/cutouts
[11]: https://cutouts.siddharthkannan.in
[12]: https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
[13]: https://github.com/icyflame/cutouts/blob/add-api-documentation/config/routes.rb
[14]: #local-setup
[15]: https://github.com/rbenv/ruby-build/issues/1215#issuecomment-399687588
[16]: https://stackoverflow.com/a/43926527/2080089
[17]: https://stackoverflow.com/a/46914751/2080089
[18]: #creating-a-local-test-user
