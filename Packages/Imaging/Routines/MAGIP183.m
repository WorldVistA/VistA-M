MAGIP183 ;WOIFO/PMK - Install code for MAG*3.0*183 ;12 Oct 2017 4:10 PM
 ;;3.0;IMAGING;**183**;Mar 19, 2002;Build 11
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 ; There are no environment checks here but the MAGIP183 has to be
 ; referenced by the "Environment Check Routine" field of the KIDS
 ; build so that entry points of the routine are available to the
 ; KIDS during all installation phases.
 ; 
 ; Supported IA #1157 reference for $$ADD^XPDMENU function
 ; 
 Q
 ;
 ;+++++ INSTALLATION ERROR HANDLING
ERROR ;
 S:$D(XPDNM) XPDABORT=1
 ;--- Display the messages and store them to the INSTALL file
 D DUMP^MAGUERR1(),ABTMSG^MAGKIDS()
 Q
 ;
 ;
 ;
 ;***** PRE-INSTALL CODE
PRE ;
 Q
 ;
 ;
 ;
 ;***** POST-INSTALL CODE
POS ;
 N CALLBACK
 D CLEAR^MAGUERR(1)
 ;
 ;--- Various Updates
 I $$CP^MAGKIDS("MAG P183 UPDATE","$$UPDATE^"_$T(+0))<0  D ERROR  Q
 ;
 W !!!,"Setting DICOM Text Gateway to use Radiology HL7 V2.4 protocols -- PASS 1"
 D MAGIP183^MAGDHPS ; set the Radiology HL7 V2.4 for MAG SEND ORM/ORU
 W !!!,"Setting DICOM Text Gateway to use Radiology HL7 V2.4 protocols -- PASS 2"
 D MAGIP183^MAGDHPS ; run twice to remove any incorrect settings
 ;
 ;--- Send the notification e-mail
 D BMES^XPDUTL("Post Install Mail Message: "_$$FMTE^XLFDT($$NOW^XLFDT))
 D INS^MAGQBUT4(XPDNM,DUZ,$$NOW^XLFDT,XPDA)
 Q
 ;
UPDATE() ;
 ; This subroutine creates the MAGD PATHOLOGY entry in the
 ; HLO SUBSCRIPTION REGISTRY (file 779.4).
 D NEW7794 ; create new entry in file 779.4
 D UPDTMENU ; set display order for IHE menu option
 Q 0
 ;
NEW7794 ; create an entry in the HLO SUBSCRIPTION REGISTRY (file 779.4)
 N DESCRIPTION,NAME,OWNER
 ; create the MAGD PATHOLOGY entry
 S NAME="MAGD PATHOLOGY"
 S DESCRIPTION="Subscription list for anatomic pathology"
 S OWNER="MAGD (Imaging)"
 D NEW7794A(NAME,DESCRIPTION,OWNER)
 Q
 ;
NEW7794A(NAME,DESCRIPTION,OWNER) ; create the entry in file 779.4
 N DIC,DIERR,I,IENS,MAGERR,MAGFDA,MAGIENS,X,Y
 ;
 ; check to see if <NAME> already exists
 S DIC=779.4,DIC(0)="BX",X=NAME D ^DIC
 I Y>0 D  Q
 . D MES^MAGKIDS(""""_NAME_""" already exists in the HLO SUBSCRIPTION REGISTRY.")
 . Q
 D MES^MAGKIDS("Creating new """_NAME_""" HLO SUBSCRIPTION REGISTRY entry.")
 ;
 S IENS="+1,"
 S MAGFDA(779.4,IENS,.01)=NAME        ; NAME
 S MAGFDA(779.4,IENS,.02)=OWNER       ; OWNER
 S MAGFDA(779.4,IENS,.03)=DESCRIPTION ; DESCRIPTION
 D UPDATE^DIE("","MAGFDA","MAGIENS","MAGERR")
 I $D(DIERR) D  Q
 . D MES^MAGKIDS("Error in creating """_NAME_""" in the HLO SUBSCRIPTION REGISTRY.")
 . F I=1:1 Q:'$D(MAGERR("DIERR",1,"TEXT",I))  D
 . . D MES^MAGKIDS(MAGERR("DIERR",1,"TEXT",I))
 . . Q
 . Q
 Q 
 ;
UPDTMENU ; set the DISPLAY ORDER for MAG CONFIGURE IHE PACS HL7 I/F
 N MENU,MSG,OPTION,ORDER,SYNONYM,X
 S MENU="MAG HL7 MAINT"
 S OPTION="MAG CONFIGURE IHE PACS HL7 I/F"
 S SYNONYM="IHE"
 S ORDER=20 ; display order
 S MSG="Updating DISPLAY ORDER for "_SYNONYM_" on "_MENU_" menu -- "
 S X=$$ADD^XPDMENU(MENU,OPTION,SYNONYM,ORDER)
 I X>0 D
 . D MES^MAGKIDS(MSG_"SUCCESS.")
 . Q
 E  D
 . D MES^MAGKIDS(MSG_"FAILURE: """_$P(X,"^",2,999)_"""")
 . Q
 Q
