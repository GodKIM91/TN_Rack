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

  def success?
    @params.each do |format|
      if TIME_FORMATS[format]
        @valid << TIME_FORMATS[format]
      else
        @invalid << format
      end
    end
    @invalid.empty?
  end

  def time
    Time.now.strftime(@valid.join('-'))
  end
end