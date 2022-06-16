defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  schema "posts" do
    field :body, :string
    field :summary, :string
    field :title, :string
    field :image, Blog.Image.Type

    belongs_to :user, Blog.Accounts.User
    has_many :comments, Blog.Comments.Comment
    timestamps()
  end

  @doc false
  def changeset(post, params) do
    post
    |> cast(params, [:title, :summary, :body, :user_id])
    |> cast_attachments(params, [:image])
    |> validate_required([:title, :summary, :body, :image])
  end
end
