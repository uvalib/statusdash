random = Random.new

SCHEDULER.every '10s' do

  status = random.rand(0..1) == 1
  send_event('ldap', { text: status ? 'OK' : 'Down' })
end