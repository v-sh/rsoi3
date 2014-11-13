require 'sinatra'
require 'cgi'
require 'rest-client'
require 'json'
require 'haml'

enable :sessions

SECRET = "gcwS6NIH8EXGtX5EblRC2JsX"
CLIENT_ID = "807806714570-l4jfvfiacf33vgnr651e77o8r2cnspn0.apps.googleusercontent.com"

get '/' do
  redirect to("/login") and return if !session[:token]
  @friends = get_friends
  haml :index
end

get '/login' do
  if params[:code]
    do_login(params[:code])
  else
    redirect access_request_url
  end
end

get '/logout' do
  session[:token] = false
  redirect to("/")
end


def do_login(code)
  resp = RestClient.post 'https://accounts.google.com/o/oauth2/token', {code: code, redirect_uri: "http://localhost:4567/login", client_id: CLIENT_ID, client_secret: SECRET, grant_type: "authorization_code"}
  token = JSON.parse(resp)["access_token"]
  session[:token] = token
  redirect to("/")
end

def access_request_url
  redirect_url = CGI.escape('http://localhost:4567/login')
  scope = CGI.escape('https://www.googleapis.com/auth/plus.login')
  "https://accounts.google.com/o/oauth2/auth?" +
    "response_type=code&client_id=#{CLIENT_ID}" +
    "&redirect_uri=#{redirect_url}" +
    "&scope=#{scope}" +
    "&approval_prompt=force"
end

def get_friends
  JSON.parse(RestClient.get("https://www.googleapis.com/plus/v1/people/me/people/visible",
                            params: {access_token: session[:token]}
                            ))["items"]
end

helpers do
  def make_big_ava(url)
    url.sub("?sz=50", "?sz=250")
  end
end
