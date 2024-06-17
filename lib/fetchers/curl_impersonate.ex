defmodule CurlImpersonate do
  def fetch(url) do
    args = String.split "run --rm lwthiker/curl-impersonate:0.6-chrome curl_chrome110 #{url}"
    case System.cmd("docker", args) do
      {body, 0} ->
        {:ok, body}
      {_, 6} ->
        {:error, :not_found}
      _ ->
        {:error, :internal_server_error}
    end
  end
end
