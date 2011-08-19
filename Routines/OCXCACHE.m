OCXCACHE ;SLC/RJS,CLA - ORDER CHECK CACHE CONTROLLER ;4/16/02  16:28
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**143**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
GETDATA(OCXRES,OCXCALL,OCXDFN,OCXTIME) ;
 ;
 ;
 N OCXDATA K OCXRES S OCXRES=""
 ;
 Q:'$L($G(OCXCALL)) 1
 Q:'$L($G(OCXDFN)) 2
 S ^XTMP("OCXCACHE",0)=$$FMADD^XLFDT($$NOW^XLFDT,1,"","","")_"^"_$$NOW^XLFDT
 S:'$G(OCXTIME) OCXTIME=300
 ;
 K:($G(^XTMP("OCXCACHE",OCXDFN,OCXCALL,"TIME"))<$$NOW) ^XTMP("OCXCACHE",OCXDFN,OCXCALL)
 ;
 I '$D(^XTMP("OCXCACHE",OCXDFN,OCXCALL)) D
 .I OCXCALL["$$" X "S OCXDATA="_OCXCALL
 .E  S OCXDATA="" D @OCXCALL
 .M ^XTMP("OCXCACHE",OCXDFN,OCXCALL,"DATA")=OCXDATA
 .S ^XTMP("OCXCACHE",OCXDFN,OCXCALL,"TIME")=$$NOW+OCXTIME
 ;
 M:$D(^XTMP("OCXCACHE",OCXDFN,OCXCALL,"DATA")) OCXRES=^XTMP("OCXCACHE",OCXDFN,OCXCALL,"DATA")
 Q:'$D(^XTMP("OCXCACHE",OCXDFN,OCXCALL,"DATA")) 3
 ;
 Q 0
 ;
NOW() Q $P($H,",",2)+($H*86400)
 ;
PURGE ;   Purge OCX namespaced entries in ^XTMP (Cache) that have expired.
 ;
 N OCXE0,OCXE1,OCXS
 ;
 ;S OCXS="OCX" F  S OCXS=$O(^XTMP(OCXS)) Q:'$L(OCXS)  Q:'($E(OCXS,1,3)="OCX")  D
 S OCXS="OCXCACHE" D
 .S OCXE0=0 F  S OCXE0=$O(^XTMP(OCXS,OCXE0)) Q:'$L(OCXE0)  D
 ..S OCXE1="" F  S OCXE1=$O(^XTMP(OCXS,OCXE0,OCXE1)) Q:'$L(OCXE1)  D
 ...K:($G(^XTMP(OCXS,OCXE0,OCXE1,"TIME"))<$$NOW) ^XTMP(OCXS,OCXE0,OCXE1)
 ;
 Q
 ;
 ;Sample External Call
 ;
 ;       S ORZ=$$LOCL^ORQQLR1(ORDFN,TEST,SPECIMEN)
 ;
 ;               Changes to:
 ;
 ;S TEMP=$$GETDATA^OCXCACHE(.ORZ,"$$LOCL^ORQQLR1("_ORDFN_","_TEST_","_SPECIMEN_")",ORDFN,300)
 ;
 ;$$GETDATA^OCXCACHE(RESULTS,EXTERNAL CALL,PATIENT ID,TIMEOUT) ----> returns either a 1, 2, 3, or 0
 ;                                                                     0 -> No Errors
 ;                                                                     1 -> Missing External Call.
 ;                                                                     2 -> Missing Patient ID.
 ;                                                                     3 -> Cache Data Missing.
 ;***Results = Data Value Returned,
 ;            Either Scalar or Array.
 ;
 ;***External Call = Routine call in a 'resolved parameter' format to
 ;                  reduce the chances of cache returning the wrong values.
 ;
 ;        If ORDFN=1234 and TEST=110 and SPECIMEN=119
 ;
 ;            Then        If this parameter is: "$$LOCL^ORQQLR1("_ORDFN_","_TEST_","_SPECIMEN_")"
 ;  then the value will be stored in subscript: "$$LOCL^ORQQLR1(1234,110,119)"
 ;
 ;                        If this parameter is: "$$LOCL^ORQQLR1(ORDFN,TEST,SPECIMEN)"
 ;  then the value will be stored in subscript: "$$LOCL^ORQQLR1(ORDFN,TEST,SPECIMEN)"
 ;
 ;***Object ID = If this is patient data then this will be the patient's DFN.
 ;               If this is user data then this will be the user's DUZ.
 ;               etc...
 ;
 ;***Timeout = (Optional  Default = 300 (5 Minutes)) How long, in seconds, the data has to live in the cache.
 ;
 ;^XTMP("OCXCACHE",DFN,"$$LOCL^ORQQLR1(1234,110,119)","DATA")= Data
 ;
 ;^XTMP("OCXCACHE",DFN,"$$LOCL^ORQQLR1(1234,110,119)","TIME")= When the data will be deleted from the cache.
 ;
 ; $$NOW^OCXCACHE  =  The number of seconds since the "beginning of time". Used to determine if the data
 ;                    node in the cache is past its expiration date or not.
 ;
 ;                     It is very important that ORMTIME is running if this routine is being used.
 ;                    ORMTIME calls OCXOPURG which calls PURGE^OCXCACHE that cleans out expired data
 ;                    in the cache. This will keep the cache from using up all the available diskspace
 ;                    in the Volume Set or directory that ^XTMP resides in. PURGE^OCXCACHE can be run
 ;                    manually from a programmer's prompt if needed.
 ;
