require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
    arr = []
    where_line = params.map{ |key, values| "#{key} = ?"}.join(" AND ")
    results = DBConnection.execute(<<-SQL, params.values)
    SELECT
      *
    FROM
      #{table_name}
    WHERE
      #{where_line}
    SQL
    # p where_line
    parse_all(results)
  end
end

class SQLObject
  extend Searchable
end
