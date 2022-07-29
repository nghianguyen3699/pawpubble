defmodule Pawpubbleclone.Accounts.User do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset
  alias Accounts

  schema "users" do
    field :avatar, Pawpubbleclone.Avatar.Type
    field :name, :string
    field :email, :string
    field :password, :string, virtual: true
    field :confirmpassword, :string, virtual: true
    field :password_hash, :string
    field :phone, :string
    field :address, :string
    field :revenue, :decimal
    field :gender, :string
    field :birthday, :date

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:name, :password, :email, :phone, :address, :revenue, :avatar, :gender, :birthday])
    |> validate_required(:name)
    |> validate_length(:name, min: 1, max: 30)

  end
  @spec registration_changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> validate_required_inclusion([:email, :phone])
    |> validate_password()
    |> check_comfirm_password(params)
    |> validate_email()
  end

  def update_changeset_contain_password(user, params \\ %{}) do
    user
    |> check_password_old(params)
    |> cast(params, [:email, :name, :phone, :address])
    |> validate_email()
  end

  def update_changeset_none_password(user, params \\ %{}) do
    user
    |> cast(params, [:email, :name, :phone, :address, :gender, :birthday])
  end

  def email_changeset(user, params \\ %{}) do
    user
     |> changeset(params)
     |> validate_email()
  end
  def phone_changeset(user, params \\ %{}) do
    user
     |> changeset(params)
     |> unsafe_validate_unique(:phone, Pawpubbleclone.Repo)
     |> unique_constraint(:phone, message: "phone number already exists")
  end

  def avatar_changeset(user, params \\ %{}) do
    user
     |> cast_attachments(params, [:avatar])
  end
# ------------------------------validate password and email---------------------------------
  def validate_password(changeset) do
    changeset
    |> validate_required(:password)
    |> validate_length(:password, min: 6, max: 72)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> put_pass_hash()
  end

  def validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Must have the @ and no spaces")
    |> unsafe_validate_unique(:email, Pawpubbleclone.Repo)
    |> unique_constraint(:email)
  end

# ------------------------------------------------------------------------------------------
# -------------------------------edit password---------------------------------------------
  def check_password_old(user, %{ "passwordOld" => passwordOld}) do

    if valid_password?(user, passwordOld) do
      user
    else
      changeset = change(user)
      add_error(changeset, :password, "Password is incorrect")
    end
  end
  defp valid_password?(user, password) do
      if byte_size(password) > 0 do
        Pbkdf2.verify_pass(password, user.password_hash)
      else
        user
      end
  end

  def validate_new_password(changeset, params) do
    # IO.inspect(params)
    if check_comfirm_password(changeset, params) == changeset do
      passwordNew = params["passwordNew"]
      # IO.inspect(changeset)
      case changeset do
        %Ecto.Changeset{valid?: true} ->
          passwordNew = Pbkdf2.hash_pwd_salt(passwordNew)
          changeset1 = change(changeset.data, %{password_hash: passwordNew})
          merge(changeset, changeset1)
        _ ->
          changeset
      end
    else
      add_error(changeset, :confirmpassword, "Confirm password is incorrect!")
    end


    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    # |> put_pass_hash()
  end
# --------------------------------------------------------------------------------------
# ------------------------------validate either of email or phone number----------------
  def validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &present?(changeset, &1)) do
      changeset
    else
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect(fields)}")
    end
  end

  defp present?(changeset, field) do
    value = get_field(changeset, field)
    value && value != ""
  end
# --------------------------------------------------------------------------------------
# ------------------------------paswword hash-------------------------------------------
  def put_pass_hash(changeset) do
    # IO.inspect(changeset)
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ ->
        # require IEx;
        # IEx.pry
        # IO.inspect(changeset)
        changeset
    end
  end
# --------------------------------------------------------------------------------------
# -----------------------------check comfirm password-----------------------------------
  def check_comfirm_password(changeset, params) do
    # IO.inspect(params)
    if params["confirmpassword"] === params["password"] || params["confirmpassword"] === params["passwordNew"] do
      changeset
    else
      add_error(changeset, :confirmpassword, "Confirm password is incorrect!")
    end
  end
# --------------------------------------------------------------------------------------
# -----------------------------validate infor edit--------------------------------------
  def validate_infor_edit(changeset, params)do
    name = params["name"]
    phone = params["phone"]
    address = params["address"]
    changeset = change(changeset.data, %{name: name, phone: phone, address: address})
    # IO.inspect(changeset)
    changeset
  end
#---------------------------------------------------------------------------------------
end
