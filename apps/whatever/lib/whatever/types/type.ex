defmodule Whatever.Types.Type do
  use Ecto.Schema
  import Ecto.Changeset

  schema "types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(type, attrs) do
    type
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 32)
  end
end
