require 'httparty'
require 'byebug'
require 'hashie'

def find_data
  puts "Please type 'class', 'classnames', or 'identifiers' to receive a list of these objects"
  user_choice = STDIN.gets.chomp

  url = "https://raw.githubusercontent.com/jdolan/quetoo/master/src/cgame/default/ui/settings/SystemViewController.json"
  parsed_data = HTTParty.get(url).parsed_response
  json = JSON.parse(parsed_data)

  json.extend Hashie::Extensions::DeepFind
  classes = json.deep_find_all("class")

  class_names = json.deep_find_all("classNames")
  class_names_array = []
  class_names.each do |array|
    class_names_array.concat(array)
  end

  identifiers = json.deep_find_all("identifier")

  if user_choice == "class"
    puts classes
  elsif user_choice == "classnames"
    puts class_names_array
  elsif user_choice == "identifiers"
    puts identifiers
  else
    find_data
  end
end

find_data
