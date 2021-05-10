require 'sqlite3'

class Database
  def self.create(billing:, file:, date:)

    db = SQLite3::Database.open 'db/database.db'
    db.execute 'INSERT INTO BILLING (token, file, date) VALUES ( ?, ?, ?)', billing.token, file, date
  end
end