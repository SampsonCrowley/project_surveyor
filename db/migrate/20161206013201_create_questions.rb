class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.references :survey, foreign_key: true
      t.references :category, polymorphic: true
      t.string :question
      t.integer :order
      t.boolean :required

      t.timestamps
    end
  end
end
