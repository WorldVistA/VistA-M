SROATMIT ;BIR/MAM - STUFF TRANMISSION IN ^TMP ;03/22/06
 ;;3.0; Surgery ;**18,27,38,55,62,68,153**;24 Jun 93;Build 11
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 K ^TMP("SRA",$J),^TMP("SRAMSG",$J),^TMP("SRWL",$J) S SRATOT=0,SRASITE=+$P($$SITE^SROVAR,"^",3),(SRAMNUM,SRACNT)=1
 S SRADFN=0 F  S SRADFN=$O(^SRF("ARS","N","I",SRADFN)) Q:'SRADFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","N","I",SRADFN,SRTN)) Q:'SRTN  S SR("RA")=$G(^SRF(SRTN,"RA")) I $P(SR("RA"),"^",2)="N" D CANCHK
 S SRADFN=0 F  S SRADFN=$O(^SRF("ARS","C","I",SRADFN)) Q:'SRADFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","C","I",SRADFN,SRTN)) Q:'SRTN  S SR("RA")=$G(^SRF(SRTN,"RA")) D CANCHK
 S SRADFN=0 F  S SRADFN=$O(^SRF("ARS","N","C",SRADFN)) Q:'SRADFN  S SRTN=0 F  S SRTN=$O(^SRF("ARS","N","C",SRADFN,SRTN)) Q:'SRTN  S SR("RA")=$G(^SRF(SRTN,"RA")) D STUFF
 S SRATOTM=SRAMNUM D ^SROATM4
 D ^SROATCM
 D ^SROATMNO
 D WL
 I $D(ZTQUEUED) S ZTREQ="@"
 Q
STUFF ; stuff entries into ^TMP("SRA"
 ; check ARS cross-reference
 I $P(^SRF(SRTN,"RA"),"^",2)="C" K ^SRF("ARS","N","C",SRADFN,SRTN) K DR S DIE=130,DR="235///C",DA=SRTN D ^DIE K DR Q
 I $P(SR("RA"),"^",2)'="N" Q
 D CANCHK I 'OK Q
 I $P(SR("RA"),"^",6)="N" S ^SRF("ARS","N","C",SRADFN,SRTN)=1 Q
 I SRACNT+15>100 S SRACNT=1,SRAMNUM=SRAMNUM+1
 S SRATOT=SRATOT+1,X=$E($P(^SRF(SRTN,0),"^",9),1,5)_"00",^TMP("SRWL",$J,X)=""
 K SRA,VADM D ^SROATM1 K SHEMP,VADM,SRA
 Q
CANCHK ; check to see if case has been cancelled
 S OK=1,X=$P($G(^SRF(SRTN,30)),"^") I X S OK=0
 S X=$P($G(^SRF(SRTN,31)),"^",8) I X'="" S OK=0
 I 'OK K DA,DIE,DR S DA=SRTN,DIE=130,DR="102///@;235///@;284///@;323///@" D ^DIE K DR,DA,DIE
 Q
WL ; send workload updates
 N SRSEL S SRP=0,SRT=1,X=$$SITE^SROVAR,SRINST=$P(X,"^",2),SRSTATN=+$P(X,"^",3),SRDT=0,SRNOACK=1 D DTCHK
 F  S SRDT=$O(^TMP("SRWL",$J,SRDT)) Q:'SRDT  I SRDT>SRLO S SRSEL=1 D ^SROAWL1
 K ^TMP("SRWL",$J),SRLO
 Q
DTCHK N X,Y
 S X=$E(DT,1,3),Y=+$E(DT,4,7),SRLO=$S(Y<1000:X-2,1:X-1)_"0900"
 Q
