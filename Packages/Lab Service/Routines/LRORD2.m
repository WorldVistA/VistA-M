LRORD2 ;SLC/CJS - MORE OF LAZY ACCESSION LOGGING ;8/11/97
 ;;5.2;LAB SERVICE;**121,153**;Sep 27, 1994
MORE ;get more tests, from LRORD1
LRM F LRSSX=LRM:1 D Q15,^DIC Q:Y<1  S LRWPC=LRWPC+1,LRTSTS=+Y,LRTX(LRTSTS)="",LRURGG=$P(Y(0),U,18) D ENQ K DIC("S") D GS^LRORD3 I LRSAMP>0&(LRSPEC>0) D Q20 S:'LREND LRM=LRM+1 I LREND K LRSAME Q
 K LRSAME Q
ENQ Q:$D(LRLABKY)  S DIC="^LAB(60,",DA=LRTSTS,DR=6 D EN^DIQ Q
Q15 ;from LRORD
 S DIC("S")="I $P(^(0),U,4)'="""""_$S('$D(LRLABKY):",""NO""'[$P(^(0),U,3)",'$P(LRLABKY,U,3):",""N""'[$P(^(0),U,3)",1:"") S:LRORDR="LC"!(LRORDR="I") DIC("S")=DIC("S")_",$P(^(0),U,9)"
 S:$G(LRORDRR)="R" DIC("S")=DIC("S")_",$G(^LAB(60,Y,64))"
 S DIC="^LAB(60,",DIC(0)="AEMOQZ"
 Q
Q20 ;
 S LREND=0,Z=0 F  S Z=$O(LROT(LRSAMP,LRSPEC,Z)) Q:Z<1  I +LROT(LRSAMP,LRSPEC,Z)=LRTSTS W !!?20," ~ ",$P(^LAB(60,LRTSTS,0),U),"   ",$S($D(^LAB(62,LRSAMP,0)):$P(^(0),U),1:""),"   ",$S($D(^LAB(61,LRSPEC,0)):$P(^(0),U),1:"")," ~" D DUP^LRORD2 H 2
 Q:LREND
 S LROT(LRSAMP,LRSPEC,LRSSX)=LRTSTS,LREXP=$S($P($G(^LAB(60,LRTSTS,3,+$O(^LAB(60,LRTSTS,3,"B",+LRSAMP,0)),0)),U,6):$P(^(0),U,6),$P(^LAB(60,LRTSTS,0),U,19):$P(^(0),U,19),1:0)
 I '$D(LRLABKY) S DIC="WARD REMARKS: " S DR=0 F  S DR=$O(^LAB(60,LRTSTS,3,+LRSAMP,1,DR)) Q:DR'>0  W !,"  ",DIC,^(DR,0) S DIC=""
 S:LREXP LROT(LRSAMP,LRSPEC,LRSSX,2)=LREXP S DIC("B")=LROUTINE D URG
 Q
% R %:DTIME Q:%=""!(%["N")!(%["Y")  W !,"Answer 'Y' or 'N': " G %
 W !,"For ",$P(^TMP("LRSTIK",$J,LRSSX),U,2)
URG ;from LRMIBL, LRORD1, LRWU1
 S H=+$P(^LAB(60,+LRTSTS,0),U,16),H(0)=$P(^(0),U,18) I $D(LRURGG),LRURGG'<H S X=LRURGG K LRURGG G URG1
 S:'$D(LROUTINE) LROUTINE=+$P($G(^LAB(69.9,1,3)),U,2)
 K DIC S DIC("A")="Select Urgency Status: ",DIC("S")="I '$P(^(0),U,3)",DIC="^LAB(62.05,",DIC(0)="AEQ" S DIC("B")=$S(LRORDR="WC":H(0),1:LROUTINE)
 S DIC("S")="I '$P(^(0),U,3),Y'<"_H S:LRORDR="LC" DIC("S")=DIC("S")_" I $P(^(0),U,2)" D ^DIC S:Y>0 X=+Y S:Y<1 X=9
URG1 K DIC,H S LROT(LRSAMP,LRSPEC,LRSSX,1)=X Q
RCOM ;from LRORDST, LROW1
 S LRCCOM="" S:'$D(LREXP) LREXP=0 S:'$D(LRTSTNM) LRTSTNM="" ;ASK REQUIRED COMENT
 I LREXP,$L(^LAB(62.07,LREXP,.1)) X ^(.1) Q:$G(LRKIL)  W:$E(LRCCOM)="?"&$D(^LAB(62.07,LREXP,.2)) ^(.2) G RCOM:$E(LRCCOM)="?"
 I 'LREXP R !,"Enter Order Comment: ",LRCCOM:DTIME
RC1 G ZQ:LRCCOM="?"!(LRCCOM="??"),Z3:LRCCOM=""!(LRCCOM="^") I LRCCOM["^"!(LRCCOM[";") W !,"No up-arrows or semicolons allowed." G ZQ
Z0 G ZQ:$L(LRCCOM)>67!($L(LRCCOM)<1)!(LRCCOM'?.ANP) S B3="~",LRPCE=$S($E(LRCCOM,1)="~":$E(LRCCOM,1),1:""),LRCCOM=$S($L(LRPCE):$E(LRCCOM,2,999),1:LRCCOM) D Z1 W "  (",$E(B3,1,$L(B3)-1),")" S LRCCOM=B3 K A4,B3,B6
Z3 Q:$D(LRQ)
 S:LRCCOM["^" LRCCOM="" I $L(LRCCOM) S %=1 W !,"  OK" D YN^DICN I %'=1 S:%=-1 LRCCOM="" G RCOM:%=2 I %=0 W !,"Unless special comments are required, this comment will be associated with",!,"all tests requested for this entry." G Z3
 I $D(LRTEST(+$G(LRTSTN))) D TCOM(+LRTEST(LRTSTN),LRCCOM)
RCS ;from LREXECU, LRORDST, LROW2
 Q
Z1 F V=1:1 Q:$P(LRCCOM," ",V,99)=""  S B6=$P(LRCCOM," ",V),Y="" D:B6]"" Z2 S A4=$L(B3)+$L(B6) S:A4'>68 B3=B3_B6_" " I A4>68 W "  too long",! Q
 S LRCCOM=$S('$L(LRPCE):LRCCOM,1:LRPCE_LRCCOM) K LRPCE Q
 Q
Z2 S Y=0 F  S Y=$O(^LAB(62.5,"B",B6,Y)) Q:Y=""  I "KA"[$P(^LAB(62.5,Y,0),U,4) S B6=$P(^LAB(62.5,Y,0),"^",2) Q:'$D(^(9))  S Y=$P(X," ",I-1),Y=$E(Y,$L(Y)) S:Y>1 B6=^(9) Q
 Q
ZQ S X=$S(LRCCOM="??":"??",1:"?"),(DIE,DIC)="^LAB(62.5,",DIC(0)="Q",DIC("S")="I ""KA""[$P(^(0),U,4)",D="B",DZ=X K DO D DQ^DICQ K DIC S DIC=DIE D DO^DIC1
 G RCOM
GCOM ;from LRORD1, LRPHITEM, LRTSTJAN, LRWU1
 S LREXP=0 D RCOM S LRGCOM=LRCCOM Q
DUP ;from LRORDD
 I LRTSTS=+LROT(LRSAMP,LRSPEC,Z) W !,"Since this test, collection sample, and site/specimen has already",!,"been requested on this order, it will NOT be duplicated.",$C(7),!,"If you really need a duplicate, place a separate order." S LREND=1
 Q
TCOM(TEST,COM) ;Get comments by test
 N X
 Q:'$G(TEST)  Q:'$L($GET(COM))
 S X=1+$S($D(LRTCOM(TEST)):LRTCOM(TEST),1:0),LRTCOM(TEST)=X,LRTCOM(TEST,X)="~For Test: "_$P(^LAB(60,TEST,0),"^")
 S X=X+1,LRTCOM(TEST)=X,LRTCOM(TEST,X)=COM
 Q
