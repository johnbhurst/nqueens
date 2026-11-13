# Python setup

The project's Python tooling is managed with [uv](https://docs.astral.sh/uv/). You need uv installed before using either Ansible or the data analysis scripts:

``` bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv --version
```

uv installs to `~/.local/bin`, which needs to be on your `PATH`. If a suitable Python version is not available, uv downloads one.

There are two separate uv projects, each with its own direct dependencies in `pyproject.toml`, its own locked versions in `uv.lock`, and its own `.venv` virtual environment:

| Project | Location | Direct dependencies |
| --- | --- | --- |
| Ansible | `ansible/` | `ansible-core` |
| Data analysis | top-level directory | `pandas`, `matplotlib`, `jupyter` |

They are separate because nothing uses both sets of libraries, and this way neither one constrains the versions of the other.

The Queens programs in [python/](../python) use only the standard library, and are not part of either project.

## Running commands

`uv run` runs a command in a project's environment. It creates or updates the environment first if needed, so there is no setup step and no environment to activate.

For Ansible, from the top-level directory:

``` bash
uv run --project ansible ansible-playbook --version
```

For data analysis, from the top-level directory or `bin/`:

``` bash
uv run jupyter --version
```

`bin/analysis.py` plots the combined timings from `bin/combine.py`, and lists the languages from slowest to fastest:

``` bash
uv run python bin/combine.py clang.csv clojure.csv ... > all.csv
uv run python bin/analysis.py all.csv              # show the plot in a window
uv run python bin/analysis.py all.csv -o all.png   # save the plot to a file
```

It ranks the languages at the largest board size that all of them have timings for, and leaves out times of zero, which are below the timer's resolution.
