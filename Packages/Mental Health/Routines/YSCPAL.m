YSCPAL ; GENERATED FROM 'YSSR PT INQ HEADER' PRINT TEMPLATE (#563) ; 10/11/16 ; (FILE 615.2, MARGIN=80)
 G BEGIN
N W !
T W:$X ! I '$D(DIOT(2)),DN,$D(IOSL),$S('$D(DIWF):1,$P(DIWF,"B",2):$P(DIWF,"B",2),1:1)+$Y'<IOSL,$D(^UTILITY($J,1))#2,^(1)?1U1P1E.E X ^(1)
 S DISTP=DISTP+1,DILCT=DILCT+1 D:'(DISTP#100) CSTP^DIO2
 Q
DT I $G(DUZ("LANG"))>1,Y W $$OUT^DIALOGU(Y,"DD") Q
 X ^DD("DD")
 W Y Q
M D @DIXX
 Q
BEGIN ;
 S:'$D(DN) DN=1 S DISTP=$G(DISTP),DILCT=$G(DILCT)
 I $D(DXS)<9 M DXS=^DIPT(563,"DXS")
 S I(0)="^YS(615.2,",J(0)=615.2
 W ?0 D PARSE^YSSRU K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S X="YSLCN",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>67 Q:'DN  W ?67 S X="PAGE:  ",DIP(1)=$G(X),X=$S($D(DC)#2:DC,1:"") S Y=X,X=DIP(1),X=X S X=X_Y K DIP K:DN Y W X
 D N:$X>0 Q:'DN  W ?0 S X="INDIVIDUAL PATIENT INQUIRY",X=$J("",$S($D(DIWR)+$D(DIWL)=2:DIWR-DIWL+1,$D(IOM):IOM,1:80)-$L(X)\2-$X)_X K DIP K:DN Y W X
 D N:$X>28 Q:'DN  W ?28 X DXS(1,9.2) S DIP(2)=X,X=Y S Y=X X ^DD("DD") S X=DIP(2)_Y,X=$J("",$S($D(DIWR)+$D(DIWL)=2:DIWR-DIWL+1,$D(IOM):IOM,1:80)-$L(X)\2-$X)_X K DIP K:DN Y W X
 D T Q:'DN  D N D N:$X>0 Q:'DN  W ?0 W "NAME:"
 S X=$G(^YS(615.2,D0,0)) D N:$X>6 Q:'DN  W ?6 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>28 Q:'DN  W ?28 W "FROM:"
 D N:$X>34 Q:'DN  W ?34 S X="YSAT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") S X=X S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 D N:$X>43 Q:'DN  W ?43 S X="YSAT1",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>50 Q:'DN  W ?50 W "TO:"
 D N:$X>54 Q:'DN  W ?54 S X="YSRT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") S X=X S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 D N:$X>63 Q:'DN  W ?63 S X="YSRT1",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>70 Q:'DN  W ?70 W "("
 D N:$X>71 Q:'DN  W ?71 S X="YSTT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>77 Q:'DN  W ?77 W ")"
 D N:$X>0 Q:'DN  W ?0 W "SSN:  xxx-xx-"
 D N:$X>13 Q:'DN  W ?13 S X=$E($P($G(^DPT($P(^YS(615.2,D0,0),U,2),0)),U,9),6,9) W $E(X,1,4) K Y(615.2,9)
 D N:$X>28 Q:'DN  W ?28 W "WARD:"
 S X=$G(^YS(615.2,D0,0)) D N:$X>34 Q:'DN  W ?34 S Y=$P(X,U,4) S Y=$S(Y="":Y,$D(^SC(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,30)
 D N:$X>0 Q:'DN  W ?0 S X="=",DIP(1)=$G(X),DIP(2)=$G(X),X=$G(IOM,80) S X=X,X1=DIP(1) S %=X,X="" S:X1]"" $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 W ?11 W "          "
 K Y
 Q
HEAD ;
 W !,"--------------------------------------------------------------------------------",!!
