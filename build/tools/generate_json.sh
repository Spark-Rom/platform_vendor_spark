#!/bin/bash
if [ "$1" ]; then
    file_path=$1
    file_name=$(basename "$file_path")
    echo "Generating .json"
    if [ -f $file_path ]; then
        device_name=$(echo $file_name | cut -d'-' -f5);
        build_prop="out/target/product/${device_name}/system/build.prop";
        name=$(grep ro\.spark\.device\.name ${build_prop} | cut -d= -f2);
        codename=$(grep ro\.spark\.device\= ${build_prop} | cut -d= -f2);
        version=$(grep ro\.spark\.version ${build_prop} | cut -d= -f2);
        maintainer_name=$(grep ro\.spark\.maintainer\= ${build_prop} | cut -d= -f2);
        maintainer_username=$(grep ro\.spark\.maintainer\.username ${build_prop} | cut -d= -f2);
        size=$(stat -c%s $file_path);
        id=$(sha256sum $file_path | awk '{ print $1 }');
        url="https://downloads.spark-os.live/${device_name}/${file_name}";
        group=$(grep ro\.spark\.group\.url ${build_prop} | cut -d= -f2);
        echo "{" > $file_path.json
        echo "  \"name\":\"${name}\"," >> $file_path.json
        echo "  \"codename\":\"${codename}\"," >> $file_path.json
        echo "  \"filename\":\"${file_name}\"," >> $file_path.json
        echo "  \"version\":\"${version}\"," >> $file_path.json
        echo "  \"maintainer\":\"${maintainer_name}\"," >> $file_path.json
        echo "  \"username\":\"${maintainer_username}\"," >> $file_path.json
        echo "  \"size\":${size}," >> $file_path.json
        echo "  \"url\":\"${url}\"," >> $file_path.json
        echo "  \"group\":\"${group}\"" >> $file_path.json
        echo "}" >> $file_path.json
        rm -rf "./${device_name}.json"
        mv "${file_path}.json" "./${device_name}.json"
    fi
fi

