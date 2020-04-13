# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-08

# Set this variable to a unique name for your Google Cloud Project. (You cannot use "nqueens-gcp", because it is already used.)
# export GOOGLE_PROJECT_ID=nqueens-ncp
# Set your GCP billing account - you have to pay for GCE VMs.
# export BILLING_ACCOUNT={my billing account}

# Create project
gcloud projects create $GOOGLE_PROJECT_ID

gcloud beta billing accounts list
gcloud beta billing projects link $GOOGLE_PROJECT_ID --billing-account=$BILLING_ACCOUNT

gcloud config set core/project $GOOGLE_PROJECT_ID
gcloud config set compute/region australia-southeast1
gcloud config set compute/zone australia-southeast1-a

gcloud services enable cloudfunctions.googleapis.com

# Create service account and key
gcloud --project=$GOOGLE_PROJECT_ID iam service-accounts create vagrant --display-name="Service account for Vagrant provisioning"
gcloud projects add-iam-policy-binding $GOOGLE_PROJECT_ID --member serviceAccount:vagrant@${GOOGLE_PROJECT_ID}.iam.gserviceaccount.com --role roles/compute.admin

gcloud iam service-accounts keys create ~/.config/keys/${GOOGLE_PROJECT_ID}-vagrant.json --iam-account vagrant@${GOOGLE_PROJECT_ID}.iam.gserviceaccount.com

# Create SSH key a configure it in Google Compute Engine
ssh-keygen -t rsa -f ~/.ssh/${GOOGLE_PROJECT_ID}_rsa -C $USER
cat ~/.ssh/${GOOGLE_PROJECT_ID}_rsa.pub | sed -e "s/^/${USER}:/" > ssh-keys
gcloud compute project-info add-metadata --metadata-from-file ssh-keys=ssh-keys
rm ssh-keys
