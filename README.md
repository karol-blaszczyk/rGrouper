# GroupsBy

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'groups_by'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install groups_by

## Usage

There are several ways of using groups_by.  The first way is to go through the
`GroupsBy` class itself.

    require 'groups_by'

    GroupsBy.new.groups_by(
            <ARRAY_OF_HASHES>,
            groupings: <GROUPING_RULES>)
    # => grouping result

The second way is to modify the String or Array classes by including either
core extension.

    require 'groups_by/core_ext/array'   # extends only Array
    require 'groups_by/core_ext'         # extends both Array/String

    [
      { name: '--2222--', age: '18-24', gender: 'Male', views: 1 },
      { name: '--1111--', age: '18-24', gender: 'Female', views: 2 },
      { name: '--2222--', age: '25-34', gender: 'Female', views: 1 },
      { name: '--1111--', age: '25-34', gender: 'Male', views: 1 }
    ].groups_by(:age, :gender, ->(el) { el[:name][/\d+/])

    # =>
    #  {
    #    '18-24' =>
    #      {
    #        'Male' => {
    #          '2222' => [{ name: '--2222--', age: '18-24', gender: 'Male', views: 1 }]
    #        },
    #        'Female' => {
    #          '1111' => [{ name: '--1111--', age: '18-24', gender: 'Female', views: 2 }]
    #        }
    #      },
    #    '25-34' =>
    #      {
    #        'Female' => {
    #          '2222' => [{ name: '--2222--', age: '25-34', gender: 'Female', views: 1 }]
    #        },
    #        'Male' => {
    #          '1111' => [{ name: '--1111--', age: '25-34', gender: 'Male', views: 1 }]
    #        }
    #      }
    #  }

Lastly, the `GroupsBy` class along with all core extensions can be loaded via
a single require.

    require 'groups_by/all'

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/karol-blaszczyk/groups_by. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GroupsBy project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/groups_by/blob/master/CODE_OF_CONDUCT.md).
