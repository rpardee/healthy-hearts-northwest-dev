class AddReentryFieldsToDropout < ActiveRecord::Migration
  def change
  	add_column :practices, :reentry_who, :string
  	add_column :practices, :reentry_comment, :text
  end
end
