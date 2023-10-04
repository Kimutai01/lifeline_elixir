defmodule LifelineElixir.Foodallergies do
  @moduledoc """
  The Foodallergies context.
  """

  import Ecto.Query, warn: false
  alias LifelineElixir.Repo

  alias LifelineElixir.Foodallergies.Foodallergy

  @doc """
  Returns the list of foodallergies.

  ## Examples

      iex> list_foodallergies()
      [%Foodallergy{}, ...]

  """
  def list_foodallergies do
    Repo.all(Foodallergy)
  end

  @doc """
  Gets a single foodallergy.

  Raises `Ecto.NoResultsError` if the Foodallergy does not exist.

  ## Examples

      iex> get_foodallergy!(123)
      %Foodallergy{}

      iex> get_foodallergy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_foodallergy!(id), do: Repo.get!(Foodallergy, id)

  @doc """
  Creates a foodallergy.

  ## Examples

      iex> create_foodallergy(%{field: value})
      {:ok, %Foodallergy{}}

      iex> create_foodallergy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_foodallergy(attrs \\ %{}) do
    %Foodallergy{}
    |> Foodallergy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a foodallergy.

  ## Examples

      iex> update_foodallergy(foodallergy, %{field: new_value})
      {:ok, %Foodallergy{}}

      iex> update_foodallergy(foodallergy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_foodallergy(%Foodallergy{} = foodallergy, attrs) do
    foodallergy
    |> Foodallergy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a foodallergy.

  ## Examples

      iex> delete_foodallergy(foodallergy)
      {:ok, %Foodallergy{}}

      iex> delete_foodallergy(foodallergy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_foodallergy(%Foodallergy{} = foodallergy) do
    Repo.delete(foodallergy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking foodallergy changes.

  ## Examples

      iex> change_foodallergy(foodallergy)
      %Ecto.Changeset{data: %Foodallergy{}}

  """
  def change_foodallergy(%Foodallergy{} = foodallergy, attrs \\ %{}) do
    Foodallergy.changeset(foodallergy, attrs)
  end
end
