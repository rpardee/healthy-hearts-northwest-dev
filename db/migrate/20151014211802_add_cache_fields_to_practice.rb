class AddCacheFieldsToPractice < ActiveRecord::Migration
  # Problem is bad perf (n+1 queries) on /partners/show for partners
  # that have a lot of associated practices.  Querying the associated
  # personnells (for primary contact) and events (for last activity & PAL status)
  # Takes way too long.  Try adding fields to practice to hold values we will
  # manage with activerecord callbacks on personnells and events.
  def change
    add_column :practices, :pc_name_cached, :string
    add_column :practices, :la_date_cached, :date
    add_column :practices, :pal_status_cached, :string
    execute "update practices set pc_name_cached = 'None Assigned'"
    execute "update practices set pal_status_cached = false"
  end
end
