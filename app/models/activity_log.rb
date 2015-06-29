class ActivityLog
  # Class that holds sorted info of the type timestamp-activity as entered by user

  attr_accessor :activity_logs

  def initialize
    @activity_logs = {}
  end

  # Assume keys are ordered by time for now...needs to be fixed later
  def add_entry(entry)
    # TODO: Detect inactivity (no food no exercise intervals) only 1 entry for the whole day etc
    prev_range = @activity_logs.keys.last
    unless prev_range.nil?
      if entry.offset_start - prev_range.last > 60
        no_activity = ActivityEntry.new({:effector => BloodSugarEffector.new,
                                         :offset_start => prev_range.last+1,
                                         :offset_end => entry.offset_start-1,
                                         :time => @activity_logs[prev_range].activity_time + 1.minute})
        @activity_logs[no_activity.offset_start .. no_activity.offset_end] = no_activity
      end
    end
    @activity_logs[entry.offset_start .. entry.offset_end] = entry
  end
end