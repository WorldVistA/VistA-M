KMPRBD01 ;OAK/RAK - RUM Daily/Weekly Compression ;11/19/04  10:31
 ;;2.0;CAPACITY MANAGEMENT - RUM;**1**;May 28, 2003
 ;
EN ;-- entry point for Background Driver.
 ;
 S:'$G(DT) DT=$$DT^XLFDT
 ;
 N ENDT,STR
 ;
 S STR=$$NOW^XLFDT
 D DAILY^KMPRBD02(+$H)
 ; store start, stop and delta times for daily background job
 D STRSTP^KMPDUTL2(2,1,1,STR)
 ;
 ; clean up old "job" nodes.
 D CLEAN
 ;
 ; if sunday do weekly compression
 I '$$DOW^XLFDT(DT,1) D 
 .; store weekly start/stop stats.
 .S STR=$$NOW^XLFDT
 .D WEEKLY^KMPRBD04(DT)
 .; store start, stop and delta times for weekly background job
 .D STRSTP^KMPDUTL2(2,2,1,STR)
 ;
 ; check for errors.
 D ERRORS
 ;
 Q
 ;
CLEAN ;-- clean up old "JOB" nodes
 ;
 N JOB,NODE S NODE=""
 F  S NODE=$O(^KMPTMP("KMPR","JOB",NODE)) Q:NODE=""  D
 .S JOB=0 F  S JOB=$O(^XTMP("KMPR","JOB",NODE,JOB)) Q:'+JOB  D
 ..I '$D(^XUTL("XQ",JOB)) K ^KMPTMP("KMPR","JOB",NODE,JOB)
 ;
 ; Store the number of active user jobs into ^XTMP("KMPR","ACTIVE")
 ; D CLUSTER^%ZKMPRC1
 ;
 Q
 ;
ERRORS ; check and process errors.
 ;
 Q:'$D(^XTMP("KMPR","ERR"))
 ;
 N H,I,LN,N,O,SITE,TEXT,XMSUB,X,XMTEXT,XMY,XMZ,Y,Z
 ;
 S SITE=$$SITE^VASITE
 S XMSUB="RUM Error at site "_$P(SITE,U,3)_" on "_$$FMTE^XLFDT($$DT^XLFDT)
 S TEXT(1)="  The following error(s) have been logged at "_$P(SITE,U,2)_" ("_$P(SITE,U,3)_") "
 S TEXT(2)="  while moving data from ^XTMP(""KMPR"",""DLY"") to file 8971.1."
 S H="",LN=3
 ; H = date in $H format (+$H).
 ; N = node name.
 ; O = option.
 F  S H=$O(^XTMP("KMPR","ERR",H)) Q:H=""  S N="" D 
 .F  S N=$O(^XTMP("KMPR","ERR",H,N)) Q:N=""  S O="" D 
 ..F  S O=$O(^XTMP("KMPR","ERR",H,N,O)) Q:O=""  D 
 ...S TEXT(LN)="",LN=LN+1
 ...S TEXT(LN)="Date..: "_H_"    Node: "_N,LN=LN+1
 ...S TEXT(LN)="Option: "_O,LN=LN+1
 ...; prime time.
 ...S TEXT(LN)="Prime Time     = "_$G(^XTMP("KMPR","ERR",H,N,O,0)),LN=LN+1
 ...; non-prime time.
 ...S TEXT(LN)="Non-Prime Time = "_$G(^XTMP("KMPR","ERR",H,N,O,1)),LN=LN+1
 ...; message.
 ...F I=0:0 S I=$O(^XTMP("KMPR","ERR",H,N,O,"MSG",I)) Q:'I  D 
 ....S TEXT(LN)=^XTMP("KMPR","ERR",H,N,O,"MSG",I),LN=LN+1
 S XMTEXT="TEXT("
 S XMY("G.KMP2-RUM@ISC-ALBANY.VA.GOV")=""
 D ^XMD
 ;
 K ^KMPTMP("KMPR","ERR")
 ;
 Q
