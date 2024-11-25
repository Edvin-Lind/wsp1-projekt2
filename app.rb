class App < Sinatra::Base

    def db
        return @db if @db

        @db = SQLite3::Database.new("db/todos.sqlite")
        @db.results_as_hash = true

        return @db
    end

    get '/' do
        redirect("views/index")
    end

    get '/index' do
        @todos = db.execute('SELECT * FROM todos')
        erb(:"index")
    end

    get '/views/:id' do |id|
        @todo = db.execute('SELECT * FROM todos WHERE id=?', id).first
        erb(:"index")
    end

    post '/views/index' do
        title = params['title']
        color = params['color']
        description = params['description']
        priority = params['priority']

        db.execute("INSERT INTO todos (title, color, description, priority) VALUES(?,?,?,?)", [title, color, description, priority])
        redirect("/index")
    end

    post '/views/index' do
        title = params['title']
        color = params['color']
        description = params['description']
        priority = params['priority']

        db.execute("INSERT INTO todos (title, color, description, priority) VALUES(?,?,?,?)", [title, color, description, priority])
        redirect("/index")
    end

end
