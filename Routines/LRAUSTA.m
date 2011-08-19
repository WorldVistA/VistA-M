LRAUSTA ;AVAMC/REG/CYM - AUTOPSY STATUS LIST ;3/11/98  10:27 ;
 ;;5.2;LAB SERVICE;**134,201**;Sep 27, 1994
 S LRDICS="AU" D ^LRAP G:'$D(Y) END W !!,LRO(68)," STATUS LIST"
YR W ! S %DT="AE",%DT(0)="-N",%DT("A")="Select year: " D ^%DT K %DT G:Y<0 END S H(1)=$E(Y,1,3) D XR^LRU I '$O(^LR(LRXREF,H(1),LRABV,0)) W $C(7),!!,"No entries for ",LRO(68)," (",LRABV,") in ",H(1)+1700 G YR
N1 R !,"Start with Acc #: ",N(1):DTIME G:N(1)=""!(N(1)[U) END I N(1)'?1N.N W $C(7),!!,"NUMBERS ONLY !!" G N1
N2 R !,"Go    to   Acc #: LAST // ",N(2):DTIME G:'$T!(N(2)[U) END S:N(2)="" N(2)=999999 I N(2)'?1N.N W $C(7),!!,"NUMBERS ONLY !!",!! G N2
 I N(2)<N(1) S X=N(2),N(1)=N(2),N(2)=X
DEV S ZTRTN="QUE^LRAUSTA" D BEG^LRUTL G:POP!($D(ZTSK)) END
QUE U IO S N(1)=N(1)-1 D L^LRU,S^LRU,H S LR("F")=1
 F Z=N(1):0 S Z=$O(^LR(LRXREF,H(1),LRABV,Z)) Q:'Z!(Z>N(2))!(LR("Q"))  S I=+$O(^(Z,0)) D WRT
 D END^LRUTL,END Q
FIX S X=$$Y2K^LRX(X,"5D") Q
WRT Q:'$D(^LR(I,"AU"))  S W=^("AU"),LRSENIOR=$P(W,"^",10),LRESIDEN=$P(W,"^",7),LRLLOC=$E($P(W,"^",5),1,5),P=^LR(I,0)
 S P(1)=^DIC($P(P,"^",2),0,"GL"),P=$P(P,"^",3),P=@(P(1)_P_",0)"),P(9)=$E($P(P,"^",9),6,9),P=$E($P(P,"^"),1,19)
 S X=$P(W,"^") D FIX S LRAUDT=X,X=$P(W,"^",3) D FIX S LRAUCOMP=X,X=$P(W,"^",4) D FIX S LRFAD=X,X=$P(W,"^",17) D FIX S LRPAD=X
 D:$Y>(IOSL-7) H Q:LR("Q")  W !!,$P(W,"^",6),?10,$E(P,1,14),?25,P(9),?30,LRLLOC,?36,$J(LRAUDT,8),?47,$J(LRPAD,8),?58,$J(LRFAD,8),?69,$J(LRAUCOMP,8)
 I LRSENIOR,$D(^VA(200,LRSENIOR,0)) W !?36,$P(^(0),"^")
 I LRESIDEN,$D(^VA(200,LRESIDEN,0)) W !?36,$P(^(0),"^")
 Q
H I $D(LR("F")),IOST?1"C".E D M^LRU Q:LR("Q")
 D F^LRU W !,LRABV," Autopsy Status List",?36,"|--------------- Date --------------|",!,"Acc#",?12,"Patient",?25,"ID",?30,"Loc",?36,"Autopsy",?49,"PAD",?59,"FAD",?68,"Completed",!?36,"Pathologist(s)",!,LR("%") Q
 ;
END K LRSENIOR,LRESIDEN,LRAUDT,LRAUCOMP,LRFAD,LRPAD D V^LRU Q
