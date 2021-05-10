class FileManager

  def self.create(billings)
    date = Time.now.strftime('%Y%m%d')
    method = billings.first.payment_method.upcase

    file = File.open("data/#{date}_#{method}_EMISSAO.txt", 'w+')

    file.write("#{header(billings)}\n")
    billings.each { |billing| file.write("#{body(billing)}\n")}
    file.write(footer(billings))

    file.close
  end

  def self.header(billings)
    "H #{'%05d' % billings.size}"
  end

  def self.body(billing)
    date = parse_date(billing.expiration)

    "B #{billing.token} #{date}   #{'%010d' % billing.value} #{'%02d' % billing.status }"
  end

  def self.footer(billings)
    total = 0
    billings.each { |billing| total += billing.value }
    "F #{'%015d' % total}"
  end

  private

  def self.parse_date(date)
    parsed_date = date.split('/')
    parsed_date.reverse.join
  end
end