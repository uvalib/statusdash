require 'redis'

class Processor

  def self.http_status_check( service_url, service_name, data_sink )

    if service_url.nil? || service_url.empty?
      send_event( data_sink, { text: 'Down' })
      LOGGER.error "#{service_name} endpoint not configured"
      return
    end

    begin
      response = Requester.get( service_url )
      if response.code == 200
        send_event( data_sink, { text: 'Up' })
      else
        send_event( data_sink, { text: 'Down' })
        LOGGER.error "#{service_name} returns status: #{response.code}"
      end
    rescue => e
      send_event( data_sink, { text: 'Down' })
      LOGGER.error "#{service_name} returns error: #{e.to_s}"
    end

  end

  def self.http_response_check( service_url, service_name, max_response_time, data_sink )

    if service_url.nil? || service_url.empty?
      send_event( data_sink, { text: 'Down' })
      LOGGER.error "#{service_name} endpoint not configured"
      return
    end

    begin
      start_time = Time.now
      response = Requester.get( service_url )
      end_time = Time.now
      if response.code == 200
        response_time = ( ( end_time - start_time ).to_f * 1000 ).to_i
        response_time = max_response_time unless response_time < max_response_time

        send_event( data_sink, { value: response_time } )
      else
        send_event( data_sink, { value: 0 } )
        LOGGER.error "#{service_name} returns status: #{response.code}"
      end
    rescue => e
      send_event( data_sink, { value: 0 } )
      LOGGER.error "#{service_name} returns error: #{e.to_s}"
    end
  end

  def self.redis_check( service_url, service_name, data_sink )

    if service_url.nil? || service_url.empty?
      send_event( data_sink, { text: 'Down' })
      LOGGER.error "#{service_name} endpoint not configured"
      return
    end

    begin
      redis = Redis.new( { url: service_url } )
      redis.ping
      redis.close
      send_event( data_sink, { text: 'Up' })
    rescue => e
      send_event( data_sink, { text: 'Down' })
      LOGGER.error "#{service_name} returns error: #{e.to_s}"
    end

  end
end