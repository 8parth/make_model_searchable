FactoryGirl.define do 
	factory :post, class: "Post" do 
    title "title title title"
    association :user 
  end
	
end