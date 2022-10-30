# Lightdash

Everything in this folder is copied from the [Ligthdash repository](https://github.com/lightdash/lightdash). Kudos to them for a really cool open-source visualization tool that builds on dbt!

For more help with Lightdash, see their [docs](https://docs.lightdash.com/get-started/setup-lightdash/install-lightdash/#deploy-locally-with-our-installation-script).

**Nice to know:** When Lightdash does stuff it might generate files in the dbt-model folder, and these are generated with the root user. If you run any dbt commands and get permission denied, try running the following command when you're in the root folder of the repository:

```sh
sudo chown -R $USER:$USER dbt-model
```

## Setup

First run the docker-compose file in the database folder. The reason for this is that Lightdash joins the same docker network so it can connect to the warehouse. (I could not get it to work without this, if you know of a simpler please let me know!)

Then run docker compose up.

```sh
docker-compose --env-file ./.env.fast-install -f docker-compose.yml up --detach --remove-orphans || true
```

## Shutdown

```sh
docker-compose --env-file ./.env.fast-install -f docker-compose.yml down
```
