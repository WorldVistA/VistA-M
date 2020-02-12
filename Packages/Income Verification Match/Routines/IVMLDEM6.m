IVMLDEM6 ;ALB/KCL,BRM,PHH,CKN,LBD,KUM - IVM DEMOGRAPHIC UPLOAD FILE ADDRESS ;09/02/19 8:24pm
 ;;2.0;INCOME VERIFICATION MATCH;**10,58,73,79,108,106,105,124,115,152,164,177,188**;21-OCT-94;Build 12
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
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,Y,IVMAFLD,IVMAVAL,IVMFNAM
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
 S IVMFLAG=1
 I 'Y,IVMPPICK=1 G ADDRQ    ;only address selected so quit
 I 'Y S IVMPPICK=2 G ASK1   ;check if phone should be updated
 W ! S DIR("A")="Are you sure that you want to update the complete address"
 S:$$PHARM(+$G(DFN)) DIR("A",1)="*** WARNING: This patient has ACTIVE PRESCRIPTIONS on file."
 S DIR("A",2)=""
 I $$ADRDTCK^IVMLDEM9(+$G(DFN),IVMDA2,IVMDA1) S DIR("A",2)="*** WARNING: The address that you are attempting to file is OLDER than",DIR("A",3)="             the address on file.",DIR("A",4)=""
 S DIR("?",1)="Enter 'YES' to update the complete address that was received from"
 S DIR("?")="HEC.  Enter 'NO' to quit."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1
 I 'Y,IVMPPICK=1 G ADDRQ     ;only address selected so quit
 I 'Y S IVMPPICK=2 G ASK1    ;check if phone should be updated
 ;
 ; determine correct address change date/time to use
 D ADDRDT(DFN,IVMDA2,IVMDA1)
 ;
 I IVMPPICK=3 G ASK1   ;phone number also selected
 ;
 G LOOP  ;only address selected, proceed to filing
 ;
ASK1 ; - phone selected to be uploaded
 W !! S DIR("A")="OK to update"
 S DIR("A",1)="You have selected to update the PHONE NUMBER [RESIDENCE] field."
 I $$PHNDTCK^IVMLDEM9(+$G(DFN),IVMDA2,IVMDA1) D
 .S DIR("A",2)="*** WARNING: The phone number that you are attempting to file is OLDER than"
 .S DIR("A",3)="             the phone number on file."
 .S DIR("A",4)=""
 S DIR("?",1)="Enter 'YES' to update the patient's Phone Number [Residence] that was"
 S DIR("?",2)="received from HEC.  Enter 'NO' to quit."
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR
 S IVMFLAG=1
 I 'Y,IVMPPICK=2 G ADDRQ   ;no phone or address updates, just quit
 I 'Y S IVMPPICK=1 G LOOP  ;address still needs to be filed
 ;
 ; determine correct phone # change date/time to use
 D PHONDT(DFN,IVMDA2,IVMDA1)
 ;
 W !,"Filing PHONE NUMBER [RESIDENCE] field... "
 ;
LOOP ;
 N DGPRIOR D GETPRIOR^DGADDUTL(DFN,.DGPRIOR)
 ;
 I IVMPPICK'=2 D
 .W !,"Filing address fields... "
 .D EN^DGCLEAR(DFN,"PERM") ;Deleting existing address before updating
 ; - loop thru fields in ^IVM(301.92,"AD" x-ref
 S IVMI=0 F  S IVMI=$O(^IVM(301.92,"AD",IVMI)) Q:IVMI']""  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0)) Q:IVMNODE']""
 ..Q:'(+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ..;
 ..S IVMFNAM=$P($G(^IVM(301.92,+IVMNODE,0)),U) Q:IVMFNAM=""
 ..; - check if residence phone number and not selected to upload
 ..I IVMPPICK=1&(IVMFNAM="PHONE NUMBER [RESIDENCE]"!(IVMFNAM["RESIDENCE NUMBER CHANGE")) Q
 ..; - check if not residence phone number and only phone selected to upload
 ..I IVMPPICK=2&(IVMFNAM'="PHONE NUMBER [RESIDENCE]"&(IVMFNAM'["RESIDENCE NUMBER CHANGE")) Q
 ..;
 ..;Store Address change Date/time, source and site in ^TMP to file at the end of process.
 ..S IVMAFLD=$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),IVMAVAL=$P(IVMNODE,"^",2)
 ..I ((IVMAFLD=.118)!(IVMAFLD=.119)!(IVMAFLD=.12)) S ^TMP($J,"CHANGE UPDATE",IVMAFLD)=IVMAVAL
 ..;Store Residence Number change Date/time, source and site in ^TMP to file at the end of process.
 ..I ((IVMAFLD=.1321)!(IVMAFLD=.1322)!(IVMAFLD=.1323)) S ^TMP($J,"CHANGE UPDATE",IVMAFLD)=IVMAVAL
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
 ;I IVMFLAG,$P($G(^DPT(+DFN,.13)),"^")]"",(2>IVMPPICK) D PHONE
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
 N DIE,DA,DR,IENS,FDA,IVMZCT
 ; KUM - IVM*2.0*164 
 ; To bypass DELETE TEST node test in DD for TEMP ADDRESS LINE2 AND TEMP ADDRESS LINE3
 ; In Some production accounts, DELETE TEST node is set for .1212 and .1213
 I ((IVMFIELD=.1212)!(IVMFIELD=.1213)),(IVMVALUE="@") D  Q
 .S IENS=DFN_","
 .S FDA(2,IENS,IVMFIELD)="@"
 .D FILE^DIE("","FDA")
 ; IVM*2.0*164 - Allow updating null values in Confidential start and end dates
 I ((IVMFIELD=.1417)!(IVMFIELD=.1418)) D
 .S IENS=DFN_","
 .S FDA(2,IENS,IVMCAFG)="Y"
 .D FILE^DIE("","FDA")
 I ((IVMFIELD=.1417)!(IVMFIELD=.1418)),(IVMVALUE="@") D  Q
 .S IENS=DFN_","
 .S FDA(2,IENS,IVMFIELD)="@"
 .D FILE^DIE("","FDA")
 I IVMFIELD=.14112 D  Q
 .S IENS=DFN_","
 .S FDA(2,IENS,IVMCAFG)=IVMCAVL
 .D FILE^DIE("","FDA")
 .S IENS=DFN_","
 .S FDA(2,IENS,IVMFIELD)=IVMVALUE
 .D FILE^DIE("","FDA")
 .;
 .;KUM - Use API to delete if field from ZCT and double quotes are sent.  Double quotes are converted to @
 .;IVM*2.0*188
 .S IVMZCT="N"
 .;NAME Fields
 .I ((IVMFIELD=.211)!(IVMFIELD=.2191)!(IVMFIELD=.331)!(IVMFIELD=.3311)!(IVMFIELD=.341)) S IVMZCT="Y"
 .;RELATIONSHIP TO PATIENT Fields
 .I ((IVMFIELD=.212)!(IVMFIELD=.2192)!(IVMFIELD=.332)!(IVMFIELD=.3312)!(IVMFIELD=.342)) S IVMZCT="Y"
 .;STREET ADDRESS LINE1 Fields
 .I ((IVMFIELD=.213)!(IVMFIELD=.2193)!(IVMFIELD=.333)!(IVMFIELD=.3313)!(IVMFIELD=.343)) S IVMZCT="Y"
 .;STREET ADDRESS LINE2 Fields
 .I ((IVMFIELD=.214)!(IVMFIELD=.2194)!(IVMFIELD=.334)!(IVMFIELD=.3314)!(IVMFIELD=.344)) S IVMZCT="Y"
 .;STREET ADDRESS LINE3 Fields
 .I ((IVMFIELD=.215)!(IVMFIELD=.2195)!(IVMFIELD=.335)!(IVMFIELD=.3315)!(IVMFIELD=.345)) S IVMZCT="Y"
 .;CITY Fields
 .I ((IVMFIELD=.216)!(IVMFIELD=.2196)!(IVMFIELD=.336)!(IVMFIELD=.3316)!(IVMFIELD=.346)) S IVMZCT="Y"
 .;STATE Fields
 .I ((IVMFIELD=.217)!(IVMFIELD=.2197)!(IVMFIELD=.337)!(IVMFIELD=.3317)!(IVMFIELD=.347)) S IVMZCT="Y"
 .;ZIPCODE Fields
 .I ((IVMFIELD=.218)!(IVMFIELD=.2198)!(IVMFIELD=.338)!(IVMFIELD=.3318)!(IVMFIELD=.348)) S IVMZCT="Y"
 .;ZIP+4 Fields
 .I ((IVMFIELD=.2201)!(IVMFIELD=.2203)!(IVMFIELD=.2207)!(IVMFIELD=.2204)!(IVMFIELD=.2202)) S IVMZCT="Y"
 .;PHONE NUMBER Fields
 .I ((IVMFIELD=.219)!(IVMFIELD=.2199)!(IVMFIELD=.339)!(IVMFIELD=.3319)!(IVMFIELD=.349)) S IVMZCT="Y"
 .;WORK PHONE NUMBER Fields
 .I ((IVMFIELD=.21011)!(IVMFIELD=.211011)!(IVMFIELD=.33011)!(IVMFIELD=.331011)!(IVMFIELD=.34011)) S IVMZCT="Y"
 .;ADDRESS SAME AS PATIENT Fields
 .I ((IVMFIELD=.2125)!(IVMFIELD=.21925)) S IVMZCT="Y"
 .;CONTACT TYPE SAME AS NOK Fields
 .I ((IVMFIELD=.3305)!(IVMFIELD=.3405)) S IVMZCT="Y"
 .I (IVMVALUE="@"),(IVMZCT="Y") D
 ..S IENS=DFN_","
 ..S FDA(2,IENS,IVMFIELD)="@"
 ..D FILE^DIE("","FDA")
 ;KUM - END
 S DIE="^DPT(",DA=DFN,DR=IVMFIELD_"////^S X=IVMVALUE"
 D ^DIE K DA,DIE,DR
 ;
 ; - delete inaccurate Addr Change Site data if Source is not VAMC
 ;   (trigger x-ref does not fire with 4 slash stuff)
 I IVMFIELD=.119,IVMVALUE'="VAMC" S FDA(2,+DFN_",",.12)="@" D UPDATE^DIE("E","FDA")
 ; KUM - IVM*2.0*164 
 ; If Source is not VAMC, delete the Site
 I IVMFIELD=.11582,IVMVALUE'="VAMC" S FDA(2,+DFN_",",.11581)="@" D UPDATE^DIE("E","FDA")
 Q
 ;
 ;
PHONE ; - ask user to delete phone # [Residence] from Patient (#2) file
 D PHONE^IVMPREC9 ;Moved this tag to IVMPREC9 due to routine size limit.
 Q
 ;
AUTOADDR(DFN,IVMPPICK,NOUPDT,NOPHUP) ;
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
 ;           NOPHUP  -  (optional) this flag is set when the incoming
 ;                      home phone number is older than the existing
 ;                      home phone number in the Patient (#2) file
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
 S:'$G(NOPHUP) NOPHUP=0   ;Added for IVM*2*152
 ;
 ; - check for required parameters
 Q:'$G(DFN) IVMFLAG
 ;
 N DGPRIOR D GETPRIOR^DGADDUTL(DFN,.DGPRIOR)
 ; Set the flag to don't auto-update if there is an active Prescription record and the Bad Address Indicator is null
 ; IVM*2.0*177; jam; - Auto upload even if patient has active prescription and bad address indicator is null
 ;I ('NOUPDT),$$PHARM(+DFN),'$$BADADR^DGUTL3(+DFN) S DELFLG=0
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
 ..;   If NOPHUP=1 delete entry from #301.511 sub-file, otherwise quit
 ..;   (IVM*2*152)
 ..I $P($G(^IVM(301.92,+IVMNODE,0)),U)="PHONE NUMBER [RESIDENCE]"!($P($G(^IVM(301.92,+IVMNODE,0)),U)["RESIDENCE NUMBER CHANGE") D  Q
 ...I NOPHUP D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
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
PHONDT(DFN,IVMDA2,IVMDA1) ;
 ; - validate Residence Number Change Dt/Tm before filing
 ;   if incoming phone number is accepted and the change date is
 ;   older than what's on file, then use today's date for
 ;   Residence Number Change Dt/Tm (IVM*2*152)
 ;
 Q:'$$PHNDTCK^IVMLDEM9(DFN,IVMDA2,IVMDA1)
 N FDA,IEN92,IVMDA,IENS,ERR
 S IEN92=$O(^IVM(301.92,"C","RF171P","")) Q:'IEN92
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
