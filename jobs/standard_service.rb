SCHEDULER.every '60s', allow_overlapping: false do

  services = [ 'DEPOSIT_AUTH_SERVICE',
               'DEPOSIT_REG_SERVICE',
               'ENTITY_ID_SERVICE',
               'FEDORA',
               'ORCID_ACCESS_SERVICE',
               'SOLR',
               'USER_INFO_SERVICE' ]

  services.each do |service|

    config = CONFIG[service]

    service_url = config['url']
    service_title = config['title']
    data_sink = config['id']

    Processor.http_status_check( service_url, service_title, data_sink )
  end

end