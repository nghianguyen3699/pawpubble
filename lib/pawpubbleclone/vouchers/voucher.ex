defmodule Pawpubbleclone.Voucher.Vouchers do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Phoenix.Param, key: :name}

  schema "vouchers" do
    field :name, :string
    field :value, :decimal
    field :time_start, :utc_datetime
    field :time_end, :utc_datetime

    timestamps()
  end

  def changeset(concept, params \\ %{}) do
    concept
    |> cast(params, [:name, :value, :time_start, :time_end])
    |> validate_required([:name, :value, :time_start, :time_end])
    |> unique_constraint([:name])
  end
end
