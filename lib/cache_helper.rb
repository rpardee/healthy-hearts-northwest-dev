# Putting this here so its usable from the migration that creates the cache fields.

module CacheHelper
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
  def set_practice_sites
    oregon = Practice::PRAC_STATE_VALS['OR']
    orprn = Site.find_by_name('ORPRN').id
    qualis = Site.find_by_name('Qualis').id
    counter = 0
    Practice.all.each do |p|
      if p.prac_state == oregon
        p.site_id = orprn
      else
        p.site_id = qualis
      end
      p.save!
      counter += 1
      puts("Set site_id on #{counter} practice records") if counter % 10 == 0
    end
    puts("Finished.  Set site_id on #{counter} practice records total.")
  end
end
