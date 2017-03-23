require 'rails_helper'

RSpec.describe User, type: :model do
  	it "has a valid factory" do
		FactoryGirl.create(:user).should be_valid
	end

	it "is invalid without title" do
		FactoryGirl.build(:user, email: nil).should_not be_valid
	end
end
