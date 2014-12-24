require 'sinatra'
require 'cgi'
require 'rest-client'
require 'json'
require 'haml'

enable :sessions

SECRET    = "9e48e2d1dfb0d0263c53e1f083f25645405bfbf05301d96356550be35ee5ce92a7566a4ba3414dbb596c9ad1509c663a88c0"
CLIENT_ID = "2f4f88506b95a4563ee4c014d9f41c1b7ea1133f54737e244c6bd76a30b1a740820b067d518db740ee3cc4471618801305e2"

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
  resp = RestClient.post 'http://localhost:3000/oauth/token', {code: code, client_id: CLIENT_ID, client_secret: SECRET}
  token = JSON.parse(resp)["token"]
  session[:token] = token
  redirect to("/")
end

def access_request_url
  redirect_url = CGI.escape('http://localhost:4567/login')
  scope = CGI.escape('users posts')
  "http://localhost:3000/oauth/auth?" +
    "response_type=code&client_id=#{CLIENT_ID}" +
    "&redirect_url=#{redirect_url}" +
    "&scope=#{scope}" +
    "&approval_prompt=force"
end

def get_friends
  resp = JSON.parse(RestClient.get("http://localhost:3000/users.json",
                            params: {access_token: session[:token]}
                            ))
  puts "resp = #{resp}"
  resp["items"]
end

helpers do
  def make_big_ava(url)
    url.sub("?sz=50", "?sz=250")
  end
end
