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
    to_export = {study_id:                      'Study ID',
                  name:                         'Name',
                  parent_organization:          'Parent Org',
                  current_partner:              'Primary Recruiter',
                  recruitment_source:           'Recruitment Source',
                  address:                      'Address',
                  city:                         'City',
                  prac_state:                   'State',
                  zip_code:                     'Zip',
                  phone:                        'Phone',
                  url:                          'Website',
                  email:                        'E-mail',
                  residency_training_site:      'Residency Training Site?',
                  number_clinicians:            'No. clinicians',
                  fte_clinicians:               'Clinician FTE',
                  interest_yn:                  'Interested?',
                  primary_care:                 'Primary Care',
                  prac_own_clinician:           'Clinician owned?',
                  prac_own_hosp:                'Hosp/healthsys owned?',
                  prac_own_hmo:                 'HMO Owned?',
                  prac_own_fqhc:                'FQHC Owned?',
                  prac_own_nonfed:              'Nonfed Owned?' ,
                  prac_own_academic:            'Academic Owned?',
                  prac_own_fed:                 'Federal?',
                  prac_own_rural:               'Rural?',
                  prac_own_ihs:                 'IHS?',
                  prac_own_other:               'Other Owned',
                  prac_own_yrs:                 'Years Owned',
                  elig_clinic_count:            'PC Count',
                  prac_spec_mix:                'Specialty Mix',
                  prac_pcmh:                    'PCMH?',
                  prac_aco_medicaid:            'Medicaid ACO',
                  prac_aco_medicare:            'Medicare ACO' ,
                  prac_aco_commercial:          'Private/Commercial ACO',
                  prac_aco_other:               'Other ACO',
                  prac_aco_none:                'Not an ACO',
                  prac_aco_join_medicaid:       'Join Medicaid ACO?',
                  prac_aco_join_medicare:       'Join Medicare ACO?',
                  prac_aco_join_commercial:     'Join Commercial ACO?',
                  prac_ehr:                     'EHR',
                  prac_ehr_extractdata:         'Have data extractor?',
                  prac_ehr_person_extractdata:  'Data Extractor',
                  prac_it_support:              'Have HIT support?',
                  pc_name_cached:               'Primary Contact',
                  la_date_cached:               'Last Activity',
                  pal_status_cached:            'PAL Status',
                  site_id:                      'Site',
                  id:                           'Database ID'}

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
                                  when :primary_care, :interest_yn
                                    Practice::YN12_VALS.key(user.send(k))
                                  when :prac_spec_mix
                                    Practice::PRAC_SPEC_MIX_VALS.key(user.send(k))
                                  when :prac_ehr_extractdata
                                    Practice::PRAC_EHR_EXTRACTDATA_VALS.key(user.send(k))
                                  when :prac_ehr_person_extractdata
                                    Practice::PRAC_EHR_PERSON_EXTRACTDATA_VALS.key(user.send(k))
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
