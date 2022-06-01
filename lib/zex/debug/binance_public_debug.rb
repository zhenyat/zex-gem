# frozen_string_literal: true
###############################################################################
#   Testing of Binance REST Public API
#
#   https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#test-connectivity
#
#   13.05.2022  Last update
###############################################################################
module Zex
  # puts Tools.green Time.at(Tools.timestamp.to_i / 1000)
  dotcom = Dotcom.new name: 'binance', api_mode: 'public'
  # pp dotcom

  ###  Method: Ping  ###
  # Test connectivity to the Rest API 
  # GET https://testnet.binance.vision/api/v3/ping  => {}
  api = PublicApiGet.new(dotcom: dotcom, method: 'ping')
  puts "\n#{dotcom.name.capitalize} -- Ping:", Tools.blue(api.request)

  ###  Method: Time  ###
  # Test connectivity to the Rest API and get the current server time
  # GET https://testnet.binance.vision/api/v3/time
  api = PublicApiGet.new(dotcom: dotcom, method: 'time')
  puts "\n#{dotcom.name.capitalize} -- Server Time:", Tools.blue(Time.at(api.request['serverTime']/1000))

  ###  Method: exchangeInfo  ###
  # Current exchange trading rules and symbol information
  # GET https://testnet.binance.vision/api/v3/exchangeInfo
  # GET https://api.binance.com/api/v3/exchangeInfo?symbols=["BTCUSDT","BNBBTC"]'
  api = PublicApiGet.new(dotcom: dotcom, method: 'exchangeInfo')
  puts "\n#{dotcom.name.capitalize} -- Exchange Info:", Tools.blue(api.request)

  ###  Method: Ticker  ###
  # GET https://testnet.binance.vision/api/v3/ticker/24hr?symbol=BTCUSDT
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'ticker', extension: '24hr', options: options)
  puts "\n#{dotcom.name.capitalize} -- Ticker 24h: BTCUSDT", Tools.blue(api.request)

  options = {}
  api = PublicApiGet.new(dotcom: dotcom, method: 'ticker', extension: '24hr', options: options)
  puts "\n#{dotcom.name.capitalize} -- Ticker 24h: All Pairs", Tools.blue(api.request)

  # GET https://testnet.binance.vision/api/v3/ticker/price?symbol=BTCUSDT
  #     {"symbol":"BTCUSDT","price":"28690.58000000"}
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'ticker', extension: 'price', options: options)
  puts "\n#{dotcom.name.capitalize} -- Ticker: BTCUSDT Price", Tools.blue(api.request)

  # GET https://testnet.binance.vision/api/v3/ticker/bookTicker?symbol=BTCUSDT
  #     Symbol order book ticker
  #     Best price/qty on the order book for a symbol or symbols.
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'ticker', extension: 'bookTicker', options: options)
  puts "\n#{dotcom.name.capitalize} -- Book Ticker: BTCUSDT", Tools.blue(api.request)
  ###  Method: depth  ###
  #    Order Book
  # GET https://testnet.binance.vision/api/v3/depth?symbol=BTCUSDT
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'depth', options: options)
  puts "\n#{dotcom.name.capitalize} -- Order Book: BTCUSDT Depth", Tools.blue(api.request)

  ###  Method: trades  ###
  #    Recent trades list
  # GET https://testnet.binance.vision/api/v3/trades?symbol=BTCUSDT
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'trades', options: options)
  puts "\n#{dotcom.name.capitalize} -- Trades: BTCUSDT Trades List", Tools.blue(api.request)

  ###  Method: historicalTrades  ###
  #    Old trade lookup (MARKET_DATA): Get older trades
  # GET https://testnet.binance.vision/api/v3/historicalTrades?symbol=BTCUSDT
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'historicalTrades', options: options)
  puts "\n#{dotcom.name.capitalize} -- Historical Trades: BTCUSDT", Tools.blue(api.request)
  # !!! Not working: {"code":-2014,"msg":"API-key format invalid."}

  ###  Method: aggTrades  ###
  #    Compressed/Aggregate trades list
  # GET https://testnet.binance.vision/api/v3/aggTrades?symbol=BTCUSDT
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'aggTrades', options: options)
  puts "\n#{dotcom.name.capitalize} -- Aggregate Trades List: BTCUSDT", Tools.blue(api.request)

  ###  Method: klines  ###
  #    Kline/candlestick bars for a symbol. Klines are uniquely identified by their open time.
  # GET https://testnet.binance.vision/api/v3/klines?symbol=BTCUSDT&interval=1h
  options = {symbol: 'BTCUSDT', interval: '1h'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'klines', options: options)
  puts "\n#{dotcom.name.capitalize} -- Klines: BTCUSDT", Tools.blue(api.request)

  ###  Method: avgPrice  ###
  #    Current average price for a symbol
  # GET https://testnet.binance.vision/api/v3/avgPrice?symbol=BTCUSDT
  options = {symbol: 'BTCUSDT'}
  api = PublicApiGet.new(dotcom: dotcom, method: 'avgPrice', options: options)
  puts "\n#{dotcom.name.capitalize} -- avgPrice: BTCUSDT", Tools.blue(api.request)
end
