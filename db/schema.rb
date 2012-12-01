# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121201034211) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "content"
    t.boolean  "correct_ans", :default => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.boolean  "correct",     :default => false
  end

  create_table "assignments", :force => true do |t|
    t.string   "name"
    t.boolean  "published",    :default => false
    t.datetime "due_date"
    t.integer  "total_points"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "anonymous",    :default => false
  end

  create_table "courses", :force => true do |t|
    t.string   "course_name"
    t.string   "semester"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "courses", ["course_name", "semester", "user_id"], :name => "index_courses_on_course_name_and_semester_and_user_id"

  create_table "enrollments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "enrollments", ["course_id"], :name => "index_enrollments_on_course_id"
  add_index "enrollments", ["user_id", "course_id"], :name => "index_enrollments_on_user_id_and_course_id", :unique => true
  add_index "enrollments", ["user_id"], :name => "index_enrollments_on_user_id"

  create_table "grades", :force => true do |t|
    t.integer  "user_id"
    t.integer  "assignment_id"
    t.integer  "course_id"
    t.integer  "grade"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "grades", ["assignment_id"], :name => "index_grades_on_assignment_id"
  add_index "grades", ["course_id"], :name => "index_grades_on_course_id"
  add_index "grades", ["user_id"], :name => "index_grades_on_user_id"

  create_table "microposts", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "microposts", ["user_id", "created_at"], :name => "index_microposts_on_user_id_and_created_at"

  create_table "questions", :force => true do |t|
    t.integer  "assignment_id"
    t.text     "content"
    t.boolean  "anonymous",           :default => false
    t.boolean  "allow_free_response", :default => false
    t.integer  "points"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "responses", :force => true do |t|
    t.integer  "answer_id"
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "responses", ["answer_id"], :name => "index_responses_on_answer_id"
  add_index "responses", ["question_id"], :name => "index_responses_on_question_id"
  add_index "responses", ["user_id"], :name => "index_responses_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           :default => false
    t.boolean  "professor",       :default => false
    t.boolean  "ta",              :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
