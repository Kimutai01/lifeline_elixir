defmodule LifelineElixir.DrugallergiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LifelineElixir.Drugallergies` context.
  """

  @doc """
  Generate a drugallergy.
  """
  def drugallergy_fixture(attrs \\ %{}) do
    {:ok, drugallergy} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> LifelineElixir.Drugallergies.create_drugallergy()

    drugallergy
  end
end
