defmodule Plug.App do
  use Plug.Router

  plug :match
  plug :fetch_query_params
  plug :dispatch

  get "/:name" do
    send_resp conn, 200, "Hello #{name}"
  end

  get "/render/html" do
    render conn, :index, names: [
      "yoavlt",
      "entotsu",
      "morishitter"
    ]
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
