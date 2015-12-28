SCHEDULER.every '30s', allow_overlapping: false do

  service_url = ENV[ 'USER_SERVICE_URL' ]
  data_sink_ldap = 'ldap-user'

  begin
     response = Requester.get( service_url )
     if response['ldap'] && response['ldap']['healthy'] == true
        send_event( data_sink_ldap, { text: 'Up' })
     else
        send_event( data_sink_ldap, { text: 'Down' })
     end
  rescue => e
    send_event( data_sink_ldap, { text: 'Down' })
  end

end