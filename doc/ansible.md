# Ansible

Using Ansible and Vagrant you can run many of the Queens programs in a Linux virtual machine, without needing to install all the different languages on your host machine.

You need to have this software installed to use Ansible with Vagrant:

* [Oracle VirtualBox](https://www.virtualbox.org/)
* [HashiCorp Vagrant](https://www.vagrantup.com/)
* [Python 3](https://www.python.org/)

Set up a Python3 virtual environment, following instructions in [python.md](python.md).

## Running the playbook locally (e.g. WSL2)

The playbook can also provision the machine you are on, such as an Ubuntu WSL2 environment, without Vagrant:

``` bash
ansible-playbook -i localhost, -c local -K ansible/playbook.yml
```

`-K` prompts for your sudo password, used for the system packages.

The JVM tools (Java, Groovy, Kotlin, Leiningen for Clojure, and Scala) are installed with [SDKMAN](https://sdkman.io/) for your own user, not system-wide. The playbook installs SDKMAN if it is not already in `~/.sdkman`. Their versions are set in `ansible/vars.yml`. To install or update only the JVM tools:

``` bash
ansible-playbook -i localhost, -c local -K --tags jvm ansible/playbook.yml
```

Open a new shell afterwards, or run `source ~/.sdkman/bin/sdkman-init.sh`, to pick up the tools.

## Vagrant setup

Install the providers.

``` bash
# vagrant plugin install vagrant-aws   # fails on macOS
vagrant plugin install vagrant-azure   # 2.0.0
vagrant plugin install vagrant-google  # 2.5.0
```

## Creating the virtual machine

To create and provision the virtual machine with Vagrant, run this command:

``` bash
vagrant up
```

The provisioning script downloads and installs a lot of different packages, and can take a while, depending on your internet connection speed.

Some HTTP downloads are not 100% reliable, so the script may fail. In case of a partial provision, or if you want to pick up changes to the provisioning script, re-run provisioning with this command:

``` bash
vagrant provision
```

## Running programs

To run any of the Queens programs in the virtual machine, we connect to the virtual machine using SSH. The project folder is shared in the virtual machine at `/vagrant`.

``` bash
vagrant ssh
cd /vagrant
```

For example, to run using C:

``` bash
clang/run.sh Queens 8 14
```

## Shutting down the virtual machine

To stop the virtual machine but leave it available to run again:

``` bash
vagrant halt
```

To destroy the virtual machine and free up space:

``` bash
vagrant destroy
```

To restart the virtual machine later:

``` bash
vagrant up
```

If you stopped the virtual machine with `vagrant halt`, it should restart quite quickly. If you destroyed it, it needs to be provisioned all over again.
