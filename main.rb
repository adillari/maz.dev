# frozen_string_literal: true

require "bundler/setup"
require "sinatra"
require "csv"

set :public_folder, File.dirname(__FILE__) + "/public"

before do
  @log_file_path = "visit_log.csv"
end

get "/" do
  log_request(request)
  @visits = File.foreach(@log_file_path).count
  erb :index
end

get "/info" do
  @visitors = CSV.read(@log_file_path)
  erb :visitors
end

def log_request(request)
  CSV.open(@log_file_path, "a") do |log|
    log << [Time.now.to_s, request.ip.to_s, request.user_agent, request.path]
  end
end
