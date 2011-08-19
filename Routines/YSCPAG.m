YSCPAG ; GENERATED FROM 'YSSR 10-2683 PRINT' PRINT TEMPLATE (#560) ; 08/21/96 ; (FILE 615.2, MARGIN=132)
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
 I $D(DXS)<9 F X=0:0 S X=$O(^DIPT(560,"DXS",X)) Q:'X  S Y=$O(^(X,"")) F X=X:0 Q:Y=""  S DXS(X,Y)=^(Y),Y=$O(^(Y))
 W ?0 D PARSE^YSSRU K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S X="YSAT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") S X=X S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 S X=$G(^YS(615.2,D0,0)) D N:$X>10 Q:'DN  W ?10 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,20)
 S I(1)=5,J(1)=615.34 F D1=0:0 Q:$O(^YS(615.2,D0,5,D1))'>0  X:$D(DSC(615.34)) DSC(615.34) S D1=$O(^(D1)) Q:D1'>0  D:$X>32 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^YS(615.2,D0,5,D1,0)) D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^YSR(615.6,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,12)
 Q
A1R ;
 D N:$X>53 Q:'DN  W ?53 S X="YSAT1",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>61 Q:'DN  W ?61 S X="YSRT1",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>71 Q:'DN  W ?71 S X="YSTT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 S X=$G(^YS(615.2,D0,25)) D N:$X>79 Q:'DN  W ?79 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,12)
 S X=$G(^YS(615.2,D0,0)) D N:$X>95 Q:'DN  W ?95 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U,1),1:Y) W $E(Y,1,13)
 S X=$G(^YS(615.2,D0,7)) D N:$X>110 Q:'DN  S DIWL=111,DIWR=132 S Y=$P(X,U,1) S X=Y D ^DIWP
 D A^DIWW
 D N:$X>10 Q:'DN  W ?10 X DXS(1,9.2) S X=$P(DIP(101),U,9) S D0=I(0,0) K DIP K:DN Y W X
 D N:$X>61 Q:'DN  W ?61 S X="YSRT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") S X=X S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 S I(1)=10,J(1)=615.21 F D1=0:0 Q:$O(^YS(615.2,D0,10,D1))'>0  X:$D(DSC(615.21)) DSC(615.21) S D1=$O(^(D1)) Q:D1'>0  D:$X>79 T Q:'DN  D B1
 G B1R
B1 ;
 D N:$X>110 Q:'DN  W ?110 X DXS(2,9.2) S X=$S('$D(^YSR(615.5,+$P(DIP(1),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W $E(X,1,20)
 Q
B1R ;
 D N:$X>0 Q:'DN  W ?0 W "GENERAL COMMENTS: "
 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=30,J(1)=615.27 F D1=0:0 Q:$O(^YS(615.2,D0,30,D1))'>0  S D1=$O(^(D1)) D:$X>20 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^YS(615.2,D0,30,D1,0)) S DIWL=19,DIWR=130 D ^DIWP
 Q
C1R ;
 D A^DIWW
 D N:$X>0 Q:'DN  W ?0 S X="+",DIP(1)=X,DIP(2)=X,X=$S($D(IOM):IOM,1:80) S X=X-2,X1=DIP(1) S %=X,X="" Q:X1=""  S $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"D"
 W !,?0,"PARSE^YSSRU"
 W !,?0,"NUMDATE(YSPARAM("
 W !,?32,"TYPE OF"
 W !,?10,"NAME",?32,"SECLUSION/RESTRAINT",?53,"YSPARAM("
 W !,?61,"YSPARAM(",?71,"YSPARAM("
 W !,?95,"NAME OF NURSE"
 W !,?79,"ORDERED BY",?95,"PRESENT",?110,"DIAGNOSIS"
 W !,?110,"REASONS FOR"
 W !,?10,"NAME:SSN",?61,"NUMDATE(YSPARAM(",?110,"S/R:REASONS"
 W !,?18,"GENERAL COMMENTS"
 W !,?0,"DUP("
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
