PSDOPT2 ;BIR/JPW,LTL-Outpatient Rx Entry (cont. from PSDOPT); 9 Jan 95
 ;;3.0; CONTROLLED SUBSTANCES ;**30,39,48**;13 Feb 97
 ;References to ^PSD(58.8 are covered by DBIA #2711
 ;References to file 58.81 are covered by DBIA #2808
 ;Reference to PSRX( supported by DBIA #986
 ;
 ;lists posted cs rxs
 S (PSDJJ,PSDRET,X)=0 F  S X=$O(^PSD(58.81,"AOP",PSDRX,X)) Q:X'>0  I $D(^PSD(58.81,X,3)),$P(^PSD(58.81,X,3),"^")'="" S PSDRET=1
 W !,!!,"Previously posted transactions for Rx #",RXNUM
 I $G(PSDRET)=1 W !,"(RTS) - denotes a Returned to Stock Transaction." S PSDRET=0
 W !!,"Date Posted:",?22,"Pharmacist:",?54,"Type:",?70,"Quantity:"
TRANS S PSDJJ=$O(^PSD(58.81,"AOP",PSDRX,PSDJJ)) G Q:'PSDJJ I '$D(^PSD(58.81,PSDJJ,0)) G TRANS
 S NODE=^PSD(58.81,PSDJJ,0),NODE6=^PSD(58.81,PSDJJ,6),NODE3=$G(^PSD(58.81,PSDJJ,3))
 S PHARM=+$P(NODE,"^",7),PHARMN="" I PHARM S PHARMN=$P($G(^VA(200,PHARM,0)),"^")
 S PSDATE=+$P(NODE,"^",4) I PSDATE S Y=PSDATE X ^DD("DD") S PSDATE=Y
 S VAULT=+$P(NODE,"^",3),VAULT=$P($G(^PSD(58.8,VAULT,0)),"^")
 W:VAULT'=PSDSN !,"Dispensing Site:  ",VAULT
 W !,PSDATE,?22,PHARMN,?54,$S($P(NODE6,U,2):"Refill #"_$P(NODE6,U,2),$P(NODE6,U,4):"Partial #"_$P(NODE6,U,4),1:"Original")
RTS ;PSD*3*39 (6JUL02) - Check for returned to stock
 S (PSDDATE3,PSDDATE4)=0
 S PSDTYPE=$S($P($G(NODE6),"^",2)'="":"RF",$P($G(NODE6),"^",4)'="":"PR",1:"OR")
 S PSDTYPE(1)=$S(PSDTYPE="RF":"Refill",PSDTYPE="PR":"Partial",1:"Original")
 S PSDRETN=$S(PSDTYPE="RF":$P(NODE6,"^",2),PSDTYPE="PR":$P(NODE6,"^",4),1:0) ;fill #
 S PSDDATE3=$P($G(NODE3),"^") S:$G(PSDDATE3)'="" PSDRET(PSDTYPE,PSDRETN)=PSDDATE3,Y=PSDDATE3 X ^DD("DD") S PSDDATE3(1)=Y
 I $G(NODE3)'="" W " (RTS)"
 I $G(PSDDATE3)="" G QTY
 I $G(PSDTYPE)="OR",$P($G(^PSRX(PSDRX,2)),"^",15)="" K PSDRET("OR",PSDRETN) G QTY
 I $G(PSDTYPE)="RF",$D(^PSRX(PSDRX,1,PSDRETN,0)) S PSDDATE4=$P(^PSRX(PSDRX,1,PSDRETN,0),"^") I PSDDATE4>PSDDATE3 K PSDRET("RF",PSDRETN) G QTY
 I $G(PSDTYPE)="PR",$D(^PSRX(PSDRX,"P",PSDRETN,0)) S PSDDATE4=$P(^PSRX(PSDRX,"P",PSDRETN,0),"^") I PSDDATE4>PSDDATE3 K PSDRET("PR",PSDRETN) G QTY
QTY W ?70,$J($P(NODE,U,6),6)
 I $P($G(PSDDATE3),".")=$G(PSDDATE4) S PSDRTSE(PSDTYPE,PSDRETN)=""
 ;
 ;
POST ;Check to see if fill has been released/posted
 S PSDRX(PSDTYPE,PSDRETN)="^"_$P($G(NODE),"^",6)_"^1"
 ;; PSD*3*48 RJS ; CHECK TO SEE IF RELEASED.
 I $G(NODE3),$G(^PSRX(PSDRX,1,PSDRETN,0)),$P(^PSRX(PSDRX,1,PSDRETN,0),"^",18)="" S $P(PSDRX(PSDTYPE,PSDRETN),"^",3)=""
 G TRANS
Q W ! K DIR,DIRUT S DIR(0)="EA",DIR("A")="Press <RET> to continue " D ^DIR I 'Y S PSDOUT=1
 Q
PSDRTS ;PSD*3.0*39 ; The next 10 lines are original code commented out for patch PSD*3*45  (this subroutine was duplicated then modified for testing)
 ;Fill data matches RTS date
 W !,?10,PSDTYPE(1)_$S($G(PSDTYPE)="OR":"",1:(" #"_PSDRETN))_" was returned to stock on "_$G(PSDDATE3(1)),!?10,"The prescription shows it re-issued on"_$G(PSDDATE4(1))
ASK W !!,"Was the fill re-issued AFTER being returned to stock? YES// " R AN:DTIME G Q:AN["^" S:AN="" AN="Y" S AN=$E(AN)
 I "YyNn"'[AN D  G ASK
 .W !!,"The issue date of the fill is the same day as the return to stock date.",!,"The program believes the fill has been re-issued since being returned to stock."
 .W !,"Please confirm this.",!
 I "nN"[AN W !,$G(PSDTYPE(1))_" will remain marked as returned to stock and unavailable.",! G TRANS
 W !,"ok, we'll bypass the returned to stock transaction." K PSDRET(PSDTYPE,PSDRETN) G TRANS
 Q
RTSDTC ;; PSD*3*48  ADDED LOGIC FOR WHEN AN RTS IS REISSUED ON THE SAMEDAY.
 N AN
 I (PSDRET("RF",X1)\1)'=DT D CLLDIR2^PSDOPT Q
 W !,?10,PSDTYPE(1)_$S($G(PSDTYPE)="OR":"",1:(" #"_PSDRETN))_" was returned to stock on "_$G(PSDDATE3(1)),!?10,"The prescription shows it re-issued today"
 W !!,"Was the fill re-issued AFTER being returned to stock? YES// "
 R AN:DTIME Q:AN["^"
 S:AN="" AN="Y" S AN=$E(AN)
 I AN="Y"!(AN="y") D CLLDIR2^PSDOPT
 Q
PSDKLL ;
 K PSD,PSDA,PSDATE,PSDBAL,PSDCS,PSDDATE3,PSDDATE4,PSDERR,PSDFILL,PSDFLNO,PSDHOLDX,PSDJJ,PSDLBL,PSDLBLP,PSDNEXT,PSDNUM
 K PSDNUM1,PSDOIN,PSDOUT,PSDPOST,PSDPR1,PSDQTY,PSDR,PSDREL,PSDRET,PSDRETN
 K PSDRF1,PSDRN,PSDRPH,PSDRS,PSDRTS,PSDRTSE,PSDRX,PSDRXFD
 K PSDRXIN,PSDS,PSDSEL,PSDSITE,PSDSN,PSDSTA,PSDSUPN,PSDT,PSDTYPE,PSDUZ
 K PSDXXX,PSOCSUB,PSOVR
 K QTY,RETSK,RF,RPDT,RX0,RX2,RXNUM
 Q
