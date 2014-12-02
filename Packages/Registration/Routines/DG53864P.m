DG53864P ;BP/DMR - POST INT TO ADD PRF
 ;;5.3;Reqistration;**864**;Aug 13, 1993;Build 16
 ;
 ;
 ; This rountine will create the new URGENT: ADDRESS AS FEMALE Patient Record Flag
 ; in the PRF NATIONAL FLAG file (#26.15). The routine can be deleted after the
 ; flag is installed.
 ;
EN ;
 N DGPRF,DGMSG,DGFDA,DGFDAIEN,DGWP,DGTIU,DGMSG,DGERR,DGRESULT,DGLINE
 ;
 S DGPRF="URGENT    ADDRESS AS FEMALE"
 S DGTIU="PATIENT RECORD FLAG CATEGORY I - URGENT    ADDRESS AS FEMALE"
 ;
 K DGERR,DGMSG
 D CHK^DIE(26.15,.07,"E",DGTIU,.DGRESULT,"DGERR")
 I $D(DGERR)>0 D  Q
 . D MSG^DIALOG("EA",.DGMSG,"","","DGERR")
 . S DGLINE=$O(DGMSG(999999),-1)
 . S DGMSG(DGLINE+1)="Please check that patch TIU*1.0*275 must be installed."
 . S DGMSG(DGLINE+2)="Exiting install of the new national PRF flag"
 . D MES^XPDUTL(.DGMSG)
 ;
 I $D(^DGPF(26.15,"B",DGPRF))>0 D  Q
 . S DGMSG(1)="The 'URGENT    ADDRESS AS FEMALE' PRF is already entered in the PRF"
 . S DGMSG(2)="NATIONAL FLAG file, install will abort."
 . D MES^XPDUTL(.DGMSG)
 ; Create entry in file #26.15
 D BMES^XPDUTL("Installing new national PRF entry")
 S DGFDA(1,26.15,"+1,",.01)=DGPRF
 S DGFDA(1,26.15,"+1,",.02)="ACTIVE"
 S DGFDA(1,26.15,"+1,",.03)="OTHER"
 S DGFDA(1,26.15,"+1,",.04)="0"
 S DGFDA(1,26.15,"+1,",.05)="0"
 S DGFDA(1,26.15,"+1,",.06)=""
 S DGFDA(1,26.15,"+1,",.07)=DGTIU
 K DGERR,DGMSG
 D UPDATE^DIE("E","DGFDA(1)","DGFDAIEN","DGERR")
 I $D(DGERR)>0 D  Q
 . D MSG^DIALOG("EA",.DGMSG,"","","DGERR")
 . D MES^XPDUTL(.DGMSG)
 ; Create description (word-processing) field
 K DGERR,DGMSG
 S DGWP(1,1)="This Patient Record Flag was established to ensure that a transgender"
 S DGWP(1,2)="Veteran is addressed as Female per a court order agreement. This flag"
 S DGWP(1,3)="cannot be used without approval of the Under Secretary for Health."
 D WP^DIE(26.15,DGFDAIEN(1)_",",1,"A","DGWP(1)","DGERR")
 I $D(DGERR) D  Q
 . D MSG^DIALOG("EA",.DGMSG,"","","DGERR")
 . D MES^XPDUTL(.DGMSG)
 ;
 D BMES^XPDUTL("Installation of new national PRF entry complete")
 Q
