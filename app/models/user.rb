class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :exams, dependent: :destroy
  has_many :word_associations, class_name: UserLearnWord.name,
                               dependent: :destroy
  has_many :learned_words, through: :word_associations, source: :word
  has_many :learning_lesson_accomplishments,
           ->{where status: :learning},
           class_name: LessonAccomplishment.name,
           dependent: :destroy
  has_many :learning_lessons,
           through: :learning_lesson_accomplishments,
           source: :lesson
  has_many :completed_lesson_accomplishments,
           ->{where status: :completed},
           class_name: LessonAccomplishment.name,
           dependent: :destroy
  has_many :completed_lessons,
           through: :completed_lesson_accomplishments,
           source: :lesson

  validates :name, presence: true,
                   length: {maximum: Settings.user.name_max_length}
  validates :email, presence: true,
                    length: {maximum: Settings.user.email_max_length},
                    format: {
                      with: Regexp.new(Settings.user.VALID_EMAIL_REGEX, true)
                    },
                    uniqueness: true
  validates :password, presence: true,
                       length: {minimum: Settings.user.password_min_length},
                        allow_nil: true

  scope :learners, ->{where(admin: false)}

  def learn word
    word_associations.create word: word
    learning_lessons << word.lesson
  rescue ActiveRecord::RecordNotUnique
    word_associations.find_by word: word
  end

  def learned? word
    learned_words.include? word
  end

  def learning_courses
    Course.where id: learning_lessons.pluck(:course_id)
  end
end
