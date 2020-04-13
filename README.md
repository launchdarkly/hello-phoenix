# LaunchDarkly Sample Phoenix Framework Application

We've built a simple web application that demonstrates how LaunchDarkly's SDK works. Below, you'll find the basic build procedure, but for more comprehensive instructions, you can visit your [Quickstart page](https://app.launchdarkly.com/quickstart#/).

## Prerequisites

* [Elixir](https://elixir-lang.org/install.html)
* [npm](https://nodejs.org/en/download/)
* LaunchDarkly account and server SDK key
* LaunchDarkly boolean feature flag called "alternate.page"

## Run

Clone this repo

```
git clone https://github.com/launchdarkly/hello-phoenix.git
```

Install dependencies
```
cd hello-phoenix/assets
npm install
cd ..
mix deps.get
```

Start your Phoenix server

```
LD_SDK_KEY="YOUR_SDK_KEY" mix phx.server
```

Now you can visit [`http://localhost:4000`](http://localhost:4000) from your browser.

To experience how different values of the `alternate.page` flag would affect different users, visit
* http://localhost:4000/hello-launchdarkly/Joe
* http://localhost:4000/hello-launchdarkly/Robert
* http://localhost:4000/hello-launchdarkly/Mike
* etc.

## Learn more about LaunchDarkly

* Official website: https://launchdarkly.com
* Erlang SDK documentation: https://docs.launchdarkly.com/sdk/server-side/erlang

## Learn more about Phoenix Framework

* Official website: https://www.phoenixframework.org/
* Guides: https://hexdocs.pm/phoenix/overview.html
* Docs: https://hexdocs.pm/phoenix
* Forum: https://elixirforum.com/c/phoenix-forum
* Source: https://github.com/phoenixframework/phoenix
