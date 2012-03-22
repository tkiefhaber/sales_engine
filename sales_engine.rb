$LOAD_PATH << './'
require 'lib/sales_engine/database'

class SalesEngine
  db = Database.instance
  db.query
end