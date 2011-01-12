require 'spec_helper'

describe Lolbase::API::API, "class accessors" do
  subject { Lolbase::API::API }

  its(:base_url)                 { should eql('lolbase.net') }
  its(:search_url)               { should eql('/search') }

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