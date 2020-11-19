defmodule WhateverWeb.TypeControllerTest do
  use WhateverWeb.ConnCase

  alias Whatever.Types
  alias Whatever.Types.Type

  @create_attrs %{
    name: "some name"
  }

  def fixture(:type) do
    {:ok, type} = Types.create_type(@create_attrs)
    type
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all types", %{conn: conn} do
      %Type{id: id, name: name} = fixture(:type)

      conn = get(conn, Routes.type_path(conn, :index))

      assert [
               %{
                 "id" => ^id,
                 "name" => ^name
               }
             ] = json_response(conn, 200)["data_types"]
    end
  end
end
