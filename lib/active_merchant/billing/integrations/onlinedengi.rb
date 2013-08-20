# encoding: utf-8
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Onlinedengi
        autoload :Helper, File.dirname(__FILE__) + '/onlinedengi/helper.rb'
        autoload :Notification, File.dirname(__FILE__) + '/onlinedengi/notification.rb'

        mattr_accessor :service_url
        self.service_url = 'http://www.onlinedengi.ru/wmpaycheck.php'

        def self.helper(order, account, options = {})
          Helper.new(order, account, options)
        end

        def self.notification(query_string, options = {})
          Notification.new(query_string, options)
        end
      end
    end
  end
end
