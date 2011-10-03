PSN4P69P ;BIR/DMA-post install routine to clean up data ;31 Aug 99 / 11:32 AM
 ;;4.0; NATIONAL DRUG FILE;**69**; 30 Oct 98
 ;
 ; Reference to ^PSDRUG supported by DBIA #2192
 ;
 N DA,DIE,DR,IND,LINE,NA,PR,X,XMDUZ,XMSUB,XMTEXT,XMY,XMZ
 ;NOW UPDATE LOCAL DRUG FILE
 K ^TMP($J),^TMP("PSN",$J)
 S DA=0 F  S DA=$O(^PSDRUG(DA)) Q:'DA  S PR=+$P($G(^(DA,"ND")),"^",3) I PR D
 .I $P($G(^PSDRUG(DA,3)),"^"),'$P($G(^PSNDF(50.68,PR,1)),"^",3) S DIE=50,DR="213////0;" D ^DIE K DIE,DR S IND=$O(^PSDRUG(DA,4," "),-1),$P(^(IND,0),"^",6)="NDF Update",^TMP($J,$P(^PSDRUG(DA,0),"^"))=""
 ;
 K ^TMP("PSN",$J) F LINE=1:1 S X=$P($T(TEXT+LINE),";",3,300) Q:X=""  S ^TMP("PSN",$J,LINE,0)=X
 S NA="" F LINE=LINE:1 S NA=$O(^TMP($J,NA)) Q:NA=""  S ^TMP("PSN",$J,LINE,0)=NA
 I '$D(^TMP($J)) S ^TMP("PSN",$J,LINE,0)="No items were found."
 S XMDUZ="NDF MANAGER",XMSUB="DRUGS UNMARKED FOR CMOP",XMTEXT="^TMP(""PSN"",$J,"
 K XMY S XMY("G.NDF DATA@"_^XMB("NETNAME"))=""
 S DA=0 F  S DA=$O(^XUSEC("PSNMGR",DA)) Q:'DA  S XMY(DA)=""
 I $D(DUZ) S XMY(DUZ)=""
 N DIFROM D ^XMD
 K DA,DIE,DR,IND,LINE,NA,PR,X,XMDUZ,XMSUB,XMTEXT,XMY,XMZ,^TMP($J),^TMP("PSN",$J)
 Q
 ;
TEXT ;; 
 ;;The following items in your DRUG file (#50) have been unmarked for
 ;;CMOP because they are matched to entries in the VA PRODUCT file (#50.68)
 ;;which had previously been unmarked for CMOP.
 ;; 
 ;;
