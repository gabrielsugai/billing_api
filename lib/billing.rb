class Billing
  attr_accessor :token, :payment_method, :payment_token, :value, :expiration

  def initialize(token:, payment_method:, payment_token:,value:, expiration:)
    @token = token
    @payment_method = payment_method
    @payment_token = payment_token
    @value = value
    @expiration = expiration
  end
end
