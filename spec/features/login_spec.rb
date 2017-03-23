require "rails_helper"

feature 'User signs in' do

  before :each do
    @user = FactoryGirl.create(:user,email: "testust@gmail.com", password: "abcd1234", password_confirmation: "abcd1234")    
  end
  
  scenario 'with valid email and password' do
    login_with 'testust@gmail.com', 'abcd1234'
    expect(page).to have_content('Signed in successfully')     
  end

   scenario 'with invalid email' do
     login_with 'testuat@gmail.com', 'abcd1234'
     expect(page).to have_content('Invalid Email or password')
           
   end

   scenario 'with blank password' do
     login_with 'testust@gmail.com', ''
     expect(page).to have_content('Invalid Email or password')
   end

  def login_with(email, password)
    visit root_path
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_button "Log in"
  end

  # scenario 'sign up and log in' do
  #   sign_up_and_login
  #   expect(page).to have_content('Welcome! You have signed up successfully')
  # end

  # def sign_up_and_login
  #   visit root_path
  #   click_button "Log in"
  #   fill_in "Email", :with => "newuser@gmail.com"
  #   fill_in "Password", :with => "abcd1234"
  #   fill_in "Password confirmation", :with => "abcd1234"
  #   click_button "Sign up"    
  # end
end

