#!/usr/bin/ruby

require 'fileutils'
require 'json'

def fail(file,message)
  print "***** failed on file #{file}, #{message}\n"
end

Dir["tests/*"].each { |f|
  unless f=~/(~|\.(json|bless))$/ then
    output = f+".json"
    bless = f+".bless"
    system("tint #{f} >#{output}") or fail(f,"tint crashed")
    if File.exist?(bless) then
      FileUtils.identical?(output,bless) or fail(f,"output not as expected")
    else
      fail(f,"no blessed version is given")
    end
  end
}
