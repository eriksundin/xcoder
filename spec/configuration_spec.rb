require 'rspec'
require 'xcoder'

describe Xcode::Configuration do 
  before do
    @config = Xcode.project('TestProject').target('TestProject').config('Debug')
  end
  
  it "should parse the name" do 
    @config.name.should=="Debug"
  end
  
  it "should be able to build" do
    builder = @config.builder
    builder.clean
    builder.build
    File.exists?(builder.app_path).should==true
    File.exists?(builder.dsym_path).should==true
  end
  
  it "should be able to package" do
    builder = @config.builder
    builder.clean
    builder.build
    builder.package
    File.exists?(builder.dsym_zip_path).should==true
    File.exists?(builder.ipa_path).should==true
  end
end