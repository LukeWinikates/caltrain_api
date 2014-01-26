caltrain_api
============

##Getting Started

First, [sign up](http://511.org/developer-resources_transit-api.asp) with 511.org to get a developer API key.

Once you have an API key, use `CaltrainApi::Client.configure` to set your API key.

``` RUBY
  CaltrainApi::Client.configure do |api_config|
    api_config[:auth_token] = 'AN API KEY'
  end
```

##Contributing

To run the tests, you'll need to let the test suite know about your API key by creating a `spec/.api_token` file containing just your API key on a single line.
This file is `.gitignore`d, and the test suite is configured to ensure that API keys are not checked in, but please review your commits carefully to ensure this continues to be the case.
