YSCEN81 ;ALB/ASF-CENSUS DAYS ;4/3/90  11:49
 ;;5.01;MENTAL HEALTH;**63**;Dec 30, 1994
 ;
 ; Called from the top by MENU option YSCENREM
 ;
A ;
 K P,Y D UN^YSCEN2 Q:+Y'>0
 ;
GFR ;
 W ! S (YSFR,YSTO)=0,%DT("A")="Enter the Beginning Month/Year: ",%DT="AEQ" D ^%DT
 Q:Y<1
 I $E(Y,6,7)'?2"0" W !?5,"  ... Enter Month and Year only (Example:  'June 90') ..." G GFR
 S YSFR=$E(+Y,1,5)
 ;
TO ;
 W ! S %DT("A")="Enter the Ending Month/Year: ",%DT="AEQ" D ^%DT
 Q:Y<1
 I $E(Y,6,7)'?2"0" W !?5,"  ... Enter Month and Year only (Example:  'June 90') ..." G TO
 S YSTO=$E(+Y,1,5)
 ;
 I YSTO<YSFR D
 .W !?5," ... Beginning date is after the Ending date ..."
 .W !?5,"... Please reenter both the Beginning and Ending Date ..."
 I YSTO<YSFR G GFR
 ;
OP ;
 R !!,"(T)otal, (F)emale, (G)eriatric, or (V)ietnam Era patients? T// ",C5:DTIME S YSTOUT='$T,YSUOUT=X["^" Q:YSTOUT!YSUOUT
 S C5=$TR($E(C5_"T"),"tfgv","TFGV")
 I "TFGV"'[C5 W !!,"Enter 'T' for all patients remaining",!?6,"'F' for female patients only remaining",!?6,"'G' for patients over age 65 remaining",!?6,"'V' for Vietnam era patients remaining",! G OP
 K IOP S %ZIS="Q" D ^%ZIS Q:POP  I $D(IO("Q")) K IO("Q") S ZTRTN="ENQ^YSCEN81",ZTDESC="YS IP 81",(ZTSAVE("W1"),ZTSAVE("C5"),ZTSAVE("W2"),ZTSAVE("YSTO"),ZTSAVE("YSFR"))="" D ^%ZTLOAD W !,$S($D(ZTSK):"QUEUED",1:"Not queued"),$C(7) Q
ENQ ;
 K V S $P(V,"*",81)="" U IO D START G END
START ;
 S Q3=0,L="",L1="| ",$P(L2,"-",80)="" F ZZ=1:1:9 S L=L_"----|",L1=L1_"  "_ZZ_"0%"
 S L="Date   Pts    Occ. |"_L_"-----|"
 S YSND=C5'="T" ;If C5=T, YSND=0... node 0.   Otherwise, YSND=1.
 S YSND1=$S(C5="T":2,C5="F":1,C5="G":3,C5="V":4) ;Sets piece of node 1
 F YSM=YSFR:1:YSTO S:YSM?2N1"13" YSM=YSM+88 D 1,WAIT:M5 Q:Q3
 D MON Q
 ;
1 W:$Y>2 @IOF S (M4,M5,C3)=0 F I7=1:1:31 S YSD=YSM_"00"+I7 D:$D(^DG(41.9,W1,"C",YSD,1))#2 HDR:$Y<2,LST I $Y+4>IOSL D WAIT Q:Q3  D HDR
 Q:'M5  W !!,"Average Occupancy for the above ",M5," days = ",$J(M4/M5,4,1),"%" S P(YSM)=M4/M5 Q
LST ;
 S M5=M5+1,C1=$P(^DG(41.9,W1,"C",YSD,YSND),U,YSND1),C2=$P(^DG(41.9,W1,"C",YSD,1),U,2) W:C2=""!(C2<1) !?5,"There are NO patients remaining on this ward at the end of the census day.",! Q:C2=""!(C2<1)  S P=C1/C2*100
 W !,$E(YSD,4,5)_"/"_$E(YSD,6,7)," ",$J(C1,4)," ",$J(P,6,1),"% |",$E(V,1,P/2),?70,"|"
 I C2'=C3 S C3=C2 W ?$X+2,C2
 S M4=M4+P Q
HDR ;
 W @IOF,"Ward '",W2,"' ",$S(C5="T":"",C5="F":"Female ",C5="G":"Geriatric ",C5="V":"Vietnam Era ",1:"error"),"patients: "
 ;the correct month (YSM) is set & available at the top of every page. Ie., One month per page.
 S Y=YSM D DD^%DT W "   ",Y
 D NOW^%DTC S Y=% D DD^%DT W ?(IOM-$L(Y)-1),Y
 W !,L2,!?19,L1,?70,"| beds",!,L
 QUIT
 ;
WAIT ;
 W $C(7) D WAIT^YSCEN1 Q
MON ;
 S L="    YR/MO      Occ.|"_$P(L,"|",2,99),X=$O(P(0)) Q:'X!Q3  D HDR1,MONL,WAIT
 Q
MONL ;
 S T=0 F  S T=$O(P(T)) Q:'T  W !?4,$E(T,2,3)_"/"_$E(T,4,5),"    ",$J(P(T),4,1),"% |",$E(V,1,P(T)/2),?70,"|" I $Y+4>IOSL D WAIT Q:Q3  D HDR1
 Q
HDR1 ;
 W @IOF,"Ward '",W2,"' ",$S(C5="T":"Total",C5="F":"Female",C5="G":"Geriatric",C5="V":"Vietnam Era",1:"error")
 W " Monthly Averages " D TIME^YSCEN2 W !,L2,!?12,"Average",L1,?70,"|",!,L Q
END ;
 D KILL^%ZTLOAD
 K %,%DT,%ZIS,C,C1,C2,C3,C5,I7,L,L1,L2,L3,M4,M5,P,POP,Q3,T,V,W1,W2
 K Y,Y,YSD,YSFR,YSM,YSND,YSND1,YSTM,YSTMX,YSTO,YSTOT,YSTOUT
 K ZTDESC,ZTRTN,ZTSAVE,ZTSK,ZZ
 D ^%ZISC
 QUIT
 ;
