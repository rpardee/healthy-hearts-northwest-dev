class AddPracticeSurveyFields < ActiveRecord::Migration
  def change
  	change_table :practice_surveys do |t|
  		t.integer :prac_race_white
  		t.integer :prac_race_black
  		t.integer :prac_race_aian
  		t.integer :prac_race_asian
  		t.integer :prac_race_pi
  		t.integer :prac_race_other
  		t.integer :prac_race_unk
  		t.integer :prac_race_nocoll
  		t.integer :prac_ethnicity_h
  		t.integer :prac_ethnicity_nh
  		t.integer :prac_ethnicity_unk
  		t.integer :prac_ethnicity_nocoll
  		t.integer :prac_pat_age_lt17
  		t.integer :prac_pat_age_18to39
  		t.integer :prac_pat_age_40to59
  		t.integer :prac_pat_age_60to75
  		t.integer :prac_pat_age_76andover
  		t.integer :prac_payor_medicare
  		t.integer :prac_payor_medicaid
  		t.integer :prac_payor_dual
  		t.integer :prac_payor_commercial
  		t.integer :prac_payor_noins
  		t.integer :prac_payor_other
  		t.integer :prac_payor_specify
  		t.integer :prac_under_ser
  	end
  end
end
