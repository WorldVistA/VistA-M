PSN100P ;BIR/DMA - set header nodes and protection ; 17 Jun 2009  7:30 AM
 ;;4.0; NATIONAL DRUG FILE;*100*;30 Oct 98;Build 5
 ;
 N DA,PSN
 S PSN("WR")="@",PSN("DEL")="@" D FILESEC^DDMOD(50.607,.PSN)
 ;
 K ^TMP($J) M ^TMP($J)=@XPDGREF
 S DA=0 F  S DA=$O(^TMP($J,DA)) Q:'DA  S PSN=^(DA) I $D(^PSNDF(50.68,DA)) S ^PSNDF(50.68,DA,2,0)=PSN
 ;
 K DA,PSN,^TMP($J) Q
