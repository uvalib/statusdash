SCHEDULER.every '60s', allow_overlapping: false do

  config = CONFIG['ADMIN']
  max_response_time = 2000

  service_url = config['url']
  data_sink_response = config['time']

  begin
     start_time = Time.now
     response = Requester.get( service_url )
     end_time = Time.now
     if response.code == 200
        response_time = ( ( end_time - start_time ).to_f * 1000 ).to_i
        response_time = max_response_time unless response_time < max_response_time

        send_event( data_sink_response, { value: response_time } )
     else
        send_event( data_sink_response, { value: 0 } )
        LOGGER.error "#{config['title']} returns status: #{response.code}"
     end
  rescue => e
    send_event( data_sink_response, { value: 0 } )
    LOGGER.error "#{config['title']} returns error: #{e.to_s}"
  end

end