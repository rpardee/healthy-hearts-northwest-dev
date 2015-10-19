require File.expand_path('lib/study_id_helper')
include StudyIdHelper

class AddStudyId < ActiveRecord::Migration
  def up
    create_table :counters, id: false do |t|
    	t.integer :study_id
      t.timestamps null: false
    end
    add_column :practices, :study_id, :string, :limit => 5
    # Reset this so Practice can be updated in StudyIdHelper.initialize_study_id
    Practice.reset_column_information
    Counter.create(study_id: StudyIdHelper.initialize_study_id)
  end

  def down
    drop_table :counters
    remove_column :practices, :study_id
  end
end
