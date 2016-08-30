SCHEDULER.every '60s', allow_overlapping: false do

  config = CONFIG['ENTITY_ID_SERVICE']

  service_url = config['url']
  data_sink = config['id']

  begin
     response = Requester.get( service_url )
     if response.code == 200
        send_event( data_sink, { text: 'Up' })
     else
        send_event( data_sink, { text: 'Down' })
        puts "ERROR #{config['title']} returns status: #{response.code}"
     end
  rescue => e
    send_event( data_sink, { text: 'Down' })
    puts "ERROR #{config['title']} returns error: #{e.to_s}"
  end

end