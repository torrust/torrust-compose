# Docker compose configuration for the Torrust Index

[![MegaLinter](https://github.com/torrust/torrust-compose/actions/workflows/mega-linter.yml/badge.svg)](https://github.com/torrust/torrust-compose/actions/workflows/mega-linter.yml)

This repo contains different sample Docker Compose configurations for the [Torrust Index](https://github.com/torrust/torrust-index).

The current configurations are:

- [`demo`](./demo/README.md): demo configuration, just to try the index locally.
- [`droplet`](./droplet/README.md): configuration to install the Index in a  [Digital Ocean Droplet](https://www.digitalocean.com/products/droplets). It should be very similar to any virtual machine.

## Requirements

- Docker version 24.0.3, build 3713ee1.
- GNU bash, version 5.2.15(1)-release (x86_64-pc-linux-gnu).

## Setup

After running the application remember the following:

- There is no user created by default, you need to sign up. The first user to sign up will be the admin.
- There are no torrent tags created by default, you need to create them.
- Check the `config***.toml` files to see the default values.

## Recommendations

- If you are using SQLite as the database engine, you can use [DB Browser for SQLite](https://sqlitebrowser.org/).
- Make sure you mount a volume to persist database data. That should be the default behavior, but it's better to be sure.
Some configurations use a [mail catcher](https://mailcatcher.me/) container to catch emails sent by the index. You can access the mail catcher web interface at <http://localhost:1080>.

### MegaLinter

Running MegaLinter locally:

```console
npx mega-linter-runner
```

Run and try to fix issues:

```console
npx mega-linter-runner --fix
```

Run only one type of linter using the linter `Descriptor`:

```console
npx mega-linter-runner -e "'ENABLE=MARKDOWN'"
```

Run only one linter using the linter `Key`:

```console
npx mega-linter-runner -e "'ENABLE_LINTERS=JSON_PRETTIER'"
```

## Contributing

We welcome contributions from the community!

How can you contribute?

- Add new examples.
- Bug reports and feature requests.
- Code contributions. You can start by looking at the issues labeled ["good first issues"](https://github.com/torrust/torrust-compose/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22).

## Links

- In the [Torrust Demo Repository](https://github.com/torrust/torrust-demo), we are tracking issues with the [Index Live Demo](https://index.torrust-demo.com/torrents) which uses the [`droplet`](./droplet/README.md) configuration in this repo.
