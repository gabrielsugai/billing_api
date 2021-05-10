class Billing
  attr_accessor :token, :payment_method, :payment_token, :value, :expiration, :status

  def initialize(token:, payment_method:, payment_token:,value:, expiration:, status:)
    @token = token
    @payment_method = payment_method
    @payment_token = payment_token
    @value = value
    @expiration = expiration
    @status = status
  end

  def self.all
    response = JSON.parse(File.read('spec/fixtures/billings.json'), symbolize_names: true)
    response.map { |invoice| new(**invoice) }
  end

  def self.where(payment_method:)
    all.select { |invoice| invoice.payment_method == payment_method }
  end
end
