require 'redis'

SCHEDULER.every '60s', allow_overlapping: false do

  config = CONFIG['REDIS']
  service_url = config['url']
  data_sink = config['id']

  begin
    redis = Redis.new( { url: service_url } )
    redis.ping
    redis.close
    send_event( data_sink, { text: 'Up' })
  rescue => e
    send_event( data_sink, { text: 'Down' })
    LOGGER.error "#{config['title']} returns error: #{e.to_s}"
  end

end