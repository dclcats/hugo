#! /bin/bash

# CURRENT_FOLDER=$(cd "$(dirname "$0")";pwd)

sed -i '/\# gitalk/ r gitalk.template' config.toml

sed -i "s/\${CLIENT_ID}/$CLIENT_ID/g" config.toml

sed -i "s/\${CLIENT_SECRET}/$CLIENT_SECRET/g" config.toml