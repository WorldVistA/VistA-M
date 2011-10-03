LRFAC ;MILW/JMC/DALISC/FHS - CUM PRINT FOR FILEROOM PATIENTS TO SEPARATE PRINTER
 ;;5.2;LAB SERVICE;;Sep 27, 1994
EN ; Entry point from menu option to manually task file room cumulative.
 W @IOF,!!?20,"Checking File #64.5, LAB REPORTS FILE"
 D CHECK I LRERR W !!,$C(7),$P(LRERR,U,2),!! G END
 W !,"File Setup ...OK",!!,"Will schedule report(s):"
 S LRRPTN=0
 F  S LRRPTN=$O(LRRP(LRRPTN)) Q:'LRRPTN  W ?25,$P(LRRP(LRRPTN),U),!
 K DIR
 S DIR(0)="YO",DIR("A")="Print Cumulative for FILE ROOM",DIR("B")="NO"
 S DIR("?")="Answer 'YES' if you want to task the FILE ROOM Cumulative to start."
 D ^DIR K DIR
 I Y D
 . S ZTRTN="CLOCK^LRFAC",ZTIO="",ZTDESC="Start FILE ROOM Cumulative"
 . D ^%ZTLOAD W !,"Request ",$S($D(ZTSK):"",1:"NOT "),"Queued" W:$D(ZTSK) !,"Task #",ZTSK
 G END
 ;
CLOCK ; Task fileroom patients cumulative to appropiate devices.
 D CHECK I LRERR D  G END
 . S XQAMSG="File setup problem observed when attempting to run Lab File Room Cumulative"
 . D ALERT
 K ^LAC($J),XQAMSG
 Q:'$D(^LAB(64.5,1,3))!($D(^LAC("LRAC","A")))
 S CNT=0 F  L +^LAB(64.5):1 Q:$T  H 60 S CNT=1 I CNT>5 D  Q  ; Lock LAB REPORTS file.
 . S XQAMSG="Unable to lock Lab Reports file (#64.5) check Lock Table"
 . D ALERT
 G END:$D(XQAMSG)
 S LRDT=$P(^LAB(64.5,1,0),U,3) ; Get last cumulative report date.
 S LRLDT=$P($G(^LAB(64.5,1,6)),U,1) I 'LRLDT S LRLDT=LRDT ;Find last fileroom report date ( if none, set to last report date).
 S LRRE=0,LRXLR="LRAC",LRPERM=0,LRBOT=$P(^LAB(64.5,1,0),U,2)
 S %DT="",X="T" D ^%DT S LRYDT=Y
 ; For each day since last fileroom run, move fileroom patients to current fileroom list.
 ; Start with last file room run date in case last run was incomplete.
 ; If patient has been printed subsequently - date stored in second piece of ^LAC("LRAC",LRDFN,0) is more recent, then skip.
 S LRLDT=LRLDT-.1
 F  S LRLDT=$O(^LRO(69,LRLDT)) Q:'LRLDT!(LRLDT'<LRDT)  D
 . S LRLLOC="FILE ROOM" ; Start with locations containing "FILE ROOM", end when doesn't contain "FILE ROOM".
 . F  S LRLLOC=$O(^LRO(69,LRLDT,1,"AR",LRLLOC)) Q:LRLLOC=""!(LRLLOC'["FILE ROOM")  D
 . . S PNM=""
 . . F  S PNM=$O(^LRO(69,LRLDT,1,"AR",LRLLOC,PNM)) Q:PNM=""  D
 . . . S LRDFN=0
 . . . F  S LRDFN=$O(^LRO(69,LRLDT,1,"AR",LRLLOC,PNM,LRDFN)) Q:'LRDFN  I LRLDT>$P($G(^LAC("LRAC",LRDFN,0)),U,2) S $P(^LRO(69,LRDT,1,"AR",LRLLOC,PNM,LRDFN),U,2)=$P(^LRO(69,LRLDT,1,"AR",LRLLOC,PNM,LRDFN),U,2)
 S LRLDT=LRDT,$P(^LAB(64.5,1,6),U,1)=LRLDT ; Update last Fileroom run date.
 L -^LAB(64.5) ; Release locks.
 ; Will task those reports that are flagged as separate fileroom.
 N ZTIO ; Tasked jobs have ZTIO defined, want ZTLOAD to build from IO* variables.
 S LRRPTN=0
 F  S LRRPTN=$O(^LAB(64.5,1,3,LRRPTN)) Q:'LRRPTN  D
 . S LRX(0)=$G(^LAB(64.5,1,3,LRRPTN,0)),LRX(.1)=$G(^LAB(64.5,1,3,LRRPTN,.1))
 . I $P(LRX(0),U,2)["FILE ROOM",$P(LRX(0),U,3)["FILE ROOM",$P(LRX(.1),U,3) D
 . . ; Starting/Ending locations contain "FILE ROOM", flag set to YES for FILEROOM REPORT.
 . . S IOP=$P(LRX(.1),U,1) Q:IOP=""  S %ZIS="N" D ^%ZIS Q:POP  ; Get device characteristics.
 . . F I="LRPERM","LRXLR","LRDT","LRLDT","LRYDT","LRBOT","LRRE","LRRPTN" S ZTSAVE(I)=""
 . . S ZTRTN="DQ^LRFAC",ZTDTH=$H,ZTDESC="Laboratory Fileroom Cumulative"
 . . D ^%ZTLOAD K ZTSK ; Task the job.
 . K IOP D ^%ZISC ; Restore device parameters.
 G END
 ;
DQ ; Queued entry point to actually print fileroom reports
 S $P(^LAB(64.5,1,3,LRRPTN,0),U,4,8)="" ; Clear previous status for this report.
 D ENT^LRAC1
 S:$D(ZTQUEUED) ZTREQ="@"
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
 I LRERR S LRERR=LRERR_U_"Report: "_$P(LRX(0),U)_" - "_$S(LRERR=3:"Starting",1:"Ending")_" Location does NOT contain 'FILE ROOM'!" Q
 I '$D(LRRP) S LRERR=5_U_"No reports for FILE ROOM found!"
 Q
 ;
END ; Clean up time.
 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZISC
 K %DT,%H,%ZIS,DA,DIR,DIRUT,I,PNM,X,X1,X2,Y,Z
 K LRBOT,LRCVT,LRDFN,LRDT,LREND,LRERR,LRLDT,LRLLOC,LRNM,LRPERM,LRRP,LRRPTN,LRRE,LRX,LRXLR,LRYDT,CNT
 K XQ1,XQAMSG,XQXFLG
 Q
ALERT ;Send Alert Messages to LRLIASON mail group
 Q:'$L($G(XQAMSG))  N Y S Y=0 F  S Y=$O(^XUSEC("LRLIASON",Y)) S XQA(Y)=""
 I $D(XQA) D SETUP^XQALERT
 Q
