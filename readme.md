Install vagrant and virtualbox to your host.

Run initAll.sh .

From now you can start the test.
 
 `sbt run` on `mongo2`
 `sudo ipsec stop/start` on `mongo` to drop the connections
 
 To reset the mongo cluster:
 - enable vpn on `mongo`
 - disable vpn on `mongo2`
 now the primary should migrate back to `mongo`
 - enable back the vpn on `mongo2`