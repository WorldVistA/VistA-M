PRCHNPO8 ;WISC/RHD/DL-MISCELLANEOUS ROUTINES FROM P.O.ADD/EDIT 443.6 ;9/5/00  12:30
V ;;5.1;IFCAP;**113**;Oct 20, 2000;Build 4
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN1 ;FILE 443.6, FCP #1
 N Y
 S Z0=$E($P(^PRC(443.6,DA,0),"-",2),1,2),Z1=+X D EN4^PRCHNPO6 I '$T K X,Z0,Z1 Q
 S DIC="^PRC(420,PRC(""SITE""),1,",DIC(0)="QEMNZ",D="B^C" D MIX^DIC1 K:Y<0!('$D(PRC("FY"))) X K DIC,Z0,Z1 Q:'$D(X)
 N CCNODE S CCNODE=$G(^PRC(420,PRC("SITE"),1,+Y,2,0)) I $P(CCNODE,U,4)'>0!(CCNODE="") W !,"The Fund Control Point selected by you, does not have any",!,"Cost Centers listed under it.",! K X Q
 I $P(Y(0),U,12)'=2,$P(Y(0),U,18)="" W $C(7),!,"LOG Department Number is missing!!" K X Q
 S Z0=$P(^PRC(443.6,DA,0),U,2),Z1=$P(Y(0),U,12) I Z1 I Z0=4!((Z0=3)&(Z1=3)) S Z0=$P(^PRCD(442.5,Z0,0),U,1) W $C(7),!,"Fund Control Point not valid for a "_Z0_" order." K Z0,Z1,X Q
 S Z0=$P(Y(0),U,1) S:$P(Y(0),U,10)]"" PRCHN("SVC")=$P($G(^DIC(49,+$P(Y(0),U,10),0)),U,1)
 S PRC("FY")=$E(100+$E(PRC("FY"),2,3)+$E(PRC("FY"),4),2,3)
 I $D(^PRC(420,PRC("SITE"),1,+Y,2,0)),$P(^(0),U,4)=1,$D(^($P(^(0),U,3),0)),$D(^PRCD(420.1,+^(0),0)) S PRCHN("CC")=$P(^(0)," ",1)
 S PRC("APP")="",X=Z0,PRC("BBFY")=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),+X) I PRC("BBFY")="" Q
 S PRC("APP")=$P($$ACC^PRC0C(PRC("SITE"),+X_"^"_PRC("FY")_"^"_PRC("BBFY")),U,11) K Z0,Z1
 I $P($G(^PRC(420,PRC("SITE"),1,+X,0)),U,19)=1 W !,"Sorry, this FCP is inactive!",! K X Q
 Q
 ;
EN2 ;UPDATE BOC #3.5
 D VEN^PRCHNPO7 Q:'$D(X)!($P(^PRC(442,DA(1),2,DA,0),U,5)="")
 S:'$D(PRC("SITE")) PRC("SITE")=$P($P(^PRC(442,DA(1),0),U,1),"-",1)
 S PRCHCV=$P(^PRC(442,DA(1),1),U),PRCHCI=$P(^(2,DA,0),U,5)
 D EN13^PRCHCRD1
 Q
 ;
BBFY(PO) ;BEGINING BUDGET FISCAL YEAR CHECK/UPDATE
 ;  ENTERED:
 ;  PO = FILE 442 INTERNAL RECORD NUMBER
 ;
 ;  RETURNED:
 ;  PRC("BBFY") = FOUR DIGIT YEAR (1995)
 ;
 ;  PO IS UNCHANGED BY THIS CALL
 ;
 N BBFY,N0,N1,FY,P2237,SFCP,DIE,DA,DR,X,FLAG
 S N0=$G(^PRC(442,PO,0)),N1=$G(^PRC(442,PO,1))
 S FY=$P(N1,U,15),FY=$E(100+$E(FY,2,3)+$E(FY,4),2,3)
 S FLAG="",P2237=$P(N0,U,12) I P2237>0 D  G:FLAG=1 T1
 .S FY=$$NP^PRC0B("^PRCS(410,"_P2237_",",3,11)
 .I FY?2N S FY=1700+$E(FY,1,3),PRC("BBFY")=FY,FLAG=1 Q
 .S FY=$$NP^PRC0B("^PRCS(410,"_P2237_",",0,1)
 .S FY=$P(FY,"-",2)
 .Q
 S FY=$$BBFY^PRCSUT(+N0,FY,+$P(N0,U,3),1)
T1 S SFCP=$P(N0,U,19) I SFCP=1!(SFCP=2) S (PRC("BBFY"),FY)=1994
 I FY?2N S DIE="^PRC(442,",DA=PO,DR="26///^S X=FY" D ^DIE
 Q
