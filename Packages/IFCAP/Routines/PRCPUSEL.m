PRCPUSEL ;WISC/RFJ/DAP-utilities: setup inventory variables ;14 Feb 91
V ;;5.1;IFCAP;**1,83,110,118**;Oct 20, 2000;Build 7
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;  enter distribution point--input variables:
 ;  prcp("dptype")=distribution point type code [W,P,S]
 ;  returns the following variables:
 ;  prcp("in")=name of inv pt (no station #),
 ;  prcp("inv")=keep perpetual inventory flag
 ;  prcp("his")=keep detailed history flag,
 ;  prcp("i")=da of inv pt
 ;
 ;*83 Routine PRCPLO1 associated with PRC*5.1*83 is a modified copy of
 ;this routine and any changes made to this routine should also be
 ;considered for that routine as well.
 ;
 N %,C,DISYS,I,J,PRCF,PRCPFLAG,X,Y
 I +$G(DUZ)<1 W !,"YOU ARE NOT SETUP AS A USER!" K PRC,PRCP Q
 ;
 S %=0 F I="FY","PARAM","PER","QTR","SITE" I '+$G(PRC(I)) S %=1 Q
 I % S PRCF("X")="S" D ^PRCFSITE I '+$G(PRC("SITE")) K PRC,PRCP Q
 ;
 S %=0 F I="DPTYPE","HIS","I","IN","INV" I $G(PRCP(I))="" S %=1 Q
 I '% D DISPLAY Q
 ;
 ;  allow adding new whse if not one for station
 I $G(PRCP("DPTYPE"))="W" D  Q:$G(PRCPFLAG)
 .   K PRCPFLAG
 .   S %=0 F  S %=$O(^PRCP(445,"AC","W",%)) Q:'%  I $P($P($G(^PRCP(445,%,0)),"^"),"-")=PRC("SITE") S PRCPFLAG=1 Q
 .   I $G(PRCPFLAG) K PRCPFLAG Q
 .   S PRCP("I")=$$INVPT^PRCPUINV(PRC("SITE"),"W",1,1,"")
 .   I 'PRCP("I") S PRCPFLAG=1 K PRC,PRCP
 ;
 S %=$S($D(PRCP("DPTYPE")):PRCP("DPTYPE"),1:"^")
 S (I,J)=0
 F  S I=$O(^PRCP(445,"AD",DUZ,I)) Q:'I  I $D(^PRCP(445,I,0)) D  I J>1 Q
 .   S:%="^"!(%[$P(^PRCP(445,I,0),"^",3)) Y(0)=^(0),J=J+1,Y=I
 I J=1 D  Q:$G(PRCPFLAG)  S PRC("SITE")=+Y(0) D V1 Q
 .   I '$D(^PRC(411,+Y(0),0)) D  K PRC,PRCP S PRCPFLAG=1
 .   .   W !,"ERROR - SITE PARAMETERS IN FILE 411 FOR SITE "
 .   .   W +Y(0)," ARE MISSING."
 I $G(PRCHAUTH) Q:'$G(PRCP("I"))  D  G V1
 .   S Y=PRCP("I")_"^"_$P($G(^PRCP(445,PRCP("I"),0)),U)
 ;
 S DIC="^PRCP(445,",DIC(0)="AEQMOZ"
 S DIC("S")="I +^(0)=PRC(""SITE""),$P(^(0),U,2)=""Y"",$D(^PRCP(445,+Y,4,DUZ,0))"
 I $D(PRCP("DPTYPE")) S DIC("S")=DIC("S")_",PRCP(""DPTYPE"")[$P(^PRCP(445,+Y,0),U,3)"
 S DIC("A")="Select "_$S('$D(PRCP("DPTYPE")):"",PRCP("DPTYPE")="W":"Supply Warehouse ",PRCP("DPTYPE")="P":"Primary ",PRCP("DPTYPE")="S":"Secondary ",1:"")_"Inventory Point: "
 S D="C",PRCPPRIV=1
 D IX^DIC
 K PRCPPRIV,DIC
 I Y<0 K PRC,PRCP Q
 ;
V1 ;  internal program jump
 D PARAM(+Y)
 ;
DISPLAY ;  display top of page header
 I '$G(PRCP("I")) G PRCPUSEL
 S %=0 F I="RV1","RV0","XY" I '$D(PRCP(I)) S %=1 Q
 I % D TERM
 ;
 S %="",$P(%," ",81)=""
 S X="I N V E N T O R Y  version "_$P($T(PRCPUSEL+1),";",3)
 S Y=80-$L(X)\2
 S X=$E(%,1,Y)_X_%
 W @IOF,PRCP("RV1"),$E(X,1,40)
 X PRCP("XY")
 W $E(X,41,80),PRCP("RV0")
 S PRCP("PAR")=^PRCP(445,PRCP("I"),0)
 S X=$S(+$G(PRC("SITE")):"("_PRC("SITE")_") ",1:"")
 S X=X_$S(PRCP("DPTYPE")="W":"Warehouse ",PRCP("DPTYPE")="P":"Primary ",PRCP("DPTYPE")="S":"Secondary ",1:"")
 S X=X_"Inventory Point: "_PRCP("IN")
 W !,X,?(80-$L($P($G(PRC("PER")),"^",2))),$P($G(PRC("PER")),"^",2)
 I PRCP("DPTYPE")="P" S Y=$P(PRCP("PAR"),"^",12) I Y,Y'>DT D
 .   D DD^%DT
 .   W !,?6,"--> NEXT REQUEST FOR WAREHOUSE ISSUES IS DUE IN SUPPLY ON ",Y,"."
 I $P(PRCP("PAR"),"^",9)="Y" D
 .   W !?6,"--> THERE ARE ITEMS AT OR BELOW THE EMERGENCY STOCK LEVEL."
 I $E($P(PRCP("PAR"),"^",14),1,5)'=$E(DT,1,5) D
 .   W !?6,"--> USAGE/DISTRIBUTION TOTALS NEEDS TO BE PURGED."
 I $E($P(PRCP("PAR"),"^",17),1,5)'=$E(DT,1,5) D
 .   W !?6,"--> RECEIPTS HISTORY BY ITEM NEEDS TO BE PURGED."
 I PRCP("DPTYPE")'="S",$E($P(PRCP("PAR"),"^",19),1,5)'=$E(DT,1,5) D
 .   W !?6,"--> DISTRIBUTION HISTORY NEEDS TO BE PURGED."
 I $E($P(PRCP("PAR"),"^",18),1,5)'=$E(DT,1,5) D
 .   W !?6,"--> TRANSACTION REGISTER NEEDS TO BE PURGED."
 I $P(PRCP("PAR"),"^",6)="Y",$E($P(PRCP("PAR"),"^",22),1,5)'=$E(DT,1,5) D
 .   W !?6,"--> OPENING MONTHLY INVENTORY BALANCES NEED TO BE SET."
 I PRCP("DPTYPE")="S",$P($G(^PRCP(445,PRCP("I"),5)),"^",1)]"" D SSMSG
 I $O(^PRCP(447.1,"C",+PRCP("PAR"),PRCP("I"),"")) D
 .   W !?6,"--> THERE ARE UNPROCESSED SUPPLY STATION TRANSACTIONS."
 ;
 W !,PRCP("RV1"),$E(%,1,40) X PRCP("XY") W $E(%,41,80),PRCP("RV0")
 Q
 ;
 ;
NOMENU ;  user did not select a valid inventory point, do not allow access
 ;  to the menu (called from option file)
 N X
 S X(1)="YOU MUST SELECT A VALID INVENTORY POINT BEFORE ACCESSING THIS MENU" D DISPLAY^PRCPUX2(1,79,.X)
 Q
 ;
 ;
PARAM(INVPT) ;  set up parameters for inventory point
 K PRCP
 N DATA
 S DATA=$G(^PRCP(445,INVPT,0)) I DATA="" Q
 S PRCP("I")=INVPT,PRCP("IN")=$P($P(DATA,"^"),"-",2,99),PRCP("INV")=$P(DATA,"^",2),PRCP("HIS")=$P(DATA,"^",6),PRCP("DPTYPE")=$P(DATA,"^",3)
 D TERM
 Q
 ;
 ;
TERM ;  get terminal attributes
 N X
 I '$D(IOF)!('$G(IOST(0))) S IOP="HOME" D ^%ZIS K IOP
 S X="IORVON;IORVOFF" D ENDR^%ZISS
 S PRCP("RV1")=$G(IORVON),PRCP("RV0")=$G(IORVOFF)
 S PRCP("XY")="N DX,DY S (DX,DY)=0 "_$G(^%ZOSF("XY"))
 Q
 ;
SSMSG ; check supply station secondaries, give message of qty mismatch
 N GIPCNT,INVPT,ITEM,PRCPFLAG,SSCNT
 S INVPT=PRCP("I")
 S ITEM=0
 F  S ITEM=$O(^PRCP(445,INVPT,1,ITEM)) Q:'+ITEM  D  I $D(PRCPFLAG) Q
 .  I $P($G(^PRCP(445,INVPT,1,ITEM,0)),"^",9)<1 Q  ; not a SS item
 .  S GIPCNT=$P($G(^PRCP(445,INVPT,1,ITEM,0)),"^",7)
 .  S SSCNT=$P($G(^PRCP(445,INVPT,1,ITEM,9)),"^",1)
 .  I 'GIPCNT,'SSCNT Q
 .  I GIPCNT=SSCNT Q
 .  W !,?6,"--> QUANTITY DISCREPANCIES EXIST WITH THE SUPPLY STATION."
 . S PRCPFLAG=1
