# 💁 Moxie's Hair Salon

#### By Olivia Hinton | Date: July 15, 2016

## Description

This website app was built for Moxie's Hair Salon to streamline the salon owner's scheduling process.

## Database Setup Instructions

Open a PSQL terminal and run these commands:

`CREATE DATABASE hair_salon;`

`CREATE TABLE stylists (id serial PRIMARY KEY, first_name varchar, last_name varchar);`

`CREATE TABLE clients (id serial PRIMARY KEY, first_name varchar, last_name varchar);`

## General Setup Instructions

* Clone this repository
* Install gems by running command `$ bundle` in the terminal
* Launch Sinatra by running command `$ ruby app.rb` in the terminal
* Launch site by visiting localhost:4567 in browser

## Tech Used

* Ruby
* SQL
* Sinatra
* Bootstrap
* HTML
* CSS

### License

*This software is licensed under the MIT license.*

Copyright (c) 2016 **Olivia Hinton**
