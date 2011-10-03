LADOWN ;DALOI/RWF - TOP LEVEL OF DOWNLOAD OPTIONS ;7/20/90  08:06
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**17,57**;Sep 27, 1994
 ;
BUILD ;Build a download file for an Instrument
 N DIR,LAQUIT,LAX,LRCUP1,LRCUP2,LRNEW,LRPROF,LRTRAY1,LRTYPE,TSK
 ;
 S LAQUIT=0
 ;
 D INIT
 I LAQUIT D QUIT Q
 ;
BU2 ;
 W !
 S DIR(0)="YO"
 S DIR("?")="If optional for this instrument, should I send the tray,cup locations."
 S DIR("A")="Send TRAY/CUP locations"
 S DIR("B")=$S($P(LRAUTO(9),"^",5)="N":"NO",1:"YES")
 D ^DIR
 I $D(DIRUT) D QUIT Q
 S LRFORCE=Y
 ;
 K DIR("?")
 S DIR("B")=$S($P(LRAUTO(9),"^",6)="N":"NO",1:"YES")
 S DIR("A")="Queue work"
 D ^DIR
 I $D(DIRUT) D QUIT Q
 ;
 W !
 I Y=1 D  Q
 . N ZTDESC,ZTRTN,ZTIO,ZTSAVE
 . S ZTRTN="DQB^LADOWN",ZTIO="",ZTSAVE("LR*")=""
 . S ZTDESC="AUTO-INSTRUMENT DOWNLOAD "
 . D ^%ZTLOAD
 . D QUIT
 ;
DQB ;
 S:$D(ZTQUEUED) ZTREQ="@"
 ; Now ready to build file.
 D BUILD^LADOWN1
 ;
 ; Routine from auto instrument file.
 S LRTRAY=LRTRAY1 D @$P(LRAUTO(9),U,3,4)
 ;
 ; Go send the records
 G SE2:$G(LREND)<1,LAST
 ;
QUIT ; Clean up
 K ^TMP($J)
 K LRLL,LRINST,LRAUTO,LRFILE,LRI,LRTRAY,LRCUP,LRAA,LRAD,LRAN,LRTEST,LRECORD,LRFLUID,LRFORCE,LRL,LRPNM
 K F,I,J,X,X5,LRRTN
 Q
 ;
INIT ;
 N %,DIC,DIR,DIRUT,DTOUT,DUOUT,ZTSK,LREND
 ;
 S LAQUIT=0
 ;
 S DIC="^LAB(62.4,",DIC(0)="AMEQZ"
 D ^DIC
 I Y<1 S LAQUIT=1 Q
 ;
 S LRINST=+Y,LRAUTO=Y(0),LRAUTO(9)=$G(^LAB(62.4,LRINST,9))
 I LRAUTO(9)="" D  Q
 . S LAQUIT=1
 . W !,"Sorry I don't know how to build for this Instrument"
 ;
 K DIC
 S DIC="^LRO(68.2,",DIC(0)="AEMQZ"
 S DIC("A")="Build using Load List: "
 S DIC("B")=$P($G(^LRO(68.2,+$P(LRAUTO,"^",4),0)),"^",1)
 D ^DIC
 I Y<1 S LAQUIT=1 Q
 ;
 S LRLL=+Y,$P(LRAUTO,"^",4)=LRLL,LRTYPE=$P(Y(0),"^",3)
 S (%,LRPROF)=0
 F  S %=$O(^LRO(68.2,LRLL,10,%)) Q:'%  S LRPROF=LRPROF+1
 I LRPROF>1 D  Q:LAQUIT
 . N DIC,DIR
 . S DIR(0)="Y",DIR("A")="All Profiles",DIR("B")="YES" D ^DIR
 . I $D(DIRUT) S LAQUIT=1
 . S LRPROF=Y
 . I 'LRPROF D
 . . S DIC="^LRO(68.2,"_LRLL_",10,",DIC(0)="AEMQ"
 . . D ^DIC
 . . I Y<1 S LAQUIT=1
 . . E  S LRPROF=LRPROF_"^"_Y
 ;
 S LAX=$G(^LRO(68.2,LRLL,2))
 I $P(LAX,"^",2)="" D  Q
 . W !,$C(7),"Load/work list not setup"
 . S LAQUIT=1
 ;
 W !!,"Working on the download file for instrument ",$P(LRAUTO,"^",1)
 W !,"from Load list ",$P(^LRO(68.2,LRLL,0),"^",1)
 I 'LRPROF W " using profile ",$P(LRPROF,"^",3)
 ;
 S LRTRAY1=$P(LAX,"^",2)
 ;
 I LRTYPE D  Q:LAQUIT
 . N DIR,DIROUT,DIRUT,DTOUT,DUOUT
 . W !
 . S DIR(0)="NO^"_$P(LAX,"^",2)_":"_$P(LAX,"^",4)_":0"
 . S DIR("A")="Starting Tray number"
 . S DIR("B")=$P(LAX,"^",2)
 . S DIR("?")="Enter a tray to start the build and sending at."
 . D ^DIR
 . I $D(DIRUT) S LAQUIT=1
 . E  S LRTRAY1=Y
 ;
 W !
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT
 S DIR(0)="NO^1:9999:0"
 S DIR("A")="Starting "_$S(LRTYPE:"CUP",1:"SEQUENCE")_" number"
 S DIR("B")=$P(LAX,"^",3)
 S DIR("?")="Enter a "_$S(LRTYPE:"cup",1:"sequence")_" to start the build and sending at."
 D ^DIR
 I $D(DIRUT) S LAQUIT=1
 E  S (LRCUP1,LRCUP2)=Y
 Q
 ;
 ;
PURGE ; Remove the download records from the Load List file, Should be removed when sent.
 N C,T
 D INIT
 I Y'>0 D QUIT Q
 S %=2 W !,"Is this OK" D YN^DICN G QUIT:%'=1
 ;
 S T=0
 F  S T=$O(^LRO(68.2,LRLL,1,T)) Q:T'>0  D
 . S C=0
 . F  S C=$O(^LRO(68.2,LRLL,1,T,1,C)) Q:C'>0  K ^LRO(68.2,LRLL,1,T,1,C,2)
 W !,"DONE"
 D QUIT
 Q
 ;
SEND D INIT
 I Y'>0 D QUIT Q
SE2 ;
 K LRFILE
 I '$D(ZTQUEUED) W !,"Now setting up to send."
 S TSK=LRINST,LRRTN=$P(LRAUTO(9),"^",1,2),LRFILE=$P(^LRO(68.2,LRLL,0),"^",1),T=TSK
 I '$P(LRAUTO,"^",8) D SETO^LAB
 ;
 ;Set-up call
 D:$L($P(LRRTN,U,2)) @("START^"_$P(LRRTN,"^",2))
 ;
 S LRTRAY=LRTRAY1
 F  D  Q:LRTRAY'>0 
 . I $D(^LRO(68.2,LRLL,1,LRTRAY)) D TRAY
 . S LRTRAY=$O(^LRO(68.2,LRLL,1,LRTRAY)) Q:LRTRAY'>0  S LRCUP2=1
 ;
 ;
SE3 ; Clean-up call
 D:$L($P(LRRTN,U,2)) @("END^"_$P(LRRTN,"^",2))
 ;
LAST ;
 I '$D(ZTQUEUED) W !,"DONE. Data should start moving now"
 D QUIT
 Q
 ;
NEW ;Start a new file for each tray.
 D:$L($P(LRRTN,U,2)) @("NEXT^"_$P(LRRTN,"^",2)) Q
 ;
TRAY ;
 S LRNEW=1 Q:LRTRAY'>0
 S LRCUP=LRCUP2-.1
 F  S LRCUP=$O(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP)) Q:LRCUP'>0  D
 . I LRNEW D NEW
 . S LRNEW=0
 . I $D(^LRO(68.2,LRLL,1,LRTRAY,1,LRCUP,2)) S X=^(2) D:$L($P(LRRTN,U,2)) @LRRTN
