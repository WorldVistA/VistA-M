DG53E451 ;BRM - Patch DG*5.3*451 Install Utility Routine #2 ; 4/14/04 8:16am
 ;;5.3;Registration;**451**; Aug 13,1993
 ;
 Q
 ;
EDITINC ; edit a few entries to the INCONSISTENT DATA ELEMENTS file (#38.6)
 N DGK,DGWP,ROOT,DGFDA,DGWP,DGIEN,DGERR,DGTITL
 D BMES^XPDUTL("  >> Editing entries 37-40 in the INCONSISTENT DATA ELEMENTS file (#38.6)")
 F DGK=37:1:40  D
 .K DGFDA,ROOT,DGWP
 .S ROOT="DGFDA(38.6,"""_DGK_","")"
 .D @DGK Q:'$D(DGFDA)
 .S DGIEN(1)=DGK
 .S DGTITL=@ROOT@(.01)
 .D UPDATE^DIE("E","DGFDA","DGIEN","DGERR")
 .I $D(DGERR) D BMES^XPDUTL("   >>> ERROR! "_DGTITL_" could not be edited in file #38.6"),MES^XPDUTL(DGERR("DIERR",1)_": "_DGERR("DIERR",1,"TEXT",1)) Q
 .D BMES^XPDUTL("      "_DGTITL_" successfully edited.")
 Q
37 ;
 S @ROOT@(.01)="POW DATA MISSING OR INCOMPLETE"
 S @ROOT@(2)="PRISONER OF WAR STATUS INDICATED, RELATED DATA MISSING OR INCOMPLETE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results when the user responds YES to the WERE YOU A"
 S DGWP(2,0)="PRISONER OF WAR prompt and any (or all) of the following prompts are"
 S DGWP(3,0)="left unanswered:  POW WAR, POW FROM DATE, POW TO DATE. This inconsistency "
 S DGWP(4,0)="also results when an imprecise date (without at least month and year "
 S DGWP(5,0)="precision) is entered."
 Q
38 ;
 S @ROOT@(.01)="POW DATES INCONSISTENT"
 S @ROOT@(2)="'PRISONER OF WAR' STATUS INDICATED, TO DATE PRECEDES FROM DATE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results when the user responds YES to the WERE YOU A"
 S DGWP(2,0)="A PRISONER OF WAR prompt and the 'from' date does not precede the 'to'"
 S DGWP(3,0)="date."
 Q
39 ;
 S @ROOT@(.01)="COMBAT DATA MISSING/INCOMPLETE"
 S @ROOT@(2)="COMBAT SERVICE INDICATED, RELATED DATA MISSING OR INCOMPLETE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results when the user responds YES to the IN COMBAT (Y/N)"
 S DGWP(2,0)="and any (or all) of the following prompts are left unanswered:  COMBAT"
 S DGWP(3,0)="WHERE, COMBAT FROM DATE, COMBAT TO DATE.  This inconsistency also results"
 S DGWP(4,0)="when an imprecise date (without at least month and year precision) is"
 S DGWP(5,0)="entered."
 Q
40 ;
 S @ROOT@(.01)="COMBAT DATES INCONSISTENT"
 S @ROOT@(2)="COMBAT SERVICE INDICATED, TO DATE PRECEDES FROM DATE"
 S @ROOT@(3)=3
 S @ROOT@(50)="DGWP"
 S DGWP(1,0)="Inconsistency results when the COMBAT (Y/N) prompt is answered YES"
 S DGWP(2,0)="but the 'to' date precedes the 'from' date of service."
 Q
