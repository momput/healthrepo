#lib/tasks/import.rake
require 'csv'
desc "Imports a CSV file into an ActiveRecord table"
task :import, [:filename] => :environment do
  CSV.foreach('food.csv', :headers => true) do |row|
    row = row.delete_if{|k,v| k == 'id'}
    row['type'] = 'Food'
    BloodSugarEffector.create!(row.to_hash)
  end
  CSV.foreach('exercise.csv', :headers => true) do |row|
    row = row.delete_if{|k,v| k == 'id'}
    row['type'] = 'Exercise'
    BloodSugarEffector.create!(row.to_hash)
  end
end

