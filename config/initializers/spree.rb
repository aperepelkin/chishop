if Spree::Config.instance 
  Spree::Config.set(:allow_ssl_in_production => false)
  Spree::Config.set(:default_locale => 'ru') 
  Spree::Config.set(:address_requires_state => false)
end
