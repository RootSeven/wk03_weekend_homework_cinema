require('pg')

class SqlRunner

  def self.run(sql, values = [])
    begin
      db = PG.connect(dbname: 'cinema', host: 'localhost')                        # CONNECT
      db.prepare('query', sql)                                                    # PREPARE
      result = db.exec_prepared('query', values)                                  # RUN
    ensure
      db.close() if db != nil                                                     # CLOSE
    end
    return result                                                                 # RETURN
  end

end
