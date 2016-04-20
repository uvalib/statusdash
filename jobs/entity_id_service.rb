SCHEDULER.every '30s', allow_overlapping: false do

  service_url = ENV[ 'ENTITY_ID_SERVICE_URL' ]
  data_sink = 'entity-id-service'

  begin
     response = Requester.get( service_url )
     if response.code == 200
        send_event( data_sink, { text: 'Up' })
     else
        send_event( data_sink, { text: 'Down' })
     end
  rescue => e
    send_event( data_sink, { text: 'Down' })
  end

end