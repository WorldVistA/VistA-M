PXRMP6IL ; SLC/PKR - Inits for PXRM*2.0*6 ;11/06/2007
 ;;2.0;CLINICAL REMINDERS;**6**;Feb 04, 2005;Build 123
 Q
 ;
 ;==========================================
INILT ;Initialize list templates
 N IEN,IND,LIST,TEMP0
 D LTL^PXRMP6IL(.LIST)
 S IND=0
 ;IA #4123
 F  S IND=$O(LIST(IND)) Q:IND=""  D
 . S IEN=$O(^SD(409.61,"B",LIST(IND),"")) Q:IEN=""
 . S TEMP0=$G(^SD(409.61,IEN,0))
 . K ^SD(409.61,IEN)
 . S ^SD(409.61,IEN,0)=TEMP0
 Q
 ;
 ;==========================================
LTL(LIST) ;This is the list of list templates that being distributed
 ;in the patch.
 S LIST(1)="PXRM EX INSTALLATION DETAIL"
 S LIST(2)="PXRM EX INSTALLATION HISTORY"
 S LIST(3)="PXRM EX REMINDER EXCHANGE"
 S LIST(4)="PXRM EXTRACT HISTORY"
 S LIST(5)="PXRM LIST RULE MANAGEMENT"
 S LIST(6)="PXRM PATIENT LIST CREATION DOC"
 S LIST(7)="PXRM PATIENT LIST PATIENTS"
 S LIST(8)="PXRM PATIENT LIST USER"
 Q
 ;
