LRHYBLD ;DALOI/HOAK - PRINT ORDER LABELS FOR HOWDY ;8/28/2005
 ;;5.2;LAB SERVICE;**405**;Sep 27, 1994;Build 93
 ;
 ; This routine has been modified by the
 ; NTXHCS VALOR Clinical Applications Team to be used
 ; with the Howdy Phlebotomy Patient Log-in Process.
 ;
 ;  from LRHYA
ENT ;
 ;  Howdy routine for printing order labels
 ;  Make sure printer is ID'd sufficiently
 ;
 D ^LRHYBL1 ; get subtype of printer
 ;
ID I $G(LRLABLIO)="" D
 .  S LRLABLIO=$P(^%ZIS(1,LRDEV,0),U)
 .  I $G(LRLABSTP)'="" S LRLABLIO=LRLABLIO_";"_LRLABSTP
 .  E  S LRLABLIO=LRLABLIO_";P-OTC560/BARCODE;132;30"
 ;
 ;
 S ZTRTN="BACK^LRHYBLD",ZTDTH=$H,ZTDESC="LAB LABELS"
 S ZTIO=LRLABLIO,ZTSAVE("LR*")=""
 S:$D(ZTQUEUED) ZTREQ="@" D ^%ZTLOAD
 QUIT
 ;
 ;
BACK ;
 ;  after task come back here
 ;
 ;  find the best label routine
 I $D(ZTQUEUED) S ZTREQ="@"
 ; from site file
 S LRLABEL="^LRLABEL"_$S($D(^LAB(69.9,1,3)):$P(^(3),U,3),1:"")
 ; from Howdy site file
 I $G(^LRHY(69.86,LRHYSITE,11))'="" S LRLABEL="^"_$G(^LRHY(69.86,LRHYSITE,11)) ;order label rtn
 ; default printer routine
 ;
 N X S X=$P(LRLABEL,U,2) X ^%ZOSF("TEST") I '$T S LRLABEL="^LRLABEL"_$S($D(^LAB(69.9,1,3)):$P(^(3),U,3),1:"")
BC ;
 S LRBAR0=$S($L($G(^%ZIS(2,+IOST(0),"BAR0"))):^("BAR0"),1:"$C(32)")
 S LRBAR1=$S($L($G(^%ZIS(2,+IOST(0),"BAR1"))):^("BAR1"),1:"$C(32)")
 K LRBAR S LRLABLIO=IO
 ;
 ;
 ;  SET all variables for label routine
TST ;
 S LRTST=LRTSTS
 D INIT
 K ZTQUEUED,ZTREQ,LRBAR,LRLABEL,LRLABLIO
 QUIT
INIT ;
 K PNM,SSN,LRDPF D PT^LRX S LRDAT=$$Y2K^LRX(LR3DTN)
 S LRORD=$G(^LRO(69,LR3DTN,1,LR3SN,.1))
 S LRAN=$G(LRORD)
 S LRUID=$G(LRORD)
 S LRXL="" S LRPREF=$G(LRPREF,0)
 S LRACC=$G(LRACC,LRORD)
 S LRINFW=$G(LRINFW,1)
 S LRCE=LRORD
 S LRTUBE=$P(^LRO(69,LR3DTN,1,LR3SN,0),U,3)
 S LRTUBE=$E($P(^LAB(62,LRTUBE,0),U),1,11)
 S LRTNM=$E($P(^LAB(60,LRTST,0),U),1,10) S LRURGT="ROUTINE"
 S LRURGA=LRURGT
 S LRURG=LRURGT
 S LRTXT=LRTNM
 S LRTOP=LRTUBE,LRTS(LRTST)=LRTNM
 S LRLLOC="LAB"
 D @LRLABEL
 QUIT
 Q
