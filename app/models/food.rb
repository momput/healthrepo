class Food < BloodSugarEffector
  EFFECT_IN_MINS = 120.0

  def change_per_minute
    index/EFFECT_IN_MINS
  end

  def effect_in_mins
    EFFECT_IN_MINS
  end
end
