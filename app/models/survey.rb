# t.references :practice
# t.string :survey_type
# t.int :administration
# t.date :date_sent
# t.string :status
# t.float :percent_complete

class Survey < ActiveRecord::Base

  belongs_to :practice

  def self.write_abcs(row, practice, result)
    # Create additional survey records for any ABCSs
    # CHANGE TO FIRST DAY AFTER THE QUARTER
    abcs_fields = { :q20154 => Date.new(2015, 9, 1),
                    :q20161 => Date.new(2016, 1, 1),
                    :q20162 => Date.new(2016, 3, 1),
                    :q20163 => Date.new(2016, 6, 1),
                    :q20164 => Date.new(2016, 9, 1),
                    :q20171 => Date.new(2017, 1, 1),
                    :q20172 => Date.new(2017, 3, 1),
                    :q20173 => Date.new(2017, 6, 1),
                    :q20174 => Date.new(2017, 9, 1),
                    :q20181 => Date.new(2018, 1, 1),
                    :q20182 => Date.new(2018, 3, 1),
                    :q20183 => Date.new(2018, 6, 1),
                    :q20184 => Date.new(2018, 9, 1)
                  }
    # We will overwrite this info on every import, in case one of these gets added by mistake.
    practice.surveys.where(survey_type: 'ABCS').delete_all
    abcs_fields.keys.each do |afld|
      if row[afld.to_s] == 1 then
        ds = abcs_fields[afld]
        srv = Survey.find_or_initialize_by(practice_id: practice.id, survey_type: "ABCS", date_sent: ds)
        srv.date_sent = ds
        srv.status = afld
        srv.save!
        result[:new_rows] += 1
      end
    end

  end

  def self.import_excel(file, spreadsheet_type)

    # raise spreadsheet_type
    result = Hash.new(0)

    result[:error_messages] = ""
    result[:spreadsheet_type] = "#{spreadsheet_type}"
    result[:original_filename] = file.original_filename

    spreadsheet = Roo::Spreadsheet.open(file)
    result[:file_info] = spreadsheet.info


    header = spreadsheet.row(1)
    if header.include?("PracticeID")
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        pid = row["PracticeID"].to_i
        if pid == 0
          result[:error_rows] += 1
          result[:error_messages] += "\nNo PracticeID value in row #{i}--data not usable."
        else
          prac = Practice.find_by(study_id: pid.to_s)
          if prac
            if spreadsheet_type == 'practice'
              survey_type = "Practice"
            elsif spreadsheet_type == 'staff_abcs'
              survey_type = "Staff"
            end

            # raise survey_type

            srv = Survey.find_or_initialize_by(practice_id: prac.id, survey_type: survey_type)

            # raise srv.survey_type

            already_existed = srv.persisted?

            if spreadsheet_type == 'staff_abcs'
              srv.date_sent = row["Sent"]
              srv.percent_complete = row["% of Staff completed"] || row["% of Staff completed "]
              srv.status = "complete" if srv.percent_complete == 1
              write_abcs(row, prac, result)
            elsif spreadsheet_type == 'practice' then
              srv.date_sent = row["Date sent"]
              srv.status = row["Status"]
            end

            if srv.save
              if already_existed
                result[:updated_rows] += 1
              else
                result[:new_rows] += 1
              end
            else
              result[:error_rows] += 1
              srv.errors.full_messages.each do |em|
                result[:error_messages] += "\n#{em}."
              end
            end
          else
            result[:error_rows] += 1
            result[:error_messages] += "\nNo practice found with PracticeID #{pid} (in row #{i})."
          end
        end
      end
    else
      result[:error_messages] = "Could not find a column headed 'PracticeID'.  Please correct your spreadsheet and try again."
    end

    return result
  end

  SURVEY_TYPES = {staff: "Staff",
                  prac: "Practice",
                  abcs: "ABCS"
  }

  SURVEY_STATUSES = {not_eligible: 'Not eligible',
                    not_sent: 'Not yet sent',
                    sent: 'Sent, no response yet',
                    completed: 'Completed',
                    declined: 'Declined'
  }

  SPREADSHEET_TYPES = {
    staff_abcs: 'Staff/ABCS',
    practice: 'Practice'
  }

end
