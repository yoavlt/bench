defmodule Plug.App do
  use Plug.Router

  plug :match
  plug :fetch_query_params
  plug :dispatch

  plug Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Poison

  @members ~w(yoavlt entotsu morishitter)

  get "/:name" do
    send_resp conn, 200, "Hello #{name}"
  end

  get "/render/html" do
    render conn, :index, names: @members
  end

  get "/render/json" do
    json = Poison.encode!(%{data: @members})
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json)
  end

  post "/post/json" do
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    _json = Poison.decode!(body)
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(%{data: @members}))
  end

  match _ do
    send_resp(conn, 404, "")
  end

  defp render(conn, template, assigns) do
    html = apply(__MODULE__, template, [[conn: conn] ++ assigns])
    # outer = layout([conn: conn, inner: inner] ++ assigns)
    send_resp(conn, 200, html)
  end

  # Embed the views
  require EEx
  EEx.function_from_file :def, :index,  "lib/views/index.eex", [:assigns]
end
