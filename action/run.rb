require "octokit"
require "json"

# Each Action has an event passed to it.
event = JSON.parse(File.read(ENV['GITHUB_EVENT_PATH']))
comment = event["comment"]["body"]
org = "github-craftwork"
team_id = 3414353
commenter = event["comment"]["user"]["login"]

puts "-------------------------------------------------"

# Use GITHUB_TOKEN to interact with the GitHub API
client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])

if comment.include?(".invite") && comment.split().length == 2
  cmd, handle = comment.split
  
  user = handle == "me" ? commenter : handle.tr('@', '')
  
  puts "USER: #{user}"

  exit(78) if client.organization_member?(org, user)
  
  client.add_team_membership(team_id, user)
end

puts "-------------------------------------------------"

puts "Action succesfully ran"
