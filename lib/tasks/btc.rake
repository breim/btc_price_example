require 'net/http'

namespace :btc do
  task api: :environment do

    API_URL = "http://api.coindesk.com/v1/bpi/currentprice.json"

    loop do
      url = URI.parse(API_URL)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
      response =  JSON.parse(res.body)

      ActionCable.server.broadcast "web_notifications_channel", data: { price: response['bpi']['USD']['rate'] }

      sleep 10
    end
  end
end
