DG53849P ;ALB/SCK - PRF CONVERSION PRE-PATCH SETUP ; 11/14/2011
 ;;5.3;Registration;**849**;Aug 13, 1993;Build 28
 ;
 ; This routine will create the new national High Risk for Suicide Patient Record
 ; flag in the PRF NATIONAL FLAG file (#26.15).  This routine will require that
 ; the associated TIU PN TITLE be already installed in the TIU DOCUMENT DEFINITION
 ; file (#8925.1).  Once the flag is installed, this routine should be deleted.
 ;  
EN ; Main entry point
 N DGPRF,DGMSG,DGFDA,DGFDAIEN,DGWP,DGTIU,DGMSG,DGERR,DGRESULT,DGLINE
 ;
 S DGPRF="HIGH RISK FOR SUICIDE"
 S DGTIU="PATIENT RECORD FLAG CATEGORY I - HIGH RISK FOR SUICIDE"
 ;
 K DGERR,DGMSG
 D CHK^DIE(26.15,.07,"E",DGTIU,.DGRESULT,"DGERR")
 I $D(DGERR)>0 D  Q
 . D MSG^DIALOG("EA",.DGMSG,"","","DGERR")
 . S DGLINE=$O(DGMSG(999999),-1)
 . S DGMSG(DGLINE+1)="Please check that patch TIU*1.0*265 has been installed"
 . S DGMSG(DGLINE+2)="Exiting install of the new national PRF flag"
 . D MES^XPDUTL(.DGMSG)
 ;
 I $D(^DGPF(26.15,"B",DGPRF))>0 D  Q
 . S DGMSG(1)="The 'HIGH RISK FOR SUICIDE' PRF is already entered in the PRF NATIONAL"
 . S DGMSG(2)="FLAG file, no further processing of the new national PRF field entry."
 . D MES^XPDUTL(.DGMSG)
 ; Create main entry in file #26.15
 D BMES^XPDUTL("Installing new national PRF entry")
 S DGFDA(1,26.15,"+1,",.01)=DGPRF
 S DGFDA(1,26.15,"+1,",.02)="ACTIVE"
 S DGFDA(1,26.15,"+1,",.03)="CLINICAL"
 S DGFDA(1,26.15,"+1,",.04)="90"
 S DGFDA(1,26.15,"+1,",.05)="30"
 S DGFDA(1,26.15,"+1,",.06)="DGPF CLINICAL HR FLAG REVIEW"
 S DGFDA(1,26.15,"+1,",.07)=DGTIU
 K DGERR,DGMSG
 D UPDATE^DIE("E","DGFDA(1)","DGFDAIEN","DGERR")
 I $D(DGERR)>0 D  Q
 . D MSG^DIALOG("EA",.DGMSG,"","","DGERR")
 . D MES^XPDUTL(.DGMSG)
 ; Create description (word-processing) field
 K DGERR,DGMSG
 S DGWP(1,1)="The purpose of this National Patient Record Flag is to alert VHA"
 S DGWP(1,2)="Mental Health Staff of patients who have a high risk for suicide"
 S DGWP(1,3)="that may pose a threat to themselves.  This is a nationally"
 S DGWP(1,4)="distributed flag."
 D WP^DIE(26.15,DGFDAIEN(1)_",",1,"A","DGWP(1)","DGERR")
 I $D(DGERR) D  Q
 . D MSG^DIALOG("EA",.DGMSG,"","","DGERR")
 . D MES^XPDUTL(.DGMSG)
 ;
 D BMES^XPDUTL("Installation of new national PRF entry complete")
 Q
