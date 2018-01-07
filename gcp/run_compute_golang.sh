# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-01-08

# n1-highcpu-2 $0.0709/hour
# n1-highcpu-4 $0.1418/hour
# n1-highcpu-8 $0.2836/hour
# n1-highcpu-16 $0.5672/hour
# n1-highcpu-32 $1.1344/hour
# n1-highcpu-64 $2.2688/hour
# n1-highcpu-96 $3.402/hour

DIR=`dirname $0`

gcloud compute --project "nqueens-gcp" instances create "queens" \
  --zone "australia-southeast1-c" \
  --machine-type "n1-highcpu-4" \
  --image "debian-9-stretch-v20180105" \
  --image-project "debian-cloud" \
  --boot-disk-size "10" \
  --boot-disk-type "pd-standard" \
  --boot-disk-device-name "queens"

gcloud compute scp $DIR/rungo.sh queens: --zone "australia-southeast1-c"
gcloud compute ssh queens --zone "australia-southeast1-c" --command "sh ./rungo.sh"

gcloud -q compute instances --project "nqueens-gcp" delete "queens" \
  --zone "australia-southeast1-c" \
  --delete-disks=all