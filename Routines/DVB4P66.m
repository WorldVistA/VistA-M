DVB4P66 ;ALB/MJB/RC - DISABILITY FILE UPDATE ; 11/16/10 3:50pm
 ;;4.0;HINQ;**66**;03/25/92;Build 14
 ;
 Q
EN ; Post Install entry point (from build).
 ; Set Up Kernel Checkpoints.  
 N DVBCKPT,DVBCKPTIEN
 F DVBCKPT="POST" D
 .S DVBCKPTIEN=$$NEWCP^XPDUTL(DVBCKPT,DVBCKPT_"^DVB4P66")
 .I 'DVBCKPTIEN D
 ..D BMES^XPDUTL("ERROR Creating "_DVBCKPT_" Checkpoint.")
 ..D BMES^XPDUTL("Please verify that this post-install routine runs to completion.")
 Q
POST ; Post install entry point (manual).
 N DVBPID,DVBTMP,DVBTMPRT
 S DVBPID="DVB*4.0*66",DVBTMPRT="^TMPRT(""DVB4P66"",$J)"
 K @DVBTMPRT
 S @DVBTMPRT=DT_U_"DVB*4.0*66 Post Install"
 D DELICD,ADDICD
 ;DVB*4.0*66 - ADDCOND, no disability conditions were added.
 K @DVBTMPRT
 Q
ADDCOND ;Add Disability Conditions to DISABILITY CONDITION (#31) file.
 D BMES^XPDUTL("  Adding disability conditions to the DISABILITY CONDITION (#31) file.  ")
 N DVBTOT,DVBTMP
 S DVBTOT=0,DVBTMP=$NA(^TMP("DVB4P66",$J,"ADDCOND"))
 K @DVBTMP S @DVBTMP@(0)="Patch DVB*4.0*66 post-install, add disability conditions."_U_$$NOW^XLFDT
 D POST^DVB4P66A(DVBTMP,.DVBTOT)
 S @DVBTMP@(0)=@DVBTMP@(0)_"^"_$$NOW^XLFDT_"^"_DVBTOT
 D ERROR(DVBTMP,"add conditions")
 Q
DELICD ;Inactivate ICD codes associated with DISABILITY CONDITION (#31) file.
 D BMES^XPDUTL("  Inactivating codes ICD codes from the DISABILITY CONDITION (#31) file.  ")
 N DVBTOT,DVBTMP
 S DVBTOT=0,DVBTMP=$NA(^TMP("DVB4P66",$J,"DELICD"))
 K @DVBTMP S @DVBTMP@(0)="Patch DVB*4.0*66 post-install, inactivate ICD codes."_U_$$NOW^XLFDT
 D POST^DVB4P66I(DVBTMP,.DVBTOT)
 S @DVBTMP@(0)=@DVBTMP@(0)_"^"_$$NOW^XLFDT_"^"_DVBTOT
 D ERROR(DVBTMP,"delete")
 Q
ADDICD ;Add ICD codes to DISABILITY CONDITION (#31) file.
 D BMES^XPDUTL("  Adding ICD codes to the DISABILITY CONDITION (#31) file.  ")
 N DVBTOT,DVBTMP
 S DVBTOT=0,DVBTMP=$NA(^TMP("DVB4P66",$J,"ADDICD"))
 K @DVBTMP S @DVBTMP@(0)="Patch DVB*4.0*66 post-install, add ICD codes."_U_$$NOW^XLFDT
 D POST^DVB4P66A(DVBTMP,.DVBTOT)
 S @DVBTMP@(0)=@DVBTMP@(0)_"^"_$$NOW^XLFDT_"^"_DVBTOT
 D ERROR(DVBTMP,"add")
 Q
ERROR(DVBTMP,DVBPHASE) ;Error Handling/Notification
 ;DVBTMP - Global Root containing error.
 ;DVBPHASE - Phase of installation.
 I '$D(@DVBTMP@("ERROR")) D  Q
 .D BMES^XPDUTL("  >>> *** SUCCESS updating the DISABILITY CONDITION (#31) file.")
 .D MES^XPDUTL(" Total RELATED ICD9 CODES "_DVBPHASE_"ed: "_DVBTOT)
 .;
 D BMES^XPDUTL("  >>> *** FAILURE updating the DISABILITY CONDITION (#31) file.")
 D BMES^XPDUTL("      Filing errors have occurred when updating the file.")
 D MES^XPDUTL("      Resolution is necessary to maintain database integrity.")
 D BMES^XPDUTL("  A MailMan message has been sent to the installer of this patch")
 D MES^XPDUTL("  with a listing of the errors.")
 D BMES^XPDUTL("  Once these errors have been resolved, please re-run")
 D MES^XPDUTL("  the Post-Installation routine directly from programmer mode")
 D MES^XPDUTL("  by entering the following command:")
 D MES^XPDUTL("  ")
 D MES^XPDUTL("  D POST^DVB4P66")
 D MES^XPDUTL("  ")
 D BMES^XPDUTL("  >>> I'm now creating and sending the MailMan message...")
 ;
 D SENDMSG(DVBTMP,.DVBTOT)
 ;
 D MES^XPDUTL("  >>> All done.")
 ;
 ;cleanup temp file
 K @DVBTMP
 Q
 ;
 ;
SENDMSG(DVBTMP,DVBTOT) ;send failure MailMan message to installer of patch
 ;
 N DIFROM,DVBMSG
 N XMY,XMDUZ,XMSUB,XMTEXT,XMDUN,XMZ
 S XMSUB="DVB*4.0*66 Patch Post-Install Error Listing"
 S XMTEXT="DVBMSG("
 S XMY(DUZ)="",XMDUZ=.5
 ;S XMDUZ=.5,(XMY(DUZ),XMY(XMDUZ))=""
 S DVBMSG(1)="Patch:  DVB*4.0*66 Automated Service Connected Designation"
 S DVBMSG(2)=""
 S DVBMSG(3)="The post-installation update of the DISABILITY CONDITION (#31) file"
 S DVBMSG(4)="has FAILED to successfully complete.  Errors have occurred when"
 S DVBMSG(5)="attempting to make the changes."
 S DVBMSG(6)=""
 S DVBMSG(7)="Resolution of ALL errors is needed to maintain database integrity."
 S DVBMSG(8)=""
 S DVBMSG(9)="Once these filing errors have been resolved, please re-run"
 S DVBMSG(10)="the Post-Installation routine directly from programmer mode"
 S DVBMSG(11)="by entering the following command:"
 S DVBMSG(12)=""
 S DVBMSG(13)="D POST^DVB4P66"
 S DVBMSG(14)=""
 S DVBMSG(15)="The new update run time should take less than 5 minutes to complete."
 S DVBMSG(16)=""
 S DVBMSG(17)=">>> Please review and resolve the following errors:"
 S DVBMSG(18)=""
 S DVBMSG(19)="*** DISABILITY CONDITION FILE (#31) FILING ERRORS ***"
 S DVBMSG(20)="-----------------------------------------------------"
 ;
 ;loop and list errors
 N DVBICD,DVBHDR,DVBHDR1,DVBIEN,DVBLN,DVBMSS,DVBVBA,DVBDESC
 S DVBHDR="VBA DX CODE: ",DVBHDR1="    ICD DIAGNOSIS CODE: "
 S DVBLN=21,DVBVBA=0
 F  S DVBVBA=$O(@DVBTMP@("ERROR",DVBVBA)) Q:'DVBVBA  D
 .I $D(@DVBTMP@("ERROR",DVBVBA,0)) D  Q
 ..S DVBMSS=DVBHDR_DVBVBA_" - "_$G(@DVBTMP@("ERROR",DVBVBA,0))
 ..S DVBMSG(DVBLN)=DVBMSS,DVBLN=DVBLN+1
 .K DVBDESC D FIND^DIC(31,"","","X",DVBVBA,,"C","","","DVBDESC")
 .S DVBMSS=DVBHDR_DVBVBA_" - "_$E($G(DVBDESC("DILIST",1,1)),1,50)
 .S DVBMSG(DVBLN)=DVBMSS,DVBLN=DVBLN+1
 .S DVBIEN=0
 .F  S DVBIEN=$O(@DVBTMP@("ERROR",DVBVBA,DVBIEN)) Q:'DVBIEN  D
 ..S DVBICD=""
 ..F  S DVBICD=$O(@DVBTMP@("ERROR",DVBVBA,DVBIEN,DVBICD)) Q:DVBICD=""  D
 ...S DVBMSS=DVBHDR1_DVBICD_" - "_$G(@DVBTMP@("ERROR",DVBVBA,DVBIEN,DVBICD))
 ...S DVBMSG(DVBLN)=DVBMSS,DVBLN=DVBLN+1
 S DVBMSG(DVBLN)="",DVBLN=DVBLN+1
 S DVBMSG(DVBLN)="<End of Report>"
 ;
 D ^XMD
 Q
 ;
