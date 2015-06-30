class BloodSugarEffector < ActiveRecord::Base

  def self.types
    ["Food", "Exercise", "Sleep"]
  end

  self.types.each do | method |
    define_method "is_#{method.downcase}?" do
      self.type == method
    end
  end

  def change_per_minute
    -1
  end

  def effect_in_mins
    1
  end

  def is_active?
    ["Food", "Exercise"].include? self.type
  end

end
