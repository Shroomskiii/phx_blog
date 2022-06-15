defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  use Waffle.Ecto.Schema

  schema "posts" do
    field :body, :string
    field :summary, :string
    field :title, :string
    field :image, Blog.Image.Type
    has_many :comments, Blog.Comments.Comment
    timestamps()
  end

  @doc false
  def changeset(post, params) do
    post
    |> cast(params, [:title, :summary, :body])
    |> cast_attachments(params, [:image])
    |> validate_required([:title, :summary, :body])
  end
end
