defmodule LifelineElixir.NextofkinsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LifelineElixir.Nextofkins` context.
  """

  @doc """
  Generate a nextofkin.
  """
  def nextofkin_fixture(attrs \\ %{}) do
    {:ok, nextofkin} =
      attrs
      |> Enum.into(%{
        name: "some name",
        phone: "some phone",
        relationship: "some relationship"
      })
      |> LifelineElixir.Nextofkins.create_nextofkin()

    nextofkin
  end
end
