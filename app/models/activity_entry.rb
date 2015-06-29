class ActivityEntry
  # Class that holds info of the type timestamp-activity as entered by user
  # figure out if this needs to persist or not, can be form data in a full fledged app

  attr_accessor :activity_time, :activity, :beginning_of_day, :offset_start, :offset_end

  def initialize(options={})
    # Add error handling need atleast 3 options
    if options.keys.include?(:offset_start)
      @offset_start = options[:offset_start]
      @offset_end = options[:offset_end]
      @activity = options[:effector]
      @activity_time = options[:time]
    else
      @activity_time = options[:time]
      @beginning_of_day = DateTime.now.beginning_of_day
      #((DateTime.now-800.minutes-DateTime.now.beginning_of_day)*24*60).to_f.round
      @offset_start = ((options[:time] - @beginning_of_day) * 24 * 60 ).to_f.round
      @offset_end = @offset_start + options[:effector].effect_in_mins
      @activity = options[:effector]
    end
  end
end