class Answer < ActiveRecord::Base
  attr_accessible :content, :correct_ans, :question_id
  belongs_to :question
  has_many :responses, :dependent => :destroy
  validates_presence_of :content
end
