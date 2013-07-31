require 'spec_helper'

describe Article do
  it { should have_many :translations }
end
