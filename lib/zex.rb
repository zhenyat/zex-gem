# frozen_string_literal: true

require 'yaml'
require 'json'
require 'net/http'
require 'openssl'
require 'net/http'
require 'pp'

require_relative "zex/version"
require_relative "zex/tools"
require_relative "zex/dotcom"
require_relative "zex/public_api"
# require_relative "zex/private_api"


module Zex
  class Error < StandardError; end

  if defined?(Rails).nil?   # Debugging
    require_relative "zex/debug/binance_public_debug"
    require_relative "zex/debug/cexio_public_debug"
    # require_relative "zex/cexio_private_debug"
  end
end
