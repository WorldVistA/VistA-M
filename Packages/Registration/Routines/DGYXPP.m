DGYXPP ;ALB/REW - Environment Check for ADT/R 10/1 Maintenance Patch ; 6/14/94
 ;;5.3;Registration;**66**;Aug 13, 1993
 ;
 ; NOTE: DGBDT = begin time (don't use in post-init modules)
 ;
% D NOW^%DTC S DGBDT=$H,DT=X,Y=% W !!,"Initialization Started: " D DT^DIQ W !!
USER I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to initialize.",! K DIFQ G NO
 ;
MAS53 I $D(DIFQ),+$G(^DG(43,1,"VERSION"))'=5.3 K DIFQ W !!,?3,"MAS Version 5.3 must be installed first!" G NO
 ;
NO I '$D(DIFQ) W !,"INITIALIZATION ABORTED"
 Q
