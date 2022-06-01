# frozen_string_literal: true

module Zex
  class  PublicApi
    def initialize dotcom:, method:, extension: nil, options: {}
      @dotcom     = dotcom
      @method     = method
      @extension  = extension
      @options    = options
      raise "\nError: unavailbale method '#{@method}' for #{@dotcom.name} - pls update the YAML file" unless method_available? @method
    end

    def dotcom
      @dotcom
    end

    def method
      @method
    end

    def method_available? method
      methods_list.include? method
    end
    
    def methods_list
      if defined?(Rails).nil?
        file = File.expand_path("../../../config/dotcoms.yml", __FILE__)
        data = YAML.load_file(file)
        data[@dotcom.name][@dotcom.api_mode]['methods'].split
      else
        file = File.expand_path("#{Rails.application.root}/config/zex/dotcoms.yml", __FILE__)
        data = YAML.load_file(file)
        data[@dotcom.name][@dotcom.api_mode]['methods'].split 
      end
    end

    def options
      @options
    end
  end

  class PublicApiGet < PublicApi
    # HTTP request
    def request
      begin
        response = Net::HTTP.get(self.uri)
      rescue StandardError => e
        {:success => 0, :error => e}
      else
        begin 
          JSON.parse response     # => Hash
        rescue
          Tools.red "HTTP.get(#{self.uri}) failed" 
        end
      end
    end

    def uri
      url = @dotcom.endpoint + "/#{@method}"
      url << "/#{@extension}" unless @extension.nil?
      uri = URI url
      uri.query = URI.encode_www_form(options) unless options.empty?
      uri
    end
  end

  class PublicApiPost < PublicApi
    def request
      begin
        Net::HTTP.start(self.uri.host, self.uri.port, :use_ssl => true) do |http|
          response = http.post(self.uri.path, URI.encode_www_form(@options)).body
          JSON.parse(response)
        end
      rescue StandardError => e
        {:success => 0, :error => e}
      end
    end

    def uri
      url = @dotcom.endpoint + "/#{@method}"
      url << "/#{@extension}" unless @extension.nil?
      URI url
    end
  end
end
