SD53622P ;ALB/CR - SD*5.3*622 INSTALL UTILITY ;10/15/14
 ;;5.3;Scheduling;**622**;Aug 13, 1993;Build 30
 ; -------------------------------------------------------------------
 ; utility to create a mail group used by the Clinic Inactivation
 ; option. Sites will need to populate the mail group with the users
 ; tasked with taking action to complete a clinic inactivation.
 ; -------------------------------------------------------------------
 ; ICR #1146 - allows Mailman API use of $$MG^XMBGRP
 ;
 ; post-install
POST N SDIEN,SDDUZ,SDGROUP,SDSELF,SDTEXT,SDTYPE,SDQUIET,SDXMY
 S SDGROUP="SD CLINIC INACTIVATE REMINDER"
 S SDSELF=0  ; don't allow self-enrollment
 S SDTYPE=0  ; public group (default)
 S SDQUIET=1 ; silent flag (default)
 S SDXMY(.5)="" ; use Postmaster as the first member of the group
 ;
 ; group description
 S SDTEXT(1)="This mail group is organized to inform Scheduling users"
 S SDTEXT(2)="whenever a clinic is inactivated either on the current"
 S SDTEXT(3)="date or on a future date. If this group is not populated"
 S SDTEXT(4)="with the corresponding users, or if it is deleted, the"
 S SDTEXT(5)="clinic inactivation messages will error out. The routine"
 S SDTEXT(6)="SDNACT needs this mail group in order to work properly."
 ;
 S SDIEN=$$FIND1^DIC(3.8,"","X",SDGROUP,"B")
 S SDDUZ=$S(+$G(DUZ)>0:DUZ,1:.5) ; group organizer, otherwise Postmaster
 I $G(SDIEN)>0 D  Q
 . D BMES^XPDUTL("The mail group "_SDGROUP_" exists.")
 . D MES^XPDUTL("Please make sure that is is populated.")
 ;
 I $G(SDIEN)=0 D
 . D BMES^XPDUTL("The mail group "_SDGROUP_" needs to be created. Please wait...")
 ;
 S SDIEN=$$MG^XMBGRP(SDGROUP,SDTYPE,SDDUZ,SDSELF,.SDXMY,.SDTEXT,SDQUIET)
 I $G(SDIEN)>0 D  Q
 . D BMES^XPDUTL("  ******************************")
 . D MES^XPDUTL("  Mail group "_SDGROUP_" created.")
 . D MES^XPDUTL("  After the patch installation, please add other members from Scheduling.")
 . D MES^XPDUTL("  ******************************")
 E  D BMES^XPDUTL("  Unable to create new mail group")
 Q
