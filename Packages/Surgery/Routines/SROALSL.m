SROALSL ;BIR/ADM - SUMMARY LIST OF ASSESSED CASES ;11/13/07
 ;;3.0; Surgery ;**166**;24 Jun 93;Build 6
 N SRTOT,SRINC,SRCOM,SRTR,SREX
 S (GRAND,SRSOUT,SRTOT,SRINC,SRCOM,SRTR,SREX)=0,(SRHDR,SRPAGE)=1,SRTITLE="SUMMARY LIST OF ASSESSED CASES" K ^TMP("SRA",$J)
 N SRJ,SRNM S SRJ=0 F  S SRJ=$O(^SRO(137.45,SRJ)) Q:'SRJ  S SRNM=$P(^SRO(137.45,SRJ,0),"^"),^TMP("SRA",$J,SRNM)="0^0^0^0^0"
 ; total assessments^incomplete^complete^transmitted^excluded"
 S ^TMP("SRA",$J,"SPECIALTY NOT ENTERED")="0^0^0^0^0"
 F  S SRSD=$O(^SRF("AC",SRSD)) Q:'SRSD!(SRSD>SRED)!SRSOUT  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSD,SRTN)) Q:'SRTN!SRSOUT  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D UTL
 I SRFLG,SRASP S SRSPEC=$P(^SRO(137.45,SRASP,0),"^") D SRASP Q
 I SRSP S SRNM="" F  S SRNM=$O(^TMP("SRA",$J,SRNM)) Q:SRNM=""  D SRSS Q:SRSOUT
 I $Y+5>IOSL!SRHDR D PAGE I SRSOUT Q
 D TOT
 Q
UTL ; set up TMP global
 N SRJ,SRK,SRST I '$P($G(^SRF(SRTN,.2)),"^",3)&'$P($G(^SRF(SRTN,.2)),"^",12) Q
 I $P($G(^SRF(SRTN,30)),"^") Q
 S SRJ=$P(^SRF(SRTN,0),"^",4) I SRFLG,SRJ'=SRASP Q
 S SRNM=$S(SRJ:$P(^SRO(137.45,SRJ,0),"^"),1:"SPECIALTY NOT ENTERED")
 S SRA=$G(^SRF(SRTN,"RA")) I $P(SRA,"^",2)="N",$P(SRA,"^",7)'="" D EXCL Q
 Q:$P(SRA,"^",6)'="Y"
 S SRST=$P(SRA,"^") Q:SRST=""!("ICT"'[SRST)  D
 .S $P(^TMP("SRA",$J,SRNM),"^")=$P(^TMP("SRA",$J,SRNM),"^")+1,SRTOT=SRTOT+1
 .I SRST="I" S $P(^TMP("SRA",$J,SRNM),"^",2)=$P(^TMP("SRA",$J,SRNM),"^",2)+1,SRINC=SRINC+1 Q
 .I SRST="C" S $P(^TMP("SRA",$J,SRNM),"^",3)=$P(^TMP("SRA",$J,SRNM),"^",3)+1,SRCOM=SRCOM+1 Q
 .S $P(^TMP("SRA",$J,SRNM),"^",4)=$P(^TMP("SRA",$J,SRNM),"^",4)+1,SRTR=SRTR+1
 Q
SRSS ;
 I $Y+5>IOSL!SRHDR D PAGE I SRSOUT Q
 S SRX=^TMP("SRA",$J,SRNM) Q:'$P(SRX,"^")
 W !,$E(SRNM,1,30),?37,$J($P(SRX,"^",2),5),?48,$J($P(SRX,"^",3),5),?60,$J($P(SRX,"^",4),5),?72,$J($P(SRX,"^",5),5)
 Q
SRASP D HDR S SRX=^TMP("SRA",$J,SRSPEC) W !,$E(SRSPEC,1,30),?37,$J($P(SRX,"^",2),5),?48,$J($P(SRX,"^",3),5),?60,$J($P(SRX,"^",4),5),?72,$J($P(SRX,"^",5),5)
 Q
EXCL ; add excluded cases
 S $P(^TMP("SRA",$J,SRNM),"^")=$P(^TMP("SRA",$J,SRNM),"^")+1,SRTOT=SRTOT+1
 S $P(^TMP("SRA",$J,SRNM),"^",5)=$P(^TMP("SRA",$J,SRNM),"^",5)+1,SREX=SREX+1
 Q
PAGE I $E(IOST)="P"!SRHDR G HDR
 W !!,"Press <RET> to continue, or '^' to quit  " R X:DTIME I '$T!(X["^") S SRSOUT=1 Q
 I X["?" W !!,"If you want to continue the listing, press the 'Enter' key.",!,"Type '^' to return to the menu." G PAGE
HDR ; print heading
 W @IOF,!,?(80-$L(SRTITLE)\2),SRTITLE,?70,$J("PAGE "_SRPAGE,9) W:$E(IOST)="P" !,?(80-$L(SRINST)\2),SRINST W !,?(80-$L(SRFRTO)\2),SRFRTO
 W:$E(IOST)="P" !,?(80-$L(SRPRINT)\2),SRPRINT
 W !!,"SURGICAL SPECIALTY",?33,"INCOMPLETE | COMPLETE | TRANSMITTED | EXCLUDED",! F LINE=1:1:80 W "="
 S SRHDR=0,SRPAGE=SRPAGE+1
 Q
TOT W !!,"TOTAL FOR ALL SPECIALTIES: ",?37,$J(SRINC,5),?48,$J(SRCOM,5),?60,$J(SRTR,5),?72,$J(SREX,5)
 Q
