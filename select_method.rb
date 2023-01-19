require_relative './app'
require 'json'

class SelectMethod
  def initialize
    @app = App.new
    @menu_option = {
      1 => 'show_books',
      2 => 'show_albums',
      3 => 'show_movies',
      4 => 'show_games',
      5 => 'show_genres',
      6 => 'show_labels',
      7 => 'show_authors',
      8 => 'show_sources',
      9 => 'add_book',
      10 => 'add_album',
      11 => 'add_movie',
      12 => 'add_game'
    }
  end

  def read_file(file)
    if File.exist?(file)
      data_from_file = File.read(file)
      JSON.parse(data_from_file)
    else
      '404'
    end
  end

  def load_json
    @app.list_books = read_file('./json/books.json') == '404' ? [] : read_file('./json/books.json')
    @app.list_authors = read_file('./json/authors.json') == '404' ? [] : read_file('./json/authors.json')
    @app.list_labels = read_file('./json/labels.json') == '404' ? [] : read_file('./json/labels.json')
    @app.list_games = read_file('./json/games.json') == '404' ? [] : read_file('./json/games.json')
  end

  def save_json
    File.write('./json/books.json', JSON.pretty_generate(@app.list_books))
    File.write('./json/authors.json', JSON.pretty_generate(@app.list_authors))
    File.write('./json/labels.json', JSON.pretty_generate(@app.list_labels))
    File.write('./json/games.json', JSON.pretty_generate(@app.list_games))
  end

  def assign_method(input)
    case input
    when 1..12
      @app.send(@menu_option[input])
    end
  end
end
