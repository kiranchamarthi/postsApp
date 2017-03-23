require 'rails_helper'

RSpec.describe Comment, type: :model do
	it "has a valid factory" do
		FactoryGirl.create(:comment).should be_valid
	end

	it "is invalid without title" do
		FactoryGirl.build(:comment, body: nil).should_not be_valid
	end
end
