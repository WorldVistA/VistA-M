IBOUTL ;ALB/AAS - INTEGRATED BILLING OUTPUT UTILITY ROUTINE ; 8-MAR-91
V ;;2.0;INTEGRATED BILLING;**93**;21-MAR-94
 ;
DATE ;
 ;  -get beginning and ending dates
 ;  -output in ibbdt - beginning date
 ;             ibedt - ending date
 ;
BDT ;  -get beginning date
 S (IBBDT,IBEDT)=""
 S %DT="AEX",%DT("A")="Start with DATE: " D ^%DT K %DT G DATEQ:Y<0 S IBBDT=Y
 ;
EDT ;  -get ending date
 S %DT="EX" R !,"Go to DATE: ",X:DTIME S:X=" " X=IBBDT G DATEQ:(X="")!(X["^") D ^%DT G EDT:Y<0 S IBEDT=Y I Y<IBBDT W *7," ??",!,"ENDING DATE must follow BEGINNING DATE." G BDT
 ;
DATEQ K %DT
 Q
 ;
PAUSE Q:$E(IOST,1,2)'["C-"
 F IBJ=$Y:1:(IOSL-4) W !
 S DIR(0)="E" D ^DIR K DIR I $D(DIRUT)!($D(DUOUT)) S IBQUIT=1 K DIRUT,DTOUT,DUOUT
 Q
 ;
DAT1(X,Y) ; Convert FM date to displayable (mm/dd/yy) format.
 ; -- optional output of time, if $g(y) 
 N DATE,T
 S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 I $G(Y) S T="."_$E($P(X,".",2)_"000000",1,7) I T>0 S DATE=DATE_" "_$S($E(T,2,3)>12:$E(T,2,3)-12,$E(T,2,3)="00":"00",1:+$E(T,2,3))_":"_$E(T,4,5)_$S($E(T,2,5)>1200:" pm",1:" am")
 Q DATE
 ;
DAT2(Y) ; Convert FM date to displayable (mmm dd yyyy) format
 N %
 Q:'$D(Y) "" D D^DIQ
 Q Y
 ;
DAT3(X) ;Convert FM date to displayable (mm/dd/yyyy) format.
 N DATE,YR
 I $G(X) S YR=($E(X,1,3)+1700)
 I $G(X) S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$G(YR),1:"")
 Q $G(DATE)
 ;
ACTNM(X) ;  -input pointer to action type file (350.1)
 ;   output printable name of action type
 S Y=$P($G(^IBE(350.1,+X,0)),"^",9) ;new action type
 Q $S($P($G(^IBE(350.1,+Y,0)),"^",8)]"":$P(^(0),"^",8),$P($G(^IBE(350.1,+X,0)),"^",8)]"":$P(^(0),"^",8),1:$P($G(^IBE(350.1,+X,0)),"^"))
 ;
STOP(JOBDESC) ; Has a tasked job been requested to stop by the user?
 ;  Input:   JOBDESC  --  Description of job to be printed
 ;  Output:        0  --  Job has not been stopped
 ;                 1  --  Job has been stopped
 ;
 ;  If the job HAS been requested to stop, the Taskman flag ZTSTOP is
 ;  set to 1.  The check 'I $G(ZTSTOP)' can also be used in application
 ;  code after calling this function, in the event that the function
 ;  call is deeply nested.
 ;
 I $D(ZTQUEUED),$$S^%ZTLOAD S ZTSTOP=1 W !!?5,"'"_$S($D(JOBDESC):JOBDESC,1:"Unknown Task")_"' stopped at user's request..."
 Q $G(ZTSTOP)
FY(DATE)        ;Return FY for date, DT is default
 NEW FY
 S:$G(DATE)'?7N.E DATE=DT
 S FY=$E(DATE,2,3) S:$E(DATE,4,5)>9 FY=FY+1 S:FY=100 FY="00"
 S:$L(FY)<2 FY="0"_FY
 Q FY
