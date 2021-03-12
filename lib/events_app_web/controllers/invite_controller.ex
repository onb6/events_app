defmodule EventsAppWeb.InviteController do
  use EventsAppWeb, :controller

  alias EventsApp.Invites
  alias EventsApp.Invites.Invite

  def index(conn, _params) do
    invites = Invites.list_invites()
    render(conn, "index.html", invites: invites)
  end

  def new(conn, _params) do
    changeset = Invites.change_invite(%Invite{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"invite" => invite_params}) do
      with {:ok, %Invite{} = invite} <- Invites.create_response(invite_params) do
        invite = Invites.load_event(invite)
        conn
        |> put_flash(:info, "Invite created successfully.")
        |> redirect(to: Routes.event_path(conn, :show, invite.event_id))
      end
  end

  def show(conn, %{"id" => id}) do
    invite = conn.assigns[:invite]
    |> Invite.load_comments()
    |> Invite.load_updates()
    |> Invite.load_events()
    invite = Invites.get_invite!(id)
    render(conn, "show.html", invite: invite)
  end

  def edit(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    changeset = Invites.change_invite(invite)
    render(conn, "edit.html", invite: invite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "invite" => invite_params}) do
    invite = Invites.get_invite!(id)

    case Invites.update_invite(invite, invite_params) do
      {:ok, invite} ->
        conn
        |> put_flash(:info, "Invite updated successfully.")
        |> redirect(to: Routes.invite_path(conn, :show, invite))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", invite: invite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invite = Invites.get_invite!(id)
    {:ok, _invite} = Invites.delete_invite(invite)

    conn
    |> put_flash(:info, "Invite deleted successfully.")
    |> redirect(to: Routes.invite_path(conn, :index))
  end
end
