require_relative 'formatter'

class App

  def call(env)
    @request = Rack::Request.new(env)
    response
    [status, headers, body]
  end

  private

  def response
    return wrong_path unless @request.path_info == '/time'
    @formatter = Formatter.new(@request.params)
    @formatter.check_format
    return unknown_format unless @formatter.success?
    formatted_time
  end

  def status
    @status_code
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body
    ["#{@message}"]
  end

  def formatted_time
    @status_code = 200
    @message = @formatter.time
  end

  def unknown_format
    @status_code = 400
    @message = "Unknown time format(s): #{@formatter.invalid}"
  end

  def wrong_path
    @status_code = 404
    @message = 'Page not found'
  end
end