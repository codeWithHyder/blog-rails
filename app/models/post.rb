class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes
  
  after_save :update_user_posts_counter

   # Updates the posts counter for a user

   private 
   
  def update_user_posts_counter
    author.update(posts_counter: author.posts.count)
  end

  # Returns the 5 most recent comments for a given post
  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
