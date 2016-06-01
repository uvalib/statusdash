#
#
#

def production_mode?
  return ENV['RAILS_ENV'] == 'production'
end

#
# end of file
#