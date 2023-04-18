require 'net/http'
require 'rspec'

module Fedexws
  class Rates
    def initialize
      #FedEx Credentials
      @credentials = Fedexws::Configuration.new
    end

    def get(shipping_params)
      
      @shipping_params = shipping_params
      
      gem_spec = Gem.loaded_specs['fedexws']
      gem_dir = gem_spec.gem_dir
      
      xml_template = File.read(File.join(gem_dir, 'lib/templates/xml_soap'))
      
      xml_template_insert_fedex_params = fedex_params_for_request(xml_template)
      xml_template_insert_shipping_params = shipping_params_for_request(xml_template_insert_fedex_params)

      url = URI("https://wsbeta.fedex.com/xml")
      
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/xml"
      
      request.body = xml_template_insert_shipping_params
      
      response = Net::HTTP.start(url.hostname, url.port, use_ssl: true) do |http|
        http.request(request)
      end
      
      begin
        response.body
      rescue Exception => e
        puts "An exception occurred: #{e.message}"
        puts e.backtrace.inspect
      end
    end 

    def fedex_params_for_request(xml_template)
      fedex_params.each do |key, value|
        xml_template.gsub!(key, value)
      end
      return xml_template
    end
    
    def shipping_params_for_request(xml_template)
      i = 0
      shipping_params_values.each do |key, value|
        xml_template.gsub!(key, value)
        i += 1
      end
      return xml_template
    end

    def fedex_params
      fedex_credentials = {
                             "API_KEY" => @credentials.api_key,
                             "API_SECRET" => @credentials.api_secret,
                             "API_ACCOUNT_NUMBER" => @credentials.api_account_number,
                             "API_METER_NUMBER" => @credentials.api_meter_number
                           }
    end

    def shipping_params_values
      
      if @shipping_params.is_a?(Hash)

        shipping_values = {
                            "ZIPCODE_FROM" => @shipping_params[:address_from][:zip],
                            "COUNTRY_FROM" => @shipping_params[:address_from][:country],
                            "ZIPCODE_TO" => @shipping_params[:address_to][:zip],
                            "COUNTRY_TO" => @shipping_params[:address_to][:country],
                            "MASS_UNIT" => @shipping_params[:package][:mass_unit].upcase,
                            "WEIGTH_SIZE" => @shipping_params[:package][:weigth],
                            "LENGTH_SIZE" => @shipping_params[:package][:length].to_i.to_s,
                            "WIDTH_SIZE" => @shipping_params[:package][:width].to_i.to_s,
                            "HEIGTH_SIZE" => @shipping_params[:package][:heigth].to_i.to_s,
                            "DISTANCE_UNIT" => @shipping_params[:package][:distance_unit].upcase
                          }
      else 
        
        shipping_values = {
                            "ZIPCODE_FROM" => "64000",
                            "COUNTRY_FROM" => "MX",
                            "ZIPCODE_TO" => "64000",
                            "COUNTRY_TO" => "MX",
                            "MASS_UNIT" => "KG",
                            "WEIGTH_SIZE" => "6.5",
                            "LENGTH_SIZE" => "25",
                            "WIDTH_SIZE" => "28",
                            "HEIGTH_SIZE" => "46",
                            "DISTANCE_UNIT" => "CM"
                          }
        
      end
    end

  end
end
