XTVCHG ;SF-ISC/RWF - VARIABLE CHANGER ;2/3/93  13:45 ;
 ;;7.3;TOOLKIT;;Apr 25, 1995
 W !,"VARIABLE CHANGER" K ^TMP($J) X ^%ZOSF("RSEL") Q:$O(^UTILITY($J,0))=""  S %X="^UTILITY($J,",%Y="^TMP($J," D %XY^%RCR K ^UTILITY($J)
 F I=1:1 S X=$T(Z+I) Q:X=""  S @("X"_I)=$P(X,";;",2)
LOOP R !,"VARIABLE TO CHANGE: ",V1:999 Q:V1["^"!(V1="")  R "  CHANGE TO: ",V2:999 G LOOP:V2="" Q:V2["^"
 S RN=0,X=" ,'_&![]<>:=-+/\*",G2=X_"()@",G1=X_"(",NL="",L1=$L(V1)
 X "F I2=0:0 S RN=$O(^TMP($J,RN)) Q:RN=NL  ZL @RN W:$X>70 ! W $J(RN,10) S CH=0 X X1 I CH ZS @RN W !"
 W !,"* DONE CHANGING ",V1," TO ",V2 G LOOP
Z ;
 ;;X X3 F I1=1:1 S L=$T(+I1),C=0 Q:L=NL  I L[V1 X X2 I C ZR +I1 ZI L W !,L S CH=1
 ;;F I=1:0 S I=$F(L,V1,I) Q:I<1  I $A(L,I-L1-1)>0,G1[$E(L,I-L1-1),G2[$E(L,I) S L=$E(L,1,I-L1-1)_V2_$E(L,I,999),C=1,I=I-1
 ;;I $T(@V1)'=NL W !,"The variable ",V1," is used as a line label and DO or GOTO may be changed.",$C(7)
