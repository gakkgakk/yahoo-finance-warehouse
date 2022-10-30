# Airbyte

Most of the stuff here is either copied from or heavily builds on the [Airbyte repository](https://github.com/airbytehq/airbyte). Kudos to them for a really cool open-source data transferring tool that works well with dbt!

## Setup Airbyte 

```sh
docker-compose up --detach
```

### Add sources, destinations and connectors

#### Install octavia CLI

Instead of manually adding stuff in the Airbyte web UI, we can use the octavia CLI tool and the yaml-files in `configuration`. Octavia is a terminal program that we can use to interact with a running Airbyte instance. 

See [Airbyte octavia readme](https://github.com/airbytehq/airbyte/blob/master/octavia-cli/README.md#install) for how to install octavia CLI.

TLDR:

```sh
curl -s -o- https://raw.githubusercontent.com/airbytehq/airbyte/master/octavia-cli/install.sh | bash
```

#### Import resources

Todo: currently octavia apply crashes when trying to create the fetch the [source-yahoo-finance-financials connector](https://hub.docker.com/repository/docker/travbula/source-yahoo-finance-financials)

### Shutdown

```sh
docker-compose down
```
