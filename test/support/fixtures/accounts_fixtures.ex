defmodule Blog.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        is_admin: true,
        name: "some name",
        password_hash: "some password_hash",
        phone: "some phone"
      })
      |> Blog.Accounts.create_user()

    user
  end
end
