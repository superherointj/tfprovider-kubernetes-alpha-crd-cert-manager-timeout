#!/bin/sh
# This is a test.
echo $TF_TOKEN

echo "credentials \"app.terraform.io\" { token = \"$TF_TOKEN\" }" >> terraform.rc

cat terraform.rc
