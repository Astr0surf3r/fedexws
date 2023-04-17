Fedexws.configure do |config|
  config.api_key = ENV['YOUR_FedEx_API_KEY_USERNAME']
  config.api_secret = ENV['YOUR_FedEx_API_SECRET_PASSWORD']
  config.api_account_number = ENV['YOUR_FedEx_API_ACCOUNT_NUMBER']
  config.api_meter_number = ENV['YOUR_FedEx_API_METER_NUMBER']
end
