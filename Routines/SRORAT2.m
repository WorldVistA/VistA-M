SRORAT2 ;B'HAM ISC/MAM - CANCELLATION RATES, ALL ; [ 04/06/00  10:19 AM ]
 ;;3.0; Surgery ;**14,63,94**;24 Jun 93
 S (PAGE,SRSOUT,SRHDR)=0 K ^TMP("SR",$J),^TMP("SRT",$J)
 S SRSDATE=SRSD-.0001,SREDT=SRED+.9999,^TMP("SR",$J)="0^0^0"
 F  S SRSDATE=$O(^SRF("AC",SRSDATE)) Q:'SRSDATE!(SRSDATE>SREDT)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDATE,SRTN)) Q:'SRTN  I $D(^SRF(SRTN,0)),$$MANDIV^SROUTL0(SRINSTP,SRTN) D UTIL
 D ^SRORATP
 Q
UTIL ; set ^TMP
 Q:$P($G(^SRF(SRTN,"NON")),"^")="Y"  S STORE=0,TYPE=$P(^SRF(SRTN,0),"^",10) Q:TYPE="EM"
 I $P($G(^SRF(SRTN,30)),"^")=""&($P($G(^(31)),"^",4)="")&($P($G(^(31)),"^",5)="") Q
 I $P($G(^SRF(SRTN,30)),"^") S STORE=2
 I $P($G(^SRF(SRTN,31)),"^",8) S STORE=2
 I $P($G(^SRF(SRTN,.2)),"^",12) S STORE=1,AVOID=""
 I 'STORE Q
 I STORE=2 S AVOID=0,X=$S($D(^SRF(SRTN,31)):$P(^(31),"^",8),1:""),REASON=$S(X:$P(^SRO(135,X,0),"^")_"^"_$P($G(^SRF(SRTN,30)),"^",2),1:"ZZNO REASON ENTERED"_"^"_"A") S AVOID=$S($P(REASON,"^",2)="N":0,1:1),REASON=$P(REASON,"^")
 S SRSS=$P(^SRF(SRTN,0),"^",4),SRSS=$S('SRSS:"ZZ",1:$P(^SRO(137.45,SRSS,0),"^"))
 I '$D(^TMP("SRT",$J,SRSS)) S ^TMP("SRT",$J,SRSS)="0^0^0"
 I STORE=2,'$D(^TMP("SRT",$J,SRSS,REASON)) S ^TMP("SRT",$J,SRSS,REASON)="0^0"
 I STORE=2,'$D(^TMP("SR",$J,REASON)) S ^TMP("SR",$J,REASON)="0^0"
 I STORE=1 S $P(^TMP("SR",$J),"^",3)=$P(^TMP("SR",$J),"^",3)+1,$P(^TMP("SRT",$J,SRSS),"^",3)=$P(^TMP("SRT",$J,SRSS),"^",3)+1 Q
 S $P(^TMP("SR",$J),"^")=$P(^TMP("SR",$J),"^")+1 I STORE=2 S $P(^TMP("SR",$J,REASON),"^")=$P(^TMP("SR",$J,REASON),"^")+1
 S $P(^TMP("SRT",$J,SRSS),"^")=$P(^TMP("SRT",$J,SRSS),"^")+1 I STORE=2 S $P(^TMP("SRT",$J,SRSS,REASON),"^")=$P(^TMP("SRT",$J,SRSS,REASON),"^")+1
 I 'AVOID Q
 S $P(^TMP("SR",$J),"^",2)=$P(^TMP("SR",$J),"^",2)+1,$P(^TMP("SR",$J,REASON),"^",2)=$P(^TMP("SR",$J,REASON),"^",2)+1
 S $P(^TMP("SRT",$J,SRSS),"^",2)=$P(^TMP("SRT",$J,SRSS),"^",2)+1,$P(^TMP("SRT",$J,SRSS,REASON),"^",2)=$P(^TMP("SRT",$J,SRSS,REASON),"^",2)+1
 Q
