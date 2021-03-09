defmodule EventsAppWeb.PageController do
  use EventsAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
    events = EventsApp.Events.list_events()
    |> EventsApp.Events.load_responses()
  end
end
