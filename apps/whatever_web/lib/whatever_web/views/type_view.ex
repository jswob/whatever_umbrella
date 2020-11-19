defmodule WhateverWeb.TypeView do
  use WhateverWeb, :view
  alias WhateverWeb.TypeView

  def render("index.json", %{types: types}) do
    %{data_types: render_many(types, TypeView, "type.json")}
  end

  def render("show.json", %{type: type}) do
    %{data_type: render_one(type, TypeView, "type.json")}
  end

  def render("type.json", %{type: type}) do
    %{id: type.id, name: type.name}
  end
end
