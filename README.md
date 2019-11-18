# Qwiik

A gem for cunsuming daraja 2.0 API.
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qwiik'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install qwiik

## Configuration
To get started configure the gem with your own credentials.
```ruby
Qwiik.configuration do |config|
  config.confiramtion_url = "https://example.com/confirm",
  config.validation_url = "https://example.com/validate",
  config.short_code = 600398

end

```
## Usage
The gem contains the following methods.
1. __`register_urls`__ - Register C2B urls ie `confirmation_url`and `validation_url`.

2. __`payouts`__ - Used to send a B2C payment to customers.Upon success  cunstomer wallet is credited. This could be `promotion payment`, `salary` etc

## Register Urls
`register_urls` method is used.The method requires `response_type` parameters.

syntax
```
register_urls("Completed")
```

> Parameters can be `Completed` or `Cancelled`.
>> When completed it doent care what response is sent by your `validation_url` and completes the transaction.
>> When `Cancelled` you must respond with `success` in your validation_url to complete the transaction
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/qwiik. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/qwiik/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Qwiik project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/qwiik/blob/master/CODE_OF_CONDUCT.md).
