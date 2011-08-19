LRLABEL3 ;SLC/RWF - PRINTS MEDLAB LABELS ;2/6/91  08:06
 ;;5.2;LAB SERVICE;**161**;Sep 27, 1994
 ;For the 7 part MEDLAB label DPS-ML (time products) AT 16.5 CPI
1 U IO S T=45,T1=23,X=136 X ^%ZOSF("RM") ; Set T=28, T1=14 for 10 cpi.
 S LRDAT=$P(LRDAT," ")
 S LRTXT=$$LRTXT^LRLABLD(.LRTS,25)
 S B=$S(LRRB=0:"",1:" B:"_LRRB)
 D T
 Q
 ;
T S X=$E(PNM,1,$S($L(LRINFW):18,1:T-1))
 W !
 F J=0:1:2 W ?(J*T),X W:$L(LRINFW) "  ",LRINFW
 S J1=N-I'<LRXL
 W ! S X=T-2-$L(LRACC) F J=0:1:2 W ?(J*T),LRACC,$J("W:"_LRLLOC_B,X)
 W ! S X=T-2-$L(SSN) F J=0:1:2 W ?(J*T),SSN,$J(LRDAT,X)
 W ! F J=0:1:2 W:J1 ?(J*T),LRPREF W ?(J*T+6),LRTOP,?(J*T+15)," Order:",LRCE
 W !,LRTXT
 W ! F J=0:1:3 W ?(J*T1+T),LRACC
 W ! F J=0:1:3 W ?(J*T1+T),LRDAT
 W !!
 K J,J1,I1
 Q
 ;
