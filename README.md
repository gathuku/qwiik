# Qwiik

[![Build Status](https://travis-ci.org/gathuku/qwiik.png?branch=master)](https://travis-ci.org/gathuku/qwiik)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/b7e3c26ac88d4b2d81524087a17d09f4)](https://www.codacy.com/manual/gathuku/qwiik?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=gathuku/qwiik&amp;utm_campaign=Badge_Grade)
[![Coverage Status](https://coveralls.io/repos/github/gathuku/qwiik/badge.svg?branch=master)](https://coveralls.io/github/gathuku/qwiik?branch=master)
[![Latest Version](https://img.shields.io/github/release/gathuku/qwiik.svg?style=flat-square)](https://github.com/gathuku/qwiik/releases)
[![Issues](https://img.shields.io/github/issues/gathuku/laravel_mpesa.svg?style=flat-square)](https://github.com/gathuku/qwiik/issues)

A gem for cunsuming daraja 2.0 API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qwiik', :git => 'git@github.com:gathuku/qwiik.git'
```

And then execute:
```
    $ bundle install
```
Or install it yourself as:
```
    $ git clone git@github.com:gathuku/qwiik.git

    $ cd qwiik && gem build qwiik.gemspec

    $ gem install qwiik-[version].gem
```
## Configuration
To get started add your credentials to environment variables
```sh
export QWIIK_PAYOUT_KEY = your_payout_key
export QWIIK_PAYOUT_SECRET = your_payout_secret
```
Then configure the gem with.
```ruby
Qwiik.configuration do |config|
  # If sandbox
  config.base_url='https://api-staging.qwwik.com'
  # If live
  config.base_url='https://api.qwwik.com'

  key= ENV['QWIIK_PAYOUT_KEY']
  secret=ENV['QWIIK_PAYOUT_SECRET']
end

```
## Usage
The gem can be used to make payouts.
1. Business to customer(B2C)
2. Business to BusinessPayBill(B2B)
3. Business to BusinessBuyGoods(B2B)

### To customers
To make a customer payout use:
> Category must be `BusinessPayment`

```ruby
  Qwiik.payouts(category:, amount:, recipient_no:, reference:)
```

###### Parameters

1. `category:`   `String` - category of the payment.
2. `amount: `   `Integer` - amount to be paid
3. `recepient_no:`   `String` - Phone number of the recepient.
4. `reference:`  `String`  - payment reference

###### Example
```ruby
responce=Qwiik.payouts(category: 'BusinessPayment', amount:100, recipient_no: '0722000024', reference: '11234578')
```
Alternatively
```ruby
args={
  category:'BusinessPayment',
  amount:100,
  recipient_no: '0722000024',
  reference:'11234578'
}
response=Qwiik.payouts(args)
```

###### Response

Body `response.body`
```json
 /* json */
{
  "data": {
    "type": "responses",
    "id": "AG_20191121_000046e92fe975f006d7",
    "attributes": {
      "resource_id": "bae4b140-8db7-4dc1-9be1-5650383d48f3"
    }
  }
}
```
### To BusinessPayBill
To make a customer payout use:
> Category must be `BusinessPayBill`
>
> Recepient_no must be a __paybil__ no

```ruby
  Qwiik.payouts(category:, amount:, recipient_no:, reference:)
```
###### Parameters

1. `category:`  `String` - category of the payment.
2. `amount: `   `Integer` - amount to be paid
3. `recepient_no:`   `String` - Paybill number of the recepient.
4. `reference:`   `String`  - payment reference

###### Example
```ruby
  Qwiik.payouts(category:'BusinessPayBill', amount:100, recipient_no:'601000', reference:'11234578')
```

### To BusinessBuyGoods
To make a businessBuyGoods payout use:
> Category must be `BusinessBuyGoods`
>
> Recepient_no must be a __till__ no.

```ruby
  Qwiik.payouts(category:, amount:, recipient_no:, reference:)
```
###### Parameters

1. `category:`   `String` - category of the payment.
2. `amount: `   `Integer` - amount to be paid
3. `recepient_no:`   `String` - Till no number of the recepient.
4. `reference:`   `String`  - payment reference

###### Example
```ruby
  Qwiik.payouts(category:'BusinessBuyGoods', amount:100, recipient_no:'116261', reference:'11234578')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gathuku/qwiik. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/gathuku/qwiik/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Qwiik project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/qwiik/blob/master/CODE_OF_CONDUCT.md).
