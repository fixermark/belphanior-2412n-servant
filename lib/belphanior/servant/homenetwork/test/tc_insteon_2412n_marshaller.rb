require 'rubygems'
require 'belphanior/servant/homenetwork/insteon_2412n_marshaller'
require 'test/unit'
require 'mocha'


class TestInsteon_2412N_Marshaller < Test::Unit::TestCase
  def setup
    @netmock = mock('Net::HTTP')
    @requestmock = mock()
    @marshaller =
      Belphanior::Servant::HomeNetwork::Insteon_2412n_Marshaller.new(
      'localhost', @netmock)
  end
  def test_send
    input = "02636600"
    @netmock.expects(:start).with('localhost',80).yields(@requestmock)
    @requestmock.expects(:post).with("/3?"+input+"=I=3","")
    @marshaller.send(input)
  end
end
