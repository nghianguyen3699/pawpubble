defmodule Pawpubbleclone.Accounts do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Accounts.User
  alias Pawpubbleclone.Admin

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  @spec list_users :: any
  def list_users do
    Repo.all(User)
  end

  def update_user(%User{} = user, atts = %{"gender" => gender, "birthday" => birthday, "address" => address}) do
    if Map.has_key?(atts, "passwordOld" ) do
      user
      |> User.update_changeset_contain_password(atts)
      |> User.validate_new_password(atts)
      |> Repo.update()
    else
      if address != "" do
        user
        |> User.update_changeset_none_password(%{"gender" => gender, "birthday" => birthday, "address" => address})
        |> Repo.update()
      else
        user
        |> User.update_changeset_none_password(%{"gender" => gender, "birthday" => birthday})
        |> Repo.update()
      end
    end

  end

  def update_email(%User{} = user, email) do
    user
     |> User.email_changeset(email)
     |> Repo.update()
  end

  def update_revenue(%User{} = user, revenue) do
    user
     |> User.changeset(revenue)
     |> Repo.update()
  end

  def update_phone(%User{} = user, phone) do
    user
     |> User.phone_changeset(phone)
     |> Repo.update()
  end

  def update_avatar(%User{} = user, avatar) do
    user
     |> User.avatar_changeset(avatar)
     |> IO.inspect()
     |> Repo.update()
  end

  def delete(%User{} = user) do
    Repo.delete(user)
  end

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(atts \\ %{}) do
    %User{}
    |> User.registration_changeset(atts)
    |> Repo.insert()
  end

  # def authenticate_by_name_and_pass(name, given_pass) do
  #   user = get_user_by(name: name)
  #   IO.inspect(user)
  #   cond do
  #     user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
  #       {:ok, user}
  #     user ->
  #       {:error, :unauthenticate}
  #     true ->
  #       Pbkdf2.no_user_verify()
  #       {:error, :not_found}
  #   end
  # end
  def authenticate_by_email_and_pass(email, given_pass) do
    user = get_user_by(email: email)
    admin = Admin.get_admin_by(email: email)
    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}
      admin && Pbkdf2.verify_pass(given_pass, admin.password_hash) ->
        {:ok, admin}
      user ->
        {:error, :unauthenticate}
      admin ->
        {:error, :unauthenticate}
      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
