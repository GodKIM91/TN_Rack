class Formatter

  TIME_FORMATS = { "year"   => "%Y",
                   "month"  => "%m",
                   "day"    => "%d",
                   "hour"   => "%H",
                   "minute" => "%M",
                   "second" => "%S" }.freeze

  attr_reader :invalid

  def initialize(params)
    @params = params['format'].split(',')
    @valid = []
    @invalid = []
  end

  def sort_params
    @params.each do |format|
      if TIME_FORMATS[format]
        @valid << TIME_FORMATS[format]
      else
        @invalid << format
      end
    end
  end

  def full_correct?
    @invalid.empty?
  end

  def time
    Time.now.strftime(@valid.join('-'))
  end
end