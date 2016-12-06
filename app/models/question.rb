class Question < ApplicationRecord
  default_scope { order(:order) }
  
  before_save :new_question

  enum question_type: [:multiple_choice, :range]

  belongs_to :survey

  belongs_to :category, polymorphic: true, optional: true, dependent: :destroy
  accepts_nested_attributes_for :category, reject_if: :all_blank

  def self.category_list
    question_types.keys.to_a.map{|v| [v.humanize, v.to_s.classify]}
  end

  def self.category_includes?(category_to_check)
    question_types.keys.to_a.map{|v| v.to_s.classify }.include?(category_to_check)
  end

  def new_question
    unless category_id || self.category_id
      new_question = category_type.constantize.create()
      self.category_id = new_question.id
    end
  end

  def category_class
    category_type.constantize
  end

  def build_category(params)
    raise "Unknown category_type: #{category_type}" unless Question.category_includes?(category_type)
    self.category = category_type.constantize.new(params)
  end
end
