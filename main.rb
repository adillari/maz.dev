# frozen_string_literal: true

require "bundler/setup"
require "sinatra"

before do
  @log_file_path = "visit_log.csv"
end

get "/" do
  log_request(request)
  @visits = File.foreach(@log_file_path).count
  erb :index
end

def log_request(request)
  File.open(@log_file_path, "a") do |file|
    file.puts "#{Time.now}, #{request.ip}, #{request.user_agent}, #{request.path}"
  end
end
