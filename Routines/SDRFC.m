SDRFC ;SF/GFT-XAK,BSN/GRR - RADIOLOGY PULL LIST ; 12/4/90  09:36 ;
 ;;5.3;Scheduling;;Aug 13, 1993
 S DIV="" D DIV^SDUTL I $T D RALST^SDDIV Q:Y<0
 S U="^",%DT="AXE",%DT("A")="RADIOLOGY PULL LIST IN TERMINAL-DIGIT ORDER FOR WHAT DATE: " D ^%DT K %DT("A") Q:Y<0  S SDY=Y
 S PGM="START^SDRFC",VAR="DIV^SDY",VAL=DIV_"^"_SDY D ZIS^DGUTQ G:POP Q
START S Y=SDY U IO K ^UTILITY($J)
 F C=0:0 S C=$N(^SC("ARAD",C)) Q:C'>0  D CHECK I $T F SC="S","C" F D=Y-.01:0 S D=$N(^SC("ARAD",C,D)) Q:D\1-Y  F P=0:0 S P=$N(^SC("ARAD",C,D,P)) Q:P'>0  I $P(^(P),"^",1)'="N" S X=P D C:$D(^DPT(+X,0))
 S DA=0 W @IOF,!?31,"RADIOLOGY PULL LIST",!?31,"Printed on: " D NOW^%DTC S Y=$E(%,1,12) D DT^DIQ
 F I=0:0 S DA=$N(^UTILITY($J,DA)) G Q:DA<0 S X=0,DA1=DA,J=0 D P G Q:DA<0
P S X=$N(^UTILITY($J,DA,X)) Q:X'>0  S DA1=DA,DFN=X,X=$N(^(X)),PAT1=^DPT(DFN,0) I X<0 S DA=$N(^UTILITY($J,DA)) I DA'<0 S X=$N(^(DA,0))
 S PAT2=$S(X>0:^DPT(X,0),1:"") W !!,$E($P(PAT1,"^",9),6,9),"  ",$P(PAT1,"^",1),?40,$E($P(PAT2,"^",9),6,9),"  ",$P(PAT2,"^",1),!!?6,$P(PAT1,"^",9),?46,$P(PAT2,"^",9)
 S AP1=$N(^UTILITY($J,DA1,DFN,0)),DAT1=^(AP1),AP2=$N(^UTILITY($J,DA,X,0)),DAT2=$S(AP2>0:^(AP2),1:"") W !!?6,$P(^SC(+DAT1,0),"^",1),?46,$S(AP2>0:$P(^SC(+DAT2,0),"^",1),1:"") W ! D O
 W ! F J=1:1 S:AP1>0 AP1=$N(^UTILITY($J,DA1,DFN,AP1)) Q:AP1<0&(AP2<0)  S:AP1>0 C=+^(AP1) S:AP2>0 AP2=$N(^UTILITY($J,DA,X,AP2)) S:AP2>0 C2=+^(AP2) D O
 W @$E("!!!!!!!!!!!!!",1,13-J) S J=0 G P
Q W ! W:IOST'?1"C".E @IOF K DIV,Y,X,I,AP1,AP2,C,C2,D,DA,DA1,DAT1,DAT2,DFN,P,PAT1,PAT2,SC,SDY,T,J D CLOSE^DGUTQ Q
 ;
C S DA=$E($P(^(0),U,9),6,9),DA=$E(DA,3,4)_$E(DA,1,2),X=$P(X_"^^^^^",U,1,5) ;NAKED REFERENCE - ^DPT(DFN,0)
 I $D(^("S",D,0)),$P(^(0),U,2)["C" S X=X_"^***CANCELLED!***"
 S ^UTILITY($J," "_DA,+X,D)=C_U_X
 Q
O I J=1 W !?6 W:AP1>0 "LATER APPOINTMENTS:" W:AP2>0 ?46,"LATER APPOINTMENTS:"
 W !?6 I AP1>0 S Y=AP1 D DTS^SDUTL W:'J Y S T=$P(AP1,".",2)_"000" W " ",$E(T,1,2),":",$E(T,3,4) W:J " ",$E($P(^SC(C,0),"^",1),1,25)
 I AP2>0 S Y=AP2 D DTS^SDUTL W:'J ?46,Y S T=$P(AP2,".",2)_"000" W ?46," ",$E(T,1,2),":",$E(T,3,4) W:J " ",$E($P(^SC(C2,0),"^",1),1,25)
 Q
CHECK I $D(^SC(C,0)),$P(^(0),"^",3)="C",$S(DIV="":1,$P(^SC(C,0),"^",15)=DIV:1,1:0),$S('$D(^SC(C,"I")):1,+^("I")=0:1,+^("I")>Y:1,+$P(^("I"),"^",2)'>Y&(+$P(^("I"),"^",2)'=0):1,1:0)
 Q
