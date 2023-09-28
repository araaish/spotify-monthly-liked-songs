# spotify-monthly-liked-songs
Scheduled script to create monthly playlist of liked songs

`spotify_script.rb` retrieves all of your liked songs on Spotify and creates a new playlist titled "**<month\>** **<year\>**" for songs liked in that month

## Getting Started

- Create a new app in the [Spotify dashboard](https://developer.spotify.com/dashboard)
- Store the `client_id` and `client_secret` for later use
- Navigate to the following url in your browser and authorize your app to access your account:
  > https://accounts.spotify.com/authorize?client_id=<YOUR CLIENT ID\>&response_type=code&redirect_uri=http://localhost:7777/callback&scope=user-library-read,playlist-modify-private
- This will redirect to a localhost page. Copy the authorization code in the url and store it for later use
- Run `get_refresh_token.rb` to get a token that does not expire and can be used to retrieve an access token later. The script will return the refresh token in stdout. Store
  this refresh token for later
- Store the above values as variables in a `keys.rb` file for reference in the main script
- Run `spotify_script.rb` and vibe


## Running on a Schedule

I want to create a new playlist every month, so I need to run this script on the last day of every month. You can use a cron job on Mac/Linux, or Task Scheduler on Windows

Steps for running script on schedule using Windows Task Scheduler: (thanks chatgpt)
- Create a New Task:
    - Open Task Scheduler and click "Create Basic Task..." or "Create Task..." to start creating a new task.
- Configure the Basic Task:
    - Provide a name and description for your task.
- Select Triggers and Set Schedule:
    - Choose when you want the task to start (e.g., daily, weekly) and set the trigger parameters.
- Select Action:
    - Choose "Start a program" as the action.
- Configure Action:
    - In the "Program/script" field, provide the path to the ruby.exe executable (e.g., "C:\path\to\ruby.exe").
    - In the "Add arguments (optional)" field, provide the path to your Ruby script (e.g., "C:\path\to\your\script.rb").
    - In the "Start in (optional)" field, provide the directory where your script is located (e.g., "C:\path\to\your").
- Finish

# Reference
[Spotify API](https://developer.spotify.com/documentation/web-api)

[Task Scheduler](https://www.jcchouinard.com/python-automation-using-task-scheduler/#:~:text=How%20to%20schedule%20a%20Python%20script%20with%20Task%20Scheduler%3F,Python%20file%20ase%20an%20argument.)
