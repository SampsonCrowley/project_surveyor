class Option < ApplicationRecord
  belongs_to :multiple_choice, :counter_cache => true
end
