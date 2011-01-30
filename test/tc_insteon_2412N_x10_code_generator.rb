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
      @marshaller.expects(:send).with("0263"+value+unit_1_code+"00")
    end
  end
  def test_unit_codes
  end
  def test_command_codes
  end
end
