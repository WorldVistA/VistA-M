PRCHNPO5 ;WISC/RSD,RHD/DL-INPUT TRANSFORM FOR FILE 440,441,442 ;11/23/16  13:36
V ;;5.1;IFCAP;**113,159,198**;Oct 20, 2000;Build 6
 ;Per VA Directive 6402, this routine should not be modified.
 ;
EN1 ;FILE 442, FCP #1
 I '$D(PRCHAMND),$D(^PRCS(410,+$P(^PRC(442,DA,0),U,12),0)),+$P(^(0),"-",4)'=+X W !,"Fund Control Point cannot be changed since 2237 has been selected." K X Q
 S Z0=$E($P(^PRC(442,DA,0),"-",2),1,2),Z1=+X D EN4^PRCHNPO6 I '$T K X,Z0,Z1 Q
 S DIC="^PRC(420,PRC(""SITE""),1,",DIC(0)="QEMNZ"
 S:$D(PRCHPUSH) DIC("S")="I $P(^(0),U,12)=2"
 I $G(PRCHPC)!$G(PRCHDELV) S DIC("S")="I $D(^PRC(420,""C"",DUZ,PRC(""SITE""),+Y))"
 S D="B^C" D MIX^DIC1 K:Y<0!('$D(PRC("FY"))) X K DIC,PRCHCPO,Z0,Z1 Q:'$D(X)
 N CCNODE S CCNODE=$G(^PRC(420,PRC("SITE"),1,+Y,2,0)) I $P(CCNODE,U,4)'>0!(CCNODE="") W !,"The Fund Control Point selected by you, does not have any",!,"Cost Centers listed under it.",!,$P(Y,U,2) K X Q
 I $P(Y(0),U,12)'=2,$P(Y(0),U,18)="" W $C(7),!,"LOG Department Number is missing!!" K X Q
 S Z0=$P(^PRC(442,DA,0),U,2),Z1=$P(Y(0),U,12) I Z1 I ((Z0=3)&(Z1=3)) S Z0=$P(^PRCD(442.5,Z0,0),U,1) W $C(7),!,"Fund Control Point not valid for a "_Z0_" order." K Z0,Z1,X Q
 S Z0=$P(Y(0),U,1),PRC("FY")=$E(100+$E(PRC("FY"),2,3)+$E(PRC("FY"),4),2,3) S:$P(Y(0),U,10)]"" PRCHN("SVC")=$P($G(^DIC(49,+$P(Y(0),U,10),0)),U,1)
 I $D(^PRC(420,PRC("SITE"),1,+Y,2,0)),$P(^(0),U,4)=1,$D(^($P(^(0),U,3),0)),$D(^PRCD(420.1,+^(0),0)) S PRCHN("CC")=$P(^(0)," ",1)
 S PRC("APP")="",X=Z0,PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),+X) I PRC("BBFY")="" Q
 S PRC("APP")=$P($$ACC^PRC0C(PRC("SITE"),+X_"^"_PRC("FY")_"^"_PRC("BBFY")),U,11) K Z0,Z1
 I $P($G(^PRC(420,PRC("SITE"),1,+X,0)),U,19)=1 W !,"Sorry, this FCP is inactive!",! K X Q
 Q
 ;
EN2 ;FILE 442, COST CENTER #2
 S PRCFA("ALL")=1,DIC="^PRCD(420.1,",DIC(0)="QEMZ" D ^DIC K DIC,PRCFA("ALL") I Y'>0 W !,"The Cost Center entered by you is not in the COST CENTER FILE.",! K X,Y,Z0 Q
 I $P(Y(0),U,2)=1 W !,"The Cost Center entered by you has been DEACTIVATED.",! K X,Y,Z0 Q
 S X=+Y(0)
 S Z1=$G(^PRC(420,PRC("SITE"),1,Z0,2,+Y(0),0)) I Z1'>0!(Z1="") W !,"This Cost Center isn't found in FCP "_$P(^PRC(420,PRC("SITE"),1,Z0,0),U,1)_".",! K X,Y,Z0,Z1 Q
 N BOCNOD S BOCNOD=$G(^PRCD(420.1,+Y,1,0)) I $P(BOCNOD,U,4)'>0!(BOCNOD="") W !,"The Cost Center selected by you, does not have any BOCs listed",!,"under it.",! K X
 K Y,Z0,Z1 Q
 ;
EN3 ;FILE 442, VENDOR #5
 N REP,REP1
 I DIE["PRC(442,",$D(DA),$D(^PRC(442,DA,2,"AE")) K X
 Q:'$D(X)!$G(PRCHPC)
 I '$G(PRCHDELV) D  Q:'$G(X)
 . S DIC("S")="S Z0=+$P($G(^(2)),U,2) I "_$E("'",'$D(PRCHNRQ))_"Z0,'$D(^PRC(440,""AC"",""S"",Y))" I $D(PRCHPUSH) S DIC("S")=DIC("S")_",(Z0=1!(Z0=3))"
 . D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X Q:'$D(X)  S PRCHNVF=Y
 Q:'$D(^PRC(440,X,2))  S Z0=^(2) I $P(^PRC(442,DA,0),U,2)=4,$P(Z0,U,11)'="Y" W $C(7),!,"This Vendor is not set up as a GUARANTEED DELIVERY Vendor!." K X,Z0 Q
 ;
 ; SEE IF VENDOR IS INACTIVE.
 ;
 I $P($G(^PRC(440,X,10)),U,5)=1 K X Q
 ;
 ;
 ;
 K PRCHEDI I $P($G(^PRC(440,X,3)),U,2)="Y" S PRCHEDI="" ;CHECK FOR EDI VENDOR
 I $D(^PRCD(420.8,+$P(Z0,U,2),0)) S PRCHN("SC")=$P(^(0),U,1)
 K Z0
 Q
 ;
EN4 ;FILE 442, EST. SHIPPING AND/OR HANDLING #13
 S %A="   FOB is Destination, Are you sure you want Handling Charges ",%B="",%=1 D ^PRCFYN I %'=1 K X W !?3,"<DELETED>",$C(7)
 Q
 ;
EN5 ;FILE 442, REPETITIVE (PR CARD) NO. #1.5
 I $P(^PRC(442,DA(1),0),U,3)=""!($P(^(1),U,1)="") W !!,"Fund Control Point and Vendor must be entered before items !",$C(7) K X Q
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0) D LCK^PRCHCRD
 Q
 ;
EN6 ;FILE 442, UNIT OF PURCHASE #3
 D VEN Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=$P($P(^PRC(442,DA(1),0),U,1),"-",1) S PRCHCV=$P(^PRC(442,DA(1),1),U,1),PRCHCI=$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN0^PRCHCRD
 Q
 ;
EN8 ;FILE 442, CONTRACT FIELD #4
 D VEN Q:'$D(X)  K DIC("S")
 S Z0=$P(^PRC(442,DA(1),1),U,1),ZA=DA,ZA(1)=DA(1)
 S DA(1)=Z0,DIC="^PRC(440,Z0,4,",DIC(0)="QELMZ",DLAYGO=440
 I $G(PRCHPC)!$G(PRCHDELV) S DIC(0)="QEMZ"
 D EN10,^DIC S X=$P(Y,U,2),DA=ZA,DA(1)=ZA(1) K ZA K:Y'>0 X
 I $D(X),$D(DT),$P(Y(0),U,2)-DT<0 W !?10,"**CONTRACT HAS EXPIRED**",$C(7),$C(7) K X,DLAYGO Q
 S:'$D(PRC("SITE")) PRC("SITE")=$P($P(^PRC(442,DA(1),0),U,1),"-",1) I $P(^PRC(442,DA(1),2,DA,0),U,5)]"" S PRCHCI=$P(^(0),U,5),PRCHCV=Z0,PRCHCPO=DA(1) D EN2^PRCHCRD
 K DLAYGO
 Q
 ;
EN9 ;FILE 442, ACTUAL UNIT COST #5
 D VEN Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=$P($P(^PRC(442,DA(1),0),U,1),"-",1) S PRCHCV=$P(^PRC(442,DA(1),1),U,1),PRCHCI=$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN1^PRCHCRD
 Q
 ;
EN10 ;FILE 440 CONTRACT NUMBER
 I $D(Z0) S:'$D(^PRC(440,Z0,4,0)) ^PRC(440,Z0,4,0)="^440.03I^^"
 Q
 ;
EN11 ;FILE 441 CONTRACT
 D EN10 S DIC="^PRC(440,Z0,4,",DIC(0)="QEMLZ",DLAYGO=440,ZD=DA(1),DA(1)=Z0 D ^DIC S X=+Y K:Y'>0 X S DA(1)=ZD K ZD,Z0,DIC
 I $D(X),$D(DT),$P(Y(0),U,2)-DT<0 D EN^DDIOL("**CONTRACT HAS EXPIRED**","","!?10") K X
 K DLAYGO
 Q
 ;
EN12 ;FILE 442, VENDOR STOCK NO.#9
 D VEN Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=+^PRC(442,DA(1),0) S PRCHCV=+$P(^PRC(442,DA(1),1),U,1),PRCHCI=+$P(^(2,DA,0),U,5),PRCHCPO=DA(1) D EN6^PRCHCRD
 Q
 ;
EN13 ;DIC("S") for a look-up in CONTRACT field (File 442.01,4)
 S PRCHSCOD=$P($G(^PRC(442,D0,1)),U,7)
 I $E(X)="?" S DIC("S")=$S(PRCHSCOD=2:"I $P(^PRC(440,Z0,4,+Y,0),U,6)'=""B""",1:"I 1")
 Q
 ;
EN14 ;input transform of Contract Flag field 5, file 440
 ;If PO exists, if source code=2 & contract flag is not 'C' set it 'C'
 I $G(PRCHPO)>0 D
 . S PRCHNOD1=$G(^PRC(442,PRCHPO,1))
 . S PRCHSOCO=$P(PRCHNOD1,U,7)
 . I PRCHSOCO=2 Q:X="C"  D  Q
 . . S X="C"
 . . S ARR(1)=""
 . . S ARR(2)="     Note: "
 . . S ARR(3)="     This PO's Source Code is Open Market, only Contract # is a valid entry."
 . . S ARR(4)="     'C' has been entered for the Contract Flag prompt."
 . . S ARR(5)="     'B' is not allowed, system allows only 'C'."
 . . S ARR(6)=""
 . . D EN^DDIOL(.ARR)
 . . S XQH="PRCH CONTRACT FLAG HELP" D:$E(X)="??" EN^XQH
 . . Q
 . Q 
 ; If Source code is not equal to 2, C or B is ok for contr. flag 
 S MSG(1)=""
 S MSG(2)="Enter 'C' if the Contract Number field is a Contract #."
 S MSG(2,"F")="!,?5"
 S MSG(3)="Otherwise enter 'B' if it is a Basic Ordering Agreement(BOA) #."
 S MSG(3,"F")="!,?5"
 S MSG(4)=""
 ;I PRCHSOCO'=2 D EN^DDIOL(.MSG) H 2
 ;any other route than via po
 I X="B" D
 . S Z=$P(^PRC(440,DA(1),4,DA,0),U)
 . K:'(Z?.UN) X
 . I '$D(X) S XQH="PRCH BOA" D EN^XQH
 . K Z,XQH
 . Q
 Q
 ;
VEN I $S('$D(^PRC(442,DA(1),1)):1,$P(^(1),U,1)="":1,1:0) W !!,"Vendor must be entered before items ! ",$C(7) K X
 Q
 ;
ODATE ;PRC*5.1*159 'old date' handler call for P.O. Date exception in input template [PRCH DETAILED PURCHASE CARD]
 K ^PRC(442,"AB",+$P(^PRC(442,DA,1),U,15),DA)
 S $P(^PRC(442,DA,1),U,15)=""
 Q
