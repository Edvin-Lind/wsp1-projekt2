class App < Sinatra::Base
    configure do
        enable :method_override
      end

    def db
        return @db if @db

        @db = SQLite3::Database.new("db/todos.sqlite")
        @db.results_as_hash = true

        return @db
    end

    get '/' do
        @todos = db.execute('SELECT * FROM todos')
        erb(:"index")
    end

    post '/create' do
        title = params['title']
        color = params['color']
        description = params['description']
        priority = params['priority']

        db.execute("INSERT INTO todos (title, color, description, priority) VALUES(?,?,?,?)", [title, color, description, priority])
        redirect("/")
    end

    delete '/delete/:id' do
        id = params['id']
        db.execute('DELETE FROM todos WHERE id = ?', [id])
        redirect('/')
    end

    get '/edit/:id' do
        id = params['id']
        @todo = db.execute('SELECT * FROM todos WHERE id = ?', [id]).first
        erb(:edit)
      end

    post '/edit/:id' do
        id = params['id']
        title = params['title']
        color = params['color']
        description = params['description']
        priority = params['priority']

        db.execute('UPDATE todos SET title = ?, color = ?, description = ?, priority = ? WHERE id = ?', [title, color, description, priority, id])
        redirect('/')
    end

end
