require 'httparty'

SCHEDULER.every '20s' do

  service_url = 'http://docker1.lib.virginia.edu:8010/healthcheck'
  data_sink_ldap = 'ldap-user'
  begin
     response = HTTParty.get( service_url )
     if response['ldap']['healthy'] == true
        send_event( data_sink_ldap, { text: 'Up' })
     else
        send_event( data_sink_ldap, { text: 'Down' })
     end
  rescue => e
    send_event( data_sink_ldap, { text: 'Down' })
  end

end