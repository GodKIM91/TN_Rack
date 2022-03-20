require_relative 'formatter'

class App

  def call(env)
    status, body = request(env)
    response(status, body)
  end

  private

  def request(env)
    return wrong_path unless env['REQUEST_PATH'] == '/time'
    formatter = Formatter.new(Rack::Request.new(env).params)
    return unknown_format(formatter) unless formatter.success?
    [200, formatter.time]
  end

  def response(status, body)
    Rack::Response.new(body, status, headers).finish
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def wrong_path
    [404, 'Page not found']
  end

  def unknown_format(formatter)
    [400, "Unknown time format(s): #{formatter.invalid}"]
  end
end