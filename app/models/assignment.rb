class Assignment < ActiveRecord::Base
  after_save :check_anonymous
  
  attr_accessible :questions_attributes, :name, :published, :due_date, :anonymous, :total_points, :question
  
  has_many :questions, :dependent => :destroy
  
  accepts_nested_attributes_for :questions,
        :reject_if => lambda { |q| q[:content].blank? },
        :allow_destroy => true
  
  validates_presence_of :name
  validates_presence_of :questions
  
  has_many :users
  has_one :grade, foreign_key: "assignment_id", dependent: :destroy
  has_many :user_grades, through: :grades, source: :user

  # return an array of all my questions
  def my_questions
    self.questions.map(&:id)
  end

  def my_anonymous_questions
    questions.where(:anonymous => true)
  end

  def my_public_questions
    questions.where(:anonymous => false)
  end

  def check_anonymous
    if anonymous == true
      questions.each { |question| question.update_attributes(:anonymous => true) }
    else
      questions.each { |question| question.update_attributes(:anonymous => false) }
    end
  end

end
