EAS136P ;ALB/ERC - Combat Vet Pre-Install ;7/23/03
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**36**;Mar 15, 2001
 ;
 ;This pre-install routine will add one entry into the LTC CO-PAY
 ;EXEMPTION file (#714.1) to support the Combat Vet project
 ;associated patches - DG*5.3*528, SD*5.3*305
 ;
EN ;
 N DGERR,DGFDA,DGT
 D BMES^XPDUTL("  ** Adding a new entry to LTC CO-PAY EXEMPTION file (#714.1).")
 S DGT="LTC IS SERVICE RELATED - COMBAT VET ELIGIBLE"
 I $$FIND1^DIC(714.1,"","X",DGT) D BMES^XPDUTL("  ** "_DGT_" already exists in file #714.1.") Q
 S DGFDA(714.1,"+1,",.01)="LTC IS SERVICE RELATED - COMBAT VET ELIGIBLE"
 S DGFDA(714.1,"+1,",.02)=1
 D UPDATE^DIE("","DGFDA","","DGERR")
 I $D(DGERR) D BMES^XPDUTL("  **** ERROR! "_DGT_" not added to file #714.1"),MES^XPDUTL(DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1)) Q
 D BMES^XPDUTL("   "_DGT_" successfully added.")
 Q
