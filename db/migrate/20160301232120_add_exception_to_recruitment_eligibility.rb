class AddExceptionToRecruitmentEligibility < ActiveRecord::Migration
  def change
  	add_column :practices, :eligibility_exception, :text
  end
end
