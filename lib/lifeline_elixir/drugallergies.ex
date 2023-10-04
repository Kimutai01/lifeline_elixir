defmodule LifelineElixir.Drugallergies do
  @moduledoc """
  The Drugallergies context.
  """

  import Ecto.Query, warn: false
  alias LifelineElixir.Repo

  alias LifelineElixir.Drugallergies.Drugallergy

  @doc """
  Returns the list of drugallergies.

  ## Examples

      iex> list_drugallergies()
      [%Drugallergy{}, ...]

  """
  def list_drugallergies do
    Repo.all(Drugallergy)
  end

  @doc """
  Gets a single drugallergy.

  Raises `Ecto.NoResultsError` if the Drugallergy does not exist.

  ## Examples

      iex> get_drugallergy!(123)
      %Drugallergy{}

      iex> get_drugallergy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_drugallergy!(id), do: Repo.get!(Drugallergy, id)

  @doc """
  Creates a drugallergy.

  ## Examples

      iex> create_drugallergy(%{field: value})
      {:ok, %Drugallergy{}}

      iex> create_drugallergy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_drugallergy(attrs \\ %{}) do
    %Drugallergy{}
    |> Drugallergy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a drugallergy.

  ## Examples

      iex> update_drugallergy(drugallergy, %{field: new_value})
      {:ok, %Drugallergy{}}

      iex> update_drugallergy(drugallergy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_drugallergy(%Drugallergy{} = drugallergy, attrs) do
    drugallergy
    |> Drugallergy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a drugallergy.

  ## Examples

      iex> delete_drugallergy(drugallergy)
      {:ok, %Drugallergy{}}

      iex> delete_drugallergy(drugallergy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_drugallergy(%Drugallergy{} = drugallergy) do
    Repo.delete(drugallergy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking drugallergy changes.

  ## Examples

      iex> change_drugallergy(drugallergy)
      %Ecto.Changeset{data: %Drugallergy{}}

  """
  def change_drugallergy(%Drugallergy{} = drugallergy, attrs \\ %{}) do
    Drugallergy.changeset(drugallergy, attrs)
  end
end
