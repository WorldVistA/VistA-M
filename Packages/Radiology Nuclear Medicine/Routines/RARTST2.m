RARTST2 ;HISC/CAH,FPT,GJC,DAD AISC/MJK,RMO-Reports Distribution ;3/19/97  13:45
 ;;5.0;Radiology/Nuclear Medicine;**8,9**;Mar 16, 1998
SRT N RASRT S RASRT="" F RAS2=0:0 S RASRT=$O(^TMP($J,"RADIST",RABTY,RASRT)) Q:RASRT=""  F RAR=0:0 S RAR=$O(^TMP($J,"RADIST",RABTY,RASRT,RAR)) Q:'RAR  S RARDIFN=+^(RAR) D PRNT
 Q
SET S RARPT=+Y K RABTY D RASET^RAUTL2 Q:'Y  S RAY3=$G(^RABTCH(74.4,RARDIFN,0)) Q:RAY3']""
 I $D(^RABTCH(74.3,"B","REQUESTING PHYSICIAN",RAB))#2 D  G SET1
 . ; Requesting Physician functionality
 . S:+$P(RAY3,"^",12) RABTY=$P($G(^VA(200,+$P(RAY3,"^",12),0)),"^")
 . S:'+$P(RAY3,"^",12) RABTY=$P($G(^VA(200,+$P(Y,"^",14),0)),"^")
 . S:RABTY']"" RABTY="Unknown" S RABTY="^"_RABTY
 . Q
 I RABT=6!(RABT=8) D  Q:'$D(RABTY)
 . S Y=+$P(RAY3,"^",RABT) Q:'Y
 . I RABT=6,$D(^DIC(42,Y,0)) S RABTY=$P(^(0),"^")
 . I RABT=8,$D(^SC(Y,0)) S RABTY=$P(^(0),"^")
 . Q
 E  D
 . N RA6,RA8 S RABTY="Unknown"
 . S RA6=+$P(RAY3,"^",6),RA8=+$P(RAY3,"^",8)
 . I RA6,'RA8 S RABTY=$S($D(^DIC(42,RA6,0)):$P(^(0),"^"),1:RABTY)
 . I 'RA6,RA8 S RABTY=$S($D(^SC(RA8,0)):$P(^(0),"^"),1:RABTY)
 . S:RABTY']"" RABTY="Unknown"
 . Q
 ;
SET1 ; Set the data global
 N RAEXIT S RAEXIT=0
 S RAY1=$G(^RADPT(RADFN,"DT",RADTI,0)) Q:'$D(RAIMAG(+$P(RAY1,U,2)))  I $D(RANGE),$P(RAY3,"^",+$P(RANGE,"^",3))'=+RANGE Q
 ;If RANGE is defined, user is prt'g from 'Individual Ward' or 'Single
 ; Clinic' option, and rpt should be bypassed if ward or clinic on the
 ; file 74.3 rpt record does not one of the selected requesting loc's
 ;If RANGE is NOT defined, user is prt'g from 'Print by Routine Queue'
 ; option and bypass logic depends on which queue they are printing 
 ; from:  If Requesting Phys. Queue, use requesting location (i.e. ward
 ; or clinic on file 74.3) to determine if its division matches the
 ; division selected.  If File Room, Medical Records, or Other than
 ; Ward or Clinic queues are being printed, use exam division (i.e.
 ; division on exam record) to determine if exam's division matches
 ; the division selected.
 I '$D(RANGE),$D(^RABTCH(74.3,"B","REQUESTING PHYSICIAN",RAB)) D  Q:RAEXIT
 . I $P(RAY3,"^",6) S:'$D(RAF408($$GET1^DIQ(42,$P(RAY3,"^",6),.015,"I"))) RAEXIT=1
 . I $P(RAY3,"^",8) S:'$D(RAF408($$GET1^DIQ(44,$P(RAY3,"^",8),3.5,"I"))) RAEXIT=1
 . Q
 I '$D(RANGE),('$D(^RABTCH(74.3,"B","REQUESTING PHYSICIAN",RAB))) Q:'$D(RA4(+$P(RAY1,"^",3)))
 Q:'$D(^DPT(RADFN,0))  S RANME=^(0),RASSN=$$SSN^RAUTL,RASSN=$S(RASSN:$TR(RASSN,"-"),1:"999999999"),RANME=$P(RANME,"^")
 S RARTST2=1 D UPDLOC^RAUTL10 K RARTST2 Q:'$D(RAPRTOK)
 ;RARTST2I will only be defined if UPDLOC has deleted the file 74.4
 ;entry RARDIFN.  RARTST2I will be the modified File Room entry
 S ^TMP($J,"RADIST",$S(RALOCSRT=1:RABTY,1:U),$S(RASRT="P":RANME,RASRT="S":"A"_RASSN,RASRT="T":"A"_($E(RASSN,8,9)_$E(RASSN,6,7))),RARPT)=$S($D(RARTST2I):RARTST2I,1:RARDIFN) K RARTST2I
 Q
 ;
PRNT Q:'$D(^RARPT(RAR,0))  Q:$P(^(0),"^",5)'="V"  S:$D(^RABTCH(74.3,RAB,"M")) RARTMES=^("M")_$S($D(RABEG):" (REPRINT)",1:"")
 S RASTFL="" S RARPT=RAR D ^RARTR Q:$G(RAY3)<0
 S %DT="TX",X="NOW" D ^%DT
 I $D(^RABTCH(74.4,RARDIFN,0)),($P(^RABTCH(74.4,RARDIFN,0),"^",4)="") D
 . N D,D0,DA,DI,DIC,DIE,DQ,DR,X
 . S DA=RARDIFN,DIE="^RABTCH(74.4,"
 . S DR="3////"_DUZ_";4////"_Y D ^DIE
 . Q
 S RARTCNT=RARTCNT+1 Q
 ;
START ;RANGE is only defined if prt'g via 'Individual Ward' or 'Single Clinic'
 ;options.  The next ward or clinic to be printed is saved in piece
 ;1 and 2 of RANGE  (RANGE=ward or clinic ien^ward or clinic name^6 or 8)
 U IO
 I $D(RANGE) D
 . S TEXT="",RANGE=$TR(RANGE,"~","^")
 . F  S TEXT=$O(^TMP($J,"WARD/CLIN",TEXT)) Q:TEXT=""  D
 .. S TEXTD0=0
 .. F  S TEXTD0=$O(^TMP($J,"WARD/CLIN",TEXT,TEXTD0)) Q:TEXTD0'>0  D
 ... S $P(RANGE,U,1,2)=TEXTD0_U_TEXT D START0
 ... Q
 .. Q
 . Q
 E  D
 . D START0
 . Q 
 K %DT,D0,D1,DA,DIC,DIE,DIR,DIRUT,DIWF,DIWL,DIWR,DR,POP,RABT,RABTY,RACNI
 K RADATE,RAIMAG,RAPRT,RAPRTF,RAPRTOK,RAST,Z,RARTMES,RARPT,RARTCNT,RAB
 K RARDIFN,RADIV,RASRT,RABEG,RAEND,RAR,RASSN,RANME,RADFN,RADT,RADTI
 K RANGE,RARPT,RAS1,RAS2,RASTFL,RALOCSRT,RARTST1,RAY1,TEXT,TEXTD0
 K ^TMP($J,"RADIST"),^TMP($J,"WARD/CLIN")
 D CLOSE^RAUTL
 Q
 ;
START0 ;
 K ^TMP($J,"RADIST") Q:'$D(^RABTCH(74.3,RAB,0))  S Y=$P(^(0),"^",2),RABT=$S(Y="I":6,Y="O":8,1:0),RAPRTF=1 D BANNER
 I '$D(RABEG) F RARDIFN=0:0 S RARDIFN=$O(^RABTCH(74.4,"C",RAB,RARDIFN)) Q:'RARDIFN  I $D(^RABTCH(74.4,RARDIFN,0)),'$P(^(0),"^",4) S Y=^(0) D SET
 I $D(RABEG) F RADT=(RABEG-.0001):0 S RADT=$O(^RABTCH(74.4,"AD",RADT)) Q:'RADT!(RADT>RAEND)  F RARDIFN=0:0 S RARDIFN=$O(^RABTCH(74.4,"AD",RADT,RARDIFN)) Q:'RARDIFN  I $D(^RABTCH(74.4,RARDIFN,0)),$P(^(0),"^",11)=RAB S Y=^(0) D SET
 I '$D(^TMP($J,"RADIST")) D  G Q
 . W:$Y>(IOSL-4) @IOF
 . W !!,$G(RARTMES),!!,"No reports met the criteria selected."
 . I $D(RANGE) W !,$P("^^^^^Ward^^Clinic",U,$P(RANGE,U,3)),": ",$P(RANGE,U,2)
 . Q
 S RABTY="",RARTCNT=0 F RAS1=0:0 S RABTY=$O(^TMP($J,"RADIST",RABTY)) Q:RABTY=""  D NEWLOC,SRT
 W @IOF,"Total Number of Reports printed: ",RARTCNT,!!
 ;S DA=+RAB,DR="[RA DISTRIBUTION LOG]",DIE="^RABTCH(74.3,",RARTMES="" S:$D(RANGE) RARTMES=$P(RANGE,"^",2)
 ;D ^DIE K DE,DQ
 ; Added in patch 9 to stop endless loops...
START1 L +^RABATCH(74.3,+RAB)
 S RARTMES="" S:$D(RANGE) RARTMES=$P(RANGE,U,2)
 S RAIENS="+1,"_(+RAB)_",",RAFDA(74.33,RAIENS,.01)="NOW"
 D UPDATE^DIE("E","RAFDA","RAIEN","RAERR")
 I '$G(RAIEN(1)) L -^RABTCH(74.3,+RAB) K RAIENS,RAIEN,RAFDA G START1
 K RAFDA,RAIENS S RAIENS=RAIEN(1)_","_(+RAB)_"," K RAIEN
 S RAFDA(74.33,RAIENS,2)=$S($D(RABEG):"R",1:"P")
 S RAFDA(74.33,RAIENS,3)=DUZ
 S RAFDA(74.33,RAIENS,4)=$E(RARTMES,1,20)
 S RAFDA(74.33,RAIENS,5)=RARTCNT
 D FILE^DIE(,"RAFDA","RAERR")
 L -^RABTCH(74.3,+RAB)
 K RAFDA,RAIENS,RAERR
Q D BANNER
 Q
 ;
BANNER I $D(^RABTCH(74.3,RAB,"M")) S RARTMES=^("M")_$S($D(RABEG):" (REPRINT)",1:"")
 Q
NEWLOC ; Print Location/Requesting Physician data
 I RABTY="^" Q
 W @IOF,!!!!!?10
 W $S(RABTY'["^":"L O C A T I O N :   ",1:"REQUESTING PHYSICIAN:   ")
 W $S(RABTY["^":$P(RABTY,"^",2),1:RABTY)
 Q
