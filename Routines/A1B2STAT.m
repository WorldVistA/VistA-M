A1B2STAT ;ALB/AAS - ODS SYSTEM STATUS SCREEN ; 1/14/91
 ;;Version 1.55 (local for MAS v5 sites);;
 ;
% S U="^" D HOME^%ZIS
 ;
 W @IOF,"Operation Desert Shield - Software Status"
 S X="",$P(X,"=",IOM)="" W !,X
 S A1B2N=$S($D(^A1B2(11500.5,1,0)):^(0),1:"")
 W !,"ODS Software Active ........................ ",$S($P(A1B2N,"^",2):"YES",1:"NO")
 W !,"ODS Software Activation date ............... " S Y=$P(A1B2N,"^",3) D DT^DIQ
 W !,"Date of last ODS Rollup .................... " S Y=$P(A1B2N,"^",4) D DT^DIQ
 W !,"Status Last Rollup ......................... " I $P(A1B2N,"^",5)]"" W $P($P($P(^DD(11500.5,.05,0),"^",3),$P(A1B2N,"^",5)_":",2),";",1)
 W !,"Message sent to ............................ " I $P(A1B2N,"^",6),$D(^DIC(4.2,$P(A1B2N,"^",6),0)) W $P(^DIC(4.2,$P(A1B2N,"^",6),0),"^")
LAST W !!,"Since Midnight Last Night" D CALC
 W !,"-------------------------"
 W !,"Number Patients in Last Rollup ............. ",C(.1)
 W !,"Number Admissions in Last Rollup ........... ",C(.2)
 W !,"Number Displaced VA Pts in Last Rollup ..... ",C(.3)
 W !,"Number Registered ODS Pts in Last Rollup ... ",C(.4)
TOT W !!,"Total Entries in ODS files"
 W !,"--------------------------"
 W !,"ODS Patients ............................... ",$S($D(^A1B2(11500.1,0)):$P(^(0),"^",4),1:"")
 W !,"ODS Admissions ............................. ",$S($D(^A1B2(11500.2,0)):$P(^(0),"^",4),1:"")
 W !,"ODS Displaced Patients ..................... ",$S($D(^A1B2(11500.3,0)):$P(^(0),"^",4),1:"")
 W !,"ODS Registrations .......................... ",$S($D(^A1B2(11500.4,0)):$P(^(0),"^",4),1:"")
 ;
 W !! S DIR(0)="E" D ^DIR
END K A1B2N,DIR,X,Y,A1B2FI,C,I,J
 Q
 ;
CALC ;  -- count entries rolled up since midnight
 F I=.1:.1:.4 S A1B2FI=11500+I S C(I)=0,X=DT F J=0:0 S X=$O(^A1B2(A1B2FI,"AXDT",X)) Q:'X!(X>(DT+.99))  S C(I)=C(I)+1
 Q
