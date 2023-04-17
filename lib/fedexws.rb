require "fedexws/configuration"

class fedexws
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
     yield(configuration)
  end
end