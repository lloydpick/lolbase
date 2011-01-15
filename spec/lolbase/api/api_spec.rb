require 'spec_helper'

describe Lolbase::API::API, "class accessors" do
  subject { Lolbase::API::API }

  its(:base_url)                 { should eql('lolbase.net') }
  its(:search_url)               { should eql('search') }

  its(:max_connection_tries)     { should eql(10) }
  its(:cache_directory_path)     { should eql('cache/') }
  its(:failed_cache_timeout)     { should eql(86400) }
  its(:cache_failed_requests)    { should be_true }
end

describe Lolbase::API::API, "initialization" do
  context "without options" do
    subject { Lolbase::API.new }

    its(:region)        { should eql('eu') }
    its(:caching)       { should be_true }
    its(:cache_timeout) { should eql(604800) }
    its(:debug)         { should_not be_true }
  end

  context "with options" do
    let(:options) { {:character_name => 'USA_Person', :region => 'us', :caching => false, :cache_timeout => 1600, :debug => true} }
    subject { Lolbase::API.new(options) }

    its(:character_name) { should eql(options[:character_name]) }
    its(:region)         { should eql(options[:region]) }
    its(:caching)        { should eql(options[:caching]) }
    its(:cache_timeout)  { should eql(options[:cache_timeout]) }
    its(:debug)          { should eql(options[:debug]) }
  end
end

describe Lolbase::API::API, "attribute accessors" do
  let(:api) { Lolbase::API.new(:caching => false) }

  describe "#character_name= and #character_name" do
    it "should assign and return 'ToonName'" do
      api.character_name = 'ToonName'
      api.character_name.should == 'ToonName'
    end
  end

  describe "#region= and #region" do
    it "should assign and return 'Region'" do
      api.region = 'Region'
      api.region.should == 'Region'
    end
  end

  describe "#caching= and #caching" do
    it "should assign and return true" do
      api.caching = true
      api.caching.should == true
    end
  end

  describe "#cache_timeout= and #cache_timeout" do
    it "should assign and return 600" do
      api.cache_timeout = 600
      api.cache_timeout.should == 600
    end
  end

  describe "#debug= and #debug" do
    it "should assign and return true" do
      api.debug = true
      api.debug.should == true
    end
  end
end

describe Lolbase::API::API, "search" do
  let(:api) { Lolbase::API.new(:caching => false) }

  it "should raise NoSearchString when first param is blank" do
    expect { api.search({}) }.to raise_error(Lolbase::Exceptions::NoSearchString)
  end

  it "should raise InvalidSearchType when given an invalid search type" do
    expect { api.search('Foo', :type => 'bar') }.to raise_error(Lolbase::Exceptions::InvalidSearchType)
  end

  describe "#search_characters" do
    it "should call #search with the correct parameters" do
      api.expects(:search).with(:search => 'CharacterName', :type => 'characters').twice
      api.search_characters('CharacterName')
      api.search_characters(:search => 'CharacterName')
    end

    it "should return an array of instances of SearchCharacter" do
      results = api.search_characters('Limeh')
      results.should be_kind_of(Array)
      results[0].should be_kind_of(Lolbase::Classes::SearchCharacter)
    end
  end

end

describe Lolbase::API::API do
  let(:api) { Lolbase::API.new(:caching => false) }

  describe "#base_url" do
    it "should return a default when given no parameters" do
      api.base_url.should match(Lolbase::API::API.base_url)
    end
  end
end