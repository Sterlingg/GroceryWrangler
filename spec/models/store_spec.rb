require 'spec_helper'

describe Store do
  let(:store) {FactoryGirl.create(:store)}

  it { should respond_to :name }

end
