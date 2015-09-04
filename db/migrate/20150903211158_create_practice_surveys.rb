class CreatePracticeSurveys < ActiveRecord::Migration
  def change
    create_table :practice_surveys do |t|
    	t.references :practice, index: true, foreign_key: true, null: false
    	t.string :survey_key
    	t.integer :last_page_saved
    	t.string :name_survey_completer , null: false
    	t.string :role_survey_completer
    	t.float :pat_visits_week
    	t.integer :pat_panel
    	t.float :pat_panel_sz
    	t.float :prov_visits_day
      t.timestamps null: false
    end
  end
end
