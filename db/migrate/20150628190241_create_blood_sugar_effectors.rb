class CreateBloodSugarEffectors < ActiveRecord::Migration
  def change
    create_table :blood_sugar_effectors do |t|
      t.string   "name",           limit: 255, null: false
      t.integer  "index",          limit: 4,   null: false
      t.string   "type",           limit: 255, null: false
      t.timestamps null: false
    end
  end
end
