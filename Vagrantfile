# Copyright 2019 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2019-06-14

# To run with default VirtualBox provider, just:
#   vagrant up
# To run with Google Cloud Platform:
#   VAGRANT_DEFAULT_PROVIDER=google vagrant up

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/bionic64"

  config.vm.provider :google do |google, override|
    google_project_id = ENV["GOOGLE_PROJECT_ID"] || "nqueens-gcp"
    google_json_key_location = ENV["GOOGLE_JSON_KEY_LOCATION"] || "~/.config/keys/#{google_project_id}-vagrant.json"
    google_private_key_path = ENV["GOOGLE_PRIVATE_KEY_PATH"] || "~/.ssh/#{google_project_id}_rsa"

    google.google_project_id = google_project_id
    google.google_json_key_location = google_json_key_location
    google.image_project_id = "ubuntu-os-cloud"
    google.image_family = "ubuntu-1804-lts"

    override.ssh.username = ENV["USER"]
    override.ssh.private_key_path = google_private_key_path
    override.vm.box = "google/gce"
    override.vm.synced_folder "./", "/vagrant", type: "rsync", rsync__exclude: [
      '.git', 'ansible', 'archive', 'clojure/target', 'csharp/bin', 'csharp/obj',
      'doc', 'fsharp/bin', 'fsharp/obj', 'nim/nimcache', 'swift/.build', 'tmp', 'venv'
    ]
  end

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "ansible/playbook.yml"
    ansible.compatibility_mode = "2.0"
    ansible.extra_vars = {
      local_download: false # ENV["VAGRANT_DEFAULT_PROVIDER"] == "google"
    }
  end
end
