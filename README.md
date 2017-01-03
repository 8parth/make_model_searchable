# MakeModelSearchable 
[![Code Triagers Badge](https://www.codetriage.com/8parth/make_model_searchable/badges/users.svg)](https://www.codetriage.com/8parth/make_model_searchable)  [![Code Climate](https://codeclimate.com/github/8parth/make_model_searchable/badges/gpa.svg)](https://codeclimate.com/github/8parth/make_model_searchable)   [![Gem Version](https://badge.fury.io/rb/make_model_searchable.svg)](https://badge.fury.io/rb/make_model_searchable)

Moduler solution to add search functionality for selected fields.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'make_model_searchable'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install make_model_searchable

## Usage

###### To add search functionality to a model, for example User add following line to your model.

```ruby
class User < ActiveRecord::Base
	searchable_attributes :first_name, :last_name
end
```
Then use 
```ruby
def index
	User.search("something")
end
```

searchable_attributes line makes model searchable by adding search method to User model. 
Specifying attributes by :first_name, :last_name enables searching in specied fields. It is optional to specify attributes, if no attributes are specified then all attributes are searched.


###### To enable searching from associations, you can mention asssociation name with attributes to be searched from that association as below: 

Suppose our user has many posts, then in our model

```ruby
class User < ActiveRecord::Base
	has_many :posts
	searchable_attributes :name, posts: [:title]
end
```

or if you want to search from all text or string fields,

```ruby
class User < ActiveRecord::Base
	has_many :posts
	searchable_attributes :name, posts: []
end
```


Then use,
```ruby
def index
 	User.search("something")
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/8parth/make_model_searchable. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
