defmodule LifelineElixir.FoodallergiesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LifelineElixir.Foodallergies` context.
  """

  @doc """
  Generate a foodallergy.
  """
  def foodallergy_fixture(attrs \\ %{}) do
    {:ok, foodallergy} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> LifelineElixir.Foodallergies.create_foodallergy()

    foodallergy
  end
end
