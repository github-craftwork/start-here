require 'octokit'

user = ENV["GITHUB ACTOR"]
org = "github-craftwork"
team_id = 3414353

client = Octokit::Client.new(:access_token => ENV["GITHUB_TOKEN"])

puts "-------------------------------------"
puts "ACTOR: #{user}"

puts client.organization_member?(org, user)
puts "-------------------------------------"

if !client.organization_member?(org, user)
  client.add_team_membership(3414353, user)
end
