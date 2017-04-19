SCHEDULER.every '60s', allow_overlapping: false do

  config = CONFIG['USER_INFO_SERVICE']

  service_url = config['url']
  service_title = config['title']
  data_sink = config['id']

  Processor.http_status_check(service_url, service_title, data_sink )

end