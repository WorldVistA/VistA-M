DG53P803 ;ALB/DLF Set Enrollment group threshold to 'd' ; 6/8/09 5:51pm
 ;;5.3;Registration;**803**;Aug 13, 1993;Build 31
 Q
EN ;Post install entry point
 D MES^XPDUTL("Updating Enrollment Group Threshold file (#27.16)")
 N EGTIEN,DGENFDA,ERR,DIE
 S DGENFDA(27.16,"+1,",.01)=3090615
 S DGENFDA(27.16,"+1,",.02)=8
 S DGENFDA(27.16,"+1,",.03)=4
 S DGENFDA(27.16,"+1,",.04)=4
 S DGENFDA(27.16,"+1,",.06)=$$DT^XLFDT
 S DGENFDA(27.16,"+1,",25)="EGT set to 8d by patch DG*5.3*803"
 D UPDATE^DIE("","DGENFDA","","ERR")
 I $D(ERR) D MES^XPDUTL("   Could not set EGT entry in file #27.16")
 Q
