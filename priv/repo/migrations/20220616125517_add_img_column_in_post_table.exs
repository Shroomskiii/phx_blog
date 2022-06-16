defmodule Blog.Repo.Migrations.AddImgColumnInPostTable do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      add :image, :string
    end
  end
end
