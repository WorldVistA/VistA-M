IVMLDEM6 ;ALB/KCL/BRM/PHH/CKN - IVM DEMOGRAPHIC UPLOAD FILE ADDRESS ; 2/15/07 3:10pm
 ;;2.0;INCOME VERIFICATION MATCH;**10,58,73,79,108,106,105,124,115**; 21-OCT-94;Build 28
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
ADDR(DFN,IVMDA2,IVMDA1,IVMDA,IVMPPICK) ; - function to check if uploadable field
 ;                          is an address field and return a flag
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
 ; Output: IVMFLAG   -  1 if address field
 ;                      0 if not an address field
 ;
 ;
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,Y,IVMAFLD,IVMAVAL
 ;
 ; - initialize flags
 S IVMFLAG=0
 ;
 ; - check for required parameters
 I '$G(DFN)!('$G(IVMDA))!('$G(IVMDA1))!'($G(IVMDA2)) G ADDRQ
 ;
 ; - get pointer to (#301.92) file from (#301.511) sub-file
 S IVMPTR=+$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA,0)) G ADDRQ:'IVMPTR
 ;
ASK I '$D(^IVM(301.92,"AD",+IVMPTR)) G ADDRQ
 I IVMPPICK=2 G ASK1
 W ! S DIR("A")="Do you wish to proceed with this action"
 S DIR("A",1)="You have selected to update an address field."
 S DIR("A",2)="You will be required to upload the entire address."
 S DIR("?")="Enter 'YES' to continue or 'NO' to abort."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1 G ADDRQ:'Y
 W ! S DIR("A")="Are you sure that you want to update the complete address"
 S:$$PHARM(+$G(DFN)) DIR("A",1)="*** WARNING: This patient has ACTIVE PRESCRIPTIONS on file."
 S DIR("A",2)=""
 I $$ADRDTCK^IVMLDEM9(+$G(DFN),IVMDA2,IVMDA1) S DIR("A",2)="*** WARNING: The address that you are attempting to file is OLDER than",DIR("A",3)="             the address on file.",DIR("A",4)=""
 S DIR("?",1)="Enter 'YES' to update the complete address that was received from"
 S DIR("?")="HEC.  Enter 'NO' to quit."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1 G ADDRQ:'Y
 W !,"Filing address fields... "
 ;
 ; determine correct address change date/time to use
 D ADDRDT(DFN,IVMDA2,IVMDA1)
 ;
LOOP ;
 N DGPRIOR D GETPRIOR^DGADDUTL(DFN,.DGPRIOR)
 ;
 I IVMPPICK'=2 D EN^DGCLEAR(DFN,"PERM") ;Deleting existing address before updating
 ; - loop thru fields in ^IVM(301.92,"AD" x-ref
 S IVMI=0 F  S IVMI=$O(^IVM(301.92,"AD",IVMI)) Q:IVMI']""  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0)) Q:IVMNODE']""
 ..Q:'(+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ..;
 ..; - check if residence phone number and not selected to upload
 ..Q:(IVMPPICK=1&(+IVMNODE=$O(^IVM(301.92,"B","PHONE NUMBER [RESIDENCE]",0))))
 ..; - check if not residence phone number and only phone selected to upload
 ..Q:(IVMPPICK=2&(+IVMNODE'=$O(^IVM(301.92,"B","PHONE NUMBER [RESIDENCE]",0))))
 ..;
 ..;Store Address change Date/time, source and site in ^TMP to file at the end of process.
 ..S IVMAFLD=$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),IVMAVAL=$P(IVMNODE,"^",2)
 ..I ((IVMAFLD=.118)!(IVMAFLD=.119)!(IVMAFLD=.12)) S ^TMP($J,"CHANGE UPDATE",IVMAFLD)=IVMAVAL
 ..; - perform any necessary address field manipulation and
 ..;   load addr field rec'd from IVM into DHCP (#2) file
 ..D UPLOAD(+DFN,$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),$P(IVMNODE,"^",2)) S IVMFLAG=1
 ..;
 ..; - remove entry from (#301.511) sub-file
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ;
 D ADDRCHNG^IVMPREC6(DFN) ;Update Address change date/time,source,site if necessary
 I IVMFLAG W "completed.",! D
 .N DGCURR
 .D GETUPDTS^DGADDUTL(DFN,.DGCURR)
 .D UPDADDLG^DGADDUTL(DFN,.DGPRIOR,.DGCURR)
 ;
 ; - if addr is uploaded and phone # is not - ask user delete phone
 I IVMFLAG,$P($G(^DPT(+DFN,.13)),"^")]"",(2>IVMPPICK) D PHONE
 S VALMBCK="R"
 ;
 ;
ADDRQ ; - return  -->  1 if uploadable field is an address field
 ;           -->  0 if uploadable field is not an address field
 ;
 I IVMFLAG D RESET^IVMLDEMU
 Q IVMFLAG
 ;
 ;
UPLOAD(DFN,IVMFIELD,IVMVALUE) ; - file address fields received from IVM
 ;
 ;  Input:       DFN  -  as patient IEN
 ;          IVMFIELD  -  as the field number to be updated
 ;          IVMVALUE  -  as the value of the field
 ;
 ; Output: None
 ;
 ;
 ; - update specified address field in the Patient (#2) file
 N DIE,DA,DR
 S DIE="^DPT(",DA=DFN,DR=IVMFIELD_"////^S X=IVMVALUE"
 D ^DIE K DA,DIE,DR
 ;
 ; - delete inaccurate Addr Change Site data if Source is not VAMC
 ;   (trigger x-ref does not fire with 4 slash stuff)
 I IVMFIELD=.119,IVMVALUE'="VAMC" S FDA(2,+DFN_",",.12)="@" D UPDATE^DIE("E","FDA")
 ;
 Q
 ;
 ;
PHONE ; - ask user to delete phone # [Residence] from Patient (#2) file
 D PHONE^IVMPREC9 ;Moved this tag to IVMPREC9 due to routine size limit.
 Q
 ;
ASK1 ; - phone selected to be uploaded - address fields not selected
 W ! S DIR("A")="Okay to update the PHONE NUMBER [RESIDENCE] field"
 S DIR("?",1)="Enter 'YES' to update the patient's Phone Number [Residence] that was"
 S DIR("?",2)="received from HEC.  Enter 'NO' to quit."
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR
 S IVMFLAG=1 G ADDRQ:'Y
 W !,"Updating PHONE NUMBER [RESIDENCE] field... "
 G LOOP
 ;
AUTOADDR(DFN,IVMPPICK,NOUPDT) ;
 ; this functionality is copied from above and modified to allow
 ; an automated upload of patient address information as stipulated
 ; in the business requirements for Address Indexing to support GMT
 ;
 ;  Input:      DFN  -  as patient IEN
 ;         IVMPPICK  -  residence phone number and/or another address
 ;                        field selected
 ;                      1 - address field(s) selected
 ;                      3 - both address field(s) and phone selected
 ;           NOUPDT  -  (optional) this flag is set when the incoming
 ;                      address data is older than the existing
 ;                      address in the Patient (#2) file
 ;
 ; Output: IVMFLAG   -  1 if address fields updated
 ;                      0 if address fields not updated
 ;
 ;
 ;
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,Y,IVMAFLD,IVMAVAL,DELFLG
 ;
 ; - initialize flags
 S IVMFLAG=0,DELFLG=1
 S:'$G(NOUPDT) NOUPDT=0
 ;
 ; - check for required parameters
 Q:'$G(DFN) IVMFLAG
 ;
 N DGPRIOR D GETPRIOR^DGADDUTL(DFN,.DGPRIOR)
 ; Set the flag to don't auto-update if there is an active Prescription record and the Bad Address Indicator is null
 I ('NOUPDT),$$PHARM(+DFN),'$$BADADR^DGUTL3(+DFN) S DELFLG=0
 I 'NOUPDT,DELFLG D EN^DGCLEAR(DFN,"PERM") ;Deleting existing address before updating
 ;
 S IVMDA2=$G(IVM3015)
 Q:'$G(IVMDA2) IVMFLAG
 S IVMDA1=$O(^HL(771.3,"B","PID",""))
 S IVMDA1=$O(^IVM(301.5,IVMDA2,"IN","B",IVMDA1,""),-1)
 Q:'IVMDA1 IVMFLAG
 ;
 S IVMI=0 F  S IVMI=$O(^IVM(301.92,"AD",IVMI)) Q:IVMI']""  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 ..I ('+IVMNODE)!($P(IVMNODE,"^",2)']"") Q
 ..;
 ..; - check if residence phone number -> do not auto-upload
 ..I (IVMPPICK=1&(+IVMNODE=$O(^IVM(301.92,"B","PHONE NUMBER [RESIDENCE]",0)))) D DEMBULL^IVMPREC6 Q
 ..;
 ..; don't auto-update if there is an active Prescription record and
 ..; the Bad Address Indicator is null
 ..I 'DELFLG D DEMBULL^IVMPREC6 Q
 ..;Store Address change Date/time, source and site in ^TMP to file at the end of process.
 ..S IVMAFLD=$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),IVMAVAL=$P(IVMNODE,"^",2)
 ..I 'NOUPDT,((IVMAFLD=.118)!(IVMAFLD=.119)!(IVMAFLD=.12)) S ^TMP($J,"CHANGE UPDATE",IVMAFLD)=IVMAVAL
 ..;
 ..; - load addr field rec'd from IVM into DHCP (#2) file
 ..I 'NOUPDT D UPLOAD(+DFN,IVMAFLD,IVMAVAL) S IVMFLAG=1
 ..;
 ..; - remove entry from (#301.511) sub-file
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ..; - if no display or uploadable fields left, then delete the PID
 ..;   segment
 ..I '$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,0),'$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,1) D
 ...D DELETE^IVMLDEM5(IVMDA2,IVMDA1," ") ; Dummy up name parameter
 D ADDRCHNG^IVMPREC6(DFN) ;Update Address change date/time,source,site if necessary
 I IVMFLAG D
 .N DGCURR
 .D GETUPDTS^DGADDUTL(DFN,.DGCURR)
 .D UPDADDLG^DGADDUTL(DFN,.DGPRIOR,.DGCURR)
 Q IVMFLAG
 ;
ADDRDT(DFN,IVMDA2,IVMDA1) ;
 ; - validate Address Change Dt/Tm before filing
 ;   if incoming address is accepted and the change date is older
 ;   than what's on file, then use today's date for Addr Chg Dt/Tm
 ;
 Q:'$$ADRDTCK^IVMLDEM9(DFN,IVMDA2,IVMDA1)
 N FDA,IEN92,IVMDA,IENS,ERR
 S IEN92=$O(^IVM(301.92,"C","RF171","")) Q:'IEN92
 Q:'$D(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IEN92))
 S IVMDA=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IEN92,"")) Q:'IVMDA
 S IENS=IVMDA_","_IVMDA1_","_IVMDA2_","
 S FDA(301.511,IENS,.02)=$$NOW^XLFDT
 D FILE^DIE("","FDA","ERR")
 Q
 ;
PHARM(DFN) ;does this patient have active pharmacy prescriptions?
 ;
 ;External reference to $$EN^PSSRXACT supported by IA #4237
 ;
 Q $S('$G(DFN):0,1:$$EN^PSSRXACT(DFN))
