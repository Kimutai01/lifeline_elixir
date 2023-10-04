defmodule LifelineElixirWeb.FoodallergyLiveTest do
  use LifelineElixirWeb.ConnCase

  import Phoenix.LiveViewTest
  import LifelineElixir.FoodallergiesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_foodallergy(_) do
    foodallergy = foodallergy_fixture()
    %{foodallergy: foodallergy}
  end

  describe "Index" do
    setup [:create_foodallergy]

    test "lists all foodallergies", %{conn: conn, foodallergy: foodallergy} do
      {:ok, _index_live, html} = live(conn, Routes.foodallergy_index_path(conn, :index))

      assert html =~ "Listing Foodallergies"
      assert html =~ foodallergy.name
    end

    test "saves new foodallergy", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.foodallergy_index_path(conn, :index))

      assert index_live |> element("a", "New Foodallergy") |> render_click() =~
               "New Foodallergy"

      assert_patch(index_live, Routes.foodallergy_index_path(conn, :new))

      assert index_live
             |> form("#foodallergy-form", foodallergy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#foodallergy-form", foodallergy: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.foodallergy_index_path(conn, :index))

      assert html =~ "Foodallergy created successfully"
      assert html =~ "some name"
    end

    test "updates foodallergy in listing", %{conn: conn, foodallergy: foodallergy} do
      {:ok, index_live, _html} = live(conn, Routes.foodallergy_index_path(conn, :index))

      assert index_live |> element("#foodallergy-#{foodallergy.id} a", "Edit") |> render_click() =~
               "Edit Foodallergy"

      assert_patch(index_live, Routes.foodallergy_index_path(conn, :edit, foodallergy))

      assert index_live
             |> form("#foodallergy-form", foodallergy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#foodallergy-form", foodallergy: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.foodallergy_index_path(conn, :index))

      assert html =~ "Foodallergy updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes foodallergy in listing", %{conn: conn, foodallergy: foodallergy} do
      {:ok, index_live, _html} = live(conn, Routes.foodallergy_index_path(conn, :index))

      assert index_live |> element("#foodallergy-#{foodallergy.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#foodallergy-#{foodallergy.id}")
    end
  end

  describe "Show" do
    setup [:create_foodallergy]

    test "displays foodallergy", %{conn: conn, foodallergy: foodallergy} do
      {:ok, _show_live, html} = live(conn, Routes.foodallergy_show_path(conn, :show, foodallergy))

      assert html =~ "Show Foodallergy"
      assert html =~ foodallergy.name
    end

    test "updates foodallergy within modal", %{conn: conn, foodallergy: foodallergy} do
      {:ok, show_live, _html} = live(conn, Routes.foodallergy_show_path(conn, :show, foodallergy))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Foodallergy"

      assert_patch(show_live, Routes.foodallergy_show_path(conn, :edit, foodallergy))

      assert show_live
             |> form("#foodallergy-form", foodallergy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#foodallergy-form", foodallergy: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.foodallergy_show_path(conn, :show, foodallergy))

      assert html =~ "Foodallergy updated successfully"
      assert html =~ "some updated name"
    end
  end
end
