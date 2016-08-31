Java::org.postgresql.Driver
conn = java.sql.DriverManager.get_connection(
  'jdbc:postgresql://localhost:5432/todomvc', 'postgres', 'postgres')
sql = 'SELECT id, title, completed FROM todo_items ORDER BY id'
stmt = conn.createStatement
rset = stmt.executeQuery sql 
while rset.next
  id = rset.getInt(1)
  title = rset.getString(2)
  completed = rset.getBoolean(3)
  puts sprintf("Todo(%d,'%s',%s)", id, title, completed)
end
rset.close
stmt.close
conn.close
