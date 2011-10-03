LRURG ;AVAMC/REG - TRANSFER ROUTINES ;5/30/96  13:22 ;
 ;;5.2;LAB SERVICE;**72**;Sep 27, 1994
 W !!,"Transfer routines",!
 X ^%ZOSF("RSEL") D ^%ZIS
EN S U="^",X="N",%DT="T" D ^%DT X ^DD("DD") S %DT=Y
 S A=0,L=$P($T(L),";",3,99),PR=$P($T(PR),";",3,99)
 H 5 W "Transferred Routines",!,%DT
X X "F I=0:1 S A=$O(^TMP($J,A)) Q:A=""""  ZL @A X L,PR"
 W !! K A,I,L,LC,PR,S,X,Y Q
 ;
L ;;W:I ! W !,A S S=0 F LC=1:1 S S=S+$L($T(+LC)) I $T(+LC)="" S LC=LC-1 Q
PR ;;F I=1:1 S X=$T(+I) Q:X=""  W !,X
