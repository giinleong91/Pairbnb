Braintree::Configuration.environment = :sandbox
Braintree::Configuration.logger = Logger.new('log/braintree.log')
Braintree::Configuration.merchant_id = ENV['your_merchant_id']
Braintree::Configuration.public_key = ENV['your_public_key']
Braintree::Configuration.private_key = ENV['your_private_key']
