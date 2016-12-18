class User < ActiveRecord::Base
	has_many :posts
	searchable_attributes :first_name, :last_name, :posts => [:title], :xyz => [:sdfh]
end