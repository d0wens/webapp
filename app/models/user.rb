# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
								   class_name: "Relationship",
								   dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  has_many :courses
  has_many :enrollments, foreign_key: "user_id", dependent: :destroy
  has_many :taking_courses, through: :enrollments, source: :course
  
  #new relations
  has_many :responses, :dependent => :destroy
  accepts_nested_attributes_for :responses
  has_many :assignments
  has_many :grades, foreign_key: "user_id", dependent: :destroy
  has_many :assignment_grades, through: :grades, source: :assignment
  #end
  
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
					format: { with: VALID_EMAIL_REGEX },
					uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  default_scope order: 'users.name'
  
  def feed
	Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end
  
  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    self.relationships.find_by_followed_id(other_user.id).destroy
  end
  
  def enrolling?(this_course)
    enrollments.find_by_course_id(this_course.id)
  end
  
  def enroll!(this_course)
    self.enrollments.create!(course_id: this_course.id)
  end
  
  def unenroll!(this_course)
    self.enrollments.find_by_course_id(this_course.id).destroy
  end
  
  def take_assignment(this_ass)
    self.assignment_grades.create!(assignment_id: this_ass.id)
  end
  
  private
  
    def create_remember_token
	  self.remember_token = SecureRandom.urlsafe_base64
	end

end
