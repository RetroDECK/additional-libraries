#!/bin/bash

git clone https://github.com/XargonWan/RetroDECK --depth=1 RetroDECK

# Creating module manifest
manifest_header="manifest-header.yml"
manifest_module="manifest_module.yml"
module_manifest="net.retrodeck.module.yml"
command="/app/bin/module" 

# sed -n '/command/q;p' RetroDECK/net.retrodeck.retrodeck.yml > "$manifest_header"  TEMPORARY DISABLED TO TRY A BUILD WITH ANOTHER RUNTIME
echo -e "command: $command\n" >> "$manifest_header"
sed -i '/^[[:space:]]*#/d' "$manifest_header"
sed -i 's/[[:space:]]*#.*$//' "$manifest_header"
sed -n '/finish-args:/,${/cleanup:/q;p;}' RetroDECK/net.retrodeck.retrodeck.yml >> "$manifest_header"

sed -i 's/net.retrodeck.retrodeck/net.retrodeck.module/' "$manifest_header"

cat "$manifest_header" > "$module_manifest"
cat "$manifest_module" >> "$module_manifest"

rm -rf RetroDECK