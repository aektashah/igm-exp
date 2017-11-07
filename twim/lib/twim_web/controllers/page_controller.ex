defmodule TwimWeb.PageController do
  use TwimWeb, :controller
	require Logger

  def index(conn, _params) do
	url = "https://api.twitter.com/oauth/request_token"	
	creds = OAuther.credentials(consumer_key: System.get_env("CONSUMER_KEY"), consumer_secret: System.get_env("CONSUMER_SECRET"),	token: System.get_env("TOKEN"), token_secret: System.get_env("TOKEN_SECRET"))
	params = OAuther.sign("post", url, [], creds)
	{header, req_params} = OAuther.header(params)
	{:ok, code, header, ref} = :hackney.request('post', url, [header], {:form, req_params})
    	Logger.debug "#{inspect(:hackney.body(ref))}"
	render conn, "index.html"#, body: Poison.encode!(Poison.Parser.parse!(body)) 
  end
end
