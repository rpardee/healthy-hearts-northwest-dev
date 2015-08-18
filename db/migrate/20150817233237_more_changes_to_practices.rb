class MoreChangesToPractices < ActiveRecord::Migration
  def change
  	remove_column :practices, :npi, :string
  	remove_column :practices, :elig_ownership, :integer
  	rename_column :practices, :elig_ownership_other, :prac_own_other_specify
  	rename_column :practices, :elig_ownership_years, :prac_own_yrs
  	rename_column :practices, :elig_specialty, :prac_spec_mix
  	rename_column :practices, :elig_phys_count, :number_clinicians
  	rename_column :practices, :elig_phys_fte, :fte_clinicians
  	rename_column :practices, :elig_pcmh, :prac_pcmh
  	remove_column :practices, :elig_aco, :integer
  	rename_column :practices, :elig_aco_apply, :prac_aco_join_medicaid
  	change_table :practices do |t|
  		t.column :prac_own_clinician, :boolean, default: false
  		t.column :prac_own_hosp, :boolean, default: false
  		t.column :prac_own_hmo, :boolean, default: false
  		t.column :prac_own_fqhc, :boolean, default: false
  		t.column :prac_own_nonfed, :boolean, default: false
  		t.column :prac_own_academic, :boolean, default: false
  		t.column :prac_own_fed, :boolean, default: false
  		t.column :prac_own_rural, :boolean, default: false
  		t.column :prac_own_ihs, :boolean, default: false
  		t.column :prac_own_other, :boolean, default: false
  		t.column :prac_aco_medicaid, :boolean, default: false
  		t.column :prac_aco_medicare, :boolean, default: false
  		t.column :prac_aco_commercial, :boolean, default: false
  		t.column :prac_aco_other, :boolean, default: false
  		t.column :prac_aco_none, :boolean, default: false
  		t.column :prac_aco_dk, :boolean, default: false
  		t.column :prac_aco_join_medicare, :integer
  		t.column :prac_aco_join_commercial, :integer
  	end
  end
end
