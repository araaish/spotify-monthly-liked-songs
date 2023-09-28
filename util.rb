
require_relative 'keys'

# constants
TOKEN_ENDPOINT = "https://accounts.spotify.com/api/token"
API_SAVED_TRACKS_ENDPOINT = "https://api.spotify.com/v1/me/tracks?limit=50"
API_CREATE_PLAYLIST_ENDPOINT = "https://api.spotify.com/v1/users/#{USER_ID}/playlists"

# check if track was added this month
def check_ts(ts)
    datetime = DateTime.parse(ts)
    month = datetime.month
    year = datetime.year
    formatted_ts = format('%d-%02d', year, month)
    current_month = DateTime.now.month
    current_year = DateTime.now.year
    fromatted_current_ts = format('%d-%02d', current_year, current_month)
    if formatted_ts == fromatted_current_ts
        return true
    else
        return false
    end
end

# collect tracks from API response
def collect_tracks(items)
    tracks = []
    for item in items
        done = false
        added_at = item['added_at']
        track_uri = item['track']['uri']
        if check_ts(added_at)
            tracks.append(track_uri)
        end
    end
    return tracks
end

