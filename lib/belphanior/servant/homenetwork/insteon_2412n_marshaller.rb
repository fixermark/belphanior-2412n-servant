# Marshaller for the Insteon 2412N home automation server
require 'net/http'

module Belphanior
  module Servant
    module HomeNetwork
      class Insteon_2412n_Marshaller
        class ConnectionFailure < RuntimeError
        end
        def initialize(host, network_class=nil)
          @host = host
          if network_class
            @network_class = network_class
          else
            @network_class = Net::HTTP
          end
        end
        def send(command)
          @network_class.start(@host, 80) {|http|
            # I don't know what the prefix and suffix here mean;
            # they were determined empirically by examining the output
            # from the 2412N's built-in web GUI
            http.post("/3?"+command+"=I=3", "")
          }
        end
      end
    end
  end
end
