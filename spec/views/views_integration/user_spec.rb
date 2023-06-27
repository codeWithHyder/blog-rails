require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'user index page' do
    before do
      allow_any_instance_of(ApplicationController)
        .to receive(:current_user)
        .and_return(User.create(name: 'Tom', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.'))
      @first_user = User.create(name: 'zewdie', photo: 'https://randomuser.me/api/portraits/women/67.jpg',
                                bio: 'Teacher from Mexico.')
      User.create(name: 'Enis', photo: 'https://randomuser.me/api/portraits/women/70.jpg', bio: 'Teacher from Mexico.')
      visit root_path
    end
    it 'shows the right content' do
      expect(page).to have_content('Welcome Tom')
    end
    it 'I can see the username of all other users' do
      expect(page).to have_content('Shubham')
      expect(page).to have_content('Enis')
      expect(page).to have_content('Tom')
    end
    it 'I can see the profile picture for each user.' do
      expect(page).to have_css("img[src='https://unsplash.com/photos']")
      expect(page).to have_css("img[src='https://randomuser.me/api/portraits/women/67.jpg']")
      expect(page).to have_css("img[src='https://randomuser.me/api/portraits/women/70.jpg']")
    end
    it 'I can see the number of posts each user has written.' do
      Post.create(author: @first_user, title: 'Hello', text: 'This is my first post')
      expect(page).to have_content('Number of posts: 1')
      expect(page).to have_content('Number of posts: 0')
    end
    it 'When I click on a user, I am redirected to that user show page.' do
      click_link 'Shubham'
      expect(page).to have_current_path(user_path(@first_user))
    end
  end
end
