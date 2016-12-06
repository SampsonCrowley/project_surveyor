class CreateMultipleChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :multiple_choices do |t|
      t.integer :options_count, default: 0
      t.boolean :multi

      t.timestamps
    end
  end
end
