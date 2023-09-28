require 'httparty'
require_relative 'keys'
require_relative 'util'

# Get access token using refresh token
encoded_auth = Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")
header = {
    'Content-Type' => 'application/x-www-form-urlencoded',
    'Authorization' => "Basic #{encoded_auth}"
}
request_payload = {
    grant_type: 'refresh_token',
    refresh_token: REFRESH_TOKEN
}
response = HTTParty.post(TOKEN_ENDPOINT, headers: header, body: request_payload)
access_token = response['access_token']

# Get current month and year
datetime = Time.now
current_month = datetime.strftime("%B")
current_year = datetime.strftime("%Y")

# Get saved tracks from this month
header = {
    'Authorization' => "Bearer #{access_token}"
}
# pagination
done = false
new_tracks = []
page_endpoint = API_SAVED_TRACKS_ENDPOINT
while not done
    response = HTTParty.get(page_endpoint, headers: header)
    tracks = collect_tracks(response['items'])
    new_tracks.concat(tracks)
    if response['next']
        page_endpoint = response['next']
    else
        done = true
    end
end

# End script if no new tracks
if new_tracks.empty?
    File.open('logs.txt', 'a') { |f|
        f.puts "No new tracks for #{current_month} #{current_year}" 
    }
    exit
end

# Create new playlist
request_payload = {
    name: "#{current_month} #{current_year}",
    public: 'false'
}
response = HTTParty.post(API_CREATE_PLAYLIST_ENDPOINT, headers: header, body: request_payload.to_json)
playlist_id = response['id']

# Add tracks to playlist
API_ADD_TRACKS_ENDPOINT = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"
request_payload = {
    uris: new_tracks
}
response = HTTParty.post(API_ADD_TRACKS_ENDPOINT, headers: header, body: request_payload.to_json)
File.open('logs.txt', 'a') { |f|
    if response['snapshot_id']
        f.puts "#{current_month} #{current_year} playlist created"
    else
        f.puts "Failed to add tracks to playlist #{current_month} #{current_year}"
    end
}
