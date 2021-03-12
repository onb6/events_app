# From lecture notes
defmodule EventsAppWeb.Helpers do
    def have_current_user?(conn) do
      conn.assigns[:current_user] != nil
    end

    def current_user_id?(conn, user_id) do
        user = conn.assigns[:current_user]
        user && user.id == user_id
    end

    def current_user_id(conn) do
      user = conn.assigns[:current_user]
      user && user.id
    end

    def invitee_by_email(invite) do 
      if EventsApp.Users.is_user_by_email(invite.email) do 
        EventsApp.Users.get_user_by_email(invite.email)
      else 
        false 
      end
    end

    def on_invite_list?(conn, invites) do 
      user = conn.assigns[:current_user]
      Enum.any?(invites, fn i -> i.email == user.email end)
    end 

    def need_response?(conn, invites) do 
      if on_invite_list?(conn, invites) do
      user = conn.assigns[:current_user]
      Enum.find(invites, fn i -> i.email == user.email end).response == -1
      end
    end
      
end