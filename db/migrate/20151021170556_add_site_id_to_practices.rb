# https://stackoverflow.com/questions/17226902/custom-helper-methods-for-rails-3-2-migrations
require File.expand_path('lib/cache_helper')
include CacheHelper

class AddSiteIdToPractices < ActiveRecord::Migration
  def up
    add_reference :practices, :site, index: true, foreign_key: true
    CacheHelper.set_practice_sites
  end
  def down
    remove_reference :practices, :site
  end
end
