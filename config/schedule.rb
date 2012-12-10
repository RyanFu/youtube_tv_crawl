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

# Learn more: http://github.com/javan/whenever

env :PATH, ENV['PATH']

every :day, :at => '03:01am' do  
  rake 'crawl:crawl_ep',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'crawl:crawl_drama',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
  rake 'db:data:dump',:output => {:error => 'log/error.log', :standard => 'log/cron.log'}
end