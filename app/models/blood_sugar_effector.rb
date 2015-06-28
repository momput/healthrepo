class BloodSugarEffector < ActiveRecord::Base

  def self.types
    ["Food", "Exercise"]
  end

  self.types.each do | method |
    define_method "is_#{method.downcase}?" do
      self.type == method
    end
  end
end
