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

  def export(practices)
  to_export = {study_id:              'Study ID',
                name:                 'Name',
                address:              'Address',
                phone:                'Phone',
                url:                  'Website',
                created_at:           'Record Created At',
                updated_at:           'Last DB update',
                email:                'E-mail',
                recruitment_source:   'Recruitment Source',
                prac_ehr:             'EHR',
                current_partner:      'Current Partner',
                parent_organization:  'Parent Org',
                prac_state:           'State',
                zip_code:             'Zip',
                city:                 'City',
                pc_name_cached:       'Primary Contact',
                la_date_cached:       'Last Activity',
                pal_status_cached:    'PAL Status',
                site_id:              'Site',
                id:                   'Database ID'}

    csv_string = CSV.generate do |csv|
      csv << to_export.values
      Practice.all.each do |user|
        wanted_attributes = Hash.new
        to_export.keys.each do |k|
          wanted_attributes[k] = case k
                                  when :prac_state
                                    Practice::PRAC_STATE_VALS.key(user.send(k))
                                  when :prac_ehr
                                    Practice::PRAC_EHRNAME_VALS.key(user.send(k))
                                  when :recruitment_source
                                    Practice::RECRUITMENT_SOURCE_VALS.key(user.send(k))
                                  when :site_id
                                    user.site ? user.site.name : 'Not assigned'
                                  else
                                      user.send(k)
                                  end

        end
        csv << wanted_attributes.values
      end
    end
  end
end
