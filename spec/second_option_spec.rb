require "spec_helper"
require 'stringio'
require 'byebug'

describe Second_option do

  def input_test
    Second_option.new.find_data
  end

  describe ".new.find_data(input)" do

    it "returns the correct number of instances given the constructor 'input'" do
      expect(input_test).to eq(26)
    end
  end
end
