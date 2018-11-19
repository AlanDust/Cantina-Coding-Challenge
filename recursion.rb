require 'httparty'
require 'byebug'
require 'hashie'

class Recursion

  def initialize
  end

  def run
    url = "https://raw.githubusercontent.com/jdolan/quetoo/master/src/cgame/default/ui/settings/SystemViewController.json"
    data = HTTParty.get(url)
    parsed_data = HTTParty.get(url).parsed_response
    json = JSON.parse(parsed_data)
    selector_type = ""
    new_json = []

    puts "Please input a selector for class, classnames (include .), or identifiers (include #) to receive a JSON object associated with that selector"
    puts "(case sensitive!)"
    user_choice = STDIN.gets.chomp

    if user_choice.include?("#")
      selector_type = "identifier"
      user_choice = user_choice.tr('#','')
    elsif user_choice.include?('.')
      selector_type = "classNames"
      user_choice = user_choice.tr('.','')
    else
      selector_type = "class"
    end
    user_choice
    selector_type
    get_data = find_data([], selector_type, json, user_choice)
    puts get_data
  end

  def find_data(new_json, selector_type, data, user_choice)
    if selector_type == "classNames"
      if data[selector_type]&.include?(user_choice)
        new_json << data
      end
    elsif data[selector_type] == user_choice
      new_json << data
    elsif data["contentView"] != nil
      data["contentView"]["subviews"].each do |subview|
        new_json << find_data([], selector_type, subview, user_choice)
      end
    elsif data["subviews"] != nil
      data["subviews"].each do |subview|
        new_json << find_data([], selector_type, subview, user_choice)
      end
    end
    new_json
  end
end
