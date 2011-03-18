#!/bin/bash

# Make backup copies of development and production files
cp config/facebooker.yml.development config/.facebooker.yml.development
cp config/facebooker.yml.production config/.facebooker.yml.production

cp config/people_finder.yml.development config/.facebooker.yml.development
cp config/people_finder.yml.production config/.facebooker.yml.production

# Move current to development and production to current
cp config/facebooker.yml config/facebooker.yml.development
cp config/facebooker.yml.production config/facebooker.yml

cp config/people_finder.yml config/facebooker.yml.development
cp config/people_finder.yml.production config/facebooker.yml