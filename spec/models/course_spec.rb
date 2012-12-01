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

require 'spec_helper'

describe Course do
  pending "add some examples to (or delete) #{__FILE__}"
end
