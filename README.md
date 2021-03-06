# iOS Analytics

Translate plist format into checkstyle format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ios_analytics'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ios_analytics

## Usage

First, execute analyze task in xcodebuild.
Example is below,

```
xcodebuild -scheme "$XCODE_SCHEME" -workspace "$XCODE_WORKSPACE" -archivePath "$ARCHIVE_PATH" -derivedDataPath "$PWD/derivedData" analyze CODE_SIGN_IDENTITY="$DEVELOPER_NAME"
```

After, you execute below, you can see checkstyle formatted result.

```
ios_analytics translate --appName="SampleApp" --derivedData="$PWD/derivedData"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ios_analytics.
