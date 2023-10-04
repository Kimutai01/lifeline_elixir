defmodule LifelineElixir.Nextofkins do
  @moduledoc """
  The Nextofkins context.
  """

  import Ecto.Query, warn: false
  alias LifelineElixir.Repo

  alias LifelineElixir.Nextofkins.Nextofkin

  @doc """
  Returns the list of nextofkins.

  ## Examples

      iex> list_nextofkins()
      [%Nextofkin{}, ...]

  """
  def list_nextofkins do
    Repo.all(Nextofkin)
  end

  @doc """
  Gets a single nextofkin.

  Raises `Ecto.NoResultsError` if the Nextofkin does not exist.

  ## Examples

      iex> get_nextofkin!(123)
      %Nextofkin{}

      iex> get_nextofkin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nextofkin!(id), do: Repo.get!(Nextofkin, id)

  @doc """
  Creates a nextofkin.

  ## Examples

      iex> create_nextofkin(%{field: value})
      {:ok, %Nextofkin{}}

      iex> create_nextofkin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nextofkin(attrs \\ %{}) do
    %Nextofkin{}
    |> Nextofkin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nextofkin.

  ## Examples

      iex> update_nextofkin(nextofkin, %{field: new_value})
      {:ok, %Nextofkin{}}

      iex> update_nextofkin(nextofkin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nextofkin(%Nextofkin{} = nextofkin, attrs) do
    nextofkin
    |> Nextofkin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nextofkin.

  ## Examples

      iex> delete_nextofkin(nextofkin)
      {:ok, %Nextofkin{}}

      iex> delete_nextofkin(nextofkin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nextofkin(%Nextofkin{} = nextofkin) do
    Repo.delete(nextofkin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nextofkin changes.

  ## Examples

      iex> change_nextofkin(nextofkin)
      %Ecto.Changeset{data: %Nextofkin{}}

  """
  def change_nextofkin(%Nextofkin{} = nextofkin, attrs \\ %{}) do
    Nextofkin.changeset(nextofkin, attrs)
  end
end
