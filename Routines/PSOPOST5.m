PSOPOST5 ;BIR/RTR-Find Pending Orders for Patch 98 ;03/25/02
 ;;7.0;OUTPATIENT PHARMACY;**98**;DEC 1997
 ;External reference to PS(50.606 supported by DBIA 2174
 ;External reference to PS(50.7 supported by DBIA 2223
 ;External reference to PSDRUG supported by DBIA 221
 K ZTDTH
 N PSOBACKG S PSOBACKG=0
 I $D(ZTQUEUED) S ZTDTH=$H,PSOBACKG=1
 I $G(ZTDTH)="" D
 .W !!,"This background job will find all Outpatient Pending orders that may not",!,"show up in the Complete Orders from OERR option. The mail message will be",!,"sent to all PSNMGR key holders. Please forward to any other appropriate"
 W !,"pharmacy personnel for review."
 W ! S ZTRTN="START^PSOPOST5",ZTIO="",ZTDESC="Patch PSO*7*98 background job" D ^%ZTLOAD I '$D(ZTSK) D  S XPDABORT=2
 .W !!,"The status of this install will remain 'Start of Install'. Please reinstall",!,"this patch and queue this background job at that time.",!
 .I '$G(PSOBACKG) K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 Q
START ;
 N PSOPOR,PSOPOC,PSOTMP,PSOPNM,PSOPTR,PSODNAME,PSOISPD,PSOKEYN
 K ^TMP("PSOXORD",$J),^TMP("PSOPHOLD",$J),^TMP("PSOXPAT",$J)
 S PSOPOC=0,PSOTMP=6
 F PSOPOR=0:0 S PSOPOR=$O(^PS(52.41,PSOPOR)) Q:'PSOPOR  I $P($G(^PS(52.41,PSOPOR,0)),"^",3)="XO" D
 .S PSOPNODE=$G(^PS(52.41,PSOPOR,0))
 .S PSOPTR=$P(PSOPNODE,"^",2) I 'PSOPTR Q
 .S PSOPNM=$P($G(^DPT(PSOPTR,0)),"^")
 .S PSOPOC=PSOPOC+1
 .K PSODNAME
 .I $P(PSOPNODE,"^",9) S PSODNAME=$P($G(^PSDRUG($P(PSOPNODE,"^",9),0)),"^")
 .I $G(PSODNAME)="",$P(PSOPNODE,"^",8) D
 ..I $P($G(^PS(50.7,$P(PSOPNODE,"^",8),0)),"^")'="" S PSODNAME=$P($G(^PS(50.7,$P(PSOPNODE,"^",8),0)),"^")_"  "_$P($G(^PS(50.606,+$P($G(^PS(50.7,$P(PSOPNODE,"^",8),0)),"^",2),0)),"^")
 .S PSOISPD=$S($P(PSOPNODE,"^",12)="":"Unknown",1:$E($P(PSOPNODE,"^",12),4,5)_"/"_$E($P(PSOPNODE,"^",12),6,7)_"/"_$E($P(PSOPNODE,"^",12),2,3))
 .I '$D(^TMP("PSOXPAT",$J,PSOPTR)) S ^TMP("PSOPHOLD",$J,PSOPTR,PSOTMP)=" ",PSOTMP=PSOTMP+1 S ^TMP("PSOPHOLD",$J,PSOPTR,PSOTMP)="  Patient: "_$G(PSOPNM) S PSOTMP=PSOTMP+1,^TMP("PSOXPAT",$J,PSOPTR)=""
 .S ^TMP("PSOPHOLD",$J,PSOPTR,PSOTMP)=$S($G(PSODNAME)="":"DRUG NAME MISSING",1:$G(PSODNAME))_"    Issd: "_$G(PSOISPD) S PSOTMP=PSOTMP+1
MAIL ;Send mail message
 S XMDUZ="PSO*7*98 NON-DISPLAYED PENDING ORDERS SEARCH",XMSUB="NON-DISPLAYED OUTPATIENT PENDING ORDERS"
 S XMY(DUZ)=""
 F PSOKEYN=0:0 S PSOKEYN=$O(^XUSEC("PSNMGR",PSOKEYN)) Q:'PSOKEYN  S XMY(PSOKEYN)=""
 S ^TMP("PSOXORD",$J,1)="The following Outpatient Pending orders should be reviewed using",^TMP("PSOXORD",$J,2)="the Patient Prescription Processing option. These are orders"
 S ^TMP("PSOXORD",$J,3)="that were entered as 'change' orders through CPRS, but may",^TMP("PSOXORD",$J,4)="not have displayed when using the 'Complete Orders from OERR' option."
 S ^TMP("PSOXORD",$J,5)=" "
 S ^TMP("PSOXORD",$J,6)="Total number of orders found = "_+$G(PSOPOC)_$S(+$G(PSOPOC)=0:"  (Nothing to review)",1:"")
 S ^TMP("PSOXORD",$J,7)=" "
 S (PSOTMP,PSOTMPX)=0,PSOCRV=8
 F PSOTMP=0:0 S PSOTMP=$O(^TMP("PSOPHOLD",$J,PSOTMP)) Q:'PSOTMP  F PSOTMPX=0:0 S PSOTMPX=$O(^TMP("PSOPHOLD",$J,PSOTMP,PSOTMPX)) Q:'PSOTMPX  S ^TMP("PSOXORD",$J,PSOCRV)=$G(^TMP("PSOPHOLD",$J,PSOTMP,PSOTMPX)),PSOCRV=PSOCRV+1
 S XMTEXT="^TMP(""PSOXORD"",$J," N DIFROM D ^XMD K XMSUB,XMTEXT,XMY,XMDUZ
 K ^TMP("PSOXORD",$J),^TMP("PSOPHOLD",$J),^TMP("PSOXPAT",$J)
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
