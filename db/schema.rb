# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_23_063404) do

  create_table "courses", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "order"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "exam_answers", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "exam_question_id", null: false
    t.bigint "word_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_question_id", "word_id"], name: "index_exam_answers_on_exam_question_id_and_word_id", unique: true
    t.index ["exam_question_id"], name: "index_exam_answers_on_exam_question_id"
    t.index ["word_id"], name: "index_exam_answers_on_word_id"
  end

  create_table "exam_questions", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "true_answer_id", null: false
    t.bigint "user_answer_id"
    t.bigint "exam_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exam_id"], name: "index_exam_questions_on_exam_id"
    t.index ["true_answer_id"], name: "index_exam_questions_on_true_answer_id"
    t.index ["user_answer_id"], name: "index_exam_questions_on_user_answer_id"
  end

  create_table "exams", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "lesson_id", null: false
    t.boolean "is_finished", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_exams_on_lesson_id"
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "lessons", charset: "utf8mb4", force: :cascade do |t|
    t.integer "order"
    t.string "name"
    t.text "description"
    t.boolean "completed", default: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "words", charset: "utf8mb4", force: :cascade do |t|
    t.string "definition"
    t.string "translation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "lesson_id", null: false
    t.index ["lesson_id"], name: "index_words_on_lesson_id"
  end

  add_foreign_key "exam_answers", "exam_questions"
  add_foreign_key "exam_answers", "words"
  add_foreign_key "exam_questions", "exams"
  add_foreign_key "exam_questions", "words", column: "true_answer_id"
  add_foreign_key "exam_questions", "words", column: "user_answer_id"
  add_foreign_key "exams", "lessons"
  add_foreign_key "exams", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "words", "lessons"
end
