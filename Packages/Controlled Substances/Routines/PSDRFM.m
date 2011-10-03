PSDRFM ;BIR/JPW-File/Adj Mail Msg ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
MSG ;send mailman message with count correction adj info
 S PHARMN1=$S($P($G(^VA(200,+PHARM1,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),PSDRN=$S($P($G(^PSDRUG(+PSDR,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 K XMY,^TMP("PSDTAMSG",$J) S Y=PSDT X ^DD("DD") S RDT=Y S ^TMP("PSDTAMSG",$J,1,0)="Controlled Substances count correction has been filed."
 S (^TMP("PSDTAMSG",$J,1.5,0),^TMP("PSDTAMSG",$J,1.7,0))=""
 S ^TMP("PSDTAMSG",$J,1.6,0)="Option used: "_$P($G(XQY0),U,2)
 S ^TMP("PSDTAMSG",$J,2,0)="Correction Date/Time: "_RDT,^TMP("PSDTAMSG",$J,3,0)=""
 S ^TMP("PSDTAMSG",$J,4,0)="Ward signed out from: "_$G(NAOUN)
 S:$G(PAT) ^TMP("PSDTAMSG",$J,4.5,0)="Patient: "_$P($G(^DPT(+PAT,0)),U)
 S ^TMP("PSDTAMSG",$J,5,0)="Drug: "_PSDRN
 S ^TMP("PSDTAMSG",$J,6,0)="Quantity adjusted: "_-QTY
 S ^TMP("PSDTAMSG",$J,7,0)="Adjusted by: "_PHARMN1
 S ^TMP("PSDTAMSG",$J,8,0)="Witnessed by: "_$P($G(^VA(200,+$G(NUR2),0)),U)
 S ^TMP("PSDTAMSG",$J,9,0)="Reason: "_$G(PSDRE)
 S XMSUB="CONTROLLED SUBS ADJUSTMENT",XMTEXT="^TMP(""PSDTAMSG"",$J,",XMDUZ="CONTROLLED SUBSTANCES MONITOR"
 F JJ=0:0 S JJ=$O(^XUSEC("PSD ERROR",JJ)) Q:'JJ  S XMY(JJ)=""
 I $P($G(^PSD(58.8,+$G(NAOU),6)),U) S XMY("G."_$P($G(^XMB(3.8,+$P($G(^PSD(58.8,+$G(NAOU),6)),U),0)),U))="" W !!,"Notifying "
 S:'$D(XMY) XMY(.5)="" D ^XMD K XMY,^TMP("PSDTAMSG",$J)
 K JJ,PHARMN1,PSDRN,RDT,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 Q
