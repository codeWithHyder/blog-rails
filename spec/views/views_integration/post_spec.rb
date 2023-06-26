require 'rails_helper'
RSpec.describe Post, type: :system do
  user = User.create(name: 'Anna', posts_counter: 3, photo: 'https://randomuser.me/api/portraits/women/67.jpg',
                     bio: 'Project manager')
  subject do
    Post.new(user_id: user.id, title: 'First post', text: 'First post', comment_counter: 2, likes_counter: 2)
  end
  before { subject.save }
  describe 'Post index page' do
    it "I can see the user's profile picture." do
      visit user_posts_path(user.id)
      page.has_css?('.img-fluid')
    end
end

