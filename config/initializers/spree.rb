if Spree::Config.instance 
  Spree::Config.set(:allow_ssl_in_production => false)
  Spree::Config.set(:default_locale => 'ru') 
end 
