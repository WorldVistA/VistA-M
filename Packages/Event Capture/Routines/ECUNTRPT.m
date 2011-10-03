ECUNTRPT ;ALB/DHE DSS Units Errors Report ; 12/3/09 10:47am
 ;;2.0; EVENT CAPTURE ;**107**;8 May 96;Build 14
 ;
 ;This report displays DSS Units with any Associated Stop Codes
 ;with any errors or warnings.
 ;
 ;Routine entry point, START if from roll and scroll, EN if
 ;from GUI
 ;
 ;need to set up output device and taskman
START ;
 W @IOF,!!,"This option displays DSS Units with Associated Stop Code Errors.",!!
 S %ZIS="QM" D ^%ZIS G EXIT:POP
 I $D(IO("Q")) D  Q
 . N ZTRTN,ZTDESC
 . S ZTRTN="EN^ECUNTRPT",ZTDESC="DSS Units with Assoc Stop Codes"
 . D ^%ZTLOAD D HOME^%ZIS K IO("Q") Q
 U IO
EN ;
 N I,CNTR,DATE,ECERR,ECNAME,ECOUT,ECRDT,ECSTOP,ECSTOP1,ERR,INACT,LN
 N PG,RTYPE,STR,UNITNM,UNT
 ;
 S %H=$H,ECRDT=$$HTE^XLFDT(%H,"5M"),ECOUT=0
 S CNTR=0,PG=1,UNT=0,$P(LN,"-",80)=""
 D HEAD
 F  S UNT=$O(^ECD(UNT)) Q:'UNT  D  I ECOUT Q
 .Q:'$D(^ECD(UNT,0))
 .;check to see if unit is inactive
 .I $P(^ECD(UNT,0),"^",6)=1 Q
 .;get associated stop code
 .S ECSTOP=$P(^ECD(UNT,0),"^",10) Q:$G(ECSTOP)=0!(ECSTOP="")
 .;
 .S UNITNM=$P($G(^ECD(UNT,0)),U),ERR=0
 .S STR=$G(^DIC(40.7,ECSTOP,0))
 .I $G(STR)="" S ERR=ERR+1,ECERR(ERR)="CODE DOES NOT EXIST IN FILE 40.7",ECNAME="" Q
 .S ECNAME=$P(STR,U),ECSTOP1=$P(STR,U,2),INACT=$P(STR,U,3),RTYPE=$P(STR,U,6)
 .I $L(ECSTOP1)'=3 S ERR=ERR+1,ECERR(ERR)="CODE MUST BE 3 DIGITS"
 .I $G(INACT),((DT>INACT)!(DT=INACT)) S ERR=ERR+1,ECERR(ERR)="INACTIVE CODE"
 .I (RTYPE'=("P"))&(RTYPE'=("E")) S ERR=ERR+1,ECERR(ERR)="SECONDARY CODE"
 .I ($Y+4)>IOSL D PAGE Q:ECOUT  D HEAD
 .;if errors, loop through array, write, then kill
 .I ERR D  S ERR=0 K ECERR
 ..W !!,"DSS Unit: ",?12,UNT,?19,UNITNM
 ..W !,"Stop Code: ",?12,ECSTOP1,?19,ECNAME
 ..F I=1:1:ERR W !,"Reason: ",ECERR(ERR)
 Q
EXIT ;
 K POP,QUIT,ZTQUEUED
 Q
 ;
HEAD ;header
 W:$E(IOST,1,2)="C-"!(PG>1) @IOF
 W !!,"DSS UNITS WITH ANY ASSOCIATED STOP CODE ERRORS"
 W !,"Page: ",PG,?53,"Run Date: ",ECRDT,!,LN
 S PG=PG+1
 Q
PAGE ;
 N SS,JJ
 I $D(PG),$E(IOST,1,2)="C-" D
 .S SS=22-$Y F JJ=1:1:22 W !
 .S DIR(0)="E" W ! D ^DIR K DIR I 'Y S ECOUT=1
 Q
 ;
STRTGUI ; if called from GUI, enter routine here
 D EN
 Q
