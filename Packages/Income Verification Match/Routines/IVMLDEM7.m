IVMLDEM7 ;ALB/KCL,LBD - IVM DEMOGRAPHIC UPLOAD - DELETE ADDRESS ; 3/11/12 2:39pm
 ;;2.0;INCOME VERIFICATION MATCH;**10,79,152**; 21-OCT-94;Build 4
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
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,Y,IVMFNAM
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
 S IVMFLAG=1
 I 'Y,IVMPPICK=1 G ADDRQ    ;only address selected so quit
 I 'Y S IVMPPICK=2 G ASK1   ;check if phone should be deleted
 W ! S DIR("A")="Are you sure that you want to delete the complete address"
 S DIR("A",1)="If you delete this address, then the previously filed address"
 S DIR("A",2)="will be transmitted to HEC and all sites visited by this patient."
 S DIR("?",1)="Enter 'YES' to delete the complete address that was received from"
 S DIR("?")="HEC.  Enter 'NO' to quit."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1
 I 'Y,IVMPPICK=1 G ADDRQ    ;only address selected so quit
 I 'Y S IVMPPICK=2 G ASK1   ;check if phone # should be deleted
 ;
 ; file new Address Change Date/Time
 N FDA,ERRMSG
 S FDA(2,DFN_",",.118)=$$FMTE^XLFDT($$NOW^XLFDT)
 D FILE^DIE("E","FDA","ERRMSG")
 ;
 I IVMPPICK=3 G ASK1   ;check if phone # should be deleted
 ;
LOOP ; - loop thru fields in ^IVM(301.92,"AD" x-ref
 I IVMPPICK'=2 W !,"Deleting address fields... "
 S IVMI=0 F  S IVMI=$O(^IVM(301.92,"AD",IVMI)) Q:IVMI']""  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0)) Q:IVMNODE']""
 ..Q:'(+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ..;
 ..S IVMFNAM=$P($G(^IVM(301.92,+IVMNODE,0)),U) Q:IVMFNAM=""
 ..; - check if residence phone number and not selected to delete
 ..I IVMPPICK=1&(IVMFNAM="PHONE NUMBER [RESIDENCE]"!(IVMFNAM["RESIDENCE NUMBER CHANGE")) Q
 ..; - check if not residence phone number and only phone selected to delete
 ..I IVMPPICK=2&(IVMFNAM'="PHONE NUMBER [RESIDENCE]"&(IVMFNAM'["RESIDENCE NUMBER CHANGE")) Q
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
 S IVMFLAG=1
 I 'Y,IVMPPICK=2 G ADDRQ   ;no phone or address deletions, just quit
 I 'Y S IVMPPICK=1 G LOOP  ;address still needs to be deleted
 ;
 W !,"Deleting PHONE NUMBER [RESIDENCE] field from the list... "
 G LOOP
