# frozen_string_literal: true
###############################################################################
#   Testing of CEX.IO REST Public API (GET requests)
#   https://cex.io/rest-api
#
#   13.05.2022  Created
###############################################################################
module Zex
  # puts Tools.green Time.at(Tools.timestamp.to_i / 1000)
  dotcom = Dotcom.new name: 'cexio', api_mode: 'public'
  # pp dotcom

  ### Method: currency_limits ###
  # GET https://cex.io/api/currency_limits
  api = PublicApiGet.new dotcom: dotcom, method: 'currency_limits'
  puts "\n#{dotcom.name.capitalize} -- Currency Limits", Tools.blue(api.request)

  ###  Method: Ticker  ###
  # GET https://cex.io/api/ticker/BTC/USD
  extension = 'BTC/USD'
  api = PublicApiGet.new dotcom: dotcom, method: 'ticker', extension: extension
  puts "\n#{dotcom.name.capitalize} -- Ticker: BTCUSD", Tools.blue(api.request)

  ###  Method: Tickers  ###
  # GET https://cex.io/api/tickers/{marketSymbol1}/{marketSymbol2}/.../{marketSymbolN}
  extension = 'BTC/ETH/BCH'
  api = PublicApiGet.new dotcom: dotcom, method: 'tickers', extension: extension
  puts "\n#{dotcom.name.capitalize} -- Tickers: BTC/ETH/BCH", Tools.blue(api.request)

  ###  Method: Last Price  ###
  # GET https://cex.io/api/last_price/{symbol1}/{symbol2}
  extension = 'ETH/USD'
  api = PublicApiGet.new dotcom: dotcom, method: 'last_price', extension: extension
  puts "\n#{dotcom.name.capitalize} -- Last price: ETH/USD", Tools.blue(api.request)

  ###  Method: Last Prices  ###
  # GET https://cex.io/api/last_prices/{marketSymbol1}/{marketSymbol2}/.../{marketSymbolN}
  extension = 'BTC/ETH/BCH'
  api = PublicApiGet.new dotcom: dotcom, method: 'last_prices', extension: extension
  puts "\n#{dotcom.name.capitalize} -- Last prices: BTC/ETH/BCH", Tools.blue(api.request)

  ###  Method: Historical 1m OHLCV Chart  ###
  # GET https://cex.io/api/ohlcv/hd/{date}/{symbol1}/{symbol2}
  day = (Time.now - 1.day).strftime('%Y%d%m')
  extension = "hd/#{day}/ETH/USD"
  api = PublicApiGet.new dotcom: dotcom, method: 'ohlcv', extension: extension
  puts "\n#{dotcom.name.capitalize} -- OHLCV 1 m / 1h / 1d data: ETH/USD", Tools.blue(api.request)

  ###  Method: Order Book  ###
  # GET https://cex.io/api/order_book/{symbol1}/{symbol2}/
  extension = 'BTC/USD/'
  api = PublicApiGet.new dotcom: dotcom, method: 'order_book', extension: extension
  puts "\n#{dotcom.name.capitalize} -- Orde Book: BTCUSD", Tools.blue(api.request)

  # GET https://cex.io/api/order_book/{symbol1}/{symbol2}?depth=N  (n=1 - default: ALL)
  options = {depth: 5}  # Slash at the end !!!
  api = PublicApiGet.new dotcom: dotcom, method: 'order_book', extension: extension, options: options
  puts "\n#{dotcom.name.capitalize} -- Order Book: BTCUSD, depth = 5", Tools.blue(api.request)

  ###  Method: Trade History  ###
  # GET https://cex.io/api/trade_history/{symbol1}/{symbol2}/
  extension = 'ETH/USD/'
  api = PublicApiGet.new dotcom: dotcom, method: 'trade_history', extension: extension
  puts "\n#{dotcom.name.capitalize} -- Trade History: ETHUSD", Tools.blue(api.request)

  # GET https://cex.io/api/trade_history/{symbol1}/{symbol2}?since={tid}/
  extension = 'ETH/USD/'      # Slash at the end !!!
  options = {since: 6282000}
  api = PublicApiGet.new dotcom: dotcom, method: 'trade_history', extension: extension, options: options
  puts "\n#{dotcom.name.capitalize} -- Trade History: ETHUSD with Trade ID > 6282000", Tools.blue(api.request)

  ###  Method: Convert  ###
  # POST https://cex.io/api/convert/{symbol1}/{symbol2}  body: {amnt: 3.0}
  extension = 'ETH/USD'
  options = {amnt: 3.0}
  api = PublicApiPost.new dotcom: dotcom, method: 'convert', extension: extension, options: options
  puts "\n#{dotcom.name.capitalize} -- Convert: ETHUSD", Tools.blue(api.request)

  ###  Method: price_stats  ###
  # POST https://cex.io/api/price_stats/{symbol1}/{symbol2} 
  #      body: {"lastHours": 24, "maxRespArrSize": 100}
  extension = 'ETH/USD'
  options = {"lastHours": 24, "maxRespArrSize": 100}
  api = PublicApiPost.new dotcom: dotcom, method: 'price_stats', extension: extension, options: options
  puts "\n#{dotcom.name.capitalize} -- Chart: ETHUSD", Tools.blue(api.request)
end
