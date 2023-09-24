require 'httparty'
require_relative 'keys'

# Get auth token
API_ENDPOINT = 'https://accounts.spotify.com/api/token'
header = {
    'Content-Type' => 'application/x-www-form-urlencoded'
}
request_payload = {
    grant_type: 'client_credentials',
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET
}
response = HTTParty.post(API_ENDPOINT, headers: header, body: request_payload)
auth_token = response['access_token']



