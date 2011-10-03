IBDEPRE ; ALB/ISC - PREINIT FOR USE BY IMP/EXP UTILITY ;AUG 13, 1993
 ;;3.0;AUTOMATED INFO COLLECTION SYS;;APR 24, 1997
 ;
P D NOW^%DTC S IBDBDT("IBDE")=$H,DT=$$DT^XLFDT,Y=% W !!,"Initialization Started: " D DT^DIQ
 ;
 ;
PRE W !!
 ;
USER I $S('($D(DUZ)#2):1,'$D(^VA(200,+DUZ,0)):1,'$D(DUZ(0)):1,DUZ(0)'="@":1,1:0) W !!?3,"The variable DUZ must be set to an active user code and the variable",!?3,"DUZ(0) must equal '@' to initialize.",! K DIFQ G NO
 ;
 Q:'$D(DIFQ)
 ;
CHECK ;checks if there is anything in the workspace
 N COUNT,FILE,QUIT
 S (QUIT,COUNT)=0
 F  S FILE=$P($T(FILES+COUNT),";;",2) Q:QUIT!(FILE="")  D  Q:QUIT
 .S COUNT=COUNT+1
 .I $O(@FILE@(0)) D
 ..K DIR S DIR(0)="Y",DIR("B")="YES"
 ..W !,"Please check your work space from the import/export utility option.",!!,"These INITS require that your work space be clear, currently it is not.",!,"Would you like to clear the work space now?"
 ..D ^DIR
 ..I $D(DIRUT)!(Y=0) K DIFQ
 ..S QUIT=1
 ;
 I '$D(DIFQ) W !,"INITIALIZATION ABORTED" K IBDBDT
 K DIR,DIRUT,DUOUT
 Q
 ;
NO I '$D(DIFQ) W !,"INITIALIZATION ABORTED" K IBDBDT
 K DIR,DIRUT,DUOUT
 Q
 ;
FILES ;;^IBE(358)
 ;;^IBE(358.1)
