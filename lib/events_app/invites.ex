defmodule EventsApp.Invites do
  @moduledoc """
  The Invites context.
  """

  import Ecto.Query, warn: false
  alias EventsApp.Repo

  alias EventsApp.Invites.Invite

  @doc """
  Returns the list of invites.

  ## Examples

      iex> list_invites()
      [%Invite{}, ...]

  """
  def list_invites do
    Repo.all(Invite)
  end

  @doc """
  Gets a single invite.

  Raises `Ecto.NoResultsError` if the Invite does not exist.

  ## Examples

      iex> get_invite!(123)
      %Invite{}

      iex> get_invite!(456)
      ** (Ecto.NoResultsError)

  """
  def get_invite!(id), do: Repo.get!(Invite, id)

  @doc """
  Creates a invite.

  ## Examples

      iex> create_invite(%{field: value})
      {:ok, %Invite{}}

      iex> create_invite(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_invite(attrs \\ %{}) do
    %Invite{}
    |> Invite.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a invite.

  ## Examples

      iex> update_invite(invite, %{field: new_value})
      {:ok, %Invite{}}

      iex> update_invite(invite, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_invite(%Invite{} = invite, attrs) do
    invite
    |> Invite.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a invite.

  ## Examples

      iex> delete_invite(invite)
      {:ok, %Invite{}}

      iex> delete_invite(invite)
      {:error, %Ecto.Changeset{}}

  """
  def delete_invite(%Invite{} = invite) do
    Repo.delete(invite)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking invite changes.

  ## Examples

      iex> change_invite(invite)
      %Ecto.Changeset{source: %Invite{}}

  """
  def change_invite(%Invite{} = invite) do
    Invite.changeset(invite, %{})
  end

  def load_event(%Invite{} = invite) do
    invite = Repo.preload(invite, :event)
    event = EventsApp.Events.load_invites(invite.event)
    %{ invite | event: event }
  end

  def create_response(attrs \\ %{}) do
    %Invite{}
    |> Invite.changeset(attrs)
    |> Repo.insert(
      on_conflict: :replace_all,
      conflict_target: [:id])
  end


  # # From lecture notes
  # def load_comments(%Invite{} = invite) do
  #   Repo.preload(invite, [comments: :event])
  # end

  # # From lecture notes
  # def load_updates(%Invite{} = invite) do
  #   Repo.preload(invite, [updates: :event])
  # end

  # def load_events(%Invite{} = invite) do
  #   Repo.preload(invite, [events: :event])
  # end
end
