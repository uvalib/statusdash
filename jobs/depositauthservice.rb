SCHEDULER.every '30s', allow_overlapping: false do

  service_url = ENV[ 'DEPOSIT_SERVICE_URL' ]
  data_sink_sis = 'sis-depositauth'
  data_sink_mysql = 'mysql-depositauth'

  begin
     response = Requester.get( service_url )

     if response['filesystem'] && response['filesystem']['healthy'] == true
        send_event( data_sink_sis, { text: 'Up' })
     else
        send_event( data_sink_sis, { text: 'Down' })
     end

     if response['mysql'] && response['mysql']['healthy'] == true
       send_event( data_sink_mysql, { text: 'Up' })
     else
       send_event( data_sink_mysql, { text: 'Down' })
     end
  rescue => e
    send_event( data_sink_sis, { text: 'Down' })
    send_event( data_sink_mysql, { text: 'Down' })
  end

end