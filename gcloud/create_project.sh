# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-08

gcloud projects create nqueens-gcp

gcloud beta billing accounts list
gcloud beta billing projects link nqueens-gcp --billing-account=$BILLING_ACCOUNT

gcloud config set core/project nqueens-gcp
gcloud config set compute/region australia-southeast1

gcloud services enable cloudfunctions.googleapis.com
