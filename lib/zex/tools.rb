# frozen_string_literal: true

module Zex
  class Tools
    class << self
      def nonce
        Time.now.utc.to_i + 11
      end

      def timestamp
        Time.now.utc.strftime("%s%3N")
      end

      def request_signature(payload:, api_secret: nil)
        raise "\n===== ZT! api_secret not found!" unless api_secret
        digest = OpenSSL::Digest::SHA256.new
        OpenSSL::HMAC.hexdigest(digest, api_secret, payload)
      end

      def validate_face face
        Zex.faces.include? face
      end

      def validate_mode mode
        Zex.modes.include? mode
      end

      # Text Colors
      def black(text);          "\e[30m#{(text)}\e[0m" end
      def red(text);            "\e[31m#{(text)}\e[0m" end
      def green(text);          "\e[32m#{(text)}\e[0m" end
      def brown(text);          "\e[33m#{(text)}\e[0m" end
      def blue(text);           "\e[34m#{text}\e[0m" end
      def magenta(text);        "\e[35m#{text}\e[0m" end
      def cyan(text);           "\e[36m#{text}\e[0m" end
      def gray(text);           "\e[37m#{text}\e[0m" end
      
      def bg_black(text);       "\e[40m#{text}\e[0m" end
      def bg_red(text);         "\e[41m#{text}\e[0m" end
      def bg_green(text);       "\e[42m#{text}\e[0m" end
      def bg_brown(text);       "\e[43m#{text}\e[0m" end
      def bg_blue(text);        "\e[44m#{text}\e[0m" end
      def bg_magenta(text);     "\e[45m#{text}\e[0m" end
      def bg_cyan(text);        "\e[46m#{text}\e[0m" end
      def bg_gray(text);        "\e[47m#{text}\e[0m" end
      
      def bold(text);           "\e[1m#{text}\e[22m" end
      def italic(text);         "\e[3m#{text}\e[23m" end
      def underline(text);      "\e[4m#{text}\e[24m" end
      def blink(text);          "\e[5m#{text}\e[25m" end
      def reverse_color(text);  "\e[7m#{text}\e[27m" end
    end
  end
end
