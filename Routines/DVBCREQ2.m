DVBCREQ2 ;557/THM-CHECK DATES TO PRINT NEW REQUESTS ; 4/17/91  8:42 AM
 ;;2.7;AMIE;;Apr 10, 1995
 ;Skips Saturday if indicated in file, skips Sunday always
 ;If Saturday is skipped, is printed on Monday
 ;Holidays queue up for T+1 at current time unless Saturday,
 ;when they queue for T+3 at current time.
 ;
EN I '$D(DT) S X="T" D ^%DT S DT=Y
 D NOW^%DTC S DVBCNOW=%H,X=DT D DW^%DTC S TODAY=X,DVBCNSKP=$P(^DVB(396.1,1,0),U,14)
 I $D(^HOLIDAY(DT)) G HOLIDAY
 I TODAY="SATURDAY"&(DVBCNSKP'="Y")!(TODAY="SUNDAY") G EXIT
 G TASK
 ;
EXIT K %,%H,Y,X,TODAY,DVBCNSKP
 Q
 ;
TASK I '$D(^DVB(396.1,1,0)) W !!,"No parameters in AMIE site parameter file!",!! Q
 I TODAY="SATURDAY"&(DVBCNSKP="Y") S X="T-1" D ^%DT S BDTRQ=Y,EDTRQ=Y+.2359 G TASK1 ;Friday's requests
 I TODAY="SATURDAY"&(DVBCNSKP'="Y") G EXIT ;don't print Friday if not Y
 I TODAY="MONDAY"&(DVBCNSKP'="Y") S X="T-3" D ^%DT S BDTRQ=Y,X="T-1" D ^%DT S EDTRQ=Y+.2359 G TASK1 ;Friday-Sunday
 I TODAY="MONDAY"&(DVBCNSKP="Y") S X="T-2" D ^%DT S BDTRQ=Y,X="T-1" D ^%DT S EDTRQ=Y+.2359 G TASK1 ;Saturday-Sunday
 S X="T-1" D ^%DT S BDTRQ=Y,EDTRQ=Y+.2359 ;Monday-Friday
 ;
TASK1 S Y=DT X ^DD("DD") S DVBCDT(0)=Y F JI=0:0 S JI=$O(^DVB(396.1,1,3,"B",JI)) Q:JI=""  F JJ=0:0 S JJ=$O(^DVB(396.1,1,3,"B",JI,JJ)) Q:JJ=""  D CLIN
 G EXIT
 ;
CLIN S XDIV=JI,ZTRTN="GO^DVBCREQP",ZTIO=$P(^DVB(396.1,1,3,JJ,0),U,2)_";80",ZTDESC="New 2507 Request Report for ",DIVNM=$S($D(^DG(40.8,XDIV,0)):$P(^(0),U,1),1:"Unknown Division"),ZTDESC=ZTDESC_DIVNM S:'$D(ZTDTH) ZTDTH=$H
 F I="BDTRQ*","EDTRQ*","DA*","DVBCDT(0)","Y","XDIV","DIVNM","JI","JJ" S ZTSAVE(I)=""
 D ^%ZTLOAD
 Q
 ;
HOLIDAY ;holidays are queued for next day at same time
 I TODAY="MONDAY",DVBCNSKP="Y" S X="T-2" D ^%DT S BDTRQ=Y,X="T-1" D ^%DT S EDTRQ=Y+.2359,ZTDTH=$P(DVBCNOW,",",1)+1_","_$P(DVBCNOW,",",2) G TASK1 ;Saturday-Sunday requests
 I TODAY="MONDAY",DVBCNSKP'="Y" S X="T-3" D ^%DT S BDTRQ=Y,X="T-1" D ^%DT S EDTRQ=Y+.2359,ZTDTH=$P(DVBCNOW,",",1)+1_","_$P(DVBCNOW,",",2) G TASK1 ;Friday-Sunday requests
 I TODAY="TUESDAY"!(TODAY="WEDNESDAY")!(TODAY="THURSDAY") S X="T-1" D ^%DT S BDTRQ=Y,EDTRQ=Y+.2359,ZTDTH=$P(DVBCNOW,",",1)+1_","_$P(DVBCNOW,",",2) G TASK1 ;Monday-Wednesday requests
 I TODAY="FRIDAY" S X="T-1" D ^%DT S BDTRQ=Y,EDTRQ=Y+.2359,ZTDTH=$P(DVBCNOW,",",1)+3_","_$P(DVBCNOW,",",2) G TASK1 ;Thursday requests
