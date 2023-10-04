defmodule LifelineElixir.DrugallergiesTest do
  use LifelineElixir.DataCase

  alias LifelineElixir.Drugallergies

  describe "drugallergies" do
    alias LifelineElixir.Drugallergies.Drugallergy

    import LifelineElixir.DrugallergiesFixtures

    @invalid_attrs %{name: nil}

    test "list_drugallergies/0 returns all drugallergies" do
      drugallergy = drugallergy_fixture()
      assert Drugallergies.list_drugallergies() == [drugallergy]
    end

    test "get_drugallergy!/1 returns the drugallergy with given id" do
      drugallergy = drugallergy_fixture()
      assert Drugallergies.get_drugallergy!(drugallergy.id) == drugallergy
    end

    test "create_drugallergy/1 with valid data creates a drugallergy" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Drugallergy{} = drugallergy} = Drugallergies.create_drugallergy(valid_attrs)
      assert drugallergy.name == "some name"
    end

    test "create_drugallergy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Drugallergies.create_drugallergy(@invalid_attrs)
    end

    test "update_drugallergy/2 with valid data updates the drugallergy" do
      drugallergy = drugallergy_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Drugallergy{} = drugallergy} = Drugallergies.update_drugallergy(drugallergy, update_attrs)
      assert drugallergy.name == "some updated name"
    end

    test "update_drugallergy/2 with invalid data returns error changeset" do
      drugallergy = drugallergy_fixture()
      assert {:error, %Ecto.Changeset{}} = Drugallergies.update_drugallergy(drugallergy, @invalid_attrs)
      assert drugallergy == Drugallergies.get_drugallergy!(drugallergy.id)
    end

    test "delete_drugallergy/1 deletes the drugallergy" do
      drugallergy = drugallergy_fixture()
      assert {:ok, %Drugallergy{}} = Drugallergies.delete_drugallergy(drugallergy)
      assert_raise Ecto.NoResultsError, fn -> Drugallergies.get_drugallergy!(drugallergy.id) end
    end

    test "change_drugallergy/1 returns a drugallergy changeset" do
      drugallergy = drugallergy_fixture()
      assert %Ecto.Changeset{} = Drugallergies.change_drugallergy(drugallergy)
    end
  end
end
