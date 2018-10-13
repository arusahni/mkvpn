#!/bin/sh

# Copyright 2016 Aru Sahni <arusahni@gmail.com>
# License GPL V3

# Usage: ./mkvpn.sh TARGET_NAME CLIENT_CONF CA_CERT CLIENT_CERT CLIENT_KEY TLS_KEY

target_name=${1?"The name of the generated ovpn file (including extension) is required"}
client_conf=${2?"The path to the client.conf file is required"}
cacert=${3?"The path to the ca certificate file is required"}
client_cert=${4?"The path to the client certificate file is required"}
client_key=${5?"The path to the client private key file is required"}
tls_key=${6?"The path to the TLS shared secret file is required"}

cp "$client_conf" "$target_name"
sed -i "/ca ca.crt/d" "$target_name"
sed -i "/cert client.crt/d" "$target_name"
sed -i "/key client.key/d" "$target_name"
sed -i "s/tls-auth ta.key 1/key-direction 1/" "$target_name"

{ echo ""; echo "<ca>"; cat "$cacert"; echo ""; echo "</ca>";
  echo "<cert>"; cat "$client_cert"; echo "</cert>";
  echo "<key>"; cat "$client_key"; echo "</key>";
  echo "<tls-auth>"; cat "$tls_key"; echo ""; echo "</tls-auth>"; } >> "$target_name"

echo "Done!"
