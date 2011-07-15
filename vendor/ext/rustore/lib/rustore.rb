require 'spree_core'
require 'rustore_hooks'

module Rustore
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end

      delivery_event = StateMachine::Event.new(Order.state_machine, :delivery)
      delivery_event.transition(:to => 'delivery')
      Order.state_machine.events << delivery_event

      Calculator::PriceFixVolumeDiscount.register

    end

    config.to_prepare &method(:activate).to_proc

  end
end
