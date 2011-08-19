PRCHNPO6 ;WISC/RHD-MISCELLANEOUS ROUTINES FROM P.O.ADD/EDIT 442 ;6/22/94  3:19 PM
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN1 ;INPUT TRANSFORM FOR FILE 442, P.O.DATE #.1
 Q:'$D(^PRC(442,DA,0))  Q:'$P(^(0),U,3)  S PRCHSAVX=X,PRC("FY")=X S:'$D(PRC("SITE")) PRC("SITE")=+^(0) S X=$P(^(0),U,3)
 D EN1^PRCHNPO5 S:$D(X) $P(^PRC(442,DA,0),U,4)=PRC("APP")
 S X=PRCHSAVX K PRCHSAVX
 Q
 ;
EN2 ;SCREEN--P.O.#['X' (FRESH FOOD) OR 'Z' (CASCA)--INVOICE ADDRESS="FISCAL", P.O.#['C' (CERT.INV.)--MOP='CERT.INV.', INV.ADDR.="FISCAL", IMPREST FUNDS--INV.ADDR.="".
 S Z1=$E($P(^PRC(442,DA,0),"-",2),1,2),PRCHN("INV")="FMS",Z2=+$P(^(0),U,2) I $D(^PRCD(442.5,Z2,0)) S PRCHN("MP")=$P(^(0),U,3) I PRCHN("MP")=12 S Z1="IF",PRCHN("INV")="" G EN20
 I (Z1["X")!(Z1["Z") S PRCHN("INV")="FISCAL" K Z1,Z2 Q
 I Z1'["C" K Z1,Z2 Q
 S PRCHN("MP")=2,$P(^PRC(442,DA,0),U,2)=2,^PRC(442,"F",2,DA)="",Z2=2,PRCHN("INV")="FISCAL"
EN20 W !,"Method of Processing="_$P(^PRCD(442.5,Z2,0),U,1) K Z1,Z2
 Q
 ;
EN3 ;SCREEN FCP--CALLED FROM PRCHNPO3
 G:'$D(PRCHPO) FALSE S Z0=$E($P(^PRC(442,PRCHPO,0),"-",2),1,2),Z1=+$P(^PRCS(410,Y,0),"-",4)
 ;
EN4 ;SCREEN FCP FOR SPECIAL P.O.NUMBERS--Z0=1ST 2 DIGITS OF P.O.NO.,Z1=FCP
 G:(Z0["H")&('$D(^PRC(420,"AD",1,PRC("SITE"),Z1))) FALSE
 I Z0["G",$D(^PRC(411,+PRC("SITE"),0)),$D(^PRC(411.2,+$P(^(0),U,7),0)),"^DEPOT^VACO^DDC^"[("^"_$P(^(0),U,1)_"^") G TRUE
 G:(Z0["G")&('$D(^PRC(420,"AD",2,PRC("SITE"),Z1)))&('$D(^PRC(420,"AD",3,PRC("SITE"),Z1)))&('$D(^PRC(420,"AD",4,PRC("SITE"),Z1))) FALSE
 G:(Z0["Z")&('$D(^PRC(420,"AD",3,PRC("SITE"),Z1)))&('$D(^PRC(420,"AD",4,PRC("SITE"),Z1))) FALSE
 I $G(PRCHPC)!$G(PRCHDELV) I '$D(^PRC(420,"C",DUZ,PRC("SITE"),Z1)) G FALSE
 ;
TRUE I 1 Q
 ;
FALSE I 0
 Q
 ;
EN5 ;FILE #442, FIELD #1 (FCP) ONLINE HELP
 S Z1=Y D EN4 ;S FLAG=1
 Q
 ;
EST ;Find Line Item # for Field #13.1
 S N="" F PRCHESTA=1:1 S N=$O(^PRC(442,PRCHPO,2,"B",N)) Q:'N
 S N=0 F PRCHDIS=1:1 S N=$O(^PRC(442,PRCHPO,3,N)) Q:'N
 S PRCHDIS=PRCHDIS+PRCHESTA-1,$P(^PRC(442,PRCHPO,0),U,18)=PRCHDIS,$P(^(0),U,14)=PRCHDIS
 K N,PRCHESTA,PRCHDIS
 Q
 ;
EN7 ;FILE 442, PKG.MULT. #3.1
 D VEN^PRCHNPO5 Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0) S PRCHCV=+$P(^PRC(442,DA(1),1),U,1),PRCHCI=+$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN7^PRCHCRD1
 Q
 ;
EN8 ;FILE 442, P.O.NO. .01  CALLED BY THE SCREEN ON THE .01 FIELD
 Q:'$D(X)  Q:$D(PRCHNEW)&$D(^PRC(442,"B",X))
 L +^PRC(442,0):5 I '$T W $C(7),"ANOTHER USER IS EDITING SOME FILE 442 ENTRY! Please retry in a minute." K X Q
 S Z=$P(^PRC(442,0),"^",3)-1 S:Z<1 Z=100000000 F Z=Z-1:-1 I '$D(^PRC(442,Z)) L +^PRC(442,Z):0 Q:$T
 L -^PRC(442,0) I Z'>0 K X L -^PRC(442,Z)
 E  S DINUM=Z
 K Z
 Q
 ;
EN9 ;FILE 442, MAX.ORD.QTY.#9.6
 D VEN^PRCHNPO5 Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0) S PRCHCV=+$P(^PRC(442,DA(1),1),U,1),PRCHCI=+$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN9^PRCHCRD1
 Q
 ;
 ; ER-ER3 ARE CALLED FROM PRCHNPO1
ER W !," ** Error in Discount ",PRCH,", item ",PRCHN," has a unit cost of zero ",$C(7) S PRCHER=""
 Q
 ;
ER1 W !," ** Error in Discount ",PRCH,", item ",PRCHN," has been changed. Discount will be deleted",!?4,"and must be re-edited!",$C(7) S PRCHER="",DR="14///^S X=PRCH",DR(2,442.03)=".01///@" D ^DIE K DR
 Q
 ;
ER2 W !," Type Code is undefined.",$C(7) K PRCHPO
 Q
 ;
ER3 W !,$S('PRCHDT:"Breakout Code is undefined.",1:"Socioeconomic Group (FY89) not defined in Vendor file."),$C(7) K PRCHPO
 Q
 ;
SPRMK ;FORMAT & DISPLAY REMARKS FROM REQUEST TO PO
 Q:'$D(^PRCS(410,PRCHSY,"RM"))  K ^UTILITY($J,"W")
 W !,"2237 Special Remarks: " S U="^",PRCHZZ=0,DIWL=1,DIWR=78,DIWF="W"
 F PRCHJJ=0:0 S PRCHZZ=$O(^PRCS(410,PRCHSY,"RM",PRCHZZ)) Q:'PRCHZZ  I $D(^(PRCHZZ,0)) S X=^(0) D DIWP^PRCUTL($G(DA)),^DIWW
 ;
SP1 K PRCHJJ W !,"Would you like to transfer the Special Remarks to the New P.O. Comments" S %=1 D YN^DICN
 I %=0 W !,"Enter 'Y' to have the Special Remarks added to the end of the P.O. Comments.",! G SP1
 G END:%'=1 S:'$D(^PRC(442,D0,4,0)) ^(0)="^^0^0^"_DT S PRCHNN=$P(^(0),U,3),PRCHX=0
 F I=0:0 S PRCHX=$O(^PRCS(410,PRCHSY,"RM",PRCHX)) Q:'PRCHX  I $D(^(PRCHX,0)) S PRCHNN=PRCHNN+1,^PRC(442,D0,4,PRCHNN,0)=^(0)
 S ^PRC(442,D0,4,0)="^^"_PRCHNN_U_PRCHNN_U_DT
 ;
END K PRCHNN,PRCHX,PRCHZZ,DIWL,DIWR,DISF,I,%
 Q
