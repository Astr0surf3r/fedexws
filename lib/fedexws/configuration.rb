module Fedexws
  class Configuration
    # FedEx API params
    attr_accessor :api_key, :api_secret, :api_account_number, :api_meter_number
    
    def initialize
      load_parameters
    end
    
    private
    
    def load_parameters
      initializer_file = Rails.root.join('config', 'initializers', 'fedexws.rb')
      config = File.read(initializer_file)
      @api_key = config.match(/api_key\s*=\s*['"]([^'"]+)['"]/)&.captures&.first
      @api_secret = config.match(/api_secret\s*=\s*['"]([^'"]+)['"]/)&.captures&.first
      @api_account_number = config.match(/api_account_number\s*=\s*['"]([^'"]+)['"]/)&.captures&.first
      @api_meter_number = config.match(/api_meter_number\s*=\s*['"]([^'"]+)['"]/)&.captures&.first
      @credentials = [@api_key, @api_secret, @api_account_number, @api_meter_number]
    end
  end
end
