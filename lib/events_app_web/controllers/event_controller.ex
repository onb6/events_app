defmodule EventsAppWeb.EventController do
  use EventsAppWeb, :controller

  alias EventsApp.Events
  alias EventsApp.Events.Event

  alias EventsAppWeb.Plugs
  plug Plugs.RequireUser when action not in [:index, :show]
  plug :fetch_event when action in [:show, :edit, :update, :delete]
  plug :require_owner when action in [:edit, :update, :delete]

  def index(conn, _params) do
    events = Events.list_events()
    |> Enum.map(fn e -> Events.load_invites(e) end)
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    event_params = event_params
    |> Map.put("user_id", conn.assigns[:current_user].id)

    case Events.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => _id}) do
    event = conn.assigns[:event]
    |> Events.load_comments()
    |> Events.load_updates()
    |> Events.load_invites()
    |> Events.load_responses()

    comm = %EventsApp.Comments.Comment{
      event_id: event.id,
      user_id: current_user_id(conn),
    }
    new_comment = EventsApp.Comments.change_comment(comm)
    update = %EventsApp.Updates.Update{
      event_id: event.id
    }
    new_update = EventsApp.Updates.change_update(update)
    invite = %EventsApp.Invites.Invite{
      event_id: event.id
    }
    new_invite = EventsApp.Invites.change_invite(invite)

    render(conn, "show.html", event: event, new_comment: new_comment, new_update: new_update, new_invite: new_invite)
  end

  def edit(conn, %{"id" => id}) do
    event = conn.assigns[:event]
    changeset = Events.change_event(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = conn.assigns[:event]

    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: Routes.event_path(conn, :show, event))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = conn.assigns[:event]
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: Routes.event_path(conn, :index))
  end

  # From lecture notes
  def fetch_event(conn, _args) do
    id = conn.params["id"]
    event = Events.get_event!(id)
    assign(conn, :event, event)
  end

  # From lecture notes
  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    event = conn.assigns[:event]

    if user.id == event.user_id do
      conn
    else
      conn
      |> put_flash(:error, "Not your event!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

end
