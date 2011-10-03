DGPMBSP6 ;ALB/LM - BSR PRINT, CONT.; 13 JUNE 90
 ;;5.3;Registration;**170**;Aug 13, 1993
 ;
A Q:'CT
 N FY0
 ;
 S X="C U M U L A T I V E     T O T A L S"
 ;
 W ! W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 S X1=RM-$L(X)\2
 W !?0,"|",?X1,X,?130,"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 W !?0,"|",?26,"|",?40,"| Interward",?54,"|Interservice",?68,"|",?82,"| Interward",?96,"|Interservice",?110,"|",?117,"Patient",?130,"|"
 W !?0,"|",?26,"| Admissions",?40,"|    Gains",?54,"|    Gains",?68,"| Discharges",?82,"|  Losses",?96,"|    Losses",?110,"|         Days",?130,"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 W !?0,"|",?26,"|"
 S FY0=FY("Y")-1 S:FY0=-1 FY0="99" S:$L(FY0)=1 FY0="0"_FY0
 F C=1:1:14 W $S(C<13:"",1:"   ")," FY-",$S('(C#2):FY("Y"),1:FY0)_"|"
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 S I=0
1 F I1=0:0 S I=$O(CUM(I)),J=0 Q:I'>0  F J1=0:0 S J=$O(CUM(I,J)) Q:J'>0  D 2
 W:$Y<131 ?131,"" W $C(13) W:UL["-" ! F L=1:1:131 W UL
 ;
Q Q
 ;
2 S X=CUM(I,J),Z=+$O(^DIC(42,"AGL",I,0)),Z=$S('$D(^DIC(42,+Z,1,J,0)):$P(X,"^"),$P(^DIC(42,+Z,1,J,0),"^",5)]"":$P(^DIC(42,+Z,1,J,0),"^",5),1:$P(X,"^"))
 W !?0,"|",$E(Z,1,23),?26,"|" F K=2:1:15 S X1=$S(K<14:6,1:9) W $J(+$P(X,"^",K),X1),"|"
 Q
