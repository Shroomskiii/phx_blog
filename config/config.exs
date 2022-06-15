import Config

config :blog,
  ecto_repos: [Blog.Repo]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "lrliTE2s"]

config :blog, Blog.Mailer, adapter: Swoosh.Adapters.Local


config :swoosh, :api_client, false

config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]


config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :phoenix, :json_library, Jason


import_config "#{config_env()}.exs"

config :blog, Blog.Guardian,
  issuer: "blog",
  secret_key: "KCGyu9XobeQ3G+c7sfM0DMUKjMTnvc/bvc7yoplkfDiHk4MVy2eQQspXo+Xxw9zm",
  ttl: {3, :days}

config :blog, BlogWeb.AuthAccessPipeline,
    module: Blog.Guardian,
    error_handler: BlogWeb.AuthErrorHandler

config :kaffy,
  otp_app: :blog,
  ecto_repo: Blog.Repo,
  router: BlogWeb.Router
