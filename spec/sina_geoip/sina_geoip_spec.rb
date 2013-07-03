# encoding:utf-8
require "spec_helper"

describe SinaGeoIp do
	before :all do
		IP = "12.130.132.30"
	end
  it "execute success and return ok" do
    res = SinaGeoIp.geolocation(IP)
    res.class.should == Hash
    res.size == 10
    res[:ret].should == 1
  end
  
  it "precision country"  do
  	res = SinaGeoIp.geolocation(IP,:precision=>:country)
  	res.size.should == 1
  	res.keys.include?(:country)
  end
  
  it "precision province"  do
  	res = SinaGeoIp.geolocation(IP,:precision => :province)
  	res.size.should == 2
  	res.keys.include?(:province)
  end

  it "precision city"  do
  	res = SinaGeoIp.geolocation(IP,:precision=>:city)
  	res.size.should == 3
  	res.keys.include?(:city)
  end

  it "Invalid IP address"  do
   	expect { SinaGeoIp.geolocation("125.3366.363.25") }.to raise_error(RuntimeError)
  end

end