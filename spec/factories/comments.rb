# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
  	body "Post Body"
  	author 1
  end
  factory :invalid_comment_data, parent: :post do |f|
  	f.body nil
  end
end