SCHEDULER.every '30s', allow_overlapping: false do

  config = CONFIG['REDIS']
  service_url = config['url']
  data_sink = config['id']

  begin
     tokens = service_url.split( ':' )
     s = TCPSocket.open( tokens[ 0 ], tokens[ 1 ] )
     s.close
     send_event( data_sink, { text: 'Up' })
  rescue => e
    send_event( data_sink, { text: 'Down' })
  end

end