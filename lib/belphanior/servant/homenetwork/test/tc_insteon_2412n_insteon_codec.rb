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

  #     cur_sequence = sequence(key)
  #     @marshaller.expects(:send).with(
  #       "0263"+value+unit_1_code+"00").in_sequence(cur_sequence)
  #     @marshaller.expects(:send).in_sequence(cur_sequence)
  #     @codec.device_on(key+"1")
  #   end
  # end
  # def test_unit_codes
  #   # map from house codes to hex names
  #   unit_code_table = {
  #     "1"=>"6", "2"=>"E", "3"=>"2", "4"=>"A",
  #     "5"=>"1", "6"=>"9", "7"=>"5", "8"=>"D",
  #     "9"=>"7", "10"=>"F", "11"=>"3", "12"=>"B",
  #     "13"=>"0", "14"=>"8", "15"=>"4", "16"=>"C",
  #   }
  #   house_a_code = "6"
  #   unit_code_table.each do |key, value|
  #     cur_sequence = sequence(key)
  #     @marshaller.expects(:send).with(
  #       "0263"+house_a_code+value+"00").in_sequence(cur_sequence)
  #     @marshaller.expects(:send).in_sequence(cur_sequence)
  #     @codec.device_on("A"+key)
  #   end
  # end
  # def test_command_codes
  #   code_segments = [
  #                    "2",  # on
  #                    "5",  # brighter
  #                    "3",  # off
  #                    "4",  # dimmer
  #                    ]
  #   house_a_code = "6"
  #   cur_sequence = sequence("command codes")
  #   code_segments.each do |code|
  #     @marshaller.expects(:send).in_sequence(cur_sequence)
  #     @marshaller.expects(:send).with("0263" + house_a_code +
  #       code + "80").in_sequence(cur_sequence)
  #   end
  #   @codec.device_on("A1")
  #   @codec.device_brighter("A1")
  #   @codec.device_off("A1")
  #   @codec.device_dimmer("A1")
  # end
end
