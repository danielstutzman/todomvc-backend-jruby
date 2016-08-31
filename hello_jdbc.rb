require 'json'
require 'webrick'

class TodosServlet < WEBrick::HTTPServlet::AbstractServlet
  def get_instance(server)
    self
  end
  def initialize(conn)
    @conn = conn
  end
  def do_GET request, response
    todos = []
    stmt = @conn.createStatement
    rset = stmt.executeQuery 'SELECT id, title, completed FROM todo_items ORDER BY id'
    while rset.next
      todos.push({
        id:        rset.getInt(1),
        title:     rset.getString(2),
        completed: rset.getBoolean(3),
      })
    end
    rset.close
    stmt.close

    response.status = 200
    response['Content-Type'] = 'application/json'
    response.body = todos.to_json
  end
end

Java::org.postgresql.Driver
conn = java.sql.DriverManager.get_connection \
  'jdbc:postgresql://localhost:5432/todomvc', 'postgres', 'postgres'

server = WEBrick::HTTPServer.new Port: 8000
server.mount '/todos', TodosServlet.new(conn)
trap 'INT' do server.shutdown end
server.start
