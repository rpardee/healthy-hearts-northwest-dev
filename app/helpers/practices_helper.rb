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
    to_export = {
                  id:                           'Database ID',
                  study_id:                     'Study ID',
                  name:                         'Name',
                  enrolled:                     'Enrolled?',
                  interest_yn:                  'Interested?',
                  status:                       'Status',
                  pal_status_cached:            'PAL Status',
                  la_date_cached:               'Last Activity',
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
                  prac_aco_dk:                  "Don't Know ACO",
                  prac_aco_none:                'Not an ACO',
                  prac_aco_join_medicaid:       'Join Medicaid ACO?',
                  prac_aco_join_medicare:       'Join Medicare ACO?',
                  prac_aco_join_commercial:     'Join Commercial ACO?',
                  prac_ehr:                     'EHR',
                  prac_ehr_extractdata:         'Have data extractor?',
                  prac_ehr_person_extractdata:  'Data Extractor',
                  prac_it_support:              'Have HIT support?',
                  prim_con_name:                'Primary Contact',
                  prim_con_phone:               'Primary Contact Phone',
                  prim_con_email:               'Primary Contact Email',
                  ehr_ext_name:                 'EHR Extractor',
                  ehr_ext_phone:                'EHR Extractor Phone',
                  ehr_ext_email:                'EHR Extractor Email',
                  ehr_hlp_name:                 'EHR Helper',
                  ehr_hlp_phone:                'EHR Helper Phone',
                  ehr_hlp_email:                'EHR Helper Email',
                  site_id:                      'Site',
                }

    csv_string = CSV.generate do |csv|
      csv << to_export.values
      practices.all.each do |prac|
        prim_con  = prac.personnels.where(site_contact_primary: true).first
        ehr_ext   = prac.personnels.where(ehr_extractor: true).first
        ehr_hlp   = prac.personnels.where(ehr_helper: true).first
        wanted_attributes = Hash.new
        to_export.keys.each do |k|
          wanted_attributes[k] = case k
                                  when :enrolled
                                    (prac.pal_status_cached == 'Returned')
                                  when :prac_state
                                    Practice::PRAC_STATE_VALS.key(prac.send(k))
                                  when :prac_ehr
                                    Practice::PRAC_EHRNAME_VALS.key(prac.send(k))
                                  when :recruitment_source
                                    Practice::RECRUITMENT_SOURCE_VALS.key(prac.send(k))
                                  when :primary_care, :interest_yn
                                    Practice::YN12_VALS.key(prac.send(k))
                                  when :prac_spec_mix
                                    Practice::PRAC_SPEC_MIX_VALS.key(prac.send(k))
                                  when :prac_ehr_extractdata
                                    Practice::PRAC_EHR_EXTRACTDATA_VALS.key(prac.send(k))
                                  when :prac_ehr_person_extractdata
                                    Practice::PRAC_EHR_PERSON_EXTRACTDATA_VALS.key(prac.send(k))
                                  when :site_id
                                    prac.site ? prac.site.name : 'Not assigned'
                                  when :prim_con_name
                                    prim_con.name if prim_con
                                  when :prim_con_phone
                                    prim_con.phone1 if prim_con
                                  when :prim_con_email
                                    prim_con.email1 if prim_con
                                  when :ehr_ext_name
                                    ehr_ext.name if ehr_ext
                                  when :ehr_ext_phone
                                    ehr_ext.phone1 if ehr_ext
                                  when :ehr_ext_email
                                    ehr_ext.email1 if ehr_ext
                                  when :ehr_hlp_name
                                    ehr_hlp.name if ehr_hlp
                                  when :ehr_hlp_phone
                                    ehr_hlp.phone1 if ehr_hlp
                                  when :ehr_hlp_email
                                    ehr_hlp.email1 if ehr_hlp
                                  else
                                    prac.send(k)
                                  end

        end
        csv << wanted_attributes.values
      end
    end
  end
end
