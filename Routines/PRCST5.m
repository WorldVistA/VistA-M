PRCST5 ; GENERATED FROM 'PRCS APPROVE REQUEST' PRINT TEMPLATE (#299) ; 11/15/05 ; (FILE 410, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 I Y W $P("JAN^FEB^MAR^APR^MAY^JUN^JUL^AUG^SEP^OCT^NOV^DEC",U,$E(Y,4,5))_" " W:Y#100 $J(Y#100\1,2)_"," W Y\10000+1700 W:Y#1 "  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12) Q
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(299,"DXS")
 S I(0)="^PRCS(410,",J(0)=410
 D N:$X>0 Q:'DN  W ?0 W "CP TRANSACTION NUMBER: "
 S X=$G(^PRCS(410,D0,0)) W ?25,$E($P(X,U,1),1,18)
 W ?45 S X=$S('$D(D0):"",D0<0:"",1:D0),DIP(1)=$G(X) S X="IEN",X1=DIP(1) S:X]""&(X?.ANP)&(X1'[U)&(X1'["$C(94)") DIPA($E(X,1,30))=X1 S X="" K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "TEMPORARY TRANSACTION: "
 W ?25 S DIP(1)=$S($D(^PRCS(410,D0,0)):^(0),1:"") S X=$P(DIP(1),U,3),DIP(2)=$G(X) S X=1,DIP(3)=$G(X) S X=10,X=$E(DIP(2),DIP(3),X) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "TRANSACTION TYPE: "
 S X=$G(^PRCS(410,D0,0)) W ?20 S Y=$P(X,U,2) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "FORM TYPE: "
 W ?13 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^PRCS(410.5,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "REQUESTOR: "
 S X=$G(^PRCS(410,D0,7)) W ?13 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,35)
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "DATE OF REQUEST: "
 S X=$G(^PRCS(410,D0,1)) W ?19 S Y=$P(X,U,1) D DT
 D N:$X>0 Q:'DN  W ?0 W "DATE REQUIRED: "
 W ?17 S Y=$P(X,U,4) D DT
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "COMMITTED (ESTIMATED) COST: "
 S X=$G(^PRCS(410,D0,4)) W ?30 S Y=$P(X,U,1) W:Y]"" $J(Y,11,2)
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "VENDOR: "
 S X=$G(^PRCS(410,D0,2)) W ?10,$E($P(X,U,1),1,30)
 D N:$X>0 Q:'DN  W ?0 W " "
 D N:$X>0 Q:'DN  W ?0 W "ITEM #1 DESCRIPTION:  "
 S PRCST5X=$$GET1^DIQ(410.02,"1,"_DIPA("IEN")_",",1,"","PRCTXT","PRCERR") K DIP K:DN Y
 W $S($D(PRCTXT(1)):$E(PRCTXT(1),1,30),1:"Item Description not available") K DIP K:DN Y
 W ?0 K PRCST5X,PRCTXT,DIERR,PRCERR K DIP K:DN Y
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
