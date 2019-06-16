# Ansible

This module makes it possible to run many of the Queens programs in a Linux virtual machine, without needing to install all the different languages on your host machine.

You do need to have this software installed to use this module:

* [Oracle VirtualBox](https://www.virtualbox.org/)
* [HashiCorp Vagrant](https://www.vagrantup.com/)
* [Python 3](https://www.python.org/)

## Python setup

Before you start you need to configure a Python virtual environment for installing the libraries locally.

Run these commands when you first check out the project:

``` bash
git clone git@github.com:johnbhurst/nqueens.git
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

## TODO

Tasks to complete on Ansible setup.

* Add step to .NET provisioning to get rid of intro banner.
* Environment vars for Groovy?
* Convert all run playbooks to use shell instead of raw?
* Generic run playbook?
* Ansible tasks to display versions of languages?
* Variables for arguments, per language?
* Playbook to run parallel versions?
* Run in GCP?
* Parallel versions in GCP with highcpu.
