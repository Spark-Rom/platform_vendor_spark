#!/bin/bash

zip_path=${1}

type=$(bash -c "cut -d'=' -f2 <<< $(grep 'ro.spark.build.type' $(dirname $zip_path)/system/build.prop)")
device=$(bash -c "cut -d'=' -f2 <<< $(grep 'ro.spark.device' $(dirname $zip_path)/system/build.prop)")
datetime=$(bash -c "cut -d'=' -f2 <<< $(grep 'ro.build.date.utc' $(dirname $zip_path)/system/build.prop)")
version=$(bash -c "cut -d'=' -f2 <<< $(grep 'ro.spark.branding.version' $(dirname $zip_path)/system/build.prop)")
variant=$(bash -c "cut -d'=' -f2 <<< $(grep 'ro.spark.build.variant' $(dirname $zip_path)/system/build.prop)")
zip=$(basename "$zip_path")
md5=$(cat "$zip_path.md5" | cut -d' ' -f1)
size=$(ls -lat $zip_path | cut -d ' ' -f 5)
url="https://downloads.spark-os.live/$device/$zip"

function generate_json() {
  echo '{'
  echo '  "response": ['
  echo '    {'
  echo '      "datetime": "'$datetime'",'
  echo '      "filename": "'$zip'",'
  echo '      "id": "'$md5'",'
  echo '      "size": "'$size'",'
  echo '      "url": "'$url'",'
  echo '      "romtype": "'$variant'",'
  echo '      "version": "'$version'"'
  echo '    }'
  echo '  ]'
  echo '}'
}

if [ $type == "OFFICIAL" ];then
  generate_json > $zip_path.json
  echo
  echo 'Information for official maintainers:'
  echo 'Submit your build to https://github.com/Spark-Devices/official_devices repository with the json content below.'
  cat $zip_path.json
  echo
fi
