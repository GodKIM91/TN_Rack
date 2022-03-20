require_relative 'formatter'

class App

  def call(env)
    return wrong_path unless env['REQUEST_PATH'] == '/time'
    parse_params(env)
  end

  private

  def parse_params(env)
    formatter = Formatter.new(Rack::Request.new(env).params)
    formatter.sort_params
    return unknown_format(formatter) unless formatter.invalid.empty?
    response(200, formatter.time)
  end

  def response(status, body)
    Rack::Response.new(body, status, headers).finish
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def wrong_path
    [404, headers, ['Page not found']]
  end

  def unknown_format(formatter)
    [400, headers, ["Unknown time format(s): #{formatter.invalid}"]]
  end
end