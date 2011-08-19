IVMLDEM5 ;ALB/KCL - IVM DEMOGRAPHIC UPLOAD HELP ; 05-MAY-94
 ;;2.0;INCOME VERIFICATION MATCH;**10**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
EN ; - Extended help for the IVM demographic upload
 ;
 D FULL^VALM1
 D CLEAR^VALM1
 W !,?15,"***** IVM DEMOGRAPHIC UPLOAD - EXTENDED HELP *****"
 W !," "
 W !,?5,"As part of the Income Verification Match process, patient demographic"
 W !,?5,"information will be returned to field facilities.  During the course"
 W !,?5,"of verifying a Means Test, HEC contact representatives"
 W !,?5,"may determine that certain patient demographic and eligibility information"
 W !,?5,"has changed.  HEC may electronically transmit these changes"
 W !,?5,"to the field facilities in the Demographic Data Transmission message."
 W !,?5,"These demographic elements are classified as either 'UPLOADABLE' or"
 W !,?5,"'NON-UPLOADABLE'.  The Demographic Upload option will allow field"
 W !,?5,"facilities to review this data and either load (automatically or manually,"
 W !,?5,"depending upon whether the field is uploadable or non-uploadable) or"
 W !,?5,"reject the data."
 W !,?5," "
 W !,?5,"Uploadable demographic elements will be compared to the patient "
 W !,?5,"demographic elements that are currently on file in DHCP and displayed"
 W !,?5,"to the user.  The user may review these elements and choose to either"
 W !,?5,"upload or delete them."
 D PAUSE^VALM1
 W !,?5,"Non-uploadable demographic elements will be compared to the patient"
 W !,?5,"demographic elements that are currently on file in DHCP and displayed"
 W !,?5,"to the user.  This demographic information is provided to the facility"
 W !,?5,"for informational purposes only.  The user may review these elements,"
 W !,?5,"but will not be given the option to automatically load them into DHCP."
 ;
 D PAUSE^VALM1
 S VALMBCK="R"
 Q
 ;
 ;
DEMO(X,Y,TYPE) ; - extrinsic function to see if IVM patient has has demographic
 ;information for uploading or display
 ;
 ;  Input: X  --  as internal entry number of IVM PATIENT (#301.5) file
 ;         Y  --  as internal entry number of the (#301.501) sub-file
 ;         TYPE  --  as the type of demographic data:
 ;              - 0 for demographic data that is information only
 ;              - 1 for demograpic data that is uploadable
 ;
 ; Output: 1  --  if patient has specified type of demographic data
 ;         0  --  if patient does not have specified type of demographic data
 ;
 N IVMSTAT,IVMPTR
 S IVMCHK=0
 F IVMSTAT=0:0 S IVMSTAT=$O(^IVM(301.5,X,"IN",Y,"DEM","B",IVMSTAT)) Q:'IVMSTAT  D
 .S IVMPTR=$P($G(^IVM(301.92,IVMSTAT,0)),"^",3)
 .I IVMPTR=TYPE S IVMCHK=1 Q
 K X,Y,TYPE
 Q $S(IVMCHK=1:1,1:0)
 ;
 ;
DELETE(IVMDA2,IVMDA1,NAME) ; - delete segment name (.02 field from the #301.501 sub-file)
 ;    from the IVM Patient #301.5 file to remove from ASEG x-ref.
 ;
 ;  Input:   IVMDA2  --  Pointer to the case record in file #301.5
 ;           IVMDA1  --  Pointer to PID msg in sub-file #301.501
 ;             NAME  --  as patient name from the array
 ;                          ^tmp("ivmlst",$j,"idx",ctr,ctr)
 ;
 ; Output:  None
 ;
 ; - delete segment name (.02 field from the #301.501 sub-file) from
 ;   the IVM Patient #301.5 file to remove from ASEG x-ref.
 ;
 S DA=IVMDA1,DA(1)=IVMDA2
 S DIE="^IVM(301.5,"_DA(1)_",""IN"","
 S DR=".02////@" D ^DIE
 ;
 ; - delete entry from list manager array
 K ^TMP("IVMDUPL",$J,NAME,IVMDA2,IVMDA1)
 Q
