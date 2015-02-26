Stupid easy badge issuer for AWS Beanstalk Evironments 

Issue GitHub badges for your Beanstalk evironments that look like this:

![alt text](http://img.shields.io/badge/Your%20Beanstalk%20Environment-Running_Version_0.0-brightgreen.svg)
![alt text](http://img.shields.io/badge/Your%20Beanstalk%20Environment-Updating_Version_0.0-lightgrey.svg)
![alt text](http://img.shields.io/badge/Your%20Beanstalk%20Environment-Down_Version_0.0-red.svg)

## Putting it up on Heroku

Deploy to Heroku by clicking this button.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Running it locally

Add AWS Credentials to properties.yml:
```
aws:
	region: 'us-west-2'
	access_key_id: 'YOUR ACCESS KEY'
  	secret_access_key: 'YOUR SECRET ACCESS KEY'
	environment:
		id: 'yourEnvId'
options:
	cachecontrol: 'clientCacheControl'
```

```
$ git clone git://github.com/scottmotte/sinatra-heroku-cedar-template.git
$ gem install bundler
$ bundle
$ bundle exec foreman start
```

Navigate to localhost:5000/getEnvironmentBadge | 5100

