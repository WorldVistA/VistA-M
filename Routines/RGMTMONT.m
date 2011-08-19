RGMTMONT ;BIR/CML,PTD-MPI/PD Monitor HL7 Messaging/Filers and Setups ;07/30/02
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**20,30,31,34**;30 Apr 99
 ;
 ;Reference to OPTION SCHEDULING (#19.2) file supported by IA #3599
 ;Reference to ^DPT("AICNL" supported by IA #2070
 ;Reference to $$SEND^VAFHUTL for file DG(43 supported by IA #2624
 ;Reference to ^HLCS(870 supported by IA #3335
 ;Reference to $$STAT^HLCSLM supported by IA #3574
 ;Reference to ^DIA(2 and data derived from the AUDIT file (#1.1)
 ;supported by IA #2097 and #2602.
 ;
EN1 ;Call this routine from the top to do extended checks that include:
 ;- D HLMA1^RGMTUT98
 ;- D EN2^RGMTMONT
 ;- D ^RGMTMONX
 ;
 I $D(RGHLMQ) Q
 ;
 S DEV=0,EN=1 G START
 ;
DEV ;call used by developers to display ^RGMTMONX call
 S DEV=1,EN=2
 ;
START ;
 S CLUP=1
 W @IOF,"Logical Link Monitor:",!,"=====================",!
 D HLMA1^RGMTUT98
 S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 I $D(DIRUT) G QUIT
 ;
 D EN2
 S DIR(0)="E" D  D ^DIR K DIR
 .S SS=22-$Y F JJ=1:1:SS W !
 I $D(DIRUT) G QUIT
 ;
 I $G(EN)'=1 D ^RGMTMONX
 ;
 K EN,DEV G QUIT
 ;
EN2 ;Monitor Background Job - VAFC BATCH UPDATE
 ;Monitor Background Job - MPIF LOC/MIS ICN RES
 ;Check MAS PARAMETER file, field SEND PIMS HL7 V2.3 MESSAGES
 ;if call is being made from HL7 query, variable RGHLMQ will be defined
 S ^XTMP("RGMT",0)=$$FMADD^XLFDT(DT,30)_"^"_$$NOW^XLFDT_"^MPI/PD Maintenance Data"
 K ^XTMP("RGMT","HLMQMONT")
 I '$D(DEV) S DEV=0
 S LOCSITE=$P($$SITE^VASITE(),"^",3)
 I $D(RGHLMQ) D
 .D NOW^%DTC
 .S ^XTMP("RGMT","HLMQMONT",LOCSITE,"@@ RUNDATE")=$$FMTE^XLFDT($E(%,1,12))
 I '$D(RGHLMQ) W @IOF,"MPI/PD Process Monitor:",!,"======================="
 S TXTCNT=0
 N BKDA,CUR,MSG,SCHDA,SEND,TIME
CHK1 ;
 S TXT="Checking VAFC BATCH UPDATE background job..." D TXT
 D PIV^RGMTUT98
 S TXTCNT=3
 ;
 S DIC="^DIC(19,",X="VAFC BATCH UPDATE" D ^DIC K DIC S BKDA=+Y
 I BKDA<0 S TXT="=> VAFC BATCH UPDATE does not exist in OPTION file." D TXT K BKDA G CHK2
 S TXT="=> VAFC BATCH UPDATE is not currently scheduled to run."
 S DIC="^DIC(19.2,",X="VAFC BATCH UPDATE" D ^DIC K DIC S SCHDA=+Y
 I SCHDA<0 D TXT K BKDA,TXT,SCHDA G CHK2
 S TIME=$$GET1^DIQ(19.2,SCHDA_",",2)
 I TIME="" D TXT K BKDA,TXT,SCHDA,TIME G CHK2
 S TXT="=> VAFC BATCH UPDATE scheduled to run "_$$FMTE^XLFDT(TIME)_"."
 D TXT
 D NOW^%DTC
 S DAY=$E(%,1,7)
 ;
CHK2 ;
 S TXT="" D TXT
 ;
 S ICN=0,CNT=0
 F  S ICN=$O(^DPT("AICNL",1,ICN)) Q:'ICN  S CNT=CNT+1
 S TXT="Checking MPIF LOC/MIS ICN RES background job...  (Total Local ICNs = "_CNT_")"
 D TXT
 ;
 S DIC="^DIC(19,",X="MPIF LOC/MIS ICN RES" D ^DIC K DIC S BKDA=+Y
 I BKDA<0 S TXT="=> MPIF LOC/MIS ICN RES does not exist in OPTION file." D TXT K BKDA G CHK2A
 S TXT="=> MPIF LOC/MIS ICN RES is not currently scheduled to run."
 S DIC="^DIC(19.2,",X="MPIF LOC/MIS ICN RES" D ^DIC K DIC S SCHDA=+Y
 I SCHDA<0 D TXT K BKDA,SCHDA G CHK2A
 S TIME=$$GET1^DIQ(19.2,SCHDA_",",2)
 I TIME="" D TXT K BKDA,SCHDA,TIME G CHK2A
 S TXT="=> MPIF LOC/MIS ICN RES is scheduled to run "_$$FMTE^XLFDT(TIME)_"."
 D TXT
 ;
CHK2A ;check for time local/missing job was last run
 S TIME=$P($G(^RGSITE(991.8,1,0)),"^",4) I TIME'="" D
 .S TIME=$$FMTE^XLFDT(TIME)
 .S TXT="=> MPIF LOC/MIS ICN RES was last run "_TIME_"."
 .D TXT
 ;
CHK3 ;Check to see if .01 field in patient file has auditing turned on
 S TXT="" D TXT
 D FIELD^DID(2,.01,"","AUDIT","PATAUD")
 S PATAUD=$G(PATAUD("AUDIT")) I PATAUD="" S PATAUD="NOT SET"
 S PATAUD="<<"_PATAUD_">>"
 S TXT="=> Audit on NAME (#.01) field of PATIENT (#2) file set to "_PATAUD
 D TXT
 K PATAUD
 ;
CHK5 ;
 S TXT="" D TXT
 ;
 S TXT="Checking SEND Parameters for HL7 messaging..."
 D TXT
 ;
 S SEND=$P($$SEND^VAFHUTL,"^",2)
 S CUR=$S(SEND=1:"SEND MESSAGES",SEND=0:"STOP MESSAGES",SEND=2:"SUSPEND MESSAGES",1:"NULL")
 S TXT="=> SEND PIMS HL7 V2.3 MESSAGES currently set to << "_CUR_" >>."
 D TXT
 ;
 S TXT="=> STOP MPI/PD MESSAGING currently set to "
 S SEND=$P($G(^RGSITE(991.8,1,1)),"^",6)
 S CUR=$S(SEND=1:"SEND MESSAGES",SEND=0:"STOP MESSAGES",SEND=2:"SUSPEND MESSAGES",1:"NULL")
 S TXT="=> STOP MPI/PD MESSAGING currently set to << "_CUR_" >>."
 D TXT
 ;
CHK6 ;
 K RGMT
 S LOC=$P($$SITE^VASITE(),"^")
 D LINK^HLUTIL3(LOC,.RGMT)
 S LOCIEN=$O(RGMT(0))
 I 'LOCIEN D  G QUIT
 .S TXT="^DIC(4,""AC"" xref problem.  Check ^DIC(4,""AC"",,"_LOC
 .D TXT
 S LOCLINK=RGMT(LOCIEN)
 ;
 S TXT="" D TXT
 ;
 S TXT="Checking SHUTDOWN LLP? field and TCP/IP SERVICE TYPE for "_LOCLINK_"..."
 D TXT
 ;
 S CUR=$$GET1^DIQ(870,LOCIEN_",",14)
 S TXT="=> SHUTDOWN LLP? currently set to << "_CUR_" >>."
 D TXT
 ;
 S CUR=$$GET1^DIQ(870,LOCIEN_",",400.03)
 S TXT="=> TCP/IP SERVICE TYPE currently set to << "_CUR_" >>."
 D TXT
 ;
 ;check MPIVA for LLP TYPE
 S DIC="^HLCS(870,",X="MPIVA" D ^DIC K DIC S MPILL=+Y
 S CUR=$$GET1^DIQ(870,MPILL_",",2)
 S TXT="=> Logical Link MPIVA currently set to << "_CUR_" >>."
 D TXT
 ;
 ;check to see if Link Manager is running
 S LMSTAT=$$STAT^HLCSLM
 S CUR=$S('LMSTAT:"NOT RUNNING",1:"RUNNING")
 S TXT="=> HL LINK MANAGER is currently << "_CUR_" >>."
 D TXT
 ;
FLDLIST ;capture fields being audited
 I $D(RGHLMQ) D
 .S AUDCNT=0
 .S ^XTMP("RGMT","HLMQMONT",LOCSITE,"AUDIT",0)="Compiled: "_$$FMTE^XLFDT($$NOW^XLFDT)
 .S FLDLP=0 F  S FLDLP=$O(^DD(2,"AUDIT",FLDLP)) Q:'FLDLP  D
 ..S AUDCNT=AUDCNT+1
 ..K RGARR D FIELD^DID(2,FLDLP,"","LABEL","RGARR")
 ..S FLDNM=$G(RGARR("LABEL")) Q:FLDNM=""
 ..S ^XTMP("RGMT","HLMQMONT",LOCSITE,"AUDIT",AUDCNT)=FLDLP_"^"_FLDNM
 ;
 I $D(CLUP),$D(DIRUT) Q
 ;
QUIT ;
 K %,BKDA,CLUP,CNT,CUR,DAY,DIR,DIRUT,ICN,JJ,LMSTAT,LOC,LOCIEN,LOCLINK
 K LOCSITE,MPILL,MSG,PATAUD,RGHLMQ,RGMT,SCHDA,SEND,SS,TIME,TXT,TXTCNT,X,Y
 K AUDCNT,FLDLP,RGARR,FLDNM
 Q
 ;
TXT ;
 S TXTCNT=TXTCNT+1
 I '$D(RGHLMQ) W !,TXT
 I $D(RGHLMQ) S ^XTMP("RGMT","HLMQMONT",LOCSITE,TXTCNT)=TXT
 Q
