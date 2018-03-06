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

There are several ways of using groups_by.

### Base
  The first way is to go through the `GroupsBy` class itself.

  ```ruby
      require 'groups_by'

      GroupsBy.new.groups_by(
              source,
              group_by_rules: grouping_rules,
              summarizer: summarizer)
  ```
### CoreExt
  The second way is to modify the Array class by including core extension.
  ```ruby
      require 'groups_by/core_ext/array'   # extends only Array

      data = [
        { value1: 10, value2: 100, name: 'Stanton',  company: 'Smith Inc', id: '-one-' },
        { value1: 20, value2: 200, name: 'Stanton',  company: 'Fisher LLC', id: '-three-' },
        { value1: 50, value2: 500, name: 'Darrel', company: 'Smith Inc', id: '-three-' }
      ]

      result = data.groups_by(:name, :company, ->(el) { el[:id][/\w+/]})
      # => {"Stanton"=>{"Smith Inc"=>{"one"=>[{:value1=>10, :value2=>100, :name=>"Stanton", :company=>"Smith Inc", :id=>"-one-"}]}, "Fisher LLC"=>{"three"=>[{:value1=>20, :value2=>200, :name=>"Stanton", :company=>"Fisher LLC", :id=>"-three-"}]}}, "Darrel"=>{"Smith Inc"=>{"three"=>[{:value1=>50, :value2=>500, :name=>"Darrel", :company=>"Smith Inc", :id=>"-three-"}]}}}

      GropsBy.pritify result
      #   Stanton
    	#   	Smith Inc
    	#   		one
    	#   			value1    value2    name      company   id
    	#   			10        100       Stanton   Smith Inc -one-
    	#   	Fisher LLC
    	#   		three
    	#   			value1     value2     name       company    id
    	#   			20         200        Stanton    Fisher LLC -three-
    	#   Darrel
    	#   	Smith Inc
    	#   		three
    	#   			value1    value2    name      company   id
    	#   			50        500       Darrel    Smith Inc -three-      
```

## Options

### Summarizer
  You can pass summarize logic into grouper to summarize desirable values
### Pritify
  Display grouped array in prettified way

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/karol-blaszczyk/groups_by. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GroupsBy project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/groups_by/blob/master/CODE_OF_CONDUCT.md).
