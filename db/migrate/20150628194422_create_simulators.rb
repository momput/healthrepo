class CreateSimulators < ActiveRecord::Migration
  def change
    create_table :simulators do |t|

      t.timestamps null: false
    end
  end
end
