class MultipleChoice< ApplicationRecord
  has_one :question, as: :question_type

  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options, allow_destroy: true, reject_if: :all_blank

  def get_results(result_ids)
    options.where(id: result_ids).map{|o| o.text }
  end
end
