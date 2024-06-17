defmodule BittaWeb.PageController do
  use BittaWeb, :controller

  def home(conn, params) do
    # The home page is often custom made,
    # so skip the default app layout.

    IO.inspect(params)

    case params do
      %{"url" => url} ->
        CurlImpersonate.fetch(url)
        |> case do
          {:ok, result} -> conn |> json(result)
          {:error, reason} -> conn |> json(reason)
        end

      _ ->
        conn
        |>  json(%{error: "Missing url parameter"})
    end
  end
end
