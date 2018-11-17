require 'httparty'
require 'byebug'
require 'hashie'

def find_data
  puts "Please input a selector for class, classnames, or identifiers to receive a JSON object associated with that selector"
  user_choice = STDIN.gets.chomp

  url = "https://raw.githubusercontent.com/jdolan/quetoo/master/src/cgame/default/ui/settings/SystemViewController.json"
  parsed_data = HTTParty.get(url).parsed_response
  json = JSON.parse(parsed_data)

  json.extend Hashie::Extensions::DeepFind
  classes = json.deep_find_all("class")

  json.extend(Hashie::Extensions::DeepLocate)
  stack_view = json.deep_locate -> (key, value, object) { key == "class" && value == "StackView"}
  box = json.deep_locate -> (key, value, object) { key == "class" && value == "Box"}
  input = json.deep_locate -> (key, value, object) { key == "class" && value == "Input"}
  video_mode_select = json.deep_locate -> (key, value, object) { key == "class" && value == "VideoModeSelect"}
  cvar_checkbox = json.deep_locate -> (key, value, object) { key == "class" && value == "CvarCheckbox"}
  cvar_select = json.deep_locate -> (key, value, object) { key == "class" && value == "CvarSelect"}
  cvar_slider = json.deep_locate -> (key, value, object) { key == "class" && value == "CvarSlider"}

  class_names = json.deep_find_all("classNames")
  class_names_array = []
  class_names.each do |array|
    class_names_array.concat(array)
  end
  container = json.deep_locate -> (key, value, object) { key == "classNames" && value.include?("container")}
  columns = json.deep_locate -> (key, value, object) { key == "classNames" && value.include?("columns")}
  column = json.deep_locate -> (key, value, object) { key == "classNames" && value.include?("column") && !value.include?("columns")}
  accessory_view = json.deep_locate -> (key, value, object) { key == "classNames" && value.include?("accessoryView")}


  identifiers = json.deep_find_all("identifier")
  system_ = json.deep_locate -> (key, value, object) { key == "identifier" && value == "System" }
  video_mode = json.deep_locate -> (key, value, object) { key == "identifier" && value == "videoMode" }
  window_mode = json.deep_locate -> (key, value, object) { key == "identifier" && value == "windowMode" }
  vertical_sync = json.deep_locate -> (key, value, object) { key == "identifier" && value == "verticalSync" }
  texture_mode = json.deep_locate -> (key, value, object) { key == "identifier" && value == "textureMode" }
  anisotropy = json.deep_locate -> (key, value, object) { key == "identifier" && value == "anisotropy" }
  multisample = json.deep_locate -> (key, value, object) { key == "identifier" && value == "multisample" }
  supersample = json.deep_locate -> (key, value, object) { key == "identifier" && value == "supersample" }
  rate = json.deep_locate -> (key, value, object) { key == "identifier" && value == "rate" }
  apply = json.deep_locate -> (key, value, object) { key == "identifier" && value == "apply" }

  if user_choice == "StackView" || user_choice == "stackview"
    puts stack_view
  elsif user_choice == "Box" || user_choice == "box"
    puts box
  elsif user_choice == "Input" || user_choice == "input"
    puts input
  elsif user_choice == "VideoModeSelect" || user_choice == "videomodeselect"
    puts video_mode_select
  elsif user_choice == "CvarCheckbox" || user_choice == "cvarcheckbox"
    puts cvar_checkbox
  elsif user_choice == "CvarSelect" || user_choice == "cvarselect"
    puts cvar_select
  elsif user_choice == "CvarSlider" || user_choice == "cvarslider"
    puts cvar_slider
  elsif user_choice == "Container" || user_choice == "continer" || user_choice == ".container"
    puts container
  elsif user_choice == "Columns" || user_choice == "columns" || user_choice == ".columns"
    puts columns
  elsif user_choice == "Column" || user_choice == "column" || user_choice == ".column"
    puts column
  elsif user_choice == "accessoryView" || user_choice == "accessoryview" || user_choice == ".accessoryView"
    puts accessory_view
  elsif user_choice == "System" || user_choice == "system" || user_choice == "#System"
    puts system_
  elsif user_choice == "videoMode" || user_choice == "videomode" || user_choice == "#videoMode"
    puts video_mode
  elsif user_choice == "windowMode" || user_choice == "windowmode" || user_choice == "#windowMode"
    puts window_mode
  elsif user_choice == "verticalSync" || user_choice == "verticalsync" || user_choice == "#verticalSync"
    puts vertical_sync
  elsif user_choice == "textureMode" || user_choice == "texturemode" || user_choice == "#textureMode"
    puts texture_mode
  elsif user_choice == "Anisotropy" || user_choice == "anisotropy" || user_choice == "#anisotrophy"
    puts anisotropy
  elsif user_choice == "multiSample" || user_choice == "multisample" || user_choice == "#multisample"
    puts multiSample
  elsif user_choice == "Rate" || user_choice == "rate" || user_choice == "#rate"
    puts rate
  elsif user_choice == "Apply" || user_choice == "apply" || user_choice == "#apply"
    puts apply
  else
    puts "That is not a valid choice.  Please check your spelling, spacing, and capitalization."
    find_data
  end

  puts "would you like to inspect another selector? (y/n)"
  yes_or_no = STDIN.gets.chomp

  if yes_or_no == "y" || yes_or_no == "yes" || yes_or_no == "Yes" || yes_or_no == "YES"
    find_data
  end
end

find_data
