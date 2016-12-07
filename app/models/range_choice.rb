class RangeChoice < ApplicationRecord
  has_one :question, as: :question_type

  def get_results(result)
    [result.to_i]
  end
end
