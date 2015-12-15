require 'httparty'

SCHEDULER.every '20s' do

  service_url = 'http://docker1.lib.virginia.edu:8001/healthcheck'
  data_sink_sis = 'sis-depositauth'
  data_sink_mysql = 'mysql-depositauth'

  begin
     response = HTTParty.get( service_url )
     if response['filesystem']['healthy'] == true
        send_event( data_sink_sis, { text: 'Up' })
     else
        send_event( data_sink_sis, { text: 'Down' })
     end

     if response['mysql']['healthy'] == true
       send_event( data_sink_mysql, { text: 'Up' })
     else
       send_event( data_sink_mysql, { text: 'Down' })
     end
  rescue => e
    send_event( data_sink_sis, { text: 'Down' })
    send_event( data_sink_mysql, { text: 'Down' })
  end

end