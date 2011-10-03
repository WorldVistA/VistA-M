RARECOV ;HISC/SWM-Recover Purged Rad/NM Report/Exam only ;4/17/03  09:39
 ;;5.0;Radiology/Nuclear Medicine;**34**;Mar 16, 1998
 ;
 S:'$D(DTIME) DTIME=9999
 I $D(^XTMP("RARECOV")) W !,"^XTMP(""RARECOV"") exists, you must delete this before",!,"you can run another recovery.",!! G NOTDONE
 S RACRT=$E($G(IOST),1,2)="C-"
 F I=1:1:21 W !,$P($T(INSTRC+I),";;",2)
 R !,"Press return key to continue, or ""^"" to exit: ",X:DTIME
 G:X="^" Q
 ;Select Imaging type(s)
 ;Return RAPUR array  =  RAPUR(ien)="", where ien = entry in 79.2
 S (I,J,CNT)=0 K RAPUR
 W !!?12,"IMAGING TYPES",!?12,"-------------",!
 F  S I=$O(^RA(79.2,"B",I)) Q:I=""  F  S J=$O(^RA(79.2,"B",I,J)) Q:'J  S CNT=CNT+1 W !?3,CNT,") ",I S RAX(CNT)=J
 W ! S DIR(0)="L^1:"_CNT,DIR("A")="Select Imaging Type(s) to recover purged data",DIR("?")="Select by number, one or more imaging types to be purged" D ^DIR K DIR I $D(DIRUT) G Q
 S I="" F J=1:1 S I=$P(Y,",",J) Q:'I  S RAPUR(RAX(I))=""
 G Q:'$O(RAPUR(0))
 ;
 ;Select what to recover: exams, reports, or both
 S DIR(0)="S^E:Exam data;R:Report data;B:Both;",DIR("?")="Do you want to recover purged Exams, Reports, or Both exams and reports"
 S DIR("A")="Enter type of data to recover",DIR("B")="Report data"
 D ^DIR K DIR
 ;REGET70=0 means don't recover file 70 data
 S RAGET70=$S(Y="E":1,Y="B":1,1:0)
 S RAGET74=$S(Y="R":1,Y="B":1,1:0)
 ;
 S (RADT,RAIEN)=0
 F  S RAIEN=$O(RAPUR(RAIEN)) Q:'RAIEN  D ASKDT Q:RAX=""!(CNT<4)
 G:RAX=""!(CNT<4) NOTDONE
 W !
 S DIR(0)="Y",DIR("A")="Do you want to proceed "
 S DIR("B")="NO" D ^DIR
 I 'Y G NOTDONE
 ;
EXAM ;Copy backup exam/report data
 D NOW^%DTC S RANOW=%,X1=RANOW,X2=60 D C^%DTC
 S ^XTMP("RARECOV",0)=X_"^"_RANOW_"^"_"RARECOV"
 W !!,"Recovering ",$S(RAGET70&RAGET74:"Exam and Report",RAGET70:"Exam",RAGET74:"Report",1:"?")," data from backup to ^XTMP(""RARECOV"".",!
 F RADTE=0:0 S RADTE=$O(^RADPT("AR",RADTE)) Q:RADTE'>0!(RADTE>RADT)  S RADTI=9999999.9999-RADTE F RADFN=0:0 S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:RADFN'>0  D
 .F RACN=0:0 S RACN=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN)) Q:RACN'>0  S RACNI=+$O(^(RACN,0)),RA0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),RARPT=+$P(RA0,"^",17) D
 ..S RAIMAG=+$P($G(^RAMIS(71,+$P(RA0,"^",2),0)),"^",12) Q:'$D(RAPUR(RAIMAG))  W:RACRT "."
 ..K RARP S RARPTNP=$G(^RARPT(RARPT,"NOPURGE")) I RAGET74 D
 ... Q:+$O(^RARPT(RARPT,"ERR",0))  ; quit if report amended
 ...I $P(RAPUR(RAIMAG),"^",2)>RADTE,$D(^RARPT(RARPT,"R")) M ^XTMP("RARECOV","RPT",RARPT,"R")=^RARPT(RARPT,"R") S RARP=""
 ...I $P(RAPUR(RAIMAG),"^")>RADTE,$D(^RARPT(RARPT,"L")) M ^XTMP("RARECOV","RPT",RARPT,"L")=^RARPT(RARPT,"L") S RARP=""
 ...I $P(RAPUR(RAIMAG),"^",3)>RADTE,$D(^RARPT(RARPT,"H")) M ^XTMP("RARECOV","RPT",RARPT,"H")=^RARPT(RARPT,"H")  S RARP=""
 ..I $D(RARP) S ^XTMP("RARECOV","RPT",RARPT,"PURGE")=^RARPT(RARPT,"PURGE"),$P(RAPUR(RAIMAG),"^",7)=$P(RAPUR(RAIMAG),"^",7)+1
 ..K RAEX I RAGET70 D
 ...I $P(RAPUR(RAIMAG),"^")>RADTE,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L")) M ^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"L")=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L") S RAEX=""
 ...I $P(RAPUR(RAIMAG),"^",3)>RADTE,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H")) M ^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"H")=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H") S RAEX=""
 ...I $P(RAPUR(RAIMAG),"^",4)>RADTE,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"T")) M ^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"T")=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"T") S RAEX=""
 ..I $D(RAEX) S ^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"PURGE")=^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PURGE"),$P(RAPUR(RAIMAG),"^",6)=$P(RAPUR(RAIMAG),"^",6)+1
 ;
 D TOTALS G Q
INSTRC ;
 ;;Instructions for recovering purged exam and/or report data
 ;; Step 0.
 ;;         Find out:
 ;;         1 - the DATE that the purge was done
 ;;         2 - how many DAYS back from that date was used as cut-off
 ;;             ie., what was entered as "ddd" in "T-ddd"  ?
 ;; Step 1. From the Backup Volume:
 ;;         D ^RARECOV
 ;;         enter cut-off dates that you had used in the purge function
 ;; Step 2. From the Backup Volume:
 ;;         D ^%GTO   (or your system's global copy out utility)
 ;;         enter output file name
 ;;         enter ^XTMP("RARECOV"
 ;; Step 3. From the Production volume that holds ^XTMP: 
 ;;         D ^%GTI   (or your system's global restore utility)
 ;;         enter the file name from step 2
 ;; Step 4. From the Production volume:
 ;;         D ^RARESTOR
 ;;         routine will automatically read from ^XTMP("RARECOV"
 ;;         and copy data back into ^RADPT and/or ^RARPT
 ;;
NOTDONE W !!,"-- Nothing Done --"
Q ;K CNT,I,J,RADD,RADT,RAGET70,RAGET74,RAI,RAIEN,RAPRMPT,RAPUR,RAX
 Q
TOTALS ;
 S RAIEN=0
 F  S RAIEN=$O(RAPUR(RAIEN)) Q:'RAIEN  D
 . W !!,"Imaging Type: ",$P($G(^RA(79.2,RAIEN,0)),"^"),!
 . W !?5,"No. of exam records recovered : ",$P(RAPUR(RAIEN),"^",6)
 . W !?5,"No. of reports recovered      : ",$P(RAPUR(RAIEN),"^",7)
 . S ^XTMP("RARECOV",RAIEN)=RAPUR(RAIEN)
 Q
 ;Select Cut-off date for the various data fields
ASKDT S RAX="",CNT=0
 K RACUTDT W !!?7,"Cut-off Date Selection **** ",$P(^RA(79.2,RAIEN,0),"^")," ****"
 K X,%DT S %DT="APEX" W !
 S %DT("A")="Enter date that the Radiology Purge was done : " D ^%DT
 G:'Y Q G:Y'?.7N Q S RADTDONE=Y
 R !!,"Enter number of days subtracted from that date as cut-off : ",RANUM:DTIME
 G:'RANUM Q
 S ^XTMP("RARECOV",0,RAIEN)=RADTDONE_"^"_RANUM
 S X1=RADTDONE,X2=-RANUM D C^%DTC S Y=X D DD^%DT S %DT("B")=Y
 W !?7,"The default value can be changed as needed."
 K RADD
 S RAPRMPT="Cut-off Date for "
 ; define field names, because the backup volume doesn't have ^DD
 S RADD(.11)="ACTIVITY LOG CUT-OFF"
 S RADD(.12)="REPORT CUT-OFF"
 S RADD(.13)="CLINICAL HISTORY CUT-OFF"
 S RADD(.14)="TRACKING TIME CUT-OFF"
 F RAI=.11:.01:.14 S CNT=CNT+1 D  Q:Y<0
 . W ! S %DT("A")=RAPRMPT_$P(RADD(RAI),"^")_" : " D ^%DT Q:Y<0  S $P(RAX,"^",CNT)=Y S:Y>RADT RADT=Y
 G:RAX="" Q G:CNT<4 Q
 S RAPUR(RAIEN)=RAX
 Q
