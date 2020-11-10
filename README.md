# Boxt API Documentation buildpack

This buildpack should be included as part of Heroku apps that host API documentation.

For more info on how buildpacks work, read the Heroku Buildpacks API: https://devcenter.heroku.com/articles/buildpack-api

## Detect

The detect script in `./bin/detect` will test for the existence of the **boxt_documentation** gem on the system. If it's not found, the buildpack will exit, otherwise it will run the script in `./bin/compile`.

## Compile

The compile script will run the requisite rake tasks on the **boxt_documentation** gem to build the API documentation.
