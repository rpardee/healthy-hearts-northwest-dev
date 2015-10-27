class AddHlcOtherToHighLeverageChangeTests < ActiveRecord::Migration
  def change
    add_column :high_leverage_change_tests, :hlc_other, :boolean, :default => false
  end
end
