require 'sqlite3'

class Seeder

  def self.seed!
    drop_tables
    create_tables
    populate_tables
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS todos')
  end

  def self.create_tables
    db.execute('CREATE TABLE todos (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                color TEXT NOT NULL,
                description TEXT,
                priority INTEGER)')
  end

  def self.populate_tables
    db.execute('INSERT INTO todos (title, color, description, priority) VALUES ("Äpple",   "white", "En rund frukt som finns i många olika färger.", 3)')
    db.execute('INSERT INTO todos (title, color, description, priority) VALUES ("Päron",    "black", "En nästan rund, men lite avläng, frukt. Oftast mjukt fruktkött.", 2)')
    db.execute('INSERT INTO todos (title, color, description, priority) VALUES ("Banan",  "yellow", "En avlång gul frukt.", 1)')
  end

  private
  def self.db
    return @db if @db
    @db = SQLite3::Database.new('db/todos.sqlite')
    @db.results_as_hash = true
    @db
  end
end


Seeder.seed!
