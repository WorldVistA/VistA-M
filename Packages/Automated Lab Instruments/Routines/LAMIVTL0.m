LAMIVTL0 ;DAL/HOAK 1st routine for Vitek Literal Verification ;1/22/96  08:30 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;**12,37,42**;Sep 27,1994
INIT ;
 S OK=1
 D CONTROL
 D END
 Q
CONTROL ;
 D INTRO I 'OK D END QUIT
 Q
END ;
 K LRNOTO,LRBUG,LRBUX,LRTIC,LRTAC,LRTAD,LRPIC,LRNODE,LRSUM,LRIFN
 K LRQUANT,LAMIAUTO,LRINST
 ;LR*5.2*37___/\______/\  added to fix undef in LRCAPVM
 Q
INTRO ;FROM LAMIAUT0 BY FHS
 ;-----------------------------------------------------------------
 D ^LRPARAM
 S LRMIDEF=$P(^LAB(69.9,1,1),U,10) S LRMIOTH=$P(^(1),U,11)
 S LRINI=$P(^VA(200,DUZ,0),U,2)
 S LRMICOM=$S($D(^DD(63.31,.01,0)):$P(^(0),U,5,99),1:"S Q9=""1,68,KM"" D COM^LRNUM")
 S LRMICOMS=$P($P(LRMICOM,",",3),"""",1)
 S LRTEC=LRINI
 ;
MACHINE ;
 K DIC
 W @IOF
 D S1
 S DIC="^LAB(62.4,"
 S DIC(0)="AEMQZ"
 S DIC("A")="Select auto instrument here: "
 D ^DIC I Y=-1 S OK=0 QUIT  ;------------------Back to Control
 S LRINST=+Y
 S LRNODE=Y(0)
 S LRAA=$P(LRNODE,U,11)
 ;----------------------------------------------------------------------
 S LRLL=$P(LRNODE,U,4)  ;-----------> load/work list
 I '$G(LRLL) S OK=0 QUIT  ;--------------------Back to Control
 ;----------------------------------------------------------------------
AREA ;
 K DIC("A") K Y(0)
 S DIC="^LRO(68,"
 S DIC("B")=$P(^LRO(68,LRAA,0),U)
 D ^DIC  ;----------------->ACCESSION AREA
 I Y=-1 S OK=0 QUIT  ;-------------------------Back to Control
 I +Y'=LRAA S LRAA=+Y
 ;-----------------------------------------------------------------------
LRAD ;
 S %DT="AEP"
 S %DT("A")=" Accession date: "
 S %DT("B")=$$FMTE^XLFDT($$CADT^LA7UTIL(LRAA),"1D")
 D DATE^LRWU I Y=-1 S OK=0 QUIT  ;--------------Back to Control
 S LRAD=+Y
 ;-----------------------------------------------------------------------
LMIP ;
 S LRVT=$P(LRNODE,U,15) I '$G(LRVT) S LRVT="VS"
 S LRFMT=$P(^LAB(69.9,1,0),U,11),LRFMT=$S(LRFMT="":"I",1:LRFMT)
 D AUTO^LRCAPV  ;--------------->Work Load
 I Y=-1 S OK=0 QUIT  ;--------------------------Back to Control
 ;-----------------------------------------------------------------------
ACCN ;
 I '$D(^LAH(LRLL,1,"C")) S OK=0 D NODATA QUIT  ;no data in LAH
 S OK=1
 K DIR
 S LRAN=0
 F  S LRAN=$O(^LAH(LRLL,1,"C",LRAN)) Q:LRAN'>0  D  Q:'OK
 .  S DIR(0)="N"
 .  S DIR("A")="Enter the number portion of the Accession"
 .  S DIR("B")=LRAN
 .  S DIR("?")="^D LIST^LAMIVTL0"
 .  D ^DIR
 .  I $D(DUOUT)!($D(DTOUT)) S OK=0 QUIT  ;---------Back to Control
 .  I Y'=LRAN S LRAN=+Y
 .  S LRANX=LRAN
 .  ;LA*5.2*37 Check for accns not in Vista
 .  I '$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D REMOVE QUIT
 .  ;
 .  ;^LAH(65,1,"C",3,32)
 .  D LRIFN
 Q:'OK  D:$G(OK1)'>0 LIST
 G:$G(OK1)'>0 ACCN
 Q
S1 ;
 W !!,"          Vitek Literal verification screen 1",!
 Q
 ;---------------------------------------------------------------------
LIST ;
 W !!
 S LRLIST=0
 W !,"Choose from: "
 F  S LRLIST=$O(^LAH(LRLL,1,"C",LRLIST)) Q:LRLIST=""  D
 .  W !,LRLIST
 Q
REMOVE ;
 ;
 ;--^LAH(65,1,"C",3659,69) = 
 ;_____________________/\                     
 ;            \/
 ;--^LAH(65,1,69,0) = 1^1^^^3659^^VITEK^3659
 ;--^LAH(65,1,69,2,2) = CARD^gni
 ;--^LAH(65,1,69,3,1,0) = 1^^gni
 ;
 ;
 S DIR("A")=$P(^LRO(68,12,0),U)_" "_LRAN_" is not in Vista data base. I've removed the C x-ref Shall I remove ^LAH Data?"
 S DIR(0)="Y" S DIR("B")="YES"
 D ^DIR
 I $D(DTOUT)!($D(DUOUT)) S OK=0 QUIT
 ;
 I Y=1 D
 .  S LRTIC=0
 .  F  S LRTIC=$O(^LAH(LRLL,1,"C",LRAN,LRTIC)) Q:+LRTIC'>0  D
 ..  I $D(^LAH(LRLL,1,LRTIC,0)) K ^LAH(LRLL,1,LRTIC)
 K ^LAH(LRLL,1,"C",LRAN)
 K ^LAH(LRLL,1,"E",LRAN)
 ;
 ;
 W !,"Please continue...",!
 Q
LRIFN ;
 S OK1=1
 S LRIFN=0,LRCNT=0
 F  S LRIFN=$O(^LAH(LRLL,1,"C",LRAN,LRIFN)) Q:LRIFN'>0  D  Q:'OK1
 .  S LRCNT=LRCNT+1
 .  S LRIFN(LRCNT)=LRIFN
 I '$G(LRCNT) W !!,"There is no data in LAH for accession ",LRAN S OK1=0 QUIT
 Q:'OK1
 D ^LAMIVTL5  ;check for zero isolate
 Q:'OK
 D ^LAMIVTL1  ;continue processing
 D END
 Q
NODATA ;
 W !!," There is no data in LAH. Run another upload "
 Q
