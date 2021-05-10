require 'spec_helper'

describe Billing do
  it 'Instancia um objeto do tipo cobrança' do
    billing = Billing.new(token: '14f4d82cfda1bab13b2f57869024b524bf5142ca',
                          payment_method: 'credit_card',
                          payment_token: 'f97e19a69c572a533423fba90dc9f28c1aeefed3',
                          value: 100,
                          expiration: '26/04/2033',
                          status: 1)

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

  it 'Cria linha do cabeçalho do arquivo' do
    billings = Billing.where(payment_method: 'credit_card')
    header = FileManager.header(billings)

    expect(header).to eq("H #{'%05d' % billings.size}")
  end

  it 'Cria linhas do corpo do arquivo' do
    billing = Billing.new(token: '14f4d82cfda1bab13b2f57869024b524bf5142ca',
                          payment_method: 'credit_card',
                          payment_token: 'f97e19a69c572a533423fba90dc9f28c1aeefed3',
                          value: 100,
                          expiration: '26/04/2033',
                          status: 1)

    body = FileManager.body(billing)

    expect(body).to eq("B #{billing.token} 20330426   0000000100 01")
  end

  it 'Cria linha do rodape do arquivo' do
    billings = []
    billings << Billing.new(token: '16f4d82cfda1aab13b2f57869024b524bf5142ca',
                          payment_method: 'credit_card',
                          payment_token: 'f99b19a69c572a533423fba90dc9f28c1aeefed3',
                          value: 125,
                          expiration: '26/04/2033',
                          status: 1)

    billings <<  Billing.new(token: '14f4d82cfda1bab13b2f57869024b524bf5142ca',
                             payment_method: 'credit_card',
                             payment_token: 'f97e19a69c572a533423fba90dc9f28c1aeefed3',
                             value: 75,
                             expiration: '26/04/2033',
                             status: 1)

    footer = FileManager.footer(billings)

    expect(footer).to eq('F 000000000000200')
  end

  it 'Cria o arquivo com cabecalho corpo e rodape' do
    billings = Billing.where(payment_method: 'pix')
    header = FileManager.header(billings)
    body = FileManager.body(billings.first)
    footer = FileManager.footer(billings)

    allow(Database).to receive(:create).and_return('Finge que salvou')
    FileManager.create(billings)

    expect(File.read("data/20210510_PIX_EMISSAO.txt")).to include(header)
    expect(File.read("data/20210510_PIX_EMISSAO.txt")).to include(body)
    expect(File.read("data/20210510_PIX_EMISSAO.txt")).to include(footer)
  end
end
