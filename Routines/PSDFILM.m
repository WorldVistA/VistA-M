PSDFILM ;BIR/JPW-File/Adj TRAKKER Mail Msg ; 29 Aug 94
 ;;3.0; CONTROLLED SUBSTANCES ;;13 Feb 97
MSG ;send mailman message with trakker adj info
 S PHARMN1=$S($P($G(^VA(200,+PHARM1,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN"),PSDRN=$S($P($G(^PSDRUG(+PSDR,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")
 K XMY,^TMP("PSDTAMSG",$J) S Y=PSDT X ^DD("DD") S RDT=Y S ^TMP("PSDTAMSG",$J,1,0)="CS PHARM TRAKKER adjustment/error has been filed."
 S ^TMP("PSDTAMSG",$J,2,0)="Adjustment/Error Date/Time: "_RDT,^TMP("PSDTAMSG",$J,3,0)=""
 S ^TMP("PSDTAMSG",$J,4,0)="Dispensing Site: "_$S($G(PSDSN)]"":PSDSN,1:"UNKNOWN"),^TMP("PSDTAMSG",$J,5,0)="Drug: "_PSDRN
 S ^TMP("PSDTAMSG",$J,6,0)="Quantity Adjusted: "_QTY
 S ^TMP("PSDTAMSG",$J,7,0)="Adjusted by: "_PHARMN1
 S XMSUB="CS PHARM TRAKKER ADJUSTMENT",XMTEXT="^TMP(""PSDTAMSG"",$J,",XMDUZ="CONTROLLED SUBSTANCES PHARMACY"
 F JJ=0:0 S JJ=$O(^XUSEC("PSD ERROR",JJ)) Q:'JJ  S XMY(JJ)=""
 S:'$D(XMY) XMY(.5)="" D ^XMD K XMY,^TMP("PSDTAMSG",$J)
 K JJ,PHARMN1,PSDRN,RDT,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 Q
