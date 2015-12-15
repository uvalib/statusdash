require 'httparty'

SCHEDULER.every '30s' do

  service_url = 'http://opacdev.lib.virginia.edu'
  data_sink_ldap = 'virgo'
  begin
     response = HTTParty.get( service_url )
     if response.code == 200
        send_event( data_sink_ldap, { text: 'Up' })
     else
        send_event( data_sink_ldap, { text: 'Down' })
     end
  rescue => e
    send_event( data_sink_ldap, { text: 'Down' })
  end

end