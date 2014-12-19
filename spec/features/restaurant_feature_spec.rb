require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      signup
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    before do
      Restaurant.create(name: 'KFC')
    end
    context 'anonymous user' do
      scenario 'an anonymous user cannot create a restaurant' do
        visit '/restaurants'
        expect(page).not_to have_content 'Add a restaurant'
      end
    end
    context 'authenticated user' do
      scenario 'prompts an authenticated user for fill out a form, then displays the new restaurant' do
        signup
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'Canteen'
        click_button 'Create Restaurant'
        expect(page).to have_content 'Canteen'
        expect(current_path).to eq '/restaurants'
      end
    end
    context 'an invalid restaurant' do
      scenario 'does not let you submit a name that is too short' do
        signup
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    before do
      @kfc = Restaurant.create(name: 'KFC')
    end
    it 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{@kfc.id}"
    end
  end

  context 'updating restaurants' do
    before do
      create_restaurant('KFC')
    end
    it 'lets a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before do
      create_restaurant('KFC')
    end
    it 'removes a restaurant when a user clicks the delete link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'adding photos to restaurants' do
    before do
      create_restaurant('KFC')
      @file = fixture_file_upload('files/kfc.jpg', 'image/jpeg')
    end
    it 'lets a user add a photo to a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      attach_file('restaurant_image', './spec/fixtures/files/kfc.jpg')
      click_button 'Update Restaurant'
      expect(page).to have_css 'img'
    end
  end

  def create_restaurant(name)
    signup
    Restaurant.create(name: name)
  end

  def signup
    visit('/')
    click_link('Sign up')
    fill_in('Email', with: 'test@example.com')
    fill_in('Password', with: 'testtest')
    fill_in('Password confirmation', with: 'testtest')
    click_button('Sign up')
  end
end
