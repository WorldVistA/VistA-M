DGDISS ;ALB/JDS - DISPOSITION SUMMARY ; 26 AUG 84  14:14
 ;;5.3;Registration;;Aug 13, 1993
 ;
 D LO^DGUTL
SD R !,"START DATE: ",X:DTIME G Q:X=""!(X["^") S %DT="XPE",%DT(0)=-DT D ^%DT G SD:Y'>0 S SD=+Y
AN G ED:+$E(SD,6,7)'=1 S %=1 W !!,"Run statistics for the whole month" D YN^DICN G MON:%=1,ED:%=2,Q:%=-1
 W !?4,"YES - To generate a log for this entire month",!?4,"NO  - To select an end date to which to generate log." G AN
ED R !,"END DATE: ",X:DTIME G Q:X=""!(X["^") S %DT="XE" D ^%DT G ED:Y'>0 S ED=+Y I ED<SD W !?4,*7,"Can't preceed start date." G ED
OU S DGPGM="START^DGDISS",DGVAR="SD^ED" W ! D ZIS^DGUTQ G Q:POP
START U IO S S=SD-.00001,ED=ED+.25 K DIS
S S S=$O(^DPT("ADIS",S)) G DON:'S!(S>ED) S S1=0
S1 S S1=$O(^DPT("ADIS",S,S1)) G S:'S1 S S2=0
S2 S S2=$O(^DPT("ADIS",S,S1,S2)) G S1:'S2,S2:'$D(^DPT(S1,"DIS",S2,0)) S L=^(0),S3=$O(^DPT(S1,"DIS",S2)),L1="" I S3>0 S L1=^(S3,0)
 S SITE=+$P(L,"^",4),DIST=+$P(L,"^",7),ST=$P(L,U,2),SITE=$S(SITE>0:SITE,1:$S($D(^DD("SITE",1)):^(1),1:0)),DIS(SITE,DIST,+ST)=$S($D(DIS(SITE,DIST,+ST)):DIS(SITE,DIST,+ST),1:0)+1 G S2
 ;
DON S (SITE,PG)=0,DGX="" F II=0:0 S SITE=$O(DIS(SITE)) Q:'SITE!(DGX["^")  D PRINT
Q K %DT,D,DTD,DIS,I,I1,PG,POP,ST,T1,Z,T,TOT,S,S1,S2,S3,L,L1,L2,L3,ED,SD,SITE,DIST,STAT,X,Y D CLOSE^DGUTQ Q
 ;
PRINT ;
 D HD Q:DGX["^"  S S=0 F S1=0:1:2 S TOT(S1)=0,T(S1)=0
P1 S S=$O(^DIC(37,S)) D HD:($Y+4)>IOSL Q:DGX["^"  G TOT:'S W !,$S($D(^DIC(37,S,0)):$E($P(^(0),"^",1),1,30),S=0:"NOT DISPOSITIONED YET",1:"UNDEFINED DISPOSITION "_S),?30
 F T=-1:0 S T=$O(DIS(SITE,S,T)) Q:T=""  S T1=DIS(SITE,S,T),T(T)=T1,TOT(T)=TOT(T)+T1
 S T=0 F S1=0:1:2 W ?(S1*13+30),$J(T(S1),6) S T=T+T(S1),T(S1)=0
 W $J(T,13) G P1
TOT W ! F I=1:1:80 W "="
 W !!,"TOTAL" S TOT=0 F S1=0:1:2 W ?(S1*13+30),$J(TOT(S1),6) S TOT=TOT+TOT(S1)
 W $J(TOT,13),! Q
 ;
D S %=$E(Y,4,5)*3,Y=$E("JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC",%-2,%)_" "_$S($E(Y,6,7):$J(+$E(Y,6,7),2)_", ",1:"")_($E(Y,1,3)+1700)_$S(Y[".":"  "_$E(Y_0,9,10)_":"_$E(Y_"000",11,12),1:"") Q
 ;
MON S X1=SD,X2=+33 D C^%DTC S X1=$E(X,1,5)_"01",X2=-1 D C^%DTC S ED=X G OU
 Q
 ;
HD D CRCHK Q:DGX["^"  W @IOF W !?20,"REGISTRATION DISPOSITION SUMMARY",!?25,"for ",$S(SITE=0!('$D(^DG(40.8,SITE,0))):^DD("SITE",1),1:$P(^DG(40.8,SITE,0),"^",1)),!?20,"for " S Y=SD D D W Y," to " S Y=ED\1 D D W Y
 K %DT S X="N",%DT="TN" D ^%DT S DTD=+Y W !,?25," run " S Y=DTD D D W Y,?70,"PAGE: ",PG+1 S PG=PG+1
 W !!?31,"10-10",?38,"UNSCHEDULED",?52,"APPLICATIONS",!,"DISPOSITION",?30,"VISITS",?43,"VISITS",?54,"W/O EXAM",?70,"TOTAL",! F I=1:1:80 W "="
 Q
 ;
CRCHK I PG,$E(IOST,1)="C" W !!,*7,"Press RETURN to continue or '^' to stop " R X:DTIME S:'$T X="^" S DGX=X
 Q
