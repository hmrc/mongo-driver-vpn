This project is an prepared testing enviroment to test the bugfix of zombie connection after event: "primary disappears".``


The vagrant and virtualbox are required on the host.

Run `initAll.sh` to prepare VMs setup.

FYI: mongo, mongo2, mongo3 are the names of VMs. Mongo3 is an mongo arbiter.


From now you can start the test.
 
 `sbt run` on `mongo2` VM in `mongo-driver-vpn` directory. FYI: to log on the VM type `vagrant ssh mongo2`.
 
 `sudo ipsec stop/start` at `mongo` VM to drop the connections. FYI: Primary is initially on the `mongo` VM.
 
 
 To reset the mongo cluster:
 - enable vpn on `mongo`
 - disable vpn on `mongo2`
 now the primary should migrate back to `mongo`
 - enable back the vpn on `mongo2`
 
 
 To switch between reactive-mongo versions switch comments between lines in file build.sbt":
 ```
   ProjectRef(uri("https://github.com/opetch/ReactiveMongo.git#master"), "ReactiveMongo")
   //ProjectRef(uri("https://github.com/opetch/ReactiveMongo.git#zombies"), "ReactiveMongo")
```
 Difference in running with those should be the time of connection hanging.
