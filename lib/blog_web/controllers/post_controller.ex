defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Posts
  alias Blog.Posts.Post
  alias Blog.Comments.Comment
  alias Blog.Comments


  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    IO.inspect(conn.assigns)
    user_id = conn.assigns.current_user.id
    post_params = Map.put(post_params, "user_id", user_id)
    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    IO.inspect(post)
    comment_changeset = Comments.change_comment(%Comment{})
    render(conn, "show.html", post: post, comment_changeset: comment_changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    user_id = conn.assigns.current_user.id
    IO.inspect(conn)
    if post.user_id == user_id do
      changeset = Posts.change_post(post)
      render(conn, "edit.html", post: post, changeset: changeset)
    else
      conn
      |> put_flash(:error, "Access denied. You can edite your posts only!!!")
      |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    user_id = conn.assigns.current_user.id
    if post.user_id == user_id do
      {:ok, _post} = Posts.delete_post(post)
      conn
      |> put_flash(:info, "Post deleted successfully.")
      |> redirect(to: Routes.post_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Access denied. You can delete your posts only!!!")
      |> redirect(to: Routes.post_path(conn, :show, post))
    end
  end
end
