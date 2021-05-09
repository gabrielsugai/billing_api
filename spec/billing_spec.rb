require 'spec_helper'

describe Billing do
  it 'Instancia um objeto do tipo cobrança' do
    billing = Billing.new(token: '14f4d82cfda1bab13b2f57869024b524bf5142ca',
                          payment_method: 'credit_card',
                          payment_token: 'f97e19a69c572a533423fba90dc9f28c1aeefed3',
                          value: 100,
                          expiration: '26/04/2033')

    expect(billing.class).to eq Billing
    expect(billing.token).to eq('14f4d82cfda1bab13b2f57869024b524bf5142ca')
    expect(billing.payment_method).to eq('credit_card')
    expect(billing.payment_token).to eq('f97e19a69c572a533423fba90dc9f28c1aeefed3')
    expect(billing.value).to eq(100)
    expect(billing.expiration).to eq('26/04/2033')
  end

  it 'Lista todas as cobranças' do
    billings = Billing.all

    expect(billings.class).to eq(Array)
    expect(billings.first.class).to eq(Billing)
  end

  it 'Lista apenas cobrancas por cartao' do
    billings = Billing.where(payment_method: 'credit_card')

    expect(billings.size).to eq(2)
    expect(billings.first.payment_method).to eq('credit_card')
    expect(billings.last.payment_method).not_to eq('pix')
  end
end
