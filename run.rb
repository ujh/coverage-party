#!/usr/bin/env ruby
require 'tmpdir'
require 'yaml'

CONFIG = YAML.load_file(File.join(__dir__, 'config.yml'))

REPOS = CONFIG['repos']

by_user = Hash.new {|h,k| h[k] = 0}

Dir.mktmpdir do |dir|
  REPOS.each do |repo|
    print "Checking out #{repo['name']}... "
    Dir.chdir(dir) { `git clone -q git@github.com:#{repo['name']}.git` }
    print "\n"
  end
  print "\n"
  REPOS.each do |app|
    Dir.chdir(File.join(dir, app['name'])) do
      # 1. Find all commits in the repo from last week
      # 2. Run code coverage on all of them
      # 3. Remove those where the coverage couldn't be calculated
      # 4. Calculate difference between sets of commits and add difference to
      #    the running tally of the author of the newer commit.
    end
  end
end
