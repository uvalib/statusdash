require 'httparty'

SCHEDULER.every '30s', allow_overlapping: false do

  service_url = ENV[ 'VIRGO_URL' ]
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