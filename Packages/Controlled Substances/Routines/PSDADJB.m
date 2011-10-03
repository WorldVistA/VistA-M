PSDADJB ;BIR/LTL-Review Adjustment Transactions for a Drug; 2 Nov 94 [ 05/01/95  3:11 PM ]
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
START ;compiles and prints output
 S PSDTI="Adjustments from "_PSDTB(2)_" to "_PSDTB(3)
 N PSDR,PG S PSDT=PSDTB,CNT=0 S $P(LN,"-",81)=""
LOOP F  S PSDT=$O(^PSD(58.81,"ACT",PSDT)) Q:'PSDT!(PSDT>PSDTB(1))  I $O(^PSD(58.81,"ACT",PSDT,0))=PSDLOC S PSDT(1)=$O(^PSD(58.81,"ACT",PSDT,PSDLOC,0)) I $D(PSDA(+PSDT(1))),$O(^PSD(58.81,"ACT",PSDT,PSDLOC,+PSDT(1),9,0)) D
 .S PSDR(2)=$G(^PSD(58.81,+$O(^PSD(58.81,"ACT",PSDT,PSDLOC,+PSDT(1),9,0)),0))
 .S CNT=$G(CNT)+1,^TMP("PSD",$J,CNT)=LN
 .S CNT=$G(CNT)+1,^TMP("PSD",$J,CNT)=PSDA(+PSDT(1))
 .S Y=$E($P(PSDR(2),U,4),1,12),CNT=$G(CNT)+1 X ^DD("DD") S ^TMP("PSD",$J,CNT)=Y_"  "_" -> "_$P(PSDR(2),U,6)_" adjusted by "_$P($G(^VA(200,+$P(PSDR(2),U,7),0)),U)
 .S CNT=$G(CNT)+1,^TMP("PSD",$J,CNT)="Reason:  "_$P(PSDR(2),U,16)
 D BROWSE^DDBR("^TMP(""PSD"",$J)","NR",PSDTI)
END W:$E(IOST)'="C" @IOF
 I $E(IOST)="C",'PSDOUT S DIR(0)="EA",DIR("A")="END OF REPORT!  Press <RET> to return to the menu." D ^DIR
 D ^%ZISC S:$D(ZTQUEUED) ZTREQ="@" K IO("Q")
 K ^TMP("PSD",$J) Q
