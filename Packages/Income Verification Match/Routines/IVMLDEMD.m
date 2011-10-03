IVMLDEMD ;ALB/PJR/PHH/BLD - IVM DEMOGRAPHIC UPLOAD FILE DATE OF DEATH FIELDS ; 7/20/05 9:22am
 ;;2.0;INCOME VERIFICATION MATCH;**102,108,131,148**; 21-OCT-94;Build 34
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ;
DOD(DFN,IVMDA2,IVMDA1,IVMDA) ; function to upload Date of Death
 ;                                   fields and return a flag
 ;
 ;  Input:      DFN  -  as patient IEN
 ;           IVMDA2  -  pointer to case record in (#301.5) file
 ;           IVMDA1  -  pointer to PID msg in (#301.501) sub-file
 ;            IVMDA  -  pointer to record in (#301.511) sub-file
 ;
 ; Output: IVMFLAG   -  1 if a Date of Death Field
 ;                      0 if not a Date of Death field
 ;
 ;
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,Y,DODFIELD,DELDATA,CKDEL,DGDAUTO
 ;
 ; - initialize flags
 S IVMFLAG=0
 ;
 ; - check for required parameters
 I '$G(DFN)!('$G(IVMDA))!('$G(IVMDA1))!'($G(IVMDA2)) G DODQ
 ;
 ; - get pointer to (#301.92) file from (#301.511) sub-file
 S IVMPTR=+$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMDA,0)) G DODQ:'IVMPTR
 ;
ASK ;;
 D CKDEL I CKDEL G DODDEL
 W ! S DIR("A")="Do you wish to proceed with this action"
 S DIR("A",1)="You have selected to update a Date of Death field."
 S DIR("A",2)="All Date of Death Fields will be uploaded."
 S DIR("?")="Enter 'YES' to continue or 'NO' to abort."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1 G DODQ:'Y
 W !,"Filing Date of Death fields... "
 ;
 ;
LOOP ; - loop through DOD fields
 S (DGDAUTO,IVMDODUP)=1
 F DODFIELD="ZPD09","ZPD31","ZPD32" D
 .S IVMI=$O(^IVM(301.92,"C",DODFIELD,"")) I IVMI="" Q
 .S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,"")) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0)) Q:'(+IVMNODE)
 ..I DODFIELD="ZPD31",$P(IVMNODE,"^",2)=""!($P(IVMNODE,"^",2)<1)!($P(IVMNODE,"^",2)>9) S $P(IVMNODE,"^",2)="@"
 ..I DODFIELD'="ZPD31",$P(IVMNODE,"^",2)=""!($E($P(IVMNODE,"^",2),1,7)'?1.7N) S $P(IVMNODE,"^",2)="@"
 ..;
 ..;   load Date of Death field rec'd from IVM into DHCP (#2) file
 ..D UPLOAD(+DFN,$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),$P(IVMNODE,"^",2)) S IVMFLAG=1
 ..;
 ..; - remove entry from (#301.511) sub-file
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ;
 I IVMFLAG D  W "completed.",!
 .D UPLOAD(+DFN,.355,$S($G(DUZ):DUZ,1:.5))
 D DISCHRGE^DGDEATH,XFR^DGDEATH
 K IVMDODUP
 ;                                                                    
 S VALMBCK="R"
 ;
 G DODQ
 ;
DODDEL ;
 W ! S DIR("A")="Do you wish to proceed with this action"
 S DIR("A",1)="You have selected to update a DELETION of a Date of Death field."
 S DIR("A",2)="All Date of Death Fields will be deleted."
 S DIR("?")="Enter 'YES' to continue or 'NO' to abort."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S IVMFLAG=1 G DODQ:'Y
 W !,"Filing Date of Death deletions... "
 F DODFIELD="ZPD09","ZPD31","ZPD32" D
 .S IVMI=$O(^IVM(301.92,"C",DODFIELD,"")) I IVMI="" Q
 .S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,"")) Q:IVMJ']""
 .;
 .; - check for data node in (#301.511) sub-file
 .S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 .Q:'(+IVMNODE)
 .;
 .;   load Date of Death deletion rec'd from IVM into DHCP (#2) file
 .I DODFIELD="ZPD09" D UPLOAD(+DFN,.351,"@")
 .;
 .; - remove entry from (#301.511) sub-file
 .D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ;
 I IVMFLAG D  W "completed.",!
 .D UPLOAD(+DFN,.355,.5)
 ;
 S VALMBCK="R"
 ;
 G DODQ
CKDEL S CKDEL=0
 S IVMI=$O(^IVM(301.92,"C","ZPD09","")) I IVMI="" Q
 S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,""))
 I IVMJ']"" Q
 ;
 ; - check for data node in (#301.511) sub-file
 S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 Q:'(+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ;
 I $P(IVMNODE,"^",2)="""""" S CKDEL=1
 Q
AUTODOD(DFN) ;
 ; function to automatically upload Date of Death
 ; fields and return a flag
 ;
 ;  Input:      DFN  -  as patient IEN
 ;
 ; Output: IVMFLAG   -  1 if a Date of Death Field
 ;                      0 if not a Date of Death field
 ;
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,DODFIELD
 N DELDATA,CKDEL,CKADD,CKDUZ,IVMDA1,IVMDA2,DGDAUTO,IVMENT4
 ;
 ; - initialize flags
 S (IVMFLAG,CKDEL,CKADD,CKDUZ)=0,IVMENT4=999999999
 ;
 ; - check for required parameters
 S IVMDA2=$G(IVM3015)
 I 'IVMDA2 G DODQ
 S IVMDA1=$O(^HL(771.3,"B","PID",""))
 S IVMDA1=$O(^IVM(301.5,IVMDA2,"IN","B",IVMDA1,""),-1)
 I 'IVMDA1 G DODQ
 ;
 ;added for IVM*2*131
 I $$CKINPAT^IVMLDEMB($G(DFN)) D  G DODQ
 .N DODREJDT
 .; DEMBULL^IVMPREC6 already set up the IVMTEXT array so we don't want
 .; to send it if the message is to be deleted
 .; EN^IVMPREC6 will send a message if IVMCNTR
 .I $G(IVMCNTR),$G(XMSUB)["IVM - DEMOGRAPHIC UPLOAD for ",$G(IVMTEXT(1))["Updated demographic information has been received from the",$G(IVMTEXT(2))["Health Eligibilty Center.  Please select the 'Demographic Upload'" S IVMCNTR=0 K IVMTEXT
 .D AUTOREJ^IVMLDEMB,SNDBULL^IVMLDEMB ;bld 3/15/2011 for Date of Death Changes IVM*2*148
 I $P(IVMSEG,"^",9)="""""" D CKAUTO I CKDEL D AUTODEL,DEM5,BULL(+^IVM(301.5,IVMDA2,0)) G DODQ
 I $P(IVMSEG,"^",31)'=3,$P($G(^DPT(DFN,.35)),"^",1)="" D
 .D CKAUTO I CKDEL D AUTODEL,DEM5,BULL(+^IVM(301.5,IVMDA2,0)) ;G DODQ
 .I CKADD D CKDUZ,AUTOADD,DEM5 ;G DODQ
 I $P(IVMSEG,"^",31)=3,$P($G(^DPT(DFN,.35)),"^",1)'="" D
 .D CKAUTO I CKDEL D AUTODEL,DEM5,BULL(+^IVM(301.5,IVMDA2,0)) ;G DODQ
 .I CKADD D CKDUZ,AUTOADD,DEM5 G DODQ
 I $P(IVMSEG,"^",31)=3,$P($G(^DPT(DFN,.35)),"^",1)="" D
 .D CKDUZ,AUTOADD,DEM5
 ;
 G DODQ
 ;
AUTOADD ;
 S DGDAUTO=1
 ; - loop through DOD fields
 F DODFIELD="ZPD09","ZPD31","ZPD32" D
 .S IVMI=$O(^IVM(301.92,"C",DODFIELD,"")) I IVMI="" Q
 .S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,"")) Q:IVMJ']""  D
 ..;
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0)) Q:'(+IVMNODE)
 ..;
 ..;   load Date of Death field rec'd from IVM into DHCP (#2) file
 ..D UPLOAD(+DFN,$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),$P(IVMNODE,"^",2)) S IVMFLAG=1
 ..; - remove entry from (#301.511) sub-file
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ;
 I IVMFLAG D UPLOAD(+DFN,.355,$S(CKDUZ:CKDUZ,1:.5))
 D CLEAN(IVMDA2)
 Q
AUTODEL ;
 N DFNDOD,DODMPI S DFNDOD=0 I $P($G(^DPT(+DFN,.35)),U)>0 S DFNDOD=1
 F DODFIELD="ZPD09","ZPD31","ZPD32" D
 .S IVMI=$O(^IVM(301.92,"C",DODFIELD,"")) I IVMI="" Q
 .S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,"")) Q:IVMJ']""
 .; - check for data node in (#301.511) sub-file
 .S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 .Q:'(+IVMNODE)
 .;   load Date of Death deletion rec'd from IVM into DHCP (#2) file
 .I DODFIELD="ZPD09" I DFNDOD D UPLOAD(+DFN,.351,"@") S DODMPI=$$A31^MPIFA31B(+DFN),IVMFLAG=1
 .; - remove entry from (#301.511) sub-file
 .D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ;
 I IVMFLAG D
 .D NOW^%DTC
 .D UPLOAD(+DFN,.355,.5)
 .D UPLOAD(+DFN,.354,%)
 .N DA,DIE,DR
 .S DIE="^DPT(",DA=DFN,DR=".352////@"
 .D ^DIE
 Q
 D CLEAN(IVMDA2)
 Q
DEM5 ;
 I '$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,0),'$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,1) D
 .D DELETE^IVMLDEM5(IVMDA2,IVMDA1," ") ; Dummy up name parameter
 Q
CKAUTO S (CKDEL,CKADD)=0
 S IVMI=$O(^IVM(301.92,"C","ZPD09","")) I IVMI="" Q
 S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,""))
 I IVMJ']"" Q
 ;
 ; - check for data node in (#301.511) sub-file
 S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 Q:'(+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ;
 I $P(IVMNODE,"^",2)="""""" S CKDEL=1 Q
 I $P(IVMNODE,"^",2)=$P($G(^DPT(DFN,.35)),"^",1) S CKADD=1
 Q
CKDUZ ; Check to preserve DUZ for "Last Edited By"
 S IVMI=$O(^IVM(301.92,"C","ZPD32","")) I IVMI="" Q
 S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,""))
 I IVMJ']"" Q
 ;
 ; - check for data node in (#301.511) sub-file
 S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 Q:'(+IVMNODE)!($P(IVMNODE,"^",2)']"")
 ;
 I $P(IVMNODE,"^",2)=$P($G(^DPT(DFN,.35)),"^",4) D
 .S CKDUZ=$P($G(^DPT(DFN,.35)),"^",5)
 Q
UPLOAD(DFN,IVMFIELD,IVMVALUE) ; - file Date of Death fields received from IVM
 ;  Input:       DFN  -  as patient IEN
 ;          IVMFIELD  -  as the field number to be updated
 ;          IVMVALUE  -  as the value of the field
 ;
 ; Output: None
 ;
 N DA,DIE,DR
 S DIE="^DPT(",DA=DFN,DR=IVMFIELD_"////^S X=IVMVALUE"
 D ^DIE
 Q
 ;
DODQ ; - return  -->  1 if uploadable field is a Date of Death field
 ;           -->  0 if nothing uploadable
 ;
 I IVMFLAG D RESET^IVMLDEMU
 Q IVMFLAG
 ;
CLEAN(IVMI) ;
 ; Remove any Date of Death related entries from IVM UPLOAD DEM
 N IVMJ,IVMN,IVM92,OTHFLG
 S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,"ASEG","PID",IVMI,IVMJ)) Q:'IVMJ  D
 .I '$D(^IVM(301.5,IVMI,"IN",IVMJ)) D REMASEG(IVMI,IVMJ) Q
 .S (OTHFLG,IVMN)=0 F  S IVMN=$O(^IVM(301.5,IVMI,"IN",IVMJ,"DEM",IVMN)) Q:'IVMN  D
 ..S IVM92=$P(^IVM(301.5,IVMI,"IN",IVMJ,"DEM",IVMN,0),U)
 ..I "^15^36^37^"[(U_IVM92_U) D REM511(IVMI,IVMJ,IVMN)
 ..I "^15^36^37^"'[(U_IVM92_U) S OTHFLG=1
 .I 'OTHFLG D REM501(IVMI,IVMJ)
 Q
 ;
REM501(IVMI,IVMJ) ;
 ; Delete 301.501 entry to remove from ASEG x-ref
 N DA,DIE,DR
 S DA=IVMJ,DA(1)=IVMI
 S DIE="^IVM(301.5,"_DA(1)_",""IN"","
 S DR=".02////@" D ^DIE
 Q
 ;
REM511(IVMI,IVMJ,IVMN) ;
 ; Delete 301.511 entry to remove from IVM UPLOAD DEM
 N DA,DIK
 S DA(1)=IVMJ,DA(2)=IVMI,DA=IVMN
 S DIK="^IVM(301.5,"_DA(2)_",""IN"","_DA(1)_",""DEM"","
 D ^DIK
 Q
 ;
REMASEG(IVMI,IVMJ) ;
 ; Delete invalid ASEG x-ref entries
 K ^IVM(301.5,"ASEG","PID",IVMI,IVMJ)
 Q
BULL(DFN) ; Date of Death Deletion Bulletin
 I '$D(^DPT(DFN,0)) Q
 I '(+$G(^DPT(DFN,.35))) Q
 ;
 N DGDEATH,DGB,DGPCMM,XMSUB,X
 S DGDEATH=+$G(^DPT(DFN,.35)),XMSUB="Patient Death has been Deleted",DGCT=0
 D ^DGPATV
 D LINE^DGDEATH("The date of death for the following patient has been deleted.")
 D LINE^DGDEATH("")
 D DEMOG^DGDEATH
 D LINE^DGDEATH("")
 S DGPCMM=$$PCMMXMY^SCAPMC25(1,DFN,,,0) ;creates xmy array
 S DGCT=$$PCMAIL^SCMCMM(DFN,"DGTEXT",DT)
 S DGB=1 D ^DGBUL S X=DGDEATH
 K DGCT,DGDEATH D KILL^DGPATV
 ;
 Q
