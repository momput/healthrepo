class Simulator

  # Expects activity log with time-activity info
  TIME_6AM = 360

  MINS_IN_A_DAY = 1440

  def self.simulate(log)
    blood_sugar = 80

    # Preprocess logs for inactive slots

    prev_start = 0
    beginning_of_day = log.activity_logs[log.activity_logs.keys.first].activity_time.beginning_of_day
    prev_start_time = 0
    sorted_range = log.activity_logs.keys.sort{|range1, range2| range1.first <=> range2.first}

    sorted_range.each do |range|
      is_am = prev_start <= TIME_6AM || range.first-1 <=TIME_6AM # Fix this
      log.add_inactive_entry(prev_start+1, range.first-1, prev_start_time, is_am) if range.first - prev_start > 0
      # Reset
      prev_start = range.last
      prev_start_time = log.activity_logs[range].activity_time + 1.minutes
    end
    log.add_inactive_entry(sorted_range.last.last.to_i, MINS_IN_A_DAY, sorted_range.last.last + 1.minutes, false)
    sorted_range = log.activity_logs.keys.sort{|range1, range2| range1.first <=> range2.first}

    blood_sugar_graph = {}
    sorted_range.each do |selected_range|
      for i in selected_range
        blood_sugar = blood_sugar + log.activity_logs[selected_range].activity.change_per_minute
        readable_time = beginning_of_day
        readable_time = readable_time + i.minutes
        readable_time = readable_time.in_time_zone('Pacific Time (US & Canada)')

        blood_sugar_graph[readable_time] =  blood_sugar
        if blood_sugar < 0
          raise Exception.new "ERROR: Data likely messed. Blood Sugar negative"
        end
      end
    end

    blood_sugar_graph.each do |readable_time, bs|
      p "#{readable_time}, #{bs}"
    end

    ""
  end
end


