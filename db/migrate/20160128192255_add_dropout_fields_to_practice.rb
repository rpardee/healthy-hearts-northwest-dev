class AddDropoutFieldsToPractice < ActiveRecord::Migration
  def change
  	add_column :practices, :active, :boolean, :default => true
  	add_column :practices, :inactive_rsn, :integer
  	add_column :practices, :drop_dt, :date
  	add_column :practices, :drop_reentry_dt, :date
  	add_column :practices, :drop_determine, :integer
  	add_column :practices, :drop_contact_num, :string
  	add_column :practices, :drop_contact_who, :string
  	add_column :practices, :drop_notify_who, :string
  	add_column :practices, :drop_notify_how, :integer
  	add_column :practices, :drop_notify_dt, :date
  	add_column :practices, :drop_notify_rsn_demanding, :boolean
  	add_column :practices, :drop_notify_rsn_priority, :boolean
  	add_column :practices, :drop_notify_rsn_barrier, :boolean
  	add_column :practices, :drop_notify_rsn_relevant, :boolean
  	add_column :practices, :drop_notify_rsn_other, :boolean
  	add_column :practices, :drop_notify_rsn_specify, :string
  	add_column :practices, :drop_decide_who, :string
  	add_column :practices, :drop_decide_why, :string
  	add_column :practices, :drop_comments, :text
  end
end
