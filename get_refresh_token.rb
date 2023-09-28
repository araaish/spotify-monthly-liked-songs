# get refresh token
require 'httparty'
require_relative 'keys'
require_relative 'util'

request_payload = {
    grant_type: 'authorization_code',
    code: AUTH_CODE,
    redirect_uri: 'http://localhost:7777/callback'
}
encoded_auth = Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")
header = {
    'Content-Type' => 'application/x-www-form-urlencoded',
    'Authorization' => "Basic #{encoded_auth}"
}
response = HTTParty.post(TOKEN_ENDPOINT, headers: header, body: request_payload)
refresh_token = response['refresh_token']
puts "refresh token: #{refresh_token}"
