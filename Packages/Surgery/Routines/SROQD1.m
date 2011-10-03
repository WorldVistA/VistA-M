SROQD1 ;BIR/ADM - CASES WITH DEATHS WITHIN 30 DAYS ;01/29/98
 ;;3.0; Surgery ;**62,70,77,142**;24 Jun 93
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure.  Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^DIC(45.3 supported by DBIA #218
 ;
NAT ; loop through national specialties
 D HDR I SRSPEC S SRNAT=SRSPEC,SRNATNM=$P(^DIC(45.3,SRNAT,0),"^",2),SRDNAT=0 D PATS Q
 S SRNAT=0 F  S SRNAT=$O(^DIC(45.3,SRNAT)),SRSNM=0 Q:'SRNAT!SRSOUT  I $D(^TMP("SRSEC",$J,SRNAT)) S SRNATNM=$P(^DIC(45.3,SRNAT,0),"^",2),SRDNAT=0 D PATS
 I $D(^TMP("SRSEC",$J,9999)) S SRNAT=9999,SRNATNM="SPECIALTY NOT ENTERED",SRDNAT=0 D PATS
 D:'SRSOUT SUM1
 Q
IP ; loop through index procedures
 D TMP^SROQ0A D HDR F SRNAT=1:1:12 S SRSNM=0 Q:SRSOUT  I $D(^TMP("SRSEC",$J,SRNAT)) S SRNATNM=^TMP("SRIP",$J,SRNAT),SRDNAT=0 D PATS
 D:'SRSOUT SUM1
 Q
NEW ; print national specialty or index procedure category
 D:$Y+9>IOSL PAGE Q:SRSOUT  I SRNATNM["," S SRNATNM=$P(SRNATNM,",")_$P(SRNATNM,", ",2)
 W !,">>> "_SRNATNM_" <<<",! S SRSNM=1
 Q
PATS ; print patient list
 D NEW S SRNM="" F  S SRNM=$O(^TMP("SRSEC",$J,SRNAT,SRNM)) Q:SRNM=""!SRSOUT  S DFN=0 F  S DFN=$O(^TMP("SRSEC",$J,SRNAT,SRNM,DFN)) Q:'DFN!SRSOUT  D CASE
 D:'SRSOUT SUM
 Q
CASE ; print case information
 S SRDNAT=SRDNAT+1,SRDTOT=SRDTOT+1 I $Y+7>IOSL D PAGE Q:SRSOUT
 S SRZ=^TMP("SRPAT",$J,SRNM,DFN),SRSSN=$P(SRZ,"^"),(SRDD,X1)=$P(SRZ,"^",3),X2=$P(SRZ,"^",2),SRAGE=$E(X1,1,3)-$E(X2,1,3)-($E(X1,4,7)<$E(X2,4,7))
 S X=SRDD,SRDD=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S SRTN=^TMP("SRSEC",$J,SRNAT,SRNM,DFN),SR=^SRF(SRTN,0),X=$P(SR,"^",9),SRX=^TMP("SR",$J,DFN,X,SRTN),SRSD=$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3)
 S Y=$P(SRX,"^",2),SRIOSTAT=$S(Y="I":"INPAT",Y="O":"OUTPAT",1:"???")
 S Y=$P(SRX,"^",3),SRREL=$S(Y="U":"UNRELATED",Y="R":"RELATED",1:"???")
 S X=$P(SR,"^",4),SRSS=$S(X:$P(^SRO(137.45,X,0),"^"),1:"SPECIALTY NOT ENTERED"),SRL=86,SRSUPCPT=1 D PROC^SROUTL
 W !,SRSD,?12,SRNM,?44,SRDD,?60,SRSS,?102,SRIOSTAT,?111,SRREL,!,SRTN,?12,SRSSN_"  ("_SRAGE_")" S I=0 F  S I=$O(SRPROC(I)) Q:'I  W ?44,SRPROC(I),!
 Q
PAGE I $E(IOST)="P"!SRHDR G HDR
 D PRESS I SRSOUT Q
HDR ; print heading
 I $D(ZTQUEUED) D ^SROSTOP I SRHALT S SRSOUT=1 Q
 W:$Y @IOF W:$E(IOST)="P" !,?(IOM-$L(SRINST)\2),SRINST W !,?(IOM-$L(SRRPT)\2),SRRPT,?(IOM-10),$J("PAGE "_SRPAGE,9),!,?(IOM-$L(SRFRTO)\2),SRFRTO,!,?(IOM-$L(SRPRINT)\2),SRPRINT
 W !!,"OP DATE",?12,"PATIENT NAME",?44,"DATE OF DEATH",?60,"LOCAL SPECIALTY",?102,"IN/OUT",?111,"DEATH RELATED"
 W !,"CASE #",?12,"PATIENT ID#  (AGE)",?44,"PROCEDURE(S)"
 S SRHDR=0,SRPAGE=SRPAGE+1 W ! F I=1:1:IOM W "="
 I SRSNM W !,">>> "_SRNATNM_" <<<   * * Continued from previous page * *"
 Q
SUM ; print total for specialty or index procedure
 D:$Y+6>IOSL PAGE Q:SRSOUT
 W !!,"TOTAL DEATHS FOR "_SRNATNM_": "_SRDNAT,! F I=1:1:IOM W "-"
 Q
SUM1 ; print grand total for all specialties or index procedures
 D:$Y+6>IOSL PAGE Q:SRSOUT
 W !!,"TOTAL FOR ALL "_$S(SRSEL=2:"SPECIALTIES",1:"INDEX PROCEDURES")_": "_SRDTOT
 Q
PRESS W !! K DIR S DIR(0)="E" D ^DIR K DIR I $D(DTOUT)!$D(DUOUT) S SRSOUT=1
 Q
