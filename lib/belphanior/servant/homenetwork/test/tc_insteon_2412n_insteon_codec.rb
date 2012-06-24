require 'rubygems'
require 'belphanior/servant/homenetwork/insteon_2412n_insteon_codec'
require 'test/unit'
require 'mocha'


# Test of INSTEON code generator for Insteon 2412N central controller

class TestInsteon_2412N_Insteon_Codec < Test::Unit::TestCase
  def setup
    @marshaller = mock(
      'Belphanior::Servant::HomeNetwork::Insteon_2412n_Marshaller')
    @codec = Belphanior::Servant::HomeNetwork::Insteon_2412n_Insteon_Codec.new(
      @marshaller)
    @insteon_prefix = "0262"
  end

  def test_on_off
    address = "001122"
    fast_on_code = "12"
    fast_off_code = "14"
    @marshaller.expects(:send).with(
      @insteon_prefix + address + fast_on_code + "FF")
    @codec.device_on(address)
  end

  def test_brightness
    address = "001122"
    on_code = "11"
    @marshaller.expects(:send).with(
      @insteon_prefix + address + on_code + "00")
    @codec.device_set_brightness(address, 0)

    @marshaller.expects(:send).with(
      @insteon_prefix + address + on_code + "FF")
    @codec.device_set_brightness(address, 1)

    # Exact equality
    @marshaller.expects(:send).with(
      @insteon_prefix + address + on_code + "7F")
    @codec.device_set_brightness(address, 0.5)

    # Near-equality
    @marshaller.expects(:send).with(
      @insteon_prefix + address + on_code + "7F")
    @codec.device_set_brightness(address, 0.4)

    # Out of bounds
    @marshaller.expects(:send).with(
      @insteon_prefix + address + on_code + "00")
    @codec.device_set_brightness(address, -1)

    @marshaller.expects(:send).with(
      @insteon_prefix + address + on_code + "FF")
    @codec.device_set_brightness(address, 1.5)
  end
end
