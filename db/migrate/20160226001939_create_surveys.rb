class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :practice
      t.string :survey_type
      t.integer :administration
      t.date :date_sent
      t.string :status
      t.float :percent_complete

      t.timestamps null: false
    end
  end
end
