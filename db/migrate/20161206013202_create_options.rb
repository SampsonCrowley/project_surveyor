class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.references :multiple_choice, foreign_key: true
      t.string :text

      t.timestamps
    end
  end
end
