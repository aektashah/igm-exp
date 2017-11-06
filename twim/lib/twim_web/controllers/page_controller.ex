defmodule TwimWeb.PageController do
  use TwimWeb, :controller
	require Logger

  def index(conn, _params) do
		creds = OAuther.credentials(consumer_key: System.get_env("CONSUMER_KEY"), consumer_secret: System.get_env("CONSUMER_SECRET"),
			token: System.get_env("TOKEN"), token_secret: System.get_env("TOKEN_SECRET"))
		params = OAuther.sign("post", "https://api.twitter.com/1.1/statuses/lookup.json", [], creds)
		header = to_keyword_list(params)
		Logger.debug "#{inspect(header)}"
		response = HTTPotion.post "https://api.twitter.com/1.1/statuses/lookup.json", 
			[body: "id=485086311205048320", headers: header]
		Logger.debug "RESPONSE: #{inspect(response)}"
    render conn, "index.html"
  end

	# Function courtesy of https://www.codesd.com/item/recursively-convert-the-map-to-the-list-of-keywords.html
	def to_keyword_list(map) do
    Enum.map(map, fn {k,v} ->
      v = cond do
        is_map(v) -> to_keyword_list(v)
        true      -> v
      end

      {String.to_atom("#{k}"), v}
    end)
  end
end
