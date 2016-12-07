class CreateRangeChoices < ActiveRecord::Migration[5.0]
  def change
    create_table :range_choices do |t|
      t.integer :min, default: 0
      t.integer :max

      t.timestamps
    end
  end
end
