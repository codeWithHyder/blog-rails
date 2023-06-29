class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable # , :confirmable
  has_many :comments
  has_many :posts
  has_many :likes

  validates :name, presence: true

  def recent_post
    posts.order(created_at: :desc).limit(3)
  end

  def user_has_liked?(new_post_id)
    likes.exists?(post_id: new_post_id)
  end

  def remove_user_like(new_post_id)
    likes.find_by(post_id: new_post_id).destroy
  end

  def add_user_like(new_post_id)
    likes.create(post_id: new_post_id)
  end
end
