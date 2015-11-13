module PracticesHelper
  def check_practice_cache
    agree_count = 0
    problem_practices = Array.new
    prob_list = ""
    Practice.all.each do |p|
      if p.la_date_cached == p.last_contact and (p.pal_status_cached || "") == p.pal_status and (p.pc_name_cached || "") == (p.primary_contact || "")
        agree_count += 1
      else
        problem_practices << p
      end
    end
    problem_practices.each do |p|
      prob_list << "#{p.id}: Last activity: cache: #{p.la_date_cached}, actual: #{p.last_contact}\n" unless p.la_date_cached == p.last_contact
      prob_list << "#{p.id}: PAL status: cache: #{p.pal_status_cached}, actual: #{p.pal_status}\n" unless (p.pal_status_cached || "") == p.pal_status
      prob_list << "#{p.id}: Primary Contact: cache: #{p.pc_name_cached}, actual: #{p.primary_contact}\n" unless (p.pc_name_cached || "") == (p.primary_contact || "")
    end
    puts prob_list
    puts "All OK for #{agree_count} practices.  There were problems for #{problem_practices.length} practices."
  end
end
