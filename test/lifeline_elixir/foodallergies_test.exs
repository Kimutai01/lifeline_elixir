defmodule LifelineElixir.FoodallergiesTest do
  use LifelineElixir.DataCase

  alias LifelineElixir.Foodallergies

  describe "foodallergies" do
    alias LifelineElixir.Foodallergies.Foodallergy

    import LifelineElixir.FoodallergiesFixtures

    @invalid_attrs %{name: nil}

    test "list_foodallergies/0 returns all foodallergies" do
      foodallergy = foodallergy_fixture()
      assert Foodallergies.list_foodallergies() == [foodallergy]
    end

    test "get_foodallergy!/1 returns the foodallergy with given id" do
      foodallergy = foodallergy_fixture()
      assert Foodallergies.get_foodallergy!(foodallergy.id) == foodallergy
    end

    test "create_foodallergy/1 with valid data creates a foodallergy" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Foodallergy{} = foodallergy} = Foodallergies.create_foodallergy(valid_attrs)
      assert foodallergy.name == "some name"
    end

    test "create_foodallergy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Foodallergies.create_foodallergy(@invalid_attrs)
    end

    test "update_foodallergy/2 with valid data updates the foodallergy" do
      foodallergy = foodallergy_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Foodallergy{} = foodallergy} = Foodallergies.update_foodallergy(foodallergy, update_attrs)
      assert foodallergy.name == "some updated name"
    end

    test "update_foodallergy/2 with invalid data returns error changeset" do
      foodallergy = foodallergy_fixture()
      assert {:error, %Ecto.Changeset{}} = Foodallergies.update_foodallergy(foodallergy, @invalid_attrs)
      assert foodallergy == Foodallergies.get_foodallergy!(foodallergy.id)
    end

    test "delete_foodallergy/1 deletes the foodallergy" do
      foodallergy = foodallergy_fixture()
      assert {:ok, %Foodallergy{}} = Foodallergies.delete_foodallergy(foodallergy)
      assert_raise Ecto.NoResultsError, fn -> Foodallergies.get_foodallergy!(foodallergy.id) end
    end

    test "change_foodallergy/1 returns a foodallergy changeset" do
      foodallergy = foodallergy_fixture()
      assert %Ecto.Changeset{} = Foodallergies.change_foodallergy(foodallergy)
    end
  end
end
