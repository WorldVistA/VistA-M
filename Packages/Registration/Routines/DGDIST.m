DGDIST ;ALB/MRL - DISPOSITION TIME STUDY ; 13 MAY 1987
 ;;5.3;Registration;;Aug 13, 1993
 D:'$D(DT) DT^DICRW S U="^" W !!,*7 S Y=$O(^DPT("ADIS",0)) I Y S (Y,DGEAR)=$P(Y,".",1) X ^DD("DD") W "EARLIEST REGISTRATION ON FILE IS '",Y,"'." G 1
 W "NO REGISTRATIONS ON FILE TO START WITH!!" G Q
1 W !! S %DT(0)=-DT,%DT="EAX",%DT("A")="Start with REGISTRATION DATE:  " D ^%DT G Q:Y'>0 S DGFR=Y I Y<DGEAR W !?4,"Can't be before earliest registration Date.",*7 G 1
2 S Y=DT X ^DD("DD") S %DT("B")=Y,%DT("A")="    Go To REGISTRATION DATE:  " D ^%DT G Q:Y'>0 S DGTO=Y I DGTO<DGFR W !?4,"Can't be before the Start Date.",*7 G 2
3 W !!,"WANT A LISTING OF UNDISPOSITIONED REGISTRATIONS DURING THIS TIMEFRAME" S %=2 D YN^DICN G Q:%=-1 I %>0 S DGU=(%-1) G 4
 W !!?4,"As I'm gathering data for this report I may run across some registrations",!?4,"in the timeframe selected which have not yet been dispositioned which I do"
 W !?4,"not include in the statistics.  If you want a listing of those patients for",!?4,"whom a disposition date/time has not been entered answer YES otherwise",!?4,"answer NO to this prompt." G 3
4 W !!,*7,"Note: This report requires a column width of 132." K %DT S DGPGM="S^DGDIST",DGVAR="DGFR^DGTO^DGU" D ZIS^DGUTQ G Q:POP U IO
S K ^UTILITY($J,"DGT") D:'$D(DT) DT^DICRW S U="^",Y=DT X ^DD("DD") S DGC=0,DGPR="Printed: "_Y I '$D(IOF) S IOP="HOME" D ^%ZIS K IOP
 S Y=DGFR X ^DD("DD") S DGHD="Registration/Disposition Time Statistics for "_$S(DGTO>DGFR:"period covering ",1:"")_Y I DGTO>DGFR S Y=DGTO X ^DD("DD") S DGHD=DGHD_" through "_Y
 S DGTO=DGTO_".9999",X1=DGFR,X2=-1 D C^%DTC S DGFR=X_".9999" D DIV^DGUTL
 F I=0:0 S DGFR=$O(^DPT("ADIS",DGFR)) Q:'DGFR!(DGFR'<DGTO)  F DFN=0:0 S DFN=$O(^DPT("ADIS",DGFR,DFN)) Q:'DFN  F DGN=0:0 S DGN=$O(^DPT("ADIS",DGFR,DFN,DGN)) Q:'DGN  I $D(^DPT(DFN,"DIS",DGN,0)),$P(^(0),"^",2)'=2 S DGD=^(0) D SET
 G ^DGDIST1:$D(^UTILITY($J,"DGT")),Q
SET I "^2^4^5^"[("^"_$P(DGD,"^",3)_"^")!($P(DGD,"^",3)'>0) Q
 S DGF=$S($L(DGDIV):$P(DGDIV,"^",2),$D(^DG(40.8,+$P(DGD,"^",4),0)):$P(^(0),"^",1),1:"UNSPECIFIED"),DGH=$S($D(^DIC(37,+$P(DGD,"^",7),0)):$P(^(0),"^",1),1:"UNSPECIFIED")
 S DGW=$S($D(^DPT(DFN,0)):$P(^(0),"^",1),1:"UNSPECIFIED PT #"_DFN) D PID^VADPT6 S DGS=VA("PID")
 S:'$D(^UTILITY($J,"DGT")) ^("DGT")="" S:'$D(^UTILITY($J,"DGT","D",DGF)) ^(DGF)="" S:'$D(^UTILITY($J,"DGT","D",DGF,"H",DGH)) ^(DGH)="" S:'$D(^UTILITY($J,"DGT","D",DGF,"NC")) ^("NC")="" S:'$D(^UTILITY($J,"DGT","NC")) ^("NC")=""
 I $P(DGD,"^",7)']"" S $P(^("NC"),"^",1)=$P(^UTILITY($J,"DGT","D",DGF,"NC"),"^",1)+1,$P(^("NC"),"^",1)=$P(^UTILITY($J,"DGT","NC"),"^",1)+1 Q:DGU  S Y=$P(DGD,"^",1) X ^DD("DD") S DGC=DGC+1,^UTILITY($J,"DGT","ND",DGW,DGC)=DGS_"^"_DGF_"^"_Y Q
 S X=$P(DGD,"^",1),DGX=$P(X,".",2),DGX=$E((DGX_"000"),1,4) D H^%DTC S DGX=%H_","_($E(DGX,1,2)*60*60+($E(DGX,3,4)*60)),X=$P(DGD,"^",6),DGX1=$P(X,".",2),DGX1=$E((DGX1_"000"),1,4)
 D H^%DTC S DGX1=%H_","_($E(DGX1,1,2)*60*60+($E(DGX1,3,4)*60)),X=DGX1
 S Y=(X-DGX)*86400,X1=$P(X,",",2),X2=$P(DGX,",",2),X3=Y-X2+X1,X=X3\3600,X1=X3#3600\60 S:'X&('X1) X1=1 S DGM=(X*60)+X1,DGP=2,DGY=DGM D N S (DGP,DGY)=1 D N
 S DGY=1 I DGM<61 S DGP=3 D N Q  ;Disp within 1 hr
 I DGM<121 S DGP=4 D N Q  ;Disp within 2 hrs
 I DGM<481 S DGP=5 D N Q  ;Disp within 8 hrs
 I DGM<1441 S DGP=6 D N Q  ;Disp within 24 hrs
 I DGM<2881 S DGP=7 D N Q  ;Disp within 48 hrs
 I DGM<4321 S DGP=8 D N Q  ;Disp within 72 hrs
 I DGM<10081 S DGP=9 D N Q  ;Disp within 7 dys
 I DGM<43201 S DGP=10 D N Q  ;Disp within 30 dys
 S DGP=11 ;Over 30 dys
N S $P(^("DGT"),"^",DGP)=$P(^UTILITY($J,"DGT"),"^",DGP)+DGY,$P(^(DGF),"^",DGP)=$P(^UTILITY($J,"DGT","D",DGF),"^",DGP)+DGY,$P(^(DGH),"^",DGP)=$P(^UTILITY($J,"DGT","D",DGF,"H",DGH),"^",DGP)+DGY Q
Q W ! K ^UTILITY($J,"DGT"),%,%DT,%H,%Y,D,DFN,DGA,DGC,DGD,DGDIV,DGEAR,DGFR,DGH,DGHD,DGL,DGL1,DGM,DGN,DGP,DGPG,DGPGM,DGPR,DGS,DGTO,DGU,DGU1,DGF,DGVAR,DGW,DGX,DGX1,DGY,I,I1,POP,X,X1,X2,X3,Y,VA,VAERR,Z D CLOSE^DGUTQ Q
