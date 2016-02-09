module SurveysHelper
  def surveyable_export(practices)
    require "csv"
    to_export = {
      site_id: 'Site',
      name: 'Practice Name',
      study_id: 'Study ID',
      formatted_address: 'Address',
      pc_name: 'Primary Contact Name',
      pc_email1: 'Primary Contact E-Mail',
      welcome_date: 'FRIPC Date',
      ss_name: 'Staff Survey Recipient Name',
      ss_email: 'Staff Survey Recipient E-mail',
      drop_dt: 'Drop Date',
      c_name: 'Coach Name',
      c_email: 'Coach E-mail',
      pal_status_cached: 'PAL status',
      }
    csv_string = CSV.generate do |csv|
      csv << to_export.values
      practices.each do |p|
        pc = p.personnels.where(site_contact_primary: true).first
        fc = p.ivcontacts.where(contact_type: 1).order(:contact_dt).first
        pr = Partner.find(p.coach_id) if p.coach_id
        wanted_attributes = Hash.new
        to_export.keys.each do |k|
          wanted_attributes[k] = case k
          when :site_id
            p.site.name
          when :pc_name
            pc.name if pc
          when :pc_email1
            pc.email1 if pc
          when :welcome_date
            fc.contact_dt if fc
          when :ss_name
            fc.smsvy_name if fc
          when :ss_email
            fc.smsvy_email if fc
          when :c_name
            pr.name if pr
          when :c_email
            pr.email if pr
          else
            p.send(k)
          end # case
        end # keys.each
        csv << wanted_attributes.values
      end # practices.each
    end # csv.generate
  end
end
