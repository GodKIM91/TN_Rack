require_relative 'formatter'

class App

  def call(env)
    if env['REQUEST_PATH'] != '/time'
      response(404, 'Page not found')
    else
      parse_params(env)
    end
  end

  private

  def parse_params(env)
    formatter = Formatter.new(Rack::Request.new(env).params)
    formatter.sort_params
    if formatter.full_correct?
      response(200, formatter.time)
    else
      response(400, "Unknown time format(s): #{formatter.invalid}")
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response(status, body)
    Rack::Response.new(body, status, headers).finish
  end
end