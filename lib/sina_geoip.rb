#encoding: utf-8
require "sina_geoip/version"
require 'json'
require 'rest-client'

class SinaGeoIp
  SERVICE_URL = 'http://int.dpool.sina.com.cn/iplookup/iplookup.php'
  IPV4_REGEXP = /\A(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)(?:\.(?:25[0-5]|(?:2[0-4]|1\d|[1-9])?\d)){3}\z/

  @@timeout = 1
  @@fallback_timeout = 3

  class << self


    def timeout
      @@timeout
    end

    def timeout= timeout
      @@timeout = timeout
    end

    def fallback_timeout
      @@fallback_timeout
    end

    def fallback_timeout= fallback_timeout
      @@fallback_timeout = fallback_timeout
    end

    def set_defaults_if_necessary options
     args = [:country, :province,:city]
      if options[:precision] && !args.include?(options[:precision])
        raise 'Invalid precision.'  
      end
    end

    def lookup_url(ip, options = {})
      set_defaults_if_necessary options
      raise 'Invalid IP address' unless ip.to_s =~ IPV4_REGEXP
      #http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=202.102.154.3
      "#{SERVICE_URL}?format=json&ip=#{ip}"
    end

    # Retreive the remote location of a given ip address.
    #
    # It takes two optional arguments:
    #
    # ==== Example:
    #   GeoIp.geolocation('209.85.227.104', {:precision => :city})
    def geolocation(ip, options={})
      location = nil
      Timeout.timeout(self.fallback_timeout) do
        parsed_response = JSON.parse RestClient::Request.execute(:method => :get, :url => lookup_url(ip, options), :timeout => self.timeout)
        location = to_j(parsed_response, options)
      end
      location
    end

    private

    #hash => {"ret"=>1, "start"=>"202.102.151.208", "end"=>"202.102.154.255", "country"=>"中国", "province"=>"山东", "city"=>"济南", "district"=>"", "isp"=>"联通",   "type"=>"", "desc"=>""}
    def to_j(hash, options={})
      h = {ret: hash['ret'], start: hash['start'], end: hash['end'], country: hash['country'], province: hash['province'], city: hash['city'],\
         district: hash['district'], isp: hash['isp'], type: hash['type'], desc: hash['desc']}
      case options[:precision]
      when :country
        h = {country: hash['country']} # only return country
      when :province
        h = {country: hash['country'], province: hash['province']} # only country,province
      when :city
        h = {country: hash['country'], province: hash['province'],city: hash['city']} #  only country,province, city
      else
        h # return all
      end
      h
    end
  end
end

