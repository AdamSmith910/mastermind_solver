require "rspec"
require_relative "../lib/mastermind.rb"


describe MasterMind do
  before { @mastermind = MasterMind.new }

  describe "it initializes with turns" do
    expect(@mastermind.turns).to eq(0)
  end   
end