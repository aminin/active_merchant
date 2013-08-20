# encoding: utf-8
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Onlinedengi
        class Helper < ActiveMerchant::Billing::Integrations::Helper

          def initialize(order, account, options = {})
            options.delete(:secret)
            super
          end

          mapping :account, 'project'
          mapping :amount, 'amount'
          mapping :currency, 'mode_type'
          mapping :user, 'nickname'
          mapping :order, 'order_id'
          mapping :description, 'comment'
        end
      end
    end
  end
end
