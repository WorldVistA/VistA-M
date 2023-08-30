DG531093P ;ALB/ARF,JDB - PATCH DG*5.3*1093 INSTALL UTILITIES ;04/20/23 09:12am
 ;;5.3;Registration;**1093**;Aug 13, 1993;Build 12
 ;
 ; Reference to BMES^XPDUTL in ICR #10141
 ; Reference to MES^XPDUTL in ICR #10141
 ; Reference to $$PATCH^XPDUTL in ICR #10141
 ; Reference to ^XMD in ICR #10070
 ;
 ;No direct entry
 QUIT
 ;
 ;--------------------------------------------------------------------------
 ;Patch DG*5.3*1093: Environment, Pre-Install, and Post-Install entry points.
 ;--------------------------------------------------------------------------
 ;
ENV ;Main entry point for Environment check
 Q
 ;
PRE ;Main entry point for Pre-Install items
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1093 Pre-install routine...")
 ;Check if the patch has previously run, if so quit out PRE.
 I $$PATCH^XPDUTL("DG*5.3*1093") D  Q
 . D BMES^XPDUTL("Patch has been previously installed. Pre-install will not be run again.")
 . D BMES^XPDUTL(">>> Patch DG*5.3*1093 Pre-install complete.")
 D PRE1
 D BMES^XPDUTL(">>> Patch DG*5.3*1093 Pre-install complete.")
 Q
 ;
POST ;Main entry point for Post-Install items
 D BMES^XPDUTL(">>> Beginning the DG*5.3*1093 Post-install routine...")
 ;Check if the patch has previously run, if so quit out POST
 I $$PATCH^XPDUTL("DG*5.3*1093") D  Q
 . D BMES^XPDUTL("Patch has been previously installed. Post-install will not be run again.")
 . D BMES^XPDUTL(">>> Patch DG*5.3*1093 Post-install complete.")
 ; Remove triggers from fields .571 and .573 in PATIENT file (#2)
 D POST1
 ; Cleanup Indian attestation data
 D POST2
 D BMES^XPDUTL(">>> Patch DG*5.3*1093 Post-install complete.")
 Q
 ;
 ;
PRE1 ; Update existing entry in the RELIGION file (#13)
 ;Change the NAME field (#.01) of the RELIGION file (#13) from
 ;"UNITARIAN-UNIVERSALISM" to "UNITARIAN-UNIVERSALIST". This 
 ;change needs to occur before the DG*5.3*1093 patch is installed 
 ;due to an new entry being added in DG1093 with the same name, 
 ;"UNITARIAN-UNIVERSALISM".
 ;
 D BMES^XPDUTL("  - Updating the RELIGION file (#13)...")
 D MES^XPDUTL("  - Renaming UNITARIAN-UNIVERSALISM to UNITARIAN-UNIVERSALIST")
 ;
 N DGOLD,DGNEW,DGIEN,DGDATA,DGERR,DGIEN
 S DGOLD="UNITARIAN-UNIVERSALISM" ;existing name
 S DGNEW="UNITARIAN-UNIVERSALIST" ;new name
 S DGIEN=$O(^DIC(13,"B",DGOLD,""))   ;set DA to the IEN of the entry
 ;
 ; Update the existing entry's name from UNITARIAN-UNIVERSALISM to UNITARIAN-UNIVERSALIST
 S DGDATA(.01)=DGNEW
 I $$UPD^DGENDBS(13,.DGIEN,.DGDATA,.DGERR) D  Q
 . D BMES^XPDUTL("RELIGION NAME: "_DGOLD)
 . D BMES^XPDUTL("CHANGED TO: "_DGNEW)
 I $G(DGERR)'="" D
 . D MES^XPDUTL("*** ERROR! ***")
 . D MES^XPDUTL("   - The "_DGOLD_" entry was not updated.")
 . D MES^XPDUTL("   - Error: "_DGERR)
 . D MES^XPDUTL("   - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("     for assistance.")
 . D MES^XPDUTL(">>> DG*5.3*1093 Pre-install Routine Failed.")
 . D MES^XPDUTL("   - Installation Terminated.")
 . D MES^XPDUTL("   - Transport global removed from system.")
 . S XPDABORT=1  ;variable that will abort the installation
 Q
 ;
POST1 ; Remove x-ref on INDIAN SELF IDENTIFICATION (Field #.571) and INDIAN ATTESTATION DATE (Field #.573) of the PATIENT file #2
 ;
 N DGERR
 D BMES^XPDUTL("  - Removing 'AENR571' cross-reference on the INDIAN SELF IDENTIFICATION")
 D MES^XPDUTL("    field (#.571) of the PATIENT file (#2).")
 D DELIX^DDMOD(2,.571,2,,,"DGERR")
 ; No error, xRef deleted
 I '$D(DGERR) D BMES^XPDUTL("  - Cross reference removed.")
 ; Error encountered, xRef not deleted.
 I $G(DGERR)'="" D
 . D BMES^XPDUTL(" ** ERROR encountered deleting the cross reference. **")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 S DGERR=""
 D BMES^XPDUTL("  - Removing 'AENR573' cross-reference on the INDIAN ATTESTATION DATE")
 D MES^XPDUTL("    field (#.573) of the PATIENT file (#2).")
 D DELIX^DDMOD(2,.573,1,,,"DGERR")
 ; No error, xRef deleted
 I $G(DGERR)="" D BMES^XPDUTL("  - Cross reference removed.")
 ; Error encountered, xRef not deleted.
 I $G(DGERR)'="" D
 . D BMES^XPDUTL(" ** ERROR encountered deleting the cross reference. **")
 . D MES^XPDUTL("  - Submit a YOUR IT Services ticket with the Enterprise Service Desk")
 . D MES^XPDUTL("    for assistance.")
 Q
 ;
POST2 ; Remove all Indian Attestation data from patient records
 D BMES^XPDUTL("  - Queuing job to remove Indian Attestation data from all Patient records.")
 D BMES^XPDUTL("    All records in the PATIENT file (#2) will be scanned. If the INDIAN SELF")
 D MES^XPDUTL("    IDENTIFICATION field (#.571) is NOT null, the following fields will be")
 D MES^XPDUTL("    set to null in the patient record:")
 D MES^XPDUTL("    - INDIAN SELF IDENTIFICATION field (#.571)")
 D MES^XPDUTL("    - INDIAN START DATE field (#.572)")
 D MES^XPDUTL("    - INDIAN ATTESTATION DATE field (#.573)")
 D MES^XPDUTL("    - INDIAN END DATE field (#.574)")
 D MES^XPDUTL("    - INDIAN SELF IDENT CHANGE DT/TM  field (#.575)")
 D MES^XPDUTL("    - INDIAN SELF IDENT CHANGE USER field (#.576)")
 ;
 ;queue off job
 N ZTRTN,ZTDESC,ZTDTH,DGTEXT,ZTIO,ZTSK,DGTXT
 S ZTRTN="QJOB^DG531093P"
 S ZTDESC="DG*5.3*1093 Remove Indian Attestation data from all Patient records."
 S ZTDTH=$$NOW^XLFDT
 S ZTIO=""
 D ^%ZTLOAD
 I $G(ZTSK)'="" D
 . S DGTEXT(1)=""
 . S DGTEXT(2)="Indian Attestation data cleanup job queued."
 . S DGTEXT(3)="The task number is "_$G(ZTSK)_"."
 . S DGTEXT(4)=""
 . S DGTEXT(5)="A Mailman Message containing job results will be sent to the installer."
 I $G(ZTSK)="" D
 . S DGTEXT(1)=""
 . S DGTEXT(2)="*** Indian Attestation data cleanup job FAILED TO QUEUE. ***"
 . S DGTEXT(3)=""
 . S DGTEXT(4)="  - Submit a YOUR IT Services ticket with the Enterprise Service Desk"
 . S DGTEXT(5)="    for assistance."
 D BMES^XPDUTL(.DGTEXT)
 Q
 ;
QJOB ; Job Entry point
 ; Information from the job will be placed in ^XTMP (60 day expiration) and sent in a Mailman message
 K ^XTMP("DG531093P")
 S ^XTMP("DG531093P",0)=$$FMADD^XLFDT(DT,60)_U_DT_U_"PATCH DG*5.3*1093 Indian Attestation data cleanup job"
 ; Collect stats: start/end time and the number of records scanned and cleaned up
 N %,DFN,DGCNT,DGERR,DGDATA,DGDTS,DGDTE,DGY,Y,DGERRCNT
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTS=Y
 F DGY=.571:.001:.576 S DGDATA(DGY)="@"
 ;
 S (DGCNT,DGERRCNT,DFN)=0
 F  S DFN=$O(^DPT(DFN)) Q:'DFN  D  ; loop patients
 . ; Indian Attestation is null, get next
 . I $$GET1^DIQ(2,DFN,.571)="" Q
 . K DGERR
 . ;set fields .571 through .576 to null
 . I $$UPD^DGENDBS(2,.DFN,.DGDATA,.DGERR) D
 . . S DGCNT=DGCNT+1 ; bump count of patients we are blanking
 . . S ^XTMP("DG531093P",$J,"IA",DGCNT)=DFN  ;update was successful
 . ; If error occurred, record it in ^XTMP
 . I $G(DGERR)'="" D
 . . S DGERRCNT=DGERRCNT+1 ; bump count of errors
 . . S ^XTMP("DG531093P",$J,"IA","ERRORS",DGERRCNT)=DFN_U_DGERR ;set DFN and error into XTMP
 ;
 ; job completed, perhaps with an error, capture stats and send mailman message
 D NOW^%DTC S Y=% D DD^%DT
 S DGDTE=Y
 ;
 ; Place job data into ^XTMP Global
 S ^XTMP("DG531093P",$J,"DGSTART")=$G(DGDTS) ;job start date/time
 S ^XTMP("DG531093P",$J,"DGEND")=$G(DGDTE) ;job end date/time
 S ^XTMP("DG531093P",$J,"PATIENT RECORDS CLEARED")=DGCNT ; total records affected
 S ^XTMP("DG531093P",$J,"ERROR TOTAL")=DGERRCNT ; total error records
 ;
 D MESSAGE
 Q
 ;
MESSAGE ; Send MailMan Message when process completes
 N XMSUB,XMDUZ,XMY,XMTEXT,DGMSG,DGLN
 S XMY(DUZ)="",XMTEXT="DGMSG("
 S XMDUZ=.5,XMSUB="DG*5.3*1093 INDIAN ATTESTATION DATA CLEANUP JOB RESULTS"
 ;
 S DGMSG($I(DGLN))="The DG*5.3*1093 process has completed."
 S DGMSG($I(DGLN))=""
 I DGERRCNT D
 . S DGMSG($I(DGLN))="!!!! WARNING !!!!"
 . S DGMSG($I(DGLN))="  - Filing Errors encountered: "_DGERRCNT
 . S DGMSG($I(DGLN))="  - Submit a YOUR IT Services ticket with the Enterprise Service Desk"
 . S DGMSG($I(DGLN))="    for assistance with the errors. ***"
 . S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="This process ran through the PATIENT file (#2)"
 S DGMSG($I(DGLN))="and for each patient record, if a value was defined in the"
 S DGMSG($I(DGLN))="INDIAN SELF IDENTIFICATION field (#.571), these fields were set to null:"
 S DGMSG($I(DGLN))="   - INDIAN SELF IDENTIFICATION field (#.571)"
 S DGMSG($I(DGLN))="   - INDIAN START DATE field (#.572)"
 S DGMSG($I(DGLN))="   - INDIAN ATTESTATION DATE field (#.573)"
 S DGMSG($I(DGLN))="   - INDIAN END DATE field (#.574)"
 S DGMSG($I(DGLN))="   - INDIAN SELF IDENT CHANGE DT/TM  field (#.575)"
 S DGMSG($I(DGLN))="   - INDIAN SELF IDENT CHANGE USER field (#.576)"
 S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="The process statistics:"
 S DGMSG($I(DGLN))="Job Start Date/Time: "_$G(DGDTS)
 S DGMSG($I(DGLN))="  Job End Date/Time: "_$G(DGDTE)
 S DGMSG($I(DGLN))="Total records with INDIAN ATTESTATION data removed: "_DGCNT
 S DGMSG($I(DGLN))="Errors encountered: "_DGERRCNT
 S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="If a list of records that had Indian Attestation data removed"
 S DGMSG($I(DGLN))="is needed, you may view global ^XTMP(""DG531093P"","_$J_",""IA"""
 S DGMSG($I(DGLN))=""
 S DGMSG($I(DGLN))="NOTE: The global ^XTMP(""DG531093P"") will be purged after 60 days."
 ; Per the MailMan Developer Guide, the variable DIFROM should be NEW'd prior to making the call to ^XMD.
 N DIFROM
 D ^XMD
 Q
