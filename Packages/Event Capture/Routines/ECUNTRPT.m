ECUNTRPT ;ALB/DHE DSS Units Errors Report ;10/12/12  11:21
 ;;2.0;EVENT CAPTURE;**107,119**;8 May 96;Build 12
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
 N PG,RTYPE,STR,UNITNM,UNT,CNT ;119
 ;
 S %H=$H,ECRDT=$$HTE^XLFDT(%H,"5M"),ECOUT=0
 S CNTR=0,PG=1,UNT=0,$P(LN,"-",80)=""
 I $G(ECPTYP)'="E" D HEAD ;119
 I $G(ECPTYP)="E" S CNT=1,^TMP($J,"ECRPT",CNT)="DSS UNIT #^DSS UNIT NAME^STOP CODE^STOP CODE NAME^ERROR #1^ERROR #2^ERROR #3" ;119
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
 .I $G(ECPTYP)'="E" I ($Y+4)>IOSL D PAGE Q:ECOUT  D HEAD ;119
 .;if errors, loop through array, write, then kill
 .I ERR D  S ERR=0 K ECERR
 ..I $G(ECPTYP)="E" D EXPORT Q  ;119
 ..W !!,"DSS Unit: ",?12,UNT,?19,UNITNM
 ..W !,"Stop Code: ",?12,ECSTOP1,?19,ECNAME
 ..F I=1:1:ERR W !,"Reason: ",ECERR(I) ;119
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
 ;
EXPORT ;Section added in 119, puts data in exportable format
 N I
 S CNT=CNT+1,^TMP($J,"ECRPT",CNT)=UNT_U_UNITNM_U_ECSTOP1_U_ECNAME
 F I=1:1:ERR S ^TMP($J,"ECRPT",CNT)=^TMP($J,"ECRPT",CNT)_U_ECERR(I)
 Q
