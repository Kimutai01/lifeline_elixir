defmodule LifelineElixirWeb.PatientLiveTest do
  use LifelineElixirWeb.ConnCase

  import Phoenix.LiveViewTest
  import LifelineElixir.PatientsFixtures

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", national_id: "some national_id", height: "some height", age: 42, weight: "some weight"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", national_id: "some updated national_id", height: "some updated height", age: 43, weight: "some updated weight"}
  @invalid_attrs %{first_name: nil, last_name: nil, national_id: nil, height: nil, age: nil, weight: nil}

  defp create_patient(_) do
    patient = patient_fixture()
    %{patient: patient}
  end

  describe "Index" do
    setup [:create_patient]

    test "lists all patients", %{conn: conn, patient: patient} do
      {:ok, _index_live, html} = live(conn, Routes.patient_index_path(conn, :index))

      assert html =~ "Listing Patients"
      assert html =~ patient.first_name
    end

    test "saves new patient", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.patient_index_path(conn, :index))

      assert index_live |> element("a", "New Patient") |> render_click() =~
               "New Patient"

      assert_patch(index_live, Routes.patient_index_path(conn, :new))

      assert index_live
             |> form("#patient-form", patient: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#patient-form", patient: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patient_index_path(conn, :index))

      assert html =~ "Patient created successfully"
      assert html =~ "some first_name"
    end

    test "updates patient in listing", %{conn: conn, patient: patient} do
      {:ok, index_live, _html} = live(conn, Routes.patient_index_path(conn, :index))

      assert index_live |> element("#patient-#{patient.id} a", "Edit") |> render_click() =~
               "Edit Patient"

      assert_patch(index_live, Routes.patient_index_path(conn, :edit, patient))

      assert index_live
             |> form("#patient-form", patient: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#patient-form", patient: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patient_index_path(conn, :index))

      assert html =~ "Patient updated successfully"
      assert html =~ "some updated first_name"
    end

    test "deletes patient in listing", %{conn: conn, patient: patient} do
      {:ok, index_live, _html} = live(conn, Routes.patient_index_path(conn, :index))

      assert index_live |> element("#patient-#{patient.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#patient-#{patient.id}")
    end
  end

  describe "Show" do
    setup [:create_patient]

    test "displays patient", %{conn: conn, patient: patient} do
      {:ok, _show_live, html} = live(conn, Routes.patient_show_path(conn, :show, patient))

      assert html =~ "Show Patient"
      assert html =~ patient.first_name
    end

    test "updates patient within modal", %{conn: conn, patient: patient} do
      {:ok, show_live, _html} = live(conn, Routes.patient_show_path(conn, :show, patient))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Patient"

      assert_patch(show_live, Routes.patient_show_path(conn, :edit, patient))

      assert show_live
             |> form("#patient-form", patient: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#patient-form", patient: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.patient_show_path(conn, :show, patient))

      assert html =~ "Patient updated successfully"
      assert html =~ "some updated first_name"
    end
  end
end
