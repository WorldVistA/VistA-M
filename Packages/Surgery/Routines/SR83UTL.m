SR83UTL ;BIR/ADM-Utility Routine for SR*3*83 ; [ 08/04/98  9:06 AM ]
 ;;3.0; Surgery ;**83**;24 Jun 93
 ; environmental check for SR*3*83 to confirm that SR*3*79 is installed
 I '$$PATCH^XPDUTL("SR*3.0*79") D BMES^XPDUTL("Patch SR*3*79 must be installed before installing this patch!") S XPDQUIT=2
 Q
EN1 ; transmit list of aborted 1-liner cases in the following format:
 ;   site-id^divison^assessment number^date of operation
 S SITE=+$P($$SITE^SROVAR,"^",3),SRI=0 K ^TMP("SRA",$J)
 S SRSDATE=2971000 F  S SRSDATE=$O(^SRF("AC",SRSDATE)) Q:'SRSDATE!(SRSDATE>2981000)  S SRTN=0 F  S SRTN=$O(^SRF("AC",SRSDATE,SRTN)) Q:'SRTN  D
 .I $P($G(^SRF(SRTN,30)),"^")!($P($G(^SRF(SRTN,31)),"^",8)),$P($G(^SRF(SRTN,.4)),"^",2)="T" D
 ..K SRLINE S SRDIV=$P($G(^SRF(SRTN,8)),"^") I SRDIV S SRDIV=$$GET1^DIQ(4,SRDIV,99)
 ..S SRLINE=SITE_"^"_SRDIV_"^"_SRTN_"^"_SRSDATE
 ..S SRI=SRI+1,^TMP("SRA",$J,SRI)=SRLINE
TRANS ; place list in mail message
 S XMSUB="List of Aborted 1-Liners ("_SITE_")",XMDUZ=$S(DUZ:DUZ,1:"SCNR")
 S XMY("G.SRCOSERV@ISC-CHICAGO.DOMAIN.EXT")=""
 S XMTEXT="^TMP(""SRA"",$J," N I D ^XMD
 K ^TMP("SRA") S ZTREQ="@"
 Q
POST ; postinit action for SR*3*83
 S NAME=$G(^XMB("NETNAME")) I NAME["FORUM"!(NAME["ISC-")!($E(NAME,1,3)="ISC")!(NAME["ISC.")!(NAME["TST")!(NAME["TRAIN")!(NAME["DEMO.")!(NAME["UTL.") Q
 D NOW^%DTC S SRNOW=$E(%,1,12) S ZTRTN="EN1^SR83UTL",ZTDESC="Surgery Risk Assessment Retransmission",ZTIO="",ZTDTH=SRNOW D ^%ZTLOAD
 Q
