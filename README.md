# Blog

To start your Phoenix server:
  
  * Clone repository https://github.com/Shroomskiii/phx_blog.git
  * cd phx_blog
  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`]

To start Docker set values in dev.ex:
 * username: "postgres",
  password: "postgres",
  hostname: "db".
Run command "sudo docker-compose up --build"

Admin panel:
http://localhost:4000/kaffy
