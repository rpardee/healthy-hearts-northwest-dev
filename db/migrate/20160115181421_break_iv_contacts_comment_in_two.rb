class BreakIvContactsCommentInTwo < ActiveRecord::Migration
  def change
  	add_column :ivcontacts, :observations, :text
  end
end
