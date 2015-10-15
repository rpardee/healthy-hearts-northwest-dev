# https://stackoverflow.com/questions/17226902/custom-helper-methods-for-rails-3-2-migrations
require File.expand_path('lib/cache_helper')
include CacheHelper

class AddCacheFieldsToPractice < ActiveRecord::Migration
  # Problem is bad perf (n+1 queries) on /partners/show for partners
  # that have a lot of associated practices.  Querying the associated
  # personnells (for primary contact) and events (for last activity & PAL status)
  # takes way too long.  Try adding fields to practice to hold values we will
  # manage with activerecord callbacks on personnells and events.
  def up
    add_column :practices, :pc_name_cached, :string
    add_column :practices, :la_date_cached, :date
    add_column :practices, :pal_status_cached, :string
    CacheHelper.reset_cache_money
  end
  def down
    remove_column :practices, :pc_name_cached, :string
    remove_column :practices, :la_date_cached, :date
    remove_column :practices, :pal_status_cached, :string
  end
end
