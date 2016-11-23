FactoryGirl.define do
	factory :user, class: "User" do
    first_name "John"
    last_name  "Doe"
  end
  factory :user1, class: "User" do
    first_name "John"
    last_name  "Doe"
  end
  factory :user2, class: "User" do
    first_name "Harry"
    last_name  "Potter"
  end
  factory :user3, class: "User" do
    first_name "Harmoine"
    last_name  "Grenger"
  end
end