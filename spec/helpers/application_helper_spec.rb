require 'spec_helper'

describe ApplicationHelper do

  describe ".string_to_int_or_float" do

    it "should turn a float with a zero decimal places to an int" do
      expect(string_to_int_or_float('1.0')).to eq 1
    end

    it "should turn a float with multiple zero decimal places to an int" do
      expect(string_to_int_or_float('1.00000')).to eq 1
    end

    it "should turn a float with decimal places into a float" do
      expect(string_to_int_or_float('1.1')).to eq 1.1
    end

    it "should turn 0 into an int" do
      expect(string_to_int_or_float('0')).to eq 0
    end

    it "should turn 0.0 into an int" do
      expect(string_to_int_or_float('0.0')).to eq 0
    end

  end

end
