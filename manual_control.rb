require 'belphanior/servant/homenetwork/insteon_2412n_marshaller'
require 'belphanior/servant/homenetwork/insteon_2412n_x10_codec'

def make_control
  hn = Belphanior::Servant::HomeNetwork
  hn::Insteon_2412n_x10_Codec.new(
    hn::Insteon_2412n_Marshaller.new('192.168.1.9'))
end
