def to_params
  params = ''
  stack = []

  each do |k, v|
    if v.is_a?(Hash)
      stack << [k,v]
    else
      params << "#{k}=#{v}&"
    end
  end

  stack.each do |parent, hash|
    hash.each do |k, v|
      if v.is_a?(Hash)
        stack << ["#{parent}[#{k}]", v]
      else
        params << "#{parent}[#{k}]=#{v}&"
      end
    end
  end

  params.chop! # trailing &
  params
end

namespace :fixtures do
  desc "Refresh spec fixtures with fresh data from lolbase.net"
  task :refresh do
    require File.expand_path(File.dirname(__FILE__) + "/../spec/spec_helper")

    GET_SAMPLES.each_pair do |url, fixture|
      page = `curl -is #{url}`

      File.open(File.expand_path(File.dirname(__FILE__) + "/../spec/fixtures/#{fixture}"), 'w') do |f|
        f.write(page)
      end
    end

    POST_SAMPLES.each_pair do |url, extra|
      page = `curl -isd "#{extra[:query].to_params}" #{url.split("&")[0]}`

      File.open(File.expand_path(File.dirname(__FILE__) + "/../spec/fixtures/#{extra[:response]}"), 'w') do |f|
        f.write(page)
      end
    end
  end
end