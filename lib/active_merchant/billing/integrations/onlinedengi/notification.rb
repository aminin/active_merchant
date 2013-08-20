# encoding: utf-8
module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Onlinedengi
        class Notification < ActiveMerchant::Billing::Integrations::Notification
          def self.recognizes?(params)
            false
          end

          def valid_amount_format?
            gross.to_s.match(/[0-9]+\.[0-9]+|[0-9]+/).to_s  == gross
          end

          def complete?
            (content_id || item_id) && gross && transaction_id
          end

          def acknowledge
            params['key'] == generate_sign
          end

          def generate_sign
            Digest::MD5.hexdigest "#{gross}#{params['userid']}#{transaction_id}#{@options[:secret]}"
          end

          def search?
            !!BillingPayment.find_by_transaction_id(transaction_id)
          end

          def search
            !!BillingPayment.find_by_transaction_id(transaction_id)
          end

          def item_id
            !params['orderid'].blank? && params['orderid']
          end

          def content_id
            params['orderid'].blank? && params['userid']
          end

          def transaction_id
            params['paymentid']
          end

          def gross
            params['amount']
          end

          def amount
            BigDecimal.new(gross.to_s)
          end

          def currency
            'RUR'
          end

          def response_content_type
            'application/xml'
          end

          def success_response(options = {})
            <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<result>
  <id>#{options[:payment].id}</id>
  <code>YES</code>
</result>
            XML
          end

          def error_response(error_type, options = {})
            <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<result>
  <code>NO</code>
  <comment>#{options[:answer]}</comment>
</result>
            XML
          end

        end
      end
    end
  end
end
