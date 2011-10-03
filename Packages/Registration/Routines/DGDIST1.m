DGDIST1 ;ALB/MRL - DISPOSITION TIME STUDY, CONTINUED ; 13 MAY 1987
 ;;5.3;Registration;;Aug 13, 1993
 S DGPG=0,(DGL,DGL1)="",$P(DGL,"=",131)="",$P(DGL1,"-",131)="",DGF=""
 F I=0:0 S DGF=$O(^UTILITY($J,"DGT","D",DGF)),DGH="" Q:DGF=""  I +^(DGF)>0 D H F I1=0:0 S DGH=$O(^UTILITY($J,"DGT","D",DGF,"H",DGH)) D:DGH="" D Q:DGH=""  S DGW=0,DGD=^(DGH) D W
 G NC:DGDIV S DGW=2,DGF="" D H F I=0:0 S DGF=$O(^UTILITY($J,"DGT","D",DGF)) Q:DGF=""  S DGD=^(DGF) D W
 S DGW=3,DGD=^UTILITY($J,"DGT") W !,DGL1,!,DGL1 D W S DGN=+^UTILITY($J,"DGT","NC") D C
NC D:$D(^UTILITY($J,"DGT","ND")) LIST G Q^DGDIST
W Q:'$P(DGD,"^",1)  I $Y>$S($D(IOSL):(IOSL-6),1:60) D H
W1 S X=+$P(DGD,"^",1),X1=$S(X>0:($P(DGD,"^",2)\X),1:0) I X1>0 S X2=X1\60,X3=X1-(X2*60),X3=$E($S(X3<10:"0"_X3,1:X3)_"00",1,2),X1=X2_":"_X3
 E  S X1="00:00"
 W !,$S('DGW:DGH,DGW=1:"DIVISION SUB-TOTAL",DGW=2:DGF_" DIVISION",1:"MEDICAL CENTER TOTAL"),?35,$J(X,8),?45,$J(X1,9),?57,"|" S DGX=60 F DGY=3:1:11 W ?DGX,$J(+$P(DGD,"^",DGY),6) S DGX=DGX+8
 S DGN=0 I DGW=1 S DGN=+^UTILITY($J,"DGT","D",DGF,"NC") D C
 Q
H S DGPG=DGPG+1 W @IOF,!,$S(DGW=2:"MEDICAL CENTER TOTAL",1:DGF)_", "_DGHD
 W !,DGL,!?57,"|",?85,"# PATIENTS DISPOSITIONED WITHIN",!?57,"|",?126,"Over",!?34,"Number of",?47,"Average",?57,"|",?69,"2",?77,"8",?85,"24",?93,"48",?101,"72",?118,"30",?126,"30"
 W !,$S(DGW'=2:"Type of Disposition",1:"Division"),?35,"Patients",?50,"Time",?57,"|",?60,"1 Hour",?69,"Hours",?77,"Hours",?85,"Hours",?93,"Hours",?101,"Hours",?108,"7 days",?118,"days",?126,"Days",!,DGL Q
D S DGW=$S(DGDIV:2,1:1),DGD=^UTILITY($J,"DGT","D",DGF) W !,DGL1,!,DGL1 D W Q
C D LF W !,"NOTE(S)",!,"-------",!,"'Average Time per Disposition' is in HOURS:MINUTES format.",!,"NOTE:  Applications without examination are not included in this report."
 W !,"Applications for Nursing Home, Domiciliary and Dental Care are not included in this report."
 I DGN W !,"There are '",DGN,"' registrations which have not been dispositioned which are not included in the above totals." I 'DGU W "  See attached Listing."
TR W !!,DGL,!,DGPR,?120,"Page: ",DGPG Q
LF F DGA=$Y:1:$S($D(IOSL):(IOSL-14),1:52) W !
 Q
LIST D H1 S DGP="" F I=0:0 S DGP=$O(^UTILITY($J,"DGT","ND",DGP)) Q:DGP=""  F I1=0:0 S I1=$O(^UTILITY($J,"DGT","ND",DGP,I1)) Q:'I1  S DGD=^(I1) D LW
 D LF,TR Q
LW I $Y>$S($D(IOSL):(IOSL-6),1:60) D LF,TR,H1
 W !,DGP,?45,$P(DGD,"^",1),?60,$P(DGD,"^",2),?100,$P(DGD,"^",3) Q
H1 S DGPG=DGPG+1 W @IOF,!,DGHD,", Undispositioned Registrations",!,DGL,!,"Patient Name",?45,"PT ID",?60,"Division",?100,"Registration Date/Time",!,DGL Q
