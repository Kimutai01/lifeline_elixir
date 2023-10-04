defmodule LifelineElixirWeb.NextofkinLiveTest do
  use LifelineElixirWeb.ConnCase

  import Phoenix.LiveViewTest
  import LifelineElixir.NextofkinsFixtures

  @create_attrs %{name: "some name", phone: "some phone", relationship: "some relationship"}
  @update_attrs %{name: "some updated name", phone: "some updated phone", relationship: "some updated relationship"}
  @invalid_attrs %{name: nil, phone: nil, relationship: nil}

  defp create_nextofkin(_) do
    nextofkin = nextofkin_fixture()
    %{nextofkin: nextofkin}
  end

  describe "Index" do
    setup [:create_nextofkin]

    test "lists all nextofkins", %{conn: conn, nextofkin: nextofkin} do
      {:ok, _index_live, html} = live(conn, Routes.nextofkin_index_path(conn, :index))

      assert html =~ "Listing Nextofkins"
      assert html =~ nextofkin.name
    end

    test "saves new nextofkin", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.nextofkin_index_path(conn, :index))

      assert index_live |> element("a", "New Nextofkin") |> render_click() =~
               "New Nextofkin"

      assert_patch(index_live, Routes.nextofkin_index_path(conn, :new))

      assert index_live
             |> form("#nextofkin-form", nextofkin: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#nextofkin-form", nextofkin: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nextofkin_index_path(conn, :index))

      assert html =~ "Nextofkin created successfully"
      assert html =~ "some name"
    end

    test "updates nextofkin in listing", %{conn: conn, nextofkin: nextofkin} do
      {:ok, index_live, _html} = live(conn, Routes.nextofkin_index_path(conn, :index))

      assert index_live |> element("#nextofkin-#{nextofkin.id} a", "Edit") |> render_click() =~
               "Edit Nextofkin"

      assert_patch(index_live, Routes.nextofkin_index_path(conn, :edit, nextofkin))

      assert index_live
             |> form("#nextofkin-form", nextofkin: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#nextofkin-form", nextofkin: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nextofkin_index_path(conn, :index))

      assert html =~ "Nextofkin updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes nextofkin in listing", %{conn: conn, nextofkin: nextofkin} do
      {:ok, index_live, _html} = live(conn, Routes.nextofkin_index_path(conn, :index))

      assert index_live |> element("#nextofkin-#{nextofkin.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#nextofkin-#{nextofkin.id}")
    end
  end

  describe "Show" do
    setup [:create_nextofkin]

    test "displays nextofkin", %{conn: conn, nextofkin: nextofkin} do
      {:ok, _show_live, html} = live(conn, Routes.nextofkin_show_path(conn, :show, nextofkin))

      assert html =~ "Show Nextofkin"
      assert html =~ nextofkin.name
    end

    test "updates nextofkin within modal", %{conn: conn, nextofkin: nextofkin} do
      {:ok, show_live, _html} = live(conn, Routes.nextofkin_show_path(conn, :show, nextofkin))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Nextofkin"

      assert_patch(show_live, Routes.nextofkin_show_path(conn, :edit, nextofkin))

      assert show_live
             |> form("#nextofkin-form", nextofkin: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#nextofkin-form", nextofkin: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.nextofkin_show_path(conn, :show, nextofkin))

      assert html =~ "Nextofkin updated successfully"
      assert html =~ "some updated name"
    end
  end
end
