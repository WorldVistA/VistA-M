DVBCPURG ;ALB/GTS-557/THM-C&P PURGING PROGRAM ; 10/28/90  8:40 PM
 ;;2.7;AMIE;**48**;Apr 10, 1995
 ;
 ;** Version Changes
 ;   2.7 - GTS/Coded to purge 396.95  (Enhc 13)
 ;   2.7 - JLU/Utilize the 2507 purge parameter
 ;
SETUP I '$D(DT) S X="T" D ^%DT S DT=Y
 S HIST=$$PAR()
 S X1=DT,X2=HIST,X2=-X2 D C^%DTC S PDATE=X
 ;
GO F TYP="C","CT","X","RX" F REGOFF=0:0 S REGOFF=$O(^DVB(396.3,"AF",TYP,REGOFF)) Q:REGOFF=""  F REQDA=0:0 S REQDA=$O(^DVB(396.3,"AF",TYP,REGOFF,REQDA)) Q:REQDA=""  D KILL
 ;
EXIT K DIK,X,Y,REGOFF,DA,I,J,PDATE,X1,X2,HIST,%,%DT,%H,TYP,REQDA,EXMDA
 Q
 ;
KILL I '$D(^DVB(396.3,REQDA,0)) K ^DVB(396.3,"AF",TYP,REGOFF,REQDA)
 I '$D(^DVB(396.3,REQDA,0)) Q  ;clean up bad index records
 S X1=PDATE
 S X2=$S(TYP["X":$P(^DVB(396.3,REQDA,0),U,19),1:$P(^DVB(396.3,REQDA,0),U,7))
 D ^%DTC I (+X>0),('$D(^DVB(396.3,"AORQ",REQDA))) D APPTLP,EXAMLP S DIK="^DVB(396.3,",DA=REQDA D ^DIK
 K DIK,DA
 Q
 ;
APPTLP ;  **  Loop through existing appointments  **
 N LPCNT
 S LPCNT=""
 F  S LPCNT=$O(^DVB(396.95,"AR",REQDA,LPCNT)) Q:LPCNT=""  DO
 .S DIK="^DVB(396.95,",DA=LPCNT D ^DIK K DA,DIK
 Q
 ;
EXAMLP ;  **  Loop through existing exams  **
 F EXMDA=0:0 S EXMDA=$O(^DVB(396.4,"C",REQDA,EXMDA)) Q:EXMDA=""  D KEXAMS
 Q
 ;
KEXAMS ;  ** Delete exams on the request  **
 S DA=EXMDA,DIK="^DVB(396.4," D ^DIK K DIK,DA
 Q
 ;
PAR() ;function call to get the number of days to retain the 2507 requests.
 ;
 N IFN,Y
 S IFN=$$IFNPAR^DVBAUTL3()
 I IFN DO
 .S Y=$P(^DVB(396.1,IFN,0),U,11)
 .I 'Y!(Y<120) S Y=99999
 I 'IFN S Y=99999
 Q Y
