class FileManager
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