# Putting this here so its usable from the migration that creates the cache fields.

module CacheHelper
  def say_penus
    3.times do
      puts("penus")
    end
    puts("::giggle::")
  end
  def reset_cache_money
    counter = 0
    Practice.all.each do |p|
      p.la_date_cached    = p.last_contact
      p.pal_status_cached = p.pal_status
      p.pc_name_cached    = p.primary_contact

      p.save!

      counter += 1
      puts("Reset cache on #{counter} practice records") if counter % 10 == 0
    end
    "Finished.  Reset #{counter} cache fields on practice records total."
  end
end
