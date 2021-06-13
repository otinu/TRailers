# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
#
# every 12.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end

# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = Rails.env.to_sym
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
set :output, 'log/cron.log'

every 3.day, at: '6:00pm' do
  runner "Batch::SendMail.send_mail"
rescue => e
  Rails.logger.error("aborted rails runner")
  raise e

  # every 1.days, at: '9:00 am' do

  # Rails内のメソッド実行
end

# Learn more: http://github.com/javan/whenever
