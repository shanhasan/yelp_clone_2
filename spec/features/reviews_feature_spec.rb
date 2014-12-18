require 'rails_helper'
require 'timecop'

describe 'reviewing' do
  before do
    Restaurant.create(name: 'KFC')
  end

  it "allows users to leave a review using a form" do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link "Review KFC"
    fill_in "Thoughts", with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end

  scenario 'displays an average rating for all reviews' do
    leave_review("so, so", '3')
    leave_review("Greate", '5')
    expect(page).to have_content('Average rating: ★★★★☆')
  end

  scenario 'displays time when review was submitted' do
    leave_review('so, so', '3')
    Timecop.travel(Time.now + 3600)
    expect(page).to have_content('reviewed 1 hour ago')
  end
end
