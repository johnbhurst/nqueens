# Copyright 2018 John Hurst
# John Hurst (john.b.hurst@gmail.com)
# 2018-02-04

NAME=$1
FROM=$2
TO=$3

dotnet run --project ${NAME}.csproj $FROM $TO
