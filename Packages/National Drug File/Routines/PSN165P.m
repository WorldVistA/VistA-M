PSN165P ;BIR/DMA-post install to set inactivation dates ; 08 Feb 2008  11:14 AM
 ;;4.0; NATIONAL DRUG FILE;**165**; 30 Oct 98;Build 4
 ;
 N DA,DIE,DR,NA
 K ^TMP($J) M ^TMP($J)=@XPDGREF
 S NA=0 F  S NA=$O(^TMP($J,NA)) Q:'NA  S DA=$P(NA,"^"),DIE=50.416,DR="3////"_$P(NA,"^",2) D ^DIE
 K DA,DIE,DR,NA,^TMP($J)
 Q
