DG53147P ;ALB/RMO/CJM - National Enrollment Post Install Updates; 10/14/97
 ;;5.3;Registration;**147**;Aug 13, 1993
 ;
EN ;
 ;-- re-compile input templates
 D COMP
 ;-- fix potential problem in DD for rated disabilities multiple
 D FIX
 ;--notify HEC that thepatch was installed
 D NOTIFY
 Q
 ;
COMP ;-- Re-compile input templates
 ;
 N DGCOUNT,X,Y,DMAX,DGNAME,DGMAX
 S DGMAX=$$ROUSIZE^DILF
 D MES^XPDUTL("Recompiling affected input templates ...")
 F DGCOUNT=1:1 S DGNAME=$P($T(TEMP+DGCOUNT),";;",2) Q:DGNAME=""  D
 .;
 .;find the ien of the input template
 .S Y=$O(^DIE("B",DGNAME,0))
 .Q:('Y)
 .;
 .;quit if input template not compiled
 .S X=$P($G(^DIE(Y,"ROUOLD")),"^")
 .Q:(X="")
 .;
 .D MES^XPDUTL("Compiling "_DGNAME_" , compiled routine is "_X_" ...")
 .S DMAX=DGMAX
 .D EN^DIEZ
 .D MES^XPDUTL("done")
 D MES^XPDUTL("Completed compiling input templates")
 Q
 ;
FIX ;fix DD for rated disabilities multiple
 K ^DD(2.04,0,"NM")
 S ^DD(2.04,0,"NM","RATED DISABILITIES (VA)")=""
 Q
NOTIFY ; --
 ; This function will generate a notification message that the facility has installed the patch in a production account.
 ;
 N DIFROM,IVMSITE,IVMTEXT,XMTEXT,XMSUB,XMDUZ,XMY,Y
 ;
 ; if not in production account, do not send notification message (exit)
 X ^%ZOSF("UCI") I Y'=^%ZOSF("PROD") Q
 ;
 D BMES^XPDUTL(">>> Sending a 'completed installation' notification to the HEC...")
 ;
 ; get facility name/station number
 S IVMSITE=$$SITE^VASITE
 ;
 S XMSUB="Patch DG*5.3*147 Installed "_"("_$P(IVMSITE,"^",3)_")"  ; subject
 S XMDUZ="ENROLLMENT PACKAGE"  ; sender
 S XMY(DUZ)="",XMY(.5)=""  ; local recipient
 S XMY("G.ENROLLMENT EXTRACT@IVM.DOMAIN.EXT")=""  ; remote recipient
 ;
 ; message text
 S XMTEXT="IVMTEXT("
 S IVMTEXT(1)="               Facility Name:  "_$P(IVMSITE,"^",2)
 S IVMTEXT(2)="              Station Number:  "_$P(IVMSITE,"^",3)
 S IVMTEXT(3)="                Installed By:  "_$P($G(^VA(200,+$G(DUZ),0)),"^")
 S IVMTEXT(4)=""
 S IVMTEXT(5)="  Installed DG*5.3*147 patch on:  "_$$FMTE^XLFDT($$NOW^XLFDT)
 ;
 D ^XMD
 ;
 D BMES^XPDUTL("Notification message sent.")
 ;
 Q
 ;
TEMP ;
 ;;DVBA C ADD 2507 PAT
 ;;DVBHINQ UPDATE
 ;;IB SCREEN1
 ;;DGRPT 10-10T REGISTRATION
 ;;DG LOAD EDIT SCREEN 7
 ;;AICK VARO/DHCP
 ;;DGRP COLLATERAL REGISTER
