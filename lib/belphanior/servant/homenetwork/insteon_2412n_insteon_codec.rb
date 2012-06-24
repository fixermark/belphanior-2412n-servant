# Copyright 2012 Mark T. Tomczak

module Belphanior
  module Servant
    module HomeNetwork
      class Insteon_2412n_Insteon_Codec
        class BadCode < RuntimeError
        end
        COMMAND_CODE_TABLE = {
          :on => "11",
          :fast_on => "12",
          :off => "13",
          :fast_off => "14",
        }
        BRIGHTNESS_CODE_LIST = [
          [0, "00"],
          [0.1, "19"],
          [0.25, "40"],
          [0.5, "7F"],
          [0.75, "BF"],
          [0.9, "E6"],
          [1, "FF"]
        ]
        INSTEON_PREFIX = "0262"

        def initialize(marshaller)
          @marshaller = marshaller
        end

        def device_on(address)
          send_command(address, :fast_on, "FF")
        end

        def device_off(address)
          send_command(address, :fast_off, "FF")
        end

        # Set the brightness level.
        # address: 6-hexcode address of INSTEON device.
        # brightness: float value between 0 and 1
        def device_set_brightness(address, brightness)
          send_command(address, :on, brightness_value_to_code(brightness))
        end
       private

        # sends command to device specified by address.
        def send_command(address, command, brightness_code)
          @marshaller.send(INSTEON_PREFIX + address +
            COMMAND_CODE_TABLE[command] + brightness_code)
        end

        def brightness_value_to_code(brightness)
          if brightness < 0 then
            brightness = 0
          end
          if brightness > 1 then
            brightness = 1
          end
          BRIGHTNESS_CODE_LIST.each do |codepair|
            if brightness <= codepair[0] then
              return codepair[1]
            end
          end
          return "FF"
        end

      end
    end
  end
end
