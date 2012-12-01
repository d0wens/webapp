module TakeAssignmentsHelper
  def assignment_completed?(user, assignment)
    assignment.my_questions.all? { |assignment_question_ids| user.responses.map(&:question_id).include?(assignment_question_ids) }
  end
end
