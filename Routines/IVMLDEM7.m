IVMLDEM7 ;ALB/KCL - IVM DEMOGRAPHIC UPLOAD - DELETE ADDRESS ; 5/28/03 3:55pm
 ;;2.0;INCOME VERIFICATION MATCH;**10,79**; 21-OCT-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
ADDR(DFN,IVMDA2,IVMDA1,IVMDA,IVMPPICK) ; - function to check if the delete field
 ;                          is an address field and return a flag.
 ;
 ;
 ;  Input:      DFN  -  as patient IEN
 ;           IVMDA2  -  pointer to case record in (#301.5) file
 ;           IVMDA1  -  pointer to PID msg in (#301.501) sub-file
 ;            IVMDA  -  pointer to record in (#301.511) sub-file
 ;         IVMPPICK  -  residence phone number and/or another address
 ;                        field selected
 ;                      0 - phone or an address field not selected 
 ;                      1 - address field(s) selected
 ;                      2 - phone selected
 ;                      3 - both address field(s) and phone selected
 ;
 ; Output: IVMFLAG   -  1 if field is an address field
 ;                      0 if field is not an address field
 ;
 ;
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,Y
 ;
 ; - initialize flag
 S IVMFLAG=0
 ;
 ; - check for required parameters
 I '$G(DFN)!('$G(IVMDA))!('$G(IVMDA1))!'($G(IVMDA2)) G ADDRQ
 ;
 ; - get pointer to (#301.92) file from (#301.511) sub-file
 S IVMPTR=+$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA,0)) G ADDRQ:'IVMPTR
 ;
 ;
ASK I '$D(^IVM(301.92,"AD",+IVMPTR)) G ADDRQ
 I IVMPPICK=2 G ASK1
 W ! S DIR("A")="Do you wish to proceed with this action"
 S DIR("A",1)="You have selected to delete an address field."
 S DIR("A",2)="You will be required to delete the entire address."
 S DIR("?")="Enter 'YES' to continue or 'NO' to abort."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1 G ADDRQ:'Y
 W ! S DIR("A")="Are you sure that you want to delete the complete address"
 S DIR("A",1)="If you delete this address, then the previously filed address"
 S DIR("A",2)="will be transmitted to HEC and all sites visited by this patient."
 S DIR("?",1)="Enter 'YES' to delete the complete address that was received from"
 S DIR("?")="HEC.  Enter 'NO' to quit."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1 G ADDRQ:'Y
 ;
 ; file new Address Change Date/Time
 N FDA,ERRMSG
 S FDA(2,DFN_",",.118)=$$FMTE^XLFDT($$NOW^XLFDT)
 D FILE^DIE("E","FDA","ERRMSG")
 ;
 W !,"Deleting address fields... "
 ;
LOOP ; - loop thru fields in ^IVM(301.92,"AD" x-ref
 S IVMI=0 F  S IVMI=$O(^IVM(301.92,"AD",IVMI)) Q:IVMI']""  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0)) Q:IVMNODE']""
 ..Q:'(+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ..;
 ..; - check if residence phone number and not selected to delete
 ..Q:(IVMPPICK=1&(+IVMNODE=$O(^IVM(301.92,"B","PHONE NUMBER [RESIDENCE]",0))))
 ..; - check if not residence phone number and only phone selected to delete
 ..Q:(IVMPPICK=2&(+IVMNODE'=$O(^IVM(301.92,"B","PHONE NUMBER [RESIDENCE]",0))))
 ..;
 ..; - remove entry from (#301.511) sub-file
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ..S IVMFLAG=1
 ;
 I IVMFLAG S VALMBCK="R" W "completed.",!
 ;
ADDRQ ; - return  -->  1 if delete field is an address field
 ;           -->  0 if delete field is not an address field
 ;
 I IVMFLAG D RESET^IVMLDEMU
 Q IVMFLAG
 ;
ASK1 ; - phone selected to be deleted - address fields not selected
 W ! S DIR("A")="Okay to delete the PHONE NUMBER [RESIDENCE] field"
 S DIR("?",1)="Enter 'YES' to delete the patient's Phone Number [Residence] that was"
 S DIR("?",2)="received from HEC.  Enter 'NO' to quit."
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR
 S IVMFLAG=1 G ADDRQ:'Y
 W !,"Deleting PHONE NUMBER [RESIDENCE] field from the list... "
 G LOOP
