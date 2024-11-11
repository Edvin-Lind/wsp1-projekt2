class App < Sinatra::Base

    get '/' do
        erb(:"index")
    end

    get '/todo' do
        @fruits = db.execute('SELECT * FROM todos')
        erb(:"todos/index")
    end

    post '/todos/new' do
        title = params['title']
        color = params['color']
        description = params['description']
        priority = params['priority']

        db.execute("INSERT INTO todos (title, color, description, priority) VALUES(?,?,?,?)", [title, color, description, priority])
        redirect("/todos")
    end

end
