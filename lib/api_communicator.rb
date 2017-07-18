require 'rest-client'
require 'json'
require 'pry'

def array_of_films
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)

  #make the web request  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  character_hash.each do |key, value|
    if key == "results"
      character_hash[key].each do |k,v|
        return k["films"]
      end
    end
  end
end

def array_of_apis
  film_request = array_of_films.collect do |film|
    RestClient.get(film)
  end
  return film_request
end

def get_character_movies_from_api(character)

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  array_of_films
  array_of_apis

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  count = 1
  films = array_of_apis.collect do |api|
    JSON.parse(api)
  end
  films.each do |film|
    puts "#{count} #{film["title"]}"
    count+=1
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)

end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
