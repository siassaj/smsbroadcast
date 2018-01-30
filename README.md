# Smsbroadcast
Convenience wrapper for sending sms messages using www.smsbroadcast.com.au

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smsbroadcast'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smsbroadcast

## Configuration
Put the following in an initializer or somewhere in your initialization flow.

```ruby
Smsbroadcast.configure do |config|
  config.from     = "some company"
  config.username = ENV['SMSBROADCAST_USERNAME']
  config.password = ENV['SMSBROADCAST_PASSWORD]

# OPTIONAL BELOW
  config.url = "https://api.smsbroadcast.com.au/"
  config.maxsplit = "1"
  config.delay = "0"
end
```

## Send an SMS

```ruby
sms = Smsbroadcast::Sms.new({
  to: '0499999999', # or ['0499999999', '0411111111'] up to 1000 numbers
  message: 'some message text',

  # OPTIONAL BELOW
  from: 'some company',
  maxsplit: '1',
  delay: '0'
})

response = sms.deliver

response.status  #=> 'some status that smsbroadcast supports'
response.number  #=> 'the number'
response.ref     #=> 'the reference'
response.message #=> 'the message
```

## Get Account Status
Can't remember if this works. It's a bit weird, probably was meant to be like status = Smsbroadcast::GetStatus.call() or somesuch.

```ruby
  status = Smsbroadcast::Status.new
  status.call()
  status.status  #=> some status stuff
  status.balance #=> your balance as a string? i don't remember
  status.message #=> some sort of lovely message from the team at smsbroadcast?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/smsbroadcast.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

