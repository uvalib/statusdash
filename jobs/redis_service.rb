require 'redis'

SCHEDULER.every '60s', allow_overlapping: false do

  config = CONFIG['REDIS']

  service_url = config['url']
  service_title = config['title']
  data_sink = config['id']

  Processor.redis_check( service_url, service_title, data_sink )

end