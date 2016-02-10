module PracticesHelper
  require 'csv'

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
                  name:                         'Practice Name',
                  enrolled:                     'Enrolled?',
                  interest_yn:                  'Interested?',
                  status:                       'Recruitment Status',
                  pal_status_cached:            'PAL Status',
                  la_date_cached:               'Last Activity',
                  parent_organization:          'Parent Org',
                  current_partner:              'Primary Recruiter',
                  recruitment_source:           'Recruitment Source',
                  address:                      'Practice Address',
                  city:                         'Practice City',
                  prac_state:                   'Practice State',
                  zip_code:                     'Practice Zip',
                  phone:                        'Practice Phone',
                  url:                          'Practice Website',
                  email:                        'Practice E-mail',
                  residency_training_site:      'Residency Training Site?',
                  interest_yn:                  'Interested?',
                  interest_why_not:             'Why not interested?',
                  interest_why:                 'Why interested?',
                  interest_expect:              'Expected outcomes',
                  interest_challenge:           'Expected challenges',
                  interest_contact_month:       'Good month for coach visit?',
                  primary_care:                 'Primary Care',
                  number_clinicians:            'No. clinicians',
                  fte_clinicians:               'Clinician FTE',
                  prac_ehr:                     'EHR',
                  prac_ehr_mu:                  'MU-certified?',
                  prac_ehr_mu_yr:               'Year Certified',
                  prac_own_clinician:           'Clinician owned?',
                  prac_own_hosp:                'Hosp/healthsys owned?',
                  prac_own_hmo:                 'HMO Owned?',
                  prac_own_fqhc:                'FQHC Owned?',
                  prac_own_nonfed:              'Nonfed Govt Owned?' ,
                  prac_own_academic:            'Academic Owned?',
                  prac_own_fed:                 'Federal Owned?',
                  prac_own_rural:               'Rural Owned?',
                  prac_own_ihs:                 'IHS Owned?',
                  prac_own_other:               'Other Owned',
                  prac_own_other_specify:       'Other - specify',
                  prac_own_yrs:                 'Years Current Ownership',
                  elig_clinic_count:            'No. Clinics Owned by Parent Org',
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
                  prac_aco_join_commercial:     'Join Pvt/Commercial ACO?',
                  prac_ehr_extractdata:         'Have data extractor?',
                  prac_ehr_person_extractdata:  'Data Extractor',
                  prac_ehr_person_extractdata_other: 'DE--other',
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
                  active:                       'Active in Study?',
                  inactive_rsn:                 'Reason for dropping',
                  drop_dt:                      'Date dropped',
                  drop_reentry_dt:              'Date re-entered study',
                  drop_determine:               'Drop determined by',
                  drop_contact_who:             'Drop practice contact',
                  drop_notify_who:              'Who notified of the drop?',
                  drop_notify_how:              'Drop notification method',
                  drop_notify_dt:               'Date of drop notification',
                  drop_notify_rsn_demanding:    'Reason for drop: too demanding',
                  drop_notify_rsn_priority:     'Reason for drop: other priorities',
                  drop_notify_rsn_barrier:      'Reason for drop: barrier',
                  drop_notify_rsn_relevant:     'Reason for drop: H2N not useful',
                  drop_notify_rsn_other:        'Reason for drop: other',
                  drop_notify_rsn_specify:      'Reason for drop: specify',
                  drop_decide_who:              'Staff member dropping',
                  drop_decide_why:              'Staff member reason',
                  drop_comments:                'Drop Comments',
                }

    csv_string = CSV.generate do |csv|
      csv << to_export.values
      # practices.all.each do |prac|
      practices.all.find_each do |prac|
        prim_con  = prac.personnels.where(site_contact_primary: true).first
        ehr_ext   = prac.personnels.where(ehr_extractor: true).first
        ehr_hlp   = prac.personnels.where(ehr_helper: true).first
        # TODO: ? Add QI Champion.
        wanted_attributes = Hash.new
        to_export.keys.each do |k|
          wanted_attributes[k] = case k
                                  when :enrolled
                                    (prac.pal_status_cached == 'Returned')
                                  when :prac_state
                                    Practice::PRAC_STATE_VALS.key(prac.send(k))
                                  when :prac_ehr
                                    Practice::PRAC_EHR_VALS.key(prac.send(k))
                                  when :recruitment_source
                                    Practice::RECRUITMENT_SOURCE_VALS.key(prac.send(k))
                                  when :primary_care, :interest_yn, :prac_ehr_mu, :prac_pcmh
                                    Practice::YN12_VALS.key(prac.send(k))
                                  when :interest_why_not
                                    Practice::INTEREST_WHY_NOT_VALS.key(prac.send(k))
                                  when :interest_contact_month
                                    Practice::INTEREST_CONTACT_MONTH_VALS.key(prac.send(k))
                                  when :prac_spec_mix
                                    Practice::PRAC_SPEC_MIX_VALS.key(prac.send(k))
                                  when :prac_ehr_extractdata
                                    Practice::PRAC_EHR_EXTRACTDATA_VALS.key(prac.send(k))
                                  when :prac_ehr_person_extractdata
                                    Practice::PRAC_EHR_PERSON_EXTRACTDATA_VALS.key(prac.send(k))
                                  when :prac_aco_join_medicaid
                                    Practice::PRAC_ACO_JOIN_MEDICAID_VALS.key(prac.send(k))
                                  when :prac_aco_join_medicare
                                    Practice::PRAC_ACO_JOIN_MEDICARE_VALS.key(prac.send(k))
                                  when :prac_aco_join_commercial
                                    Practice::PRAC_ACO_JOIN_COMMERCIAL_VALS.key(prac.send(k))
                                  when :prac_it_support
                                    Practice::PRAC_IT_SUPPORT_VALS.key(prac.send(k))
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
