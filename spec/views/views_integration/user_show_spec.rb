require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'user show page' do
    before do
      @first_user = User.create(name: 'Shubham', photo: 'https://unsplash.com/photos', bio: 'Teacher from Mexico.')
      @first_post = Post.create(author: @first_user, title: 'first', text: 'This is my first post')
      Post.create(author: @first_user, title: 'second', text: 'This is my second post')
      Post.create(author: @first_user, title: 'third', text: 'This is my third post')
      visit user_path(@first_user)
    end
    it 'I can see the username.' do
      expect(page).to have_content(@first_user.name)
    end
    it 'I can see the user profile picture.' do
      expect(page).to have_css("img[src='https://unsplash.com/photos']")
    end
    it 'I can see the number of posts the use has written.' do
      expect(page).to have_content('Number of posts: 3')
    end
    it 'I can see the user bio.' do
      expect(page).to have_content(@first_user.bio)
    end
    it 'I can see the user first 3 posts.' do
      expect(page).to have_content('first')
      expect(page).to have_content('This is my first post')
      expect(page).to have_content('second')
      expect(page).to have_content('This is my second post')
      expect(page).to have_content('third')
      expect(page).to have_content('This is my third post')
    end
    it 'I can see a button that lets me view all of a user posts.' do
      expect(page).to have_link('See all posts')
    end
    it 'When I click a user post, it redirects me to that post show page.' do
      click_link 'first'
      expect(page).to have_current_path(user_post_path(@first_user, @first_post))
    end
    it 'When I click to see all posts, it redirects me to the user post index page.' do
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@first_user))
    end
  end
end
