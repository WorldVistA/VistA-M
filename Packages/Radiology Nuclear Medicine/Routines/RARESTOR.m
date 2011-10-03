RARESTOR ;HISC/SWM-Recover Purged Rad/NM Report/Exam only
 ;;5.0;Radiology/Nuclear Medicine;**34**;Mar 16, 1998
 ;
 S:'$D(DTIME) DTIME=9999
 I $G(^XTMP("RARECOV",0))="" W !,"^XTMP(""RARECOV"") doesn't exist -- there's no data to recover!" G Q
 S RA1=0,RA2=0,RA3=0
 S:$D(^XTMP("RARECOV","RPT")) RA1=1 S:$D(^XTMP("RARECOV","DPT")) RA2=1
 I RA1,RA2 S RA3=1
 W !,?7,"Radiology " W $S(RA3:"reports and exams",RA2:"exams",1:"reports")," were purged."
 S RAIEN=0 F  S RAIEN=$O(^XTMP("RARECOV",RAIEN)) Q:'RAIEN  D
 .S RAPUR(RAIEN)=""
 . S Y=$P(^XTMP("RARECOV",0,RAIEN),"^"),RANUM=$P(^(RAIEN),"^",2) D DD^%DT S RADTDONE=Y
 .W !!,"Imaging Type: ","**** ",$P($G(^RA(79.2,RAIEN,0)),"^")," ****"
 .W " purged on ",RADTDONE," -",RANUM," days."
 .W !,"Activity Log",?20,"Report",?40,"Clin History",?60,"Tracking Time"
 .W !,"cut-off date",?20,"cut-off date",?40,"cut-off date",?60,"cut-off date"
 .W !,"------------",?20,"------------",?40,"------------",?60,"------------"
 .W ! S X=$P(^XTMP("RARECOV",RAIEN),"^") D TW
 .W ?20 S X=$P(^(RAIEN),"^",2) D TW
 .W ?40 S X=$P(^(RAIEN),"^",3) D TW
 .W ?60 S X=$P(^(RAIEN),"^",4) D TW
 .W !?5,"No. of exam records recovered: ",$P(^XTMP("RARECOV",RAIEN),"^",6)
 .W !?5,"No. of reports recovered     : ",$P(^XTMP("RARECOV",RAIEN),"^",7)
 .Q
 ;
 W !!,?7,"The purged data were recovered"
 S Y=$P(^XTMP("RARECOV",0),"^",2) D DD^%DT
 W !,?7,"on ",Y," to ^XTMP(""RARECOV"")"
 W !!,"This routine will restore the recovered data into the appropriate records."
 ;
 S DIR(0)="Y",DIR("A")="Do you want to proceed "
 S DIR("B")="NO" D ^DIR
 I 'Y W !!,"-- Nothing Done --" G Q
 ;
SET ;Set nodes by using recovered data from ^XTMP("RARECOV"
 D NOW^%DTC S RANOW=%
 W !!,"Restoring data to exams/reports",!
70 G:'$D(^XTMP("RARECOV","DPT")) 74
 S RADFN=0
701 S RADFN=$O(^XTMP("RARECOV","DPT",RADFN)) G:'RADFN 74  S RADTI=0
702 S RADTI=$O(^XTMP("RARECOV","DPT",RADFN,RADTI)) G:'RADTI 701 S RACNI=0
703 S RACNI=$O(^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI)) G:'RACNI 702
 W "."
 I $D(^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"L")) M ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L")=^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"L") S RAEX=""
 I $D(^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"H")) M ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H")=^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"H") S RAEX=""
 I $D(^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"T")) M ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"T")=^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"T") S RAEX=""
 I $D(^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"PURGE")) S ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PURGE")=^XTMP("RARECOV","DPT",RADFN,RADTI,RACNI,"PURGE")
 G 703
 ;
74 G:'$D(^XTMP("RARECOV","RPT")) DONE
 S RARPT=0
741 S RARPT=$O(^XTMP("RARECOV","RPT",RARPT)) G:'RARPT DONE
 W "."
 I $D(^XTMP("RARECOV","RPT",RARPT,"H")) M ^RARPT(RARPT,"H")=^XTMP("RARECOV","RPT",RARPT,"H")
 I $D(^XTMP("RARECOV","RPT",RARPT,"L")) M ^RARPT(RARPT,"L")=^XTMP("RARECOV","RPT",RARPT,"L")
 I $D(^XTMP("RARECOV","RPT",RARPT,"R")) M ^RARPT(RARPT,"R")=^XTMP("RARECOV","RPT",RARPT,"R")
 I $D(^XTMP("RARECOV","RPT",RARPT,"PURGE")) S ^RARPT(RARPT,"PURGE")=^XTMP("RARECOV","RPT",RARPT,"PURGE")
 G 741
TW S X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) W X
 Q
DONE W !!,"Data have been restored."
Q ;K RA1,RADFN,RADTI,RACNI,RARPT
 Q
