require "spec_helper"
require 'stringio'
require 'byebug'

describe Program do

  def input_test
    Program.new.find_data
  end

  describe ".new.find_data(input)" do

    it "returns the correct number of instances given the constructor 'input'" do
      expect(input_test).to eq(26)
    end
  end
end
