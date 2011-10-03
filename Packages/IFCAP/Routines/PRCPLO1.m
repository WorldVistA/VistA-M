PRCPLO1 ;WOIFO/RLL/DAP-utilities: setup inventory variables     ; 1/24/06 9:56am
V ;;5.1;IFCAP;**83**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ; Copied from routine PRCPUSEL
PRCPUSEL ; Old routine label (to resolve goto below for xindex)
 Q
 ;
 ;  enter distribution point--input variables:
 ;  prcp("dptype")=distribution point type code [W,P,S]
 ;
 ;  returns the following variables:
 ;  prcp("in")=name of inv pt (no station #),
 ;  prcp("inv")=keep perpetual inventory flag
 ;  prcp("his")=keep detailed history flag,
 ;  prcp("i")=da of inv pt
 ;
DOIT ; ADDED label here
 N D,IORVOFF,IORVON,PRCHAUTH  ; needed to New for xindex
 D DOIT1
 Q
GETIPT ; $O through PRCP(^445,"B", get Station ID, Inactive?, IPID#
 ; 
 N V1,V2,V3,V4,V5,DATA1,DATA2
 S V1=0,V2=0
 F  S V1=$O(^PRCP(445,"B",V1)) Q:V1=""  D
 . F  S V2=$O(^PRCP(445,"B",V1,V2)) Q:V2=""  D
 . . Q:V1["***INACTIVE"
 . . ;S V1=$TR(V1,"*","&")  ; needed due to using "*" as delimiter
 . . S V3=$P(V1,"-",1)
 . . S V4=$P(V1,"-",2,99)
 . . ; W !," Station ID#=",V3
 . . ; W !," Inventory Point =",V4
 . . ; W !," Inventory Point ID# =",V2
 . . S DATA1=$G(^PRCP(445,+(V2),0))  ; DATA for Inv Point
 . . S PRCP("DPTYPE")=$P(DATA1,"^",3)  ; Prim, Second, or warehouse
 . . S PRCP("PAR")=DATA1  ; Data for Inv point set in array
 . . S PRCP("HIS")=$P(DATA1,"^",6)  ;
 . . S PRCP("I")=V2  ; Inv Point ID#
 . . S PRCP("INV")=$P(DATA1,"^",2)  ; External Name, Inv Point
 . . ; W !,"DATA 1 IS ",DATA1
 . . ;
 . . S DATA2=$G(^PRC(411,+(V3),0))  ; Data for Station ID#
 . . S PRC("PARAM")=DATA2  ; parameters for Station ID
 . . S PRC("SITE")=V3  ; station id#
 . . S PRC("MDIV")=""  ; multi division , add lookup/check here
 . . S PRC("PER")=""  ; normally DUZ, may not be needed
 . . S PRC("FY")="06"
 . . S PRC("QTR")="01"  ; add lookup/check here
 . . ; W !," PRC(PARAM) IS ",PRC("PARAM")
 . . ; THE WRITE STATEMENTS ABOVE WILL BE REPLACED WITH
 . . ; THE SETTING OF PRCP() AND PRC() VALUES
 . . ; *83 add code here from Days of Stock on hand logic
 . . ; if Item Inventory does not contain any items for
 . . ; an inventory point, quit here. Get next Inv. point
 . . ; N ITMDAK
 . . ; S ITMDAK=$G(^PRCP(445,+PRCP("I"),1,0))  ;at least 1 item?
 . . ; Q:'ITMDAK  ; quit if no item exists, go to next Inv. Pt.
 . . I CLRSFLAG="SS" D EN1^PRCPLO2  ; Do stock status report
 . . I CLRSFLAG="SOH" D EN1^PRCPLO  ; Do days of stock on hand rpt.
 . . Q
 . Q
 Q
 ;
 ;
DOIT1 ; ADDED label here
 N %,C,DISYS,I,J,PRCF,PRCPFLAG,X,Y
 I +$G(DUZ)<1 W !,"YOU ARE NOT SETUP AS A USER!" K PRC,PRCP Q
 ;
 S %=0 F I="FY","PARAM","PER","QTR","SITE" I '+$G(PRC(I)) S %=1 Q
 ; I % S PRCF("X")="S" D ^PRCFSITE I '+$G(PRC("SITE")) K PRC,PRCP Q
 ;
DOSITE ; Set up PRC array from PRCFSITE
 S PRC("MDIV")=""  ; multi division (need to check for this)
 S PRC("FY")="06"  ; NEED TO make this calculation
 S PRC("PARAM")=$G(^PRC(411,V2,0))  ; get params for inv pt
 S PRC("PER")=DUZ  ; may not be needed
 S PRC("QTR")="01"  ; NEED TO make this calcuation
 S PRC("SITE")=V2
 Q
 ;
DOSITEP ; Set up PRCP array from DISPLAY^PRCPLO1
 S %=0 F I="DPTYPE","HIS","I","IN","INV" I '$D(PRCP(I)) S %=1 Q
 ; I '% D DISPLAY Q
 ;
 D PARAM(+V2)
 Q
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
PARAM(INVPT)       ;  set up parameters for inventory point
 K PRCP
 N DATA,PRCPEX
 S DATA=$G(^PRCP(445,INVPT,0)) I DATA="" Q
 ; *83 new code, need to $TR PRCP("IN", convert "*" to "|"
 ;S PRCP("I")=INVPT,PRCP("INV")=(DATA,"^",2),PRCP("HIS")=$P(DATA,"^",6),PRCP("DPTYPE")=$P(DATA,"^",3)
 ;S PRCPEX=$P($P(DATA,"^"),"-",2,99)
 ;S PRCPEX=$TR(PRCPEX,"*","&")  ; Change "*" to "|"
 ;S PRCP("IN")=PRCPEX
 ; *83 (old code below)
 S PRCP("I")=INVPT,PRCP("IN")=$P($P(DATA,"^"),"-",2,99),PRCP("INV")=$P(DATA,"^",2),PRCP("HIS")=$P(DATA,"^",6),PRCP("DPTYPE")=$P(DATA,"^",3)
 ; D TERM  ;commented out for CLRS
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
