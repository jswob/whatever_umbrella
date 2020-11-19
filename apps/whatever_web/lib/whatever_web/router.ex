defmodule WhateverWeb.Router do
  use WhateverWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WhateverWeb do
    pipe_through :api
  end

  scope "/api", WhateverWeb do
    pipe_through :api

    get "/dataTypes", TypeController, :index
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: WhateverWeb.Telemetry
    end
  end
end
