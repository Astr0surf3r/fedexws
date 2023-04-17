require 'fedexws/configuration'
require 'fedexws/rates'

module Fedexws
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
     yield(configuration)
  end
end
