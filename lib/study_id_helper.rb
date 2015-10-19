module StudyIdHelper
  def initialize_study_id
    counter = 0
    Practice.all.each do |p|
      if p.pal_status == "Returned"
        counter += 1
        counter_f = "%03d" % counter
        if Practice::PRAC_STATE_VALS.key(p.prac_state) == "ID"
          study_id = "12#{counter_f}"
        elsif Practice::PRAC_STATE_VALS.key(p.prac_state) == "OR"
          study_id = "21#{counter_f}"
        elsif Practice::PRAC_STATE_VALS.key(p.prac_state) == "WA"
          study_id = "32#{counter_f}"
        else
          puts "Error: #{p.name} returned PAL but has no state set."
        end
        p.study_id = study_id
        p.save!
        puts "Set study ID to #{p.study_id}. Counter incremented to #{counter}."
      end
    end
    puts "Finished.  Set #{counter} study IDs."
    return counter
  end
end