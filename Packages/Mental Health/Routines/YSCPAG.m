YSCPAG ; GENERATED FROM 'YSSR 10-2683 PRINT' PRINT TEMPLATE (#560) ; 10/11/16 ; (FILE 615.2, MARGIN=132)
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
 I $D(DXS)<9 M DXS=^DIPT(560,"DXS")
 S I(0)="^YS(615.2,",J(0)=615.2
 W ?0 D PARSE^YSSRU K DIP K:DN Y
 D N:$X>0 Q:'DN  W ?0 S X="YSAT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") S X=X S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 S X=$G(^YS(615.2,D0,0)) D N:$X>10 Q:'DN  W ?10 S Y=$P(X,U,2) S Y=$S(Y="":Y,$D(^DPT(Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,20)
 S I(1)=5,J(1)=615.34 F D1=0:0 Q:$O(^YS(615.2,D0,5,D1))'>0  X $G(DSC(615.34))  S D1=$O(^(D1)) Q:D1'>0   D:$X>32 T Q:'DN  D A1
 G A1R
A1 ;
 S X=$G(^YS(615.2,D0,5,D1,0)) D N:$X>32 Q:'DN  W ?32 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^YSR(615.6,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,12)
 Q
A1R ;
 D N:$X>53 Q:'DN  W ?53 S X="YSAT1",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>61 Q:'DN  W ?61 S X="YSRT1",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 D N:$X>71 Q:'DN  W ?71 S X="YSTT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") K DIP K:DN Y W X
 S X=$G(^YS(615.2,D0,25)) D N:$X>79 Q:'DN  W ?79 S Y=$P(X,U,1) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,12)
 S X=$G(^YS(615.2,D0,0)) D N:$X>95 Q:'DN  W ?95 S Y=$P(X,U,5) S Y=$S(Y="":Y,$D(^VA(200,Y,0))#2:$P(^(0),U),1:Y) W $E(Y,1,13)
 S X=$G(^YS(615.2,D0,7)) D N:$X>110 Q:'DN  S DIWL=111,DIWR=132 S Y=$P(X,U,1) S X=Y D ^DIWP
 D 0^DIWW
 D ^DIWW
 D N:$X>10 Q:'DN  W ?10 X "N I,Y "_$P(^DD(615.2,9,0),U,5,99) S DIP(1)=X S X="xxx-xx-"_DIP(1) K DIP K:DN Y W X
 D N:$X>61 Q:'DN  W ?61 S X="YSRT",X=$S(X=""!(X'?.ANP):"",$D(YSDIPA($E(X,1,30))):YSDIPA($E(X,1,30)),1:"") S X=X S:X X=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3) K DIP K:DN Y W X
 S I(1)=10,J(1)=615.21 F D1=0:0 Q:$O(^YS(615.2,D0,10,D1))'>0  X $G(DSC(615.21))  S D1=$O(^(D1)) Q:D1'>0   D:$X>89 T Q:'DN  D B1
 G B1R
B1 ;
 D N:$X>110 Q:'DN  W ?110 X DXS(1,9.2) S X=$P($G(^YSR(615.5,+$P(DIP(1),U,1),0)),U) S D0=I(0,0) S D1=I(1,0) K DIP K:DN Y W $E(X,1,20)
 Q
B1R ;
 D N:$X>0 Q:'DN  W ?0 W "GENERAL COMMENTS: "
  D N:$X>18 Q:'DN  W ?18 S:'$D(DIWF) DIWF="" S:DIWF'["N" DIWF=DIWF_"N" S X="" S I(1)=30,J(1)=615.27 F D1=0:0 Q:$O(^YS(615.2,D0,30,D1))'>0  S D1=$O(^(D1)) D:$X>20 T Q:'DN  D C1
 G C1R
C1 ;
 S X=$G(^YS(615.2,D0,30,D1,0)) S DIWL=19,DIWR=130 D ^DIWP
 Q
C1R ;
 D 0^DIWW
 D ^DIWW
 D N:$X>0 Q:'DN  W ?0 S X="+",DIP(1)=$G(X),DIP(2)=$G(X),X=$G(IOM,80) S X=X-2,X1=DIP(1) S %=X,X="" S:X1]"" $P(X,X1,%\$L(X1)+1)=X1,X=$E(X,1,%) K DIP K:DN Y W X
 K Y K DIWF
 Q
HEAD ;
 W !,?0,"D"
 W !,?0,"PARSE^YSSRU"
 W !,?0,"NUMDATE(YSPARAM(""YSAT""))"
 W !,?32,"TYPE OF"
 W !,?10,"NAME",?32,"SECLUSION/RESTRAINT",?53,"YSPARAM(""YSAT1"")"
 W !,?61,"YSPARAM(""YSRT1"")"
 W !,?71,"YSPARAM(""YSTT"")"
 W !,?95,"NAME OF NURSE"
 W !,?79,"ORDERED BY",?95,"PRESENT",?110,"DIAGNOSIS"
 W !,?10,"""xxx-xx-""_LAST4",?110,"REASONS FOR"
 W !,?10,"SSN",?61,"NUMDATE(YSPARAM(""YSRT""))",?110,"S/R:REASONS"
 W !,?18,"GENERAL COMMENTS"
 W !,?0,"DUP(""+"",IOM-2)"
 W !,"------------------------------------------------------------------------------------------------------------------------------------",!!
