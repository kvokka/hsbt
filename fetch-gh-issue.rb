#!/usr/bin/env ruby

require 'pit'
require 'octokit'
config = Pit.get('github.com', :require => {'access_token' => 'Your access token of GitHub'})
octokit = Octokit::Client.new(:access_token => config['access_token'])

1.upto(ARGV[1].to_i).each do |i|
  issue = octokit.issue(ARGV[0], i)

  title = issue.title
  body = [issue.user.login, issue.body].join(': ')
  cbody = octokit.issue_comments(ARGV[0], i).map{|comment| [comment.user.login, comment.body].join(': ')}.join("\n\n----\n\n")

  File.open(i.to_s + '.txt', 'w'){|f| f.write(title + "\n\n----\n\n" + body + "\n\n----\n\n" + cbody) }
end
