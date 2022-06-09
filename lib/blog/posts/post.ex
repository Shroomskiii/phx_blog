defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    field :summary, :string
    field :title, :string
    has_many :comments, Blog.Comments.Comment
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :summary, :body])
    |> validate_required([:title, :summary, :body])
  end
end
