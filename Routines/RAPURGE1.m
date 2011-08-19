RAPURGE1 ;HISC/CAH,FPT,GJC AISC/MJK,RMO-Purge Rad/NM Data ;9/3/97  12:22
 ;;5.0;Radiology/Nuclear Medicine;**34**;Mar 16, 1998
START I $G(RAPURTYP)="" U IO W !,"RAPURTYP undefined or null, Purge Not Done." G EXIT
 U IO D NOW^%DTC S Y=%,RACRT=$E(IOST,1,2)="C-" K %,%H,%I W !!,"Purge data routine started at " D D^RAUTL W Y,"."
 ;Set up variables needed for purge of selected imaging types
 G EXIT:'$O(RAPUR(0))
 S (RADT,RAODT,RAIEN)=0 F  S RAIEN=$O(RAPUR(RAIEN)) Q:'RAIEN  S RAX=$G(^RA(79.2,RAIEN,.1)) D
 .F RAI=1:1:4 S X2=-$S($P(RAX,U,RAI)>89:$P(RAX,U,RAI),1:27393),X1=DT D C^%DTC S $P(RAPUR(RAIEN),"^",RAI)=X S:X>RADT RADT=X
 .S X2=-$S($P(RAX,U,6)>29:$P(RAX,U,6),1:27393),X1=DT D C^%DTC S $P(RAPUR(RAIEN),"^",5)=X S:X>RAODT RAODT=X
 .F RAI=6:1:8 S $P(RAPUR(RAIEN),"^",RAI)=0
 ;
EXAM ;Purge exam/report data
 I RAPURTYP="O" G ORDER
 W !!,"Purging exams/reports.",!
 F RADTE=0:0 S RADTE=$O(^RADPT("AR",RADTE)) Q:RADTE'>0!(RADTE>RADT)  S RADTI=9999999.9999-RADTE F RADFN=0:0 S RADFN=$O(^RADPT("AR",RADTE,RADFN)) Q:RADFN'>0  D
 .F RACN=0:0 S RACN=$O(^RADPT(RADFN,"DT",RADTI,"P","B",RACN)) Q:RACN'>0  S RACNI=+$O(^(RACN,0)),RA0=$G(^RADPT(RADFN,"DT",RADTI,"P",RACNI,0)),RARPT=+$P(RA0,"^",17) D:$S('$D(^("NOPURGE")):1,^("NOPURGE")'="n":1,1:0)
 ..S RAIMAG=+$P($G(^RAMIS(71,+$P(RA0,"^",2),0)),"^",12) Q:'$D(RAPUR(RAIMAG))  W:RACRT "."
 ..K RARP S RARPTNP=$G(^RARPT(RARPT,"NOPURGE")) I $S('$D(^RARPT(RARPT,0)):0,RAREPURG:1,'$D(^("PURGE")):1,1:0),RARPTNP'="n","RBA"[RAPURTYP D
 ... Q:+$O(^RARPT(RARPT,"ERR",0))  ; quit if report amended
 ...I $P(RAPUR(RAIMAG),"^",2)>RADTE,$D(^RARPT(RARPT,"R")) K ^("R") S RARP=""
 ...I $P(RAPUR(RAIMAG),"^")>RADTE,$D(^RARPT(RARPT,"L")) K ^("L") S RARP=""
 ...I $P(RAPUR(RAIMAG),"^",3)>RADTE,$D(^RARPT(RARPT,"H")) K ^("H") S RARP=""
 ..S:$D(RARP) ^RARPT(RARPT,"PURGE")=DT,$P(RAPUR(RAIMAG),"^",7)=$P(RAPUR(RAIMAG),"^",7)+1
 ..K RAEX I $S(RAREPURG:1,'$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PURGE")):1,1:0),"EBA"[RAPURTYP D
 ...I $P(RAPUR(RAIMAG),"^")>RADTE,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"L")) K ^("L") S RAEX=""
 ...I $P(RAPUR(RAIMAG),"^",3)>RADTE,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"H")) K ^("H") S RAEX=""
 ...I $P(RAPUR(RAIMAG),"^",4)>RADTE,$D(^RADPT(RADFN,"DT",RADTI,"P",RACNI,"T")) K ^("T") S RAEX=""
 ..S:$D(RAEX) ^RADPT(RADFN,"DT",RADTI,"P",RACNI,"PURGE")=DT,$P(RAPUR(RAIMAG),"^",6)=$P(RAPUR(RAIMAG),"^",6)+1
 ;
ORDER ;Purge order/request data
 I "OA"'[RAPURTYP G STAT
 W !,"Purging orders/requests.",!
 S RAPKG="" F RAODTE=0:0 S RAODTE=$O(^RAO(75.1,"AO",RAODTE)) Q:'RAODTE!(RAODTE>RAODT)  F RAOIFN=0:0 S RAOIFN=$O(^RAO(75.1,"AO",RAODTE,RAOIFN)) Q:'RAOIFN  S RAORD0=$G(^RAO(75.1,RAOIFN,0)),RAIMAG=+$P(RAORD0,"^",3) D
 .I $D(RAPUR(RAIMAG)),$P(RAORD0,"^",5)<6 S RAPUROK=$$PUROK(RAORD0,DT) D:RAPUROK ENPUR
 ;
 ;Update statistics in Imaging Type file (#79.2)
STAT D NOW^%DTC S Y=% K %,%H,%I W !,"Data purge completed at " D D^RAUTL W Y,".",!!,"The following purge statistics were compiled:"
 K RAX S RAX="" F  S RAX=$O(RAPUR(RAX)) Q:'RAX  S DA=RAX,DIE="^RA(79.2,",DR="100///""NOW""",DR(2,79.23)="2///P;3////"_DUZ_";4///"_$P(RAPUR(RAX),U,6)_";5///"_$P(RAPUR(RAX),"^",7)_";6///"_$P(RAPUR(RAX),"^",8) D ^DIE D
 .W !!,"Imaging Type: ",$P($G(^RA(79.2,RAX,0)),"^"),!
 .W !?5,"No. of exam records processed      : ",$P(RAPUR(RAX),"^",6)
 .W !?5,"No. of reports processed           : ",$P(RAPUR(RAX),"^",7)
 .W !?5,"No. of requests processed          : ",$P(RAPUR(RAX),"^",8)
EXIT K %DT,%T,D,D0,D1,DA,DDER,DE,DI,DIC,DIE,DQ,DR,DLAYGO,POP,RA0,RACN,RACNI
 K RACRT,RADFN,RADT,RADTE,RADTI,RAEX,RAI,RAIEN,RAIMAG,RAODT,RAODTE
 K RAOIFN,RAORD0,RAPKG,RAPOP,RAPUR,RAREPURG,RARP,RARPT,RARPTNP,RAX,X
 K RAGO,RAPURTYP
 K X1,X2,Y K:$G(RAORD)'="Z@" RAPUROK ; don't kill if entering through
 ; the front door & version of CPRS >2.5   RAPUROK checked in RAO7RO
 D CLOSE^RAUTL
 Q
 ;
ENPUR ;OE/RR Entry Point for the PURGE ACTION Option
 I '$D(RAPKG),($$ORVR^RAORDU()=2.5) Q:'$D(ORPK)!('$D(ORSTS))  S OREND=$S(ORSTS<6:0,1:1) Q:OREND!(ORPK'>0)  S RAOIFN=+ORPK
 ;
 ; The 'DELORD' subroutine deletes the Imaging Order data
 ; (field 11) in the 70.03 sub-file.  This code handles deletions
 ; for parent procedures as well as orphan procedures (non-parent).
 ;
 D DELORD(RAOIFN,+$G(RAORD0)) ; +$G(RAORD0) is the patient dfn
 I $D(RAPKG) D  ; track the # of requests processed
 . W:RACRT "." S $P(RAPUR(RAIMAG),"^",8)=$P(RAPUR(RAIMAG),"^",8)+1
 . Q
 I $$ORVR^RAORDU()=2.5 D
 . I $D(RAPKG) S ORIFN=+$P(RAORD0,"^",7),ORSTS="K" D:ORIFN ST^ORX K ORIFN,ORSTS
 . I '$D(RAPKG) S ORSTS="K" D:ORIFN ST^ORX K ORIFN,ORSTS
 . Q
 K %,DA,DIC,DIK
 D:$$ORVR^RAORDU()'<3&($G(RAORD)'="Z@") EN1^RAO7PURG(RAOIFN)
 ; do EN1^RAO7PURG only if we are going through the 'backdoor' for
 ; versions of CPRS 3.0 or greater.
 S DA=RAOIFN,DIK="^RAO(75.1," D ^DIK ; delete the order record
 K %,DA,DIC,DIK
 Q
DELORD(RAOIFN,RADFN) ; Delete all of the imaging order pointers that refer
 ; to a specific order.
 ; input: raoifn-ien of our order in file 75.1
 ;         radfn-ien of the patient associated with the order
 N RACNI,RADTI,X,Y S RADTI=0
 F  S RADTI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI)) Q:RADTI'>0  D
 . S RACNI=0
 . F  S RACNI=$O(^RADPT("AO",RAOIFN,RADFN,RADTI,RACNI)) Q:RACNI'>0  D
 .. K %,D,D0,DA,DIC,DIE,DQ,DR
 .. S DA(2)=RADFN,DA(1)=RADTI,DA=RACNI,DR="11///@"
 .. S DIE="^RADPT("_DA(2)_",""DT"","_DA(1)_",""P"","
 .. D ^DIE K %,D,D0,DA,DIC,DIE,DQ,DR
 .. Q
 . Q
 Q
PUROK(RAORD0,RATDAY) ; Determine if an order meets the criteria
 ; to be purged from the Rad/Nuc Med Orders file.
 ; Input: RAORD0-0 node of the order record from file 75.1
 ;      : RATDAY-the current date w/o time
 ; Output: 1 if the order meets the purge criteria, else 0
 N RAOSTAT S RAOSTAT=$P(RAORD0,"^",5)
 ;
 ; PENDING & ('Date Desired' -or- 'Sheduled Date' >= today), don't purge
 Q:RAOSTAT=5&(($P(RAORD0,"^",21)\1)'<RATDAY) 0 ; Date Desired
 Q:RAOSTAT=5&(($P(RAORD0,"^",23)\1)'<RATDAY) 0 ; Sch'ld date
 ; HOLD & ('Date Desired' -or- 'Sheduled Date' >= today), don't purge
 Q:RAOSTAT=3&(($P(RAORD0,"^",21)\1)'<RATDAY) 0 ; Date Desired
 Q:RAOSTAT=3&(($P(RAORD0,"^",23)\1)'<RATDAY) 0 ; Sch'ld date
 ;
 ; PENDING & 'Request Entered Date/Time' < than 1 year ago, don't purge
 I RAOSTAT=5,($P(RAORD0,"^",16)) Q:$P(RAORD0,"^",16)'<($$FMADD^XLFDT(RATDAY,-365)) 0
 ; HOLD & 'Request Entered Date/Time' < than 1 year ago, don't purge
 I RAOSTAT=3,($P(RAORD0,"^",16)) Q:$P(RAORD0,"^",16)'<($$FMADD^XLFDT(RATDAY,-365)) 0
 ; Orders that are in a status of: DISCONTINUED or COMPLETE are purged
 ; when they have no activity after the cut-off date for their img type
 Q 1
