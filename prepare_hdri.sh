#!/bin/bash
# url=https://github.com/google/filament/raw/main/third_party/environments/
dir=data/env_sphere/hdri
# mkdir -p $dir

env_list=(
    "bridge"
    "city"
    "courtyard"
    "fireplace"
    "forest"
    "night"
    "snow"
    "sunset"
    "tunnel"
)

# for env in "${env_list[@]}";
# do
#     echo "Downloading $env"
#     wget -nc -P $dir $url/$env.hdr
# done

# convert hdri to ktx
filament_dir=data/env_sphere/filament
mkdir -p $filament_dir
wget -nc -P $filament_dir https://github.com/google/filament/releases/download/v1.30.0/filament-v1.30.0-linux.tgz
tar -xzf $filament_dir/filament-v1.30.0-linux.tgz -C $filament_dir
filament_bin=$filament_dir/filament/bin
ktx_dir=data/env_sphere/env_ktx

for env in "${env_list[@]}";
do
    echo "Converting $env"
    mkdir -p $ktx_dir/$env
    $filament_bin/cmgen -x $ktx_dir/$env --format=ktx $dir/$env.hdr
done
