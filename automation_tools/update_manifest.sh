#!/bin/bash

git clone https://github.com/XargonWan/RetroDECK --depth=1 RetroDECK

# Creating module manifest
manifest_header="manifest-header.yml"
manifest_modules="manifest_modules.yml"
full_manifest="net.retrodeck.module.yml"
command="module" 

sed -n '/command/q;p' RetroDECK/net.retrodeck.retrodeck.yml > "$manifest_header"
echo -e "command: $command\n" >> "$manifest_header"
sed -i '/^[[:space:]]*#/d' "$manifest_header"
sed -i 's/[[:space:]]*#.*$//' "$manifest_header"
sed -n '/finish-args:/,${/cleanup:/q;p;}' RetroDECK/net.retrodeck.retrodeck.yml >> "$manifest_header"

sed -i 's/net.retrodeck.retrodeck/net.retrodeck.module/' "$manifest_header"

cat "$manifest_header" > "$full_manifest"
cat "$manifest_modules" >> "$full_manifest"

rm -rf RetroDECK