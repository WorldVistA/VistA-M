LRBLAGG ;AVAMC/REG - BLOOD BANK AGGLUTINATION STRENGTH ;3/9/94  10:29 ;
 ;;5.2;LAB SERVICE;**247**;Sep 27, 1994
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 I X'?.ANP!($L(X)<1)!($L(X)>5) K X Q
 S Y=$O(^LAB(62.55,"B",X,0)) I Y,$D(^LAB(62.55,Y,0)) S X(2)=^(0),X=$P(X(2),"^") W " ",X," ",$P(X(2),"^",2) Q
 S:$D(DIC) LRTDIC=DIC S:$D(DIC(0)) LRTDIC(0)=DIC(0)
 S DIC="^LAB(62.55,",DIC(0)="EQMZ" D ^DIC K DIC S:Y'=-1 X=$P(Y(0),"^") I Y=-1!(X["^") K X
END S:$D(LRTDIC) DIC=LRTDIC S:$D(LRTDIC(0)) DIC(0)=LRTDIC(0) K LRTDIC,LRTDIC(0) Q
OUT S %Y="",X=$O(^LAB(62.55,"B",Y,0)) Q:'X  I $D(^LAB(62.55,X,0)) S %Y="("_$P(^(0),"^",2)_")" Q
LST ;
 W "CHOOSE FROM:" S X=0 F A=0:0 S X=$O(^LAB(62.55,"B",X)) Q:X=""  F Y=0:0 S Y=$O(^LAB(62.55,"B",X,Y)) Q:'Y  I $D(^LAB(62.55,Y,0)) W !,X,"  ",$P(^(0),U,2) I $Y#21=0 R !,"'^' TO STOP: ",%Y:DTIME G:%Y[U END D STOP
 Q
STOP W $C(13),$J("",15),$C(13) Q
