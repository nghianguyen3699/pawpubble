defmodule Pawpubbleclone.Admin do

  alias Pawpubbleclone.Repo
  alias Pawpubbleclone.Accounts.Admins
  # alias Pawpubbleclone.

  def get_admin_by(params) do
    Repo.get_by(Admins, params)
  end

  def get_admin(id) do
    Repo.get(Admins, id)
  end

end
