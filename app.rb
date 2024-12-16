class App < Sinatra::Base

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

end
