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

    end
    @activity_logs[entry.offset_start .. entry.offset_end] = entry
  end

  def add_inactive_entry(offset_start, offset_end, time, is_sleep_time)
    inactive_effector = is_sleep_time ? BloodSugarSleepEffector.new : BloodSugarEffector.new
    no_activity = ActivityEntry.new({:effector => inactive_effector,
                                     :offset_start => offset_start,
                                     :offset_end => offset_end,
                                     :time => time})
    @activity_logs[no_activity.offset_start .. no_activity.offset_end] = no_activity
  end
end