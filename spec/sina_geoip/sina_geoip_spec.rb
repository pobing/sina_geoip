# encoding:utf-8
require "spec_helper"

describe SinaGeoIP do
	before :all do
		IP = "12.130.132.30"
	end
  it "execute success and return ok" do
    res = SinaGeoIP.geolocation(IP)
    p res
    res.should
    
  end
  
  
end