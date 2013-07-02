# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sina_geoip/version'

Gem::Specification.new do |spec|
  spec.name          = "sina_geoip"
  spec.version       = SinaGeoip::VERSION
  spec.authors       = ["pobing"]
  spec.email         = ["cn.jdong@gmail.com"]
  spec.description   = %q{Retreive the geolocation of an IP address based on the http://int.dpool.sina.com.cn/iplookup/iplookup.php webservice}
  spec.summary       = %q{A call to the sina geoip app . will be done to retreive the geolocation based on the IP address. No need to include a database file in the application.}
  spec.homepage      = "https://github.com/pobing/sina_geoip"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_dependency 'json', '~> 1.4.6'
  spec.add_dependency 'rest-client', '~> 1.6.1'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
