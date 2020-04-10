# Python setup

Set up a Python3 virtual environment to install libraries required by this project.

Run these commands when you first check out the project:

``` bash
cd nqueens/ansible
python3 -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

Run these commands to use the existing project in a new shell:

``` bash
cd nqueens/ansible
source venv/bin/activate
```

Run these commands to pick up new/changed library dependencies:

``` bash
cd nqueens/ansible
source venv/bin/activate
pip install -r requirements.txt
```

Run this command to deactivate the Python virtual environment in your shell when you have finished:

``` bash
deactivate
```

## See Also

* [The Right Way to Use Virtual Environments](https://medium.com/@jtpaasch/the-right-way-to-use-virtual-environments-1bc255a0cba7)
