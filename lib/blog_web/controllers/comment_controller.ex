defmodule BlogWeb.CommentController do
  use BlogWeb, :controller

  alias Blog.Posts
  alias Blog.Comments


  def create(conn, %{"post_id" => post_id, "comment" => comment_params}) do
    post = Posts.get_post!(post_id)

    case Comments.create_comment(post, comment_params) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Issue creating comment.")
        |> redirect(to: Routes.post_path(conn, :show, post))
      end
    end
  end
