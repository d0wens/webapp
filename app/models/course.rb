# == Schema Information
#
# Table name: courses
#
#  id          :integer          not null, primary key
#  course_name :string(255)
#  semester    :string(255)
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Course < ActiveRecord::Base
  attr_accessible :course_name, :semester
  
  has_many :users
  has_many :enrollments, foreign_key: "course_id", dependent: :destroy
  has_many :enrolled_users, through: :enrollments, source: :user
  
  before_save { |course| course.course_name = course_name.upcase }
  
  
  VALID_COURSE_NAME_REGEX = /\A[a-zA-Z]{4}[0-9]{3}[a-zA-Z]*/i
  validates :course_name, presence: true, length: { maximum: 8 },
						  format: { with: VALID_COURSE_NAME_REGEX }
  VALID_SEMESTER_REGEX = /\A(Spring|Fall|Summer|Winter)[0-9]{4}/i
  validates :semester,  presence: true, length: { maximum: 10 },
						format: { with: VALID_SEMESTER_REGEX }
  validates_uniqueness_of :course_name, scope: [:semester]
  
  default_scope order: 'courses.course_name'
  
  def incourse?(this_user)
    enrollments.find_by_user_id(this_user.id)
  end
  
  def enlist!(this_user)
	self.enrollments.create!(user_id: this_user.id)
  end
  
  def unenlist!(this_user)
    self.enrollments.find_by_user_id(this_user.id).destroy
  end
  
end
