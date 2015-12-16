require 'httparty'

SCHEDULER.every '30s', allow_overlapping: false do

  service_url = ENV[ 'FIREHOSE_SERVICE_URL' ]
  data_sink = 'oracle-firehose'
  begin
     response = HTTParty.get( service_url )
     if response.code == 200 && response['ldap'] && response['ldap']['healthy'] == 'true'
        send_event( data_sink, { text: 'Up' })
     else
        send_event( data_sink, { text: 'Down' })
     end
  rescue => e
    send_event( data_sink, { text: 'Down' })
  end

end