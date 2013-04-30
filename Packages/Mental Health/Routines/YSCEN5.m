YSCEN5 ;ALB/ASF,HIOFO/FT - CENSUS HX ;8/15/12 9:38am
 ;;5.01;MENTAL HEALTH;**60**;Dec 30, 1994;Build 47
 ;
 ;No external references
 ;
CROSS ; set logic for AST x-ref in File 618.4
 S:'$D(^YSG("INP",DA,6,0)) ^YSG("INP",DA,6,0)="^618.419P^0^0"
 L +^YSG("INP",DA,6):DILOCKTM Q:'$T
 S N=$P(^YSG("INP",DA,6,0),U,3)+1
 I (N>1),$D(^YSG("INP",DA,6,N-1)),(X=+^YSG("INP",DA,6,N-1,0)) S X2=^YSG("INP",DA,6,N-1,0),W1=+^YSG("INP",DA,7),^YSG("INP","AST",9999999-$P(X2,U,2),W1,X,DA)="" L -^YSG("INP",DA,6,0) Q
 S ^YSG("INP",DA,6,0)=$P(^YSG("INP",DA,6,0),U,1,2)_U_N_U_($P(^YSG("INP",DA,6,0),U,4)+1) L -^YSG("INP",DA,6)
 S W1=+^YSG("INP",DA,7),YSU=X,X="NOW",%DT="T" D ^%DT S X=YSU,YSNOW=9999999-Y,^YSG("INP","AST",YSNOW,W1,X,DA)="" K YSU,YSNOW
 S ^YSG("INP",DA,6,N,0)=X_U_Y_U_DUZ,^YSG("INP",DA,6,"B",X,N)=""
 Q:'$D(^YSG("SUB",X,1))
 Q:'$P(^YSG("SUB",X,1),U,4)  S YSTM8="" F ZZ=1:1 Q:'$D(^YSG("CEN",W1,"ROT"))  S YSTM7=$P(^YSG("CEN",W1,"ROT"),U,ZZ) Q:YSTM7'?1N.N  S:YSTM7'=X YSTM8=YSTM8_YSTM7_U
 S ^YSG("CEN",W1,"ROT")=YSTM8_X
 Q
ENTRY ; set logic for AWC x-ref in File 618.4
 S YSW1=+^YSG("INP",DA,7),G=^YSG("INP",DA,0)
 I $P(G,U,2) S ^YSG("INP","CP",$P(G,U,2),DA)=""
 I $P(G,U,5) S ^YSG("INP","AC",$P(G,U,5),DA)=""
 I $P(G,U,6) S ^YSG("INP","ACP",$P(G,U,6),DA)=""
 I $P(G,U,7) S ^YSG("INP","ACR",$P(G,U,7),DA)=""
 S ^YSG("INP","AWC",YSW1,X,DA)="" Q
LEAVE ; kill logic for AWC x-ref in File 618.4
 S YSW1=+^YSG("INP",DA,7),G=^YSG("INP",DA,0)
 I $P(G,U,2) K ^YSG("INP","CP",$P(G,U,2),DA)
 I $P(G,U,5) K ^YSG("INP","AC",$P(G,U,5),DA)
 I $P(G,U,6) K ^YSG("INP","ACP",$P(G,U,6),DA)
 I $P(G,U,7) K ^YSG("INP","ACR",$P(G,U,7),DA)
 K ^YSG("INP","AWC",YSW1,X,DA) Q
