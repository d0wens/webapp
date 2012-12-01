class Grade < ActiveRecord::Base
  attr_accessible :user_id, :assignment_id, :grade
  
  belongs_to :user
  belongs_to :assignment
  belongs_to :course
end
