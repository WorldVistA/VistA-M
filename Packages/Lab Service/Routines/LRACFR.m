LRACFR ;MILW/JMC- Lab cumulative print fileroom patients ;2/20/91  08:33 ;
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN ; Entry point from menu option to manually task file room cumulative.
 W @IOF,"Checking File #64.5, LAB REPORTS FILE"
 D CHECK I LRERR W !!,$C(7),$P(LRERR,U,2),!! G END
 W " ...OK",!!,"Will schedule report(s):"
 S LRRPTN=0
 F  S LRRPTN=$O(LRRP(LRRPTN)) Q:'LRRPTN  W ?25,$P(LRRP(LRRPTN),U),!
 K DIR
 S DIR(0)="YO",DIR("A")="Print Cumulative for FILE ROOM",DIR("B")="NO"
 S DIR("?")="Answer 'YES' if you want to task the FILE ROOM Cumulative to start."
 D ^DIR K DIR
 I Y D
 . S ZTRTN="CLOCK^LRACFR",ZTIO="",ZTDESC="Start FILE ROOM Cumulative"
 . D ^%ZTLOAD W !,"Request ",$S($D(ZTSK):"",1:"NOT "),"Queued" W:$D(ZTSK) !,"Task #",ZTSK
 G END
 ;
CLOCK ; Task fileroom patients cumulative to appropiate devices.
 D CHECK I LRERR D  G END
 . S XQAMSG="File setup problem observed when attempting to run Lab File Room Cumulative"
 . K XQA S Y=0 F  S Y=$O(^XUSEC("LRLIASON",Y)) Q:Y=""  S XQA(Y)=""
 . I $D(XQA) D SETUP^XQALERT
 K ^LAC($J)
 Q:'$D(^LAB(64.5,1,3))!($D(^LAC("LRAC","A")))
 L +^LAB(64.5) ; Lock LAB REPORTS file.
 S LRLDT=$P($G(^LAB(64.5,1,6)),U,1),LRDT=$P(^LAB(64.5,1,0),U,3) I 'LRLDT S LRLDT=LRDT ;Find last fileroom report date ( if none, set to last report date).
 L -^LAB(64.5) ; Release locks.
 S LRRE=0,LRXLR="LRAC",LRPERM=0,LRBOT=$P(^LAB(64.5,1,0),U,2)
 S %DT="",X="T" D ^%DT S LRYDT=Y
 ; For each day since last fileroom run, move fileroom patients to current fileroom list.
 ; If patient has been printed subsequently - date stored in second piece of ^LAC("LRAC",LRDFN,0) is more recent, then skip.
 S X1=LRDT,X2=LRLDT D ^%DTC
 I X>1 D
 . S LRCVT=X-1
 . F I=1:1:LRCVT S X=LRLDT D H^%DTC S %H=%H+1 D YMD^%DTC S LRLDT=X D
 . . S LRLLOC="FILE ROOM"
 . . F  S LRLLOC=$O(^LRO(69,LRLDT,1,"AR",LRLLOC)) Q:LRLLOC=""!(LRLLOC'["FILE ROOM")  D
 . . . S PNM=""
 . . . F  S PNM=$O(^LRO(69,LRLDT,1,"AR",LRLLOC,PNM)) Q:PNM=""  D
 . . . . S LRDFN=0
 . . . . F  S LRDFN=$O(^LRO(69,LRLDT,1,"AR",LRLLOC,PNM,LRDFN)) Q:'LRDFN  I LRLDT>$P($G(^LAC("LRAC",LRDFN,0)),U,2) S $P(^LRO(69,LRDT,1,"AR",LRLLOC,PNM,LRDFN),U,2)=$P(^LRO(69,LRLDT,1,"AR",LRLLOC,PNM,LRDFN),U,2)
 ; Will task those reports that are flagged as separate fileroom.
 N ZTIO ; Tasked jobs have ZTIO defined, want ZTLOAD to build from IO* variables.
 S LRRPTN=0
 F  S LRRPTN=$O(^LAB(64.5,1,3,LRRPTN)) Q:LRRPTN<1  D
 . S LRX(0)=$G(^LAB(64.5,1,3,LRRPTN,0)),LRX(.1)=$G(^LAB(64.5,1,3,LRRPTN,.1))
 . I $P(LRX(0),U,2)["FILE ROOM",$P(LRX(0),U,3)["FILE ROOM",$P(LRX(.1),U,3) D
 . . ; Starting/Ending locations contain "FILE ROOM", flag set to YES for SEPARATE FILEROOM (field #17 in file #64.5).
 . . S IOP=$P(LRX(.1),U,1) Q:IOP=""  S %ZIS="N" D ^%ZIS Q:POP  ; Get device characteristics.
 . . F I="LRPERM","LRXLR","LRDT","LRLDT","LRYDT","LRBOT","LRRE","LRRPTN" S ZTSAVE(I)=""
 . . S ZTRTN="DQ^LRACFR",ZTDTH=$H,ZTDESC="Laboratory Fileroom Cumulative"
 . . D ^%ZTLOAD K ZTSK ; Task the job.
 . K IOP D ^%ZISC ; Restore device parameters.
 G END
 ;
DQ ; Queued entry point to actually print fileroom reports
 S LRFRDT=LRDT,$P(^LAB(64.5,1,3,LRRPTN,0),U,4,8)="" ; Clear previous status for this report.
 D ENT^LRAC1
 S $P(^LAB(64.5,1,6),U,1)=LRFRDT ; Update last Fileroom run date.
 S:$D(ZTQUEUED) ZTREQ="@"
 K LRFRDT
 Q
 ;
CHECK ; Check File 64.5 for proper setup.
 N LRRPTN,LRX
 S LRERR=0,LRX(0)=$G(^LAB(64.5,1,0)),LRX(6)=$G(^LAB(64.5,1,6))
 I '$P(LRX(0),U,4) S LRERR=1_U_"Field #4, FILE ROOM, not set to 'YES'!" Q
 I '$P(LRX(6),U,2) S LRERR=2_U_"Field #17, SEPARATE FILE ROOM, not set to 'YES'!" Q
 S LRRPTN=0 K LRX
 F  S LRRPTN=$O(^LAB(64.5,1,3,LRRPTN)) Q:LRRPTN<1!(LRERR)  D
 . S LRX(0)=$G(^LAB(64.5,1,3,LRRPTN,0)),LRX(.1)=$G(^LAB(64.5,1,3,LRRPTN,.1))
 . I '$P(LRX(.1),U,3) Q
 . I $P(LRX(0),U,2)'["FILE ROOM" S LRERR=3 Q
 . I $P(LRX(0),U,3)'["FILE ROOM" S LRERR=4 Q
 . S LRRP(LRRPTN)=LRX(0)
 I LRERR S LRERR=LRERR_U_"Report: "_$P(LRX(0),U)_" - "_$S(LREND=1:"Starting",1:"Ending")_" Location does NOT contain 'FILE ROOM'!" Q
 I '$D(LRRP) S LRERR=5_U_"No reports for FILE ROOM found!"
 Q
 ;
END ; Clean up time.
 S:$D(ZTQUEUED) ZTREQ="@"
 K %DT,%H,%ZIS,DA,DIR,DIRUT,I,PNM,X,X1,X2,Y,Z
 K LRBOT,LRCVT,LRDFN,LRDT,LREND,LRERR,LRLDT,LRLLOC,LRNM,LRPERM,LRRP,LRRPTN,LRRE,LRX,LRXLR,LRYDT
 Q
