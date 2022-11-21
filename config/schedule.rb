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

# Check how to operate 'whenever' here:
# https://medium.com/swlh/automate-tasks-in-rails-using-the-whenever-gem-46f9708ab002
#

every 1.week, :at => '10:00 am' do
  rake 'weekly_newsletter_email'
end
# Learn more: http://github.com/javan/whenever
