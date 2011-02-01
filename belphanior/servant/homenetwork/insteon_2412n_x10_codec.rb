module Belphanior
  module Servant
    module HomeNetwork
      class Insteon_2412n_x10_Codec
        class BadCode < RuntimeError
        end
        HOUSE_CODE_TABLE = {
          "A"=>"6", "B"=>"E", "C"=>"2", "D"=>"A",
          "E"=>"1", "F"=>"9", "G"=>"5", "H"=>"D",
          "I"=>"7", "J"=>"F", "K"=>"3", "L"=>"B",
          "M"=>"0", "N"=>"8", "O"=>"4", "P"=>"C",
        }
        UNIT_CODE_TABLE = {
          "1"=>"6", "2"=>"E", "3"=>"2", "4"=>"A",
          "5"=>"1", "6"=>"9", "7"=>"5", "8"=>"D",
          "9"=>"7", "10"=>"F", "11"=>"3", "12"=>"B",
          "13"=>"0", "14"=>"8", "15"=>"4", "16"=>"C",
        }
        COMMAND_CODE_TABLE = {
          :all_on => "6",
          :on => "2",
          :brighter => "5",
          :off => "3",
          :all_off => "0",
          :dimmer => "4",
        }
        X10_PREFIX = "0263"
        ADDRESS_SUFFIX = "00"
        COMMAND_SUFFIX = "80"

        def initialize(marshaller)
          @marshaller = marshaller
        end

        def device_on(identifier)
          house_code, unit_code = select_code(identifier)
          @marshaller.send(X10_PREFIX + house_code + unit_code + ADDRESS_SUFFIX)
          @marshaller.send(X10_PREFIX + house_code + COMMAND_CODE_TABLE[:on] +
                           COMMAND_SUFFIX)
        end

        private

        # Converts house, unit code string to hex command string
        def select_code(house_and_unit)
          if not house_and_unit.length <= 3
            raise BadCode,
            "Code should be three characters or less."
          end
          house = house_and_unit[0..0]
          unit = house_and_unit[1..2]
          if not HOUSE_CODE_TABLE.has_key? house
            raise BadCode,
            "House code was '" << house << "', must be between 'A' and 'P'"
          end
          if not UNIT_CODE_TABLE.has_key? unit
            raise BadCode,
            "Unit code was '" << unit << "', must be between '1' and '16'"
          end
          [HOUSE_CODE_TABLE[house], UNIT_CODE_TABLE[unit]]
        end
      end
    end
  end
end
