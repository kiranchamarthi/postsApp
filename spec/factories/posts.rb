# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :post do
  	title "Post Title"
  	body "Post Body"
  	created_by 1
  	updated_by 1
  end
  factory :invalid_post_data, parent: :post do |f|
  	f.title nil
  end
end