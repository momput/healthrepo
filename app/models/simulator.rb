class Simulator

  # Expects activity log with time-activity info
  def self.simulate(logs)
    blood_sugar = 80

    for i in 0..1440
      logs.activity_logs.keys.select {|x| x.cover?(i)}.each do |selected_range|

        blood_sugar = blood_sugar + logs.activity_logs[selected_range].activity.change_per_minute
        if blood_sugar < 0
          p "ERROR: Data likely messed. Blood Sugar negative"
          return
        end
        readable_time = logs.activity_logs[selected_range].activity_time
        readabale_time = readable_time + i.minutes
        readable_time = readable_time.in_time_zone('Pacific Time (US & Canada)')

        if logs.activity_logs[selected_range].activity.is_food? || logs.activity_logs[selected_range].activity.is_exercise?
          p "#{i} is in #{selected_range} ACTIVITY TIME #{readable_time} BS = #{blood_sugar}"
        else
          p "#{i} is in #{selected_range} ACTIVITY TIME #{readable_time} no activity BS = #{blood_sugar}"
        end
      end
    end
  end
end
