require 'httparty'

SCHEDULER.every '10s' do

  response = HTTParty.get('http://docker1.lib.virginia.edu:8010/healthcheck')
  begin
     if response['ldap']['healthy'] == true
        send_event('ldap', { text: 'Up' })
     else
        send_event('ldap', { text: 'Down' })
     end
  rescue => e
    send_event('ldap', { text: 'Down' })
  end

end