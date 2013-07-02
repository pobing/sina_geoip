# SinaGeoip

Retreive the geolocation of an IP address based on the [http://int.dpool.sina.com.cn/iplookup/iplookup.php](http://int.dpool.sina.com.cn/iplookup/iplookup.php) webservice.

## Installation

Add this line to your application's Gemfile:

    gem 'sina_geoip'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sina_geoip

## Usage



### Retrieve geolocation
    SinaGeoIp.geolocation(ip_address)

### Example

    # 12.130.132.30 = sina.com.cn (CN)
    GeoIp.geolocation('12.130.132.30')

returns:
  {
    :ret => 1, 
    :start => "202.108.24.0", 
    :end => "202.108.58.255", 
    :country => "中国", 
    :province => "北京", 
    :city => "北京", 
    :district => "", 
    :isp => "联通", 
    :type => "", 
    :desc => ""
  } 


### precision

There is an option to only retreive the country information and thus excluding the city details. This results in a faster response from the service since less queries need to be done.

#### precision country 

    GeoIp.geolocation('202.108.24.0', :precision => :country)

returns:

  {
    :country => "中国"
  }

#### precision province 

    GeoIp.geolocation('202.108.24.0', :precision => :province)

returns:

  {
    :country => "中国",
    :province => "北京"
  } 

#### precision city 

    GeoIp.geolocation('202.108.24.0', :precision => :city)

returns:

  {
    :country => "中国",
    :province => "北京",
    :city => "北京"

  } 


## Contributors

* [geo_ip](https://github.com/jeroenj/geo_ip)

## Bugs

Please report them on the [Github issue tracker](https://github.com/pobing/sina_geoip/issues)
for this project.

If you have a bug to report, please include the following information:

* **Version information for bierdopje, Rails and Ruby.**
* Stack trace and error message.

You may also fork this project on Github and create a pull request.
Do not forget to include tests.

## Copyright

Copyright (c) 2013 by pobing.
