SCHEDULER.every '60s', allow_overlapping: false do

  config = CONFIG['DEPOSITREG']
  max_response_time = 2000

  service_url = config['url']
  service_title = config['title']
  data_sink_response = config['time']

  Processor.http_response_check( service_url, service_title, max_response_time, data_sink_response )

end