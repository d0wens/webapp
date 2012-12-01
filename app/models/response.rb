class Response < ActiveRecord::Base
  belongs_to :answer
  belongs_to :user
  belongs_to :question
  
  validates_uniqueness_of :question_id, :scope => [:user_id], :message => "You have already answered that question!"

  private

    def self.who_answered_me(answer_id_in)
      Response.where(:answer_id => answer_id_in).map(&:user).map(&:name)
    end

    def self.answers_total_count(answer_id_in)
      where(:answer_id => answer_id_in).count
    end
end
