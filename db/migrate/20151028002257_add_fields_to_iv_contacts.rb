class AddFieldsToIvContacts < ActiveRecord::Migration
  def change
    add_column :ivcontacts, :topic_review_guideline, :boolean
    add_column :ivcontacts, :topic_discuss_measurement, :boolean
  end
end
