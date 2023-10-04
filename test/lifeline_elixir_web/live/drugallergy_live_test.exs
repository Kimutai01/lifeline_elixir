defmodule LifelineElixirWeb.DrugallergyLiveTest do
  use LifelineElixirWeb.ConnCase

  import Phoenix.LiveViewTest
  import LifelineElixir.DrugallergiesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_drugallergy(_) do
    drugallergy = drugallergy_fixture()
    %{drugallergy: drugallergy}
  end

  describe "Index" do
    setup [:create_drugallergy]

    test "lists all drugallergies", %{conn: conn, drugallergy: drugallergy} do
      {:ok, _index_live, html} = live(conn, Routes.drugallergy_index_path(conn, :index))

      assert html =~ "Listing Drugallergies"
      assert html =~ drugallergy.name
    end

    test "saves new drugallergy", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.drugallergy_index_path(conn, :index))

      assert index_live |> element("a", "New Drugallergy") |> render_click() =~
               "New Drugallergy"

      assert_patch(index_live, Routes.drugallergy_index_path(conn, :new))

      assert index_live
             |> form("#drugallergy-form", drugallergy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#drugallergy-form", drugallergy: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.drugallergy_index_path(conn, :index))

      assert html =~ "Drugallergy created successfully"
      assert html =~ "some name"
    end

    test "updates drugallergy in listing", %{conn: conn, drugallergy: drugallergy} do
      {:ok, index_live, _html} = live(conn, Routes.drugallergy_index_path(conn, :index))

      assert index_live |> element("#drugallergy-#{drugallergy.id} a", "Edit") |> render_click() =~
               "Edit Drugallergy"

      assert_patch(index_live, Routes.drugallergy_index_path(conn, :edit, drugallergy))

      assert index_live
             |> form("#drugallergy-form", drugallergy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#drugallergy-form", drugallergy: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.drugallergy_index_path(conn, :index))

      assert html =~ "Drugallergy updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes drugallergy in listing", %{conn: conn, drugallergy: drugallergy} do
      {:ok, index_live, _html} = live(conn, Routes.drugallergy_index_path(conn, :index))

      assert index_live |> element("#drugallergy-#{drugallergy.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#drugallergy-#{drugallergy.id}")
    end
  end

  describe "Show" do
    setup [:create_drugallergy]

    test "displays drugallergy", %{conn: conn, drugallergy: drugallergy} do
      {:ok, _show_live, html} = live(conn, Routes.drugallergy_show_path(conn, :show, drugallergy))

      assert html =~ "Show Drugallergy"
      assert html =~ drugallergy.name
    end

    test "updates drugallergy within modal", %{conn: conn, drugallergy: drugallergy} do
      {:ok, show_live, _html} = live(conn, Routes.drugallergy_show_path(conn, :show, drugallergy))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Drugallergy"

      assert_patch(show_live, Routes.drugallergy_show_path(conn, :edit, drugallergy))

      assert show_live
             |> form("#drugallergy-form", drugallergy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#drugallergy-form", drugallergy: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.drugallergy_show_path(conn, :show, drugallergy))

      assert html =~ "Drugallergy updated successfully"
      assert html =~ "some updated name"
    end
  end
end
