defmodule WhateverWeb.TypeController do
  use WhateverWeb, :controller

  alias Whatever.Types

  action_fallback WhateverWeb.FallbackController

  def index(conn, _params) do
    types = Types.list_types()
    render(conn, "index.json", types: types)
  end
end
