defmodule Twitter do
  @moduledoc """
  An OAuth2 strategy for Twitter.
  """
  use OAuth2.Strategy

  alias OAuth2.Strategy.AuthCode
  require Logger

  defp config do
    [strategy: Twitter,
     consumer_key: System.get_env("TWITTER_CLIENT_ID"),
     consumer_secret: System.get_env("TWITTER_CLIENT_SECRET"),
     site: "https://api.twitter.com",
     authorize_url: "https://api.twitter.com/oauth/request_token",
     token_url: "https://api.twitter.com/oauth/request_token"]
  end

  # Public API

  def client do
    Logger.debug "CLIENT ACCESSED"
    Logger.debug "CONFIG: #{inspect(config())}"
    Application.get_env(:twim, Twitter)
    |> Keyword.merge(config())
    |> OAuth2.Client.new()
  end

  def client(token) do
    %{client() | token: OAuth2.AccessToken.new(token) }
  end

  def authorize_url!(params \\ []) do
    Logger.debug "AUTHORIZED URL"
    Logger.debug "TWIT_CLIENT: #{inspect(client())}"
    o2_client = OAuth2.Client.authorize_url!(client(), Keyword.merge(params, 
	[oauth_callback: System.get_env("TWITTER_REDIRECT_URI")]))
    Logger.debug "OAUTH_CLIENT: #{inspect(o2_client)}"
    o2_client
  end

  def get_token!(params \\ [], _headers \\ []) do
    Logger.debug "GET_TOKEN!"
    OAuth2.Client.get_token!(client(), Keyword.merge(params, oauth_token: client().oauth_token))
  end

  # Strategy Callbacks

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_header("Accept", "application/json")
    |> AuthCode.get_token(params, headers)
    Logger.debug "CLIENT: #{inspect(client)}"
    client
  end
end
