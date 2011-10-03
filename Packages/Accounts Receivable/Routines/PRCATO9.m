PRCATO9 ; GENERATED FROM 'PRCAP DEBTOR LOCATE' PRINT TEMPLATE (#401) ; 06/27/96 ; (FILE 430, MARGIN=80)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(401,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 D N:$X>0 Q:'DN  W ?0 W "BILL NO.: "
 S X=$G(^PRCA(430,D0,0)) D N:$X>11 Q:'DN  W ?11,$E($P(X,U,1),1,15)
 D N:$X>39 Q:'DN  W ?39 W "DEBTOR: "
 D N:$X>49 Q:'DN  W ?49 S Y=$P(X,U,9) S C=$P(^DD(430,9,0),U,2) D Y^DIQ:Y S C="," W $E(Y,1,25)
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 W "ABLE TO PAY:"
 S X=$G(^PRCA(430,D0,8)) D N:$X>13 Q:'DN  W ?13 S Y=$P(X,U,6) W:Y]"" $S($D(DXS(1,Y)):DXS(1,Y),1:Y)
 D N:$X>24 Q:'DN  W ?24 W "ABLE TO LOCATE:"
 D N:$X>41 Q:'DN  W ?41 S Y=$P(X,U,7) W:Y]"" $S($D(DXS(2,Y)):DXS(2,Y),1:Y)
 D N:$X>49 Q:'DN  W ?49 W "DMV LOCA. CHECK:"
 D N:$X>67 Q:'DN  W ?67 S Y=$P(X,U,18) W:Y]"" $S($D(DXS(3,Y)):DXS(3,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "POSTAL LOC. DATE SENT:"
 D N:$X>23 Q:'DN  W ?23 S Y=$P(X,U,8) D DT
 D N:$X>39 Q:'DN  W ?39 W "POSTAL LOC. DATE REC'D:"
 D N:$X>64 Q:'DN  W ?64 S Y=$P(X,U,9) D DT
 D N:$X>0 Q:'DN  W ?0 W "IRS ABLE TO LOCATE:"
 D N:$X>22 Q:'DN  W ?22 S Y=$P(X,U,10) W:Y]"" $S($D(DXS(4,Y)):DXS(4,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "IRS LOC. DATE SENT:"
 D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,11) D DT
 D N:$X>0 Q:'DN  W ?0 W "IRS LOC. DATE REC'D:"
 W ?22 S Y=$P(X,U,12) D DT
 D N:$X>39 Q:'DN  W ?39 W "CREDIT REP. ABLE TO PAY:"
 D N:$X>65 Q:'DN  W ?65 S Y=$P(X,U,13) W:Y]"" $S($D(DXS(5,Y)):DXS(5,Y),1:Y)
 D N:$X>0 Q:'DN  W ?0 W "CREDIT REPT. DATE SENT:"
 D N:$X>24 Q:'DN  W ?24 S Y=$P(X,U,14) D DT
 D N:$X>39 Q:'DN  W ?39 W "CREDIT REP. DATE REC'D:"
 D N:$X>64 Q:'DN  W ?64 S Y=$P(X,U,15) D DT
 D N:$X>0 Q:'DN  W ?0 W "PATIENT FOLDER REVIEWED:"
 D N:$X>25 Q:'DN  W ?25 S Y=$P(X,U,16) W:Y]"" $S($D(DXS(6,Y)):DXS(6,Y),1:Y)
 D N:$X>39 Q:'DN  W ?39 W "DATE FOLDER REVIEWED:"
 D N:$X>62 Q:'DN  W ?62 S Y=$P(X,U,17) D DT
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "LETTER1:"
 S X=$G(^PRCA(430,D0,6)) D N:$X>9 Q:'DN  W ?9 S Y=$P(X,U,1) D DT
 D N:$X>25 Q:'DN  W ?25 W "LETTER2:"
 D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,2) D DT
 D N:$X>52 Q:'DN  W ?52 W "LETTER3:"
 D N:$X>61 Q:'DN  W ?61 S Y=$P(X,U,3) D DT
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=X S X=79,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
