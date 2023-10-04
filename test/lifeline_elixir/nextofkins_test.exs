defmodule LifelineElixir.NextofkinsTest do
  use LifelineElixir.DataCase

  alias LifelineElixir.Nextofkins

  describe "nextofkins" do
    alias LifelineElixir.Nextofkins.Nextofkin

    import LifelineElixir.NextofkinsFixtures

    @invalid_attrs %{name: nil, phone: nil, relationship: nil}

    test "list_nextofkins/0 returns all nextofkins" do
      nextofkin = nextofkin_fixture()
      assert Nextofkins.list_nextofkins() == [nextofkin]
    end

    test "get_nextofkin!/1 returns the nextofkin with given id" do
      nextofkin = nextofkin_fixture()
      assert Nextofkins.get_nextofkin!(nextofkin.id) == nextofkin
    end

    test "create_nextofkin/1 with valid data creates a nextofkin" do
      valid_attrs = %{name: "some name", phone: "some phone", relationship: "some relationship"}

      assert {:ok, %Nextofkin{} = nextofkin} = Nextofkins.create_nextofkin(valid_attrs)
      assert nextofkin.name == "some name"
      assert nextofkin.phone == "some phone"
      assert nextofkin.relationship == "some relationship"
    end

    test "create_nextofkin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Nextofkins.create_nextofkin(@invalid_attrs)
    end

    test "update_nextofkin/2 with valid data updates the nextofkin" do
      nextofkin = nextofkin_fixture()
      update_attrs = %{name: "some updated name", phone: "some updated phone", relationship: "some updated relationship"}

      assert {:ok, %Nextofkin{} = nextofkin} = Nextofkins.update_nextofkin(nextofkin, update_attrs)
      assert nextofkin.name == "some updated name"
      assert nextofkin.phone == "some updated phone"
      assert nextofkin.relationship == "some updated relationship"
    end

    test "update_nextofkin/2 with invalid data returns error changeset" do
      nextofkin = nextofkin_fixture()
      assert {:error, %Ecto.Changeset{}} = Nextofkins.update_nextofkin(nextofkin, @invalid_attrs)
      assert nextofkin == Nextofkins.get_nextofkin!(nextofkin.id)
    end

    test "delete_nextofkin/1 deletes the nextofkin" do
      nextofkin = nextofkin_fixture()
      assert {:ok, %Nextofkin{}} = Nextofkins.delete_nextofkin(nextofkin)
      assert_raise Ecto.NoResultsError, fn -> Nextofkins.get_nextofkin!(nextofkin.id) end
    end

    test "change_nextofkin/1 returns a nextofkin changeset" do
      nextofkin = nextofkin_fixture()
      assert %Ecto.Changeset{} = Nextofkins.change_nextofkin(nextofkin)
    end
  end
end
