require 'rails_helper'

context "user not signed in and on the homepage" do
  it "should see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).to have_link('Sign in')
    expect(page).to have_link('Sign up')
<<<<<<< HEAD
  end 
=======
  end
>>>>>>> 73b030a3a2d4ecd19ca506f00d04b5acac47c3fc

  it "should not see a 'sign out' link" do
    visit('/')
    expect(page).not_to have_link('Sign out')
  end
<<<<<<< HEAD
end
=======
end

context "user signed in on the homepage" do
  before do
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end

  it "should see 'sign out' link" do
    visit('/')
    expect(page).to have_link('Sign out')
  end

  it "should not see a 'sign in' link and a 'sign up' link" do
    visit('/')
    expect(page).not_to have_link('Sign in')
    expect(page).not_to have_link('Sign up')
  end
end
>>>>>>> 73b030a3a2d4ecd19ca506f00d04b5acac47c3fc
