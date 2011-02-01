require 'belphanior/servant/homenetwork/insteon_2412n_x10_codec'
require 'test/unit'
require 'mocha'


# Test of X10 code generator for Insteon 2412N central controller

class TestInsteon_2412N_X10_Codec < Test::Unit::TestCase
  def setup
    @marshaller = mock(
      'Belphanior::Servant::HomeNetwork::Insteon_2412n_Marshaller')
    @codec = Belphanior::Servant::HomeNetwork::Insteon_2412n_x10_Codec.new(
      @marshaller)
  end

  def test_house_codes
    # map from house codes to hex names
    house_code_table = {
      "A"=>"6", "B"=>"E", "C"=>"2", "D"=>"A",
      "E"=>"1", "F"=>"9", "G"=>"5", "H"=>"D",
      "I"=>"7", "J"=>"F", "K"=>"3", "L"=>"B",
      "M"=>"0", "N"=>"8", "O"=>"4", "P"=>"C",
    }
    unit_1_code = "6"
    house_code_table.each do |key, value|
      cur_sequence = sequence(key)
      @marshaller.expects(:send).with(
        "0263"+value+unit_1_code+"00").in_sequence(cur_sequence)
      @marshaller.expects(:send).in_sequence(cur_sequence)
      @codec.device_on(key+"1")
    end
  end
  def test_unit_codes
    # map from house codes to hex names
    unit_code_table = {
      "1"=>"6", "2"=>"E", "3"=>"2", "4"=>"A",
      "5"=>"1", "6"=>"9", "7"=>"5", "8"=>"D",
      "9"=>"7", "10"=>"F", "11"=>"3", "12"=>"B",
      "13"=>"0", "14"=>"8", "15"=>"4", "16"=>"C",
    }
    house_a_code = "6"
    unit_code_table.each do |key, value|
      cur_sequence = sequence(key)
      @marshaller.expects(:send).with(
        "0263"+house_a_code+value+"00").in_sequence(cur_sequence)
      @marshaller.expects(:send).in_sequence(cur_sequence)
      @codec.device_on("A"+key)
    end
  end
  def test_command_codes
    code_segments = [
                     "2",  # on
                     "5",  # brighter
                     "3",  # off
                     "4",  # dimmer
                     ]
    house_a_code = "6"
    cur_sequence = sequence("command codes")
    code_segments.each do |code|
      @marshaller.expects(:send).in_sequence(cur_sequence)
      @marshaller.expects(:send).with("0263" + house_a_code + 
        code + "80").in_sequence(cur_sequence)
    end
    @codec.device_on("A1")
    @codec.device_brighter("A1")
    @codec.device_off("A1")
    @codec.device_dimmer("A1")
  end
end
