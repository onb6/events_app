defmodule EventsAppWeb.ResponseController do
    use EventsAppWeb, :controller

    def update(conn, %{"id" => id, "invite" => invite_params}) do
        EventsAppWeb.InviteController.update(conn, %{"id" => id, "invite" => invite_params})
    end
end