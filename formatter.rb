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
  end

  def check_format
    @valid, @invalid = @params.partition { |format| TIME_FORMATS[format] }
  end

  def success?
    @invalid.empty?
  end

  def time
    formats = @valid.map { |format| TIME_FORMATS[format]}
    Time.now.strftime(formats.join('-'))
  end
end