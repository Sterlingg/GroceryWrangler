require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ModalHelper. For example:
#
# describe ModalHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
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
