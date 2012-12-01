class Question < ActiveRecord::Base
  attr_accessible :points, :content, :allow_free_response, :assignment_id, :points, :answers_attributes

  belongs_to :assignment
  has_many :answers, :dependent => :destroy

  accepts_nested_attributes_for :answers,
        :reject_if => lambda { |a| a[:content].blank? },
        :allow_destroy => true

  validates_presence_of :answers
  validates_presence_of :content
  
  scope :by_assignment, lamda { |ass| where("assignment_id = ?", ass) }

  def my_questions
    Question.by_assignment(self.assignment_id).map(&:id)
  end
end
