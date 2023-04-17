module Fedexws
  class FedexwsGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)
  
    def create_initializer_file
      copy_file 'initializer.rb', 'config/initializers/fedexws.rb'
    end
  end
end