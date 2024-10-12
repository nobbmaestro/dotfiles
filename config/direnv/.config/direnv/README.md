# Direnv

## Workflow (Pipenv)

```sh
$ echo layout pipenv >> .envrc
```

Or more generally, in the .envrc:

```sh
layout pipenv
```

## [Workflow (Poetry)](https://github.com/direnv/direnv/wiki/Python#poetry)

Workflow for a new project, new-project say:

1. `poetry new --src new-project` where the `--src` flag is optional. This creates the `pyproject.toml` file.
2. `cd new-project`
3. Create an `.envrc` file with `echo 'layout poetry' > .envrc`
4. `direnv allow` ... `poetry install` executes creating the virtual environment, adding the virtual environment python version to your `$PATH` and finally activating the virtual environment setting the ENV variables `$VIRTUAL_ENV` and `$POETRY_ACTIVE` as we expect.
5. Start to work

Workflow for an existing project, existing-project say:

1. `cd existing-project`
2. Create an `.envrc` file with `echo 'layout poetry' > .envrc`
3. `direnv allow` ... `poetry init` executes interactively creating the `pyproject.toml`...`poetry install` executes creating the virtual environment, adding the virtual environment python version to your `$PATH` and finally activating the virtual environment setting the ENV variables `$VIRTUAL_ENV` and `$POETRY_ACTIVE` as we expect.
4. Start to work
