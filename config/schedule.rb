set :output, '/log/cron_log.log'


every :saturday, :at => '4:38am' do
  command 'rm -rf /tmp/cache'
  runner 'Game.remove_abandoned'
end

every 1.day do
  rake guests:cleanup
end


