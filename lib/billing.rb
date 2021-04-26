class Billing
  attr_accessor :token, :payment_method, :payment_token, :expiration

  def initialize(token:, payment_method:, payment_token:, expiration:)
    @token = token
    @payment_method = payment_method
    @payment_token = payment_token
    @expiration = expiration
  end
end
