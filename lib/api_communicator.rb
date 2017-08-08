require 'rest-client'
require 'json'
require 'pry'

def req(link)
  all_x = RestClient.get(link)
  x = JSON.parse(all_x)
end

def get_films_hash(hash, character)
  hash['results'].find do |result|
    result["name"] == character
  end["films"]
end

def get_character_movies_from_api(character)
  get_films_hash(req('http://www.swapi.co/api/people/'), character)
end

def movie_description(hash)
  puts "Title: #{hash["title"]}"
  puts "Description: #{hash["opening_crawl"]}"
  puts "*"*30
end

def parse_character_movies(films_hash)
  films_hash.each do |film|
    movie_hash = req(film)
    movie_description(movie_hash)
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
