DG306 ;ALB/LBD - Post-Install Routine for DG*5.3*306 ; 10-AUGUST-2000
 ;;5.3;Registration;**306**;Aug 13, 1993
 ;
 ;
 Q
POST ; Entry point for post-installation process.
 ;
 D POST1
 D POST2
 ;
 Q
 ;
POST1 ; KILL the "LAYGO" node that is on the #.01 field of the 
 ; ENROLLMENT GROUP THRESHOLD file (#27.16).  This node prevents any
 ; records from being added to the file. Reference DBIA 3180.
 ;
 K ^DD(27.16,.01,"LAYGO")
 Q
 ;
POST2 ;
 D MES^XPDUTL("Updating Enrollment Group Threshold file (#27.16)")
 N EGTIEN,DGENFDA,ERR
 ; if EGT entry already exists, delete it before setting new one
 S EGTIEN=$$FINDCUR^DGENEGT()
 I EGTIEN I $$DELETE^DGENEGT(EGTIEN)
 S DGENFDA(27.16,"+1,",.01)=3001001
 S DGENFDA(27.16,"+1,",.02)=7
 S DGENFDA(27.16,"+1,",.03)=3
 S DGENFDA(27.16,"+1,",.04)=1
 S DGENFDA(27.16,"+1,",.06)=$$DT^XLFDT
 S DGENFDA(27.16,"+1,",25)="EGT set to 7c by patch DG*5.3*306"
 D UPDATE^DIE("","DGENFDA","","ERR")
 I $D(ERR) D MES^XPDUTL("   Could not set EGT entry in file #27.16")
 Q
