class CreateHighLeverageChangeTests < ActiveRecord::Migration
  def change
    create_table :high_leverage_change_tests do |t|
      t.references :ivcontact, index: true, foreign_key: true
      t.text :description
      t.integer :test_status
      t.text :comments
      t.boolean :embed_evidence
      t.boolean :use_data
      t.boolean :xfunc_qi
      t.boolean :id_at_risk
      t.boolean :manage_pops
      t.boolean :self_management
      t.boolean :resource_linkages

      t.timestamps null: false
    end
  end
end
