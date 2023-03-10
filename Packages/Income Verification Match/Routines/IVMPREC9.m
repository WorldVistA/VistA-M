IVMPREC9 ;ALB/KCL,BRM,CKN,TDM,KUM,JAM - PROCESS INCOMING (Z05 EVENT TYPE) HL7 MESSAGES (CON'T) ;09-05-2017 10:03am
 ;;2.0;INCOME VERIFICATION MATCH;**34,58,115,121,151,159,167,192,193,187**;21-OCT-94;Build 3
 ;Per VA Directive 6402, this routine should not be modified.
 ;
ZCT ; - compare ZCT with DHCP ; IVM*2.0*192;JAM ; Tag ZCT moved from IVMPREC8
 N ZCTTYP,IVMFORAD,IVMFOR,IVMCNTRY,IVMDHCP,IVMFLD,IVMPIECE,IVMADDR,IVMADFLG
 S IVMADFLG=0
 S IVMPIECE=$E(IVMXREF,4,8)
 ; PATCH IVM*2.0*193; jam;  Capture if IVMXREF is for a foreign address  
 ;   IVMXREF may have a 9th char - Foreign address eg ZCT054K1F
 S IVMFOR=$E(IVMXREF,9)
 ;IVM*2.0*188-COMMENT BELOW TO ALLOW QUOTES
 ;S IVMSEG=$$CLEARF^IVMPRECA(IVMSEG,HLFS)
 S ZCTTYP=$E(IVMPIECE,$L(IVMPIECE)-1,$L(IVMPIECE))
 Q:$P(IVMSEG,HLFS,2)'=$S(ZCTTYP="K1":1,ZCTTYP="K2":2,ZCTTYP="E1":3,ZCTTYP="E2":4,ZCTTYP="D1":5,1:"")
 ;
 ; IVM*2.0*192 - Get country field - if it has a value and if not "USA", quit entire ZCT processing
 ; IVM*2.0*193; patch 192 code removed - process foreign addresses 
 ; S ADDR=$P(IVMSEG,"^",5),COUNTRY=$P(ADDR,"~",6) I COUNTRY'=""&(COUNTRY'="USA") QUIT
 ;
 I $P(IVMSEG,HLFS,$E(IVMPIECE,1,2))]"" D
 .;
 .; -set var IVMFLD to incoming HL7 field
 .I 'IVMADFLG S IVMFLD=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2))
 .;IVM*2.0*188-convert "" to @
 .I IVMFLD="""""" S IVMFLD="@"
 .;
 .; - if HL7 name format convert to FM
 .I IVMXREF["ZCT03" S IVMFLD=$$FMNAME^HLFNC(IVMFLD)
 .;
 .I IVMFLD="@," S IVMFLD="@" ;IVM*2.0*188
 .; - ZCT05 as the ZCT address field is 6 pieces separated by HLECH (~)
 .I IVMXREF["ZCT05" D
 ..; IVM*2.0*193; jam; Concatenate IVMFOR to piece
 ..S IVMADDR=$P(IVMSEG,HLFS,$E(IVMPIECE,1,2)),IVMPIECE=$E(IVMPIECE,3)_IVMFOR
 ..S IVMFLD=$P(IVMADDR,$E(HLECH),IVMPIECE),IVMADFLG=1
 ..; IVM*2.0*193; jam; 6th piece added - Country - default to USA
 ..S IVMCNTRY=$S($P(IVMADDR,$E(HLECH),6)'="":$P(IVMADDR,$E(HLECH),6),1:"USA")
 ..; IVM*2.0*193; jam; Set flag if this is a foreign country
 ..S IVMFORAD=$S(IVMCNTRY="USA":0,1:1)
 ..;IVM*2.0*188-convert "" to @
 ..I IVMFLD="""""" S IVMFLD="@" Q
 ..; IVM*2.0*193; jam; foreign address added
 ..I (IVMPIECE=4)!(IVMPIECE=5) S IVMFLD=$S('IVMFORAD:IVMFLD,1:"") Q:IVMFLD=""
 ..I IVMPIECE=4 S IVMFLD=$O(^DIC(5,"C",IVMFLD,0))
 ..I IVMPIECE=5 S X=IVMFLD D ZIPIN^VAFADDR S IVMFLD=$G(X)
 ..I IVMPIECE="4F" S IVMFLD=$S(IVMFORAD:IVMFLD,1:"")  ;PROVINCE
 ..I IVMPIECE="5F" S IVMFLD=$S(IVMFORAD:IVMFLD,1:"")  ;POSTAL CODE
 ..I IVMPIECE=6 S IVMFLD=$$CNTRCONV^IVMPREC8(IVMCNTRY) ;COUNTRY
 .I IVMADFLG D STORE Q
 .; - if HL7 date convert to FM date
 .I IVMXREF["ZCT10" S IVMFLD=$$FMDATE^HLFNC(IVMFLD)
 .;
 .; - execute code on the 1 node and get DHCP field
 .S IVMDHCP="" X:$D(^IVM(301.92,+IVMDEMDA,1)) ^(1) S IVMDHCP=Y
 .;
 .;IVM*2.0*188-convert "" to @
 .I IVMFLD="""""" S IVMFLD="@"
 .;
 .; if field from IVM does not equal DHCP-store for upload
 .I IVMFLD]"",(IVMFLD'=IVMDHCP) D STORE
 .;
 .I IVMXREF["ZCT10" D
 ..I IVMFLD]"",(IVMFLD>IVMDHCP) S UPDAUPG(ZCTTYP)=1
 Q
 ;
STORE ; - store HL7 fields that have a different value than DHCP fields in
 ;   the IVM Patient (#301.5) file (#301.511) multiple for uploading
 ;
 S:$D(AUPFARY(IVMDEMDA)) UPDAUP(IVMDEMDA)=""
 G:IVMFLG STORE2
 S X=$$IEN^IVMUFNC4("PID")
 ;
 K DIC("DR")
 S DA(1)=IVM3015
 I $G(^IVM(301.5,DA(1),"IN",0))']"" S ^(0)="^301.501PA^^"
 S DIC="^IVM(301.5,"_DA(1)_",""IN"",",DIC(0)="L",DLAYGO=301.501
 K DD,DO D FILE^DICN
 K DIC,DLAYGO,X,Y
 ;
 ; - build mail message if SUPRESS DEMOGRAPHIC NOTIFICATION field is
 ;   not set in the IVM Site Parameter (#301.9) file
 ;
 I '$P($G(^IVM(301.9,1,0)),"^",5),'IVMADFLG D DEMBULL^IVMPREC6
 ;
 ; - set flag in order to not repeat STORE tag for one msg
 S IVMFLG=1
 ;
 S DA(2)=DA(1)
 S DA(1)=$P(^IVM(301.5,DA(1),"IN",0),"^",3)
 ;
STORE2 ;
 ; - X as the record in the IVM Demo Upload Fields (#301.92) file
 S X=+IVMDEMDA
 I $G(^IVM(301.5,DA(2),"IN",DA(1),"DEM",0))']"" S ^(0)="^301.511PA^^"
 S DIC="^IVM(301.5,"_DA(2)_",""IN"",DA(1),""DEM"",",DIC(0)="L"
 S DIC("DR")=".02////^S X=IVMFLD",DLAYGO=301.511
 K DD,DO D FILE^DICN
 K DIC,DLAYGO,X,Y
 ;
 Q
 ;
 ;
LOOK ; Find the current DHCP field value.
 ;  Input:   DR  --   Field number of the field in file #2
 ;          DFN  --   Pointer to the patient in file #2
 ;  Output:   Y  --   Internal value of field
 ;
 N IVMOUTTY,I
 ;S DIC="^DPT(",DA=DFN,DIQ="IVM",DIQ(0)="I" D EN^DIQ1
 S DIQ(0)=$S($G(DIQ(0))="":"I",$G(DIQ(0))="E":"E",1:"I")
 S IVMOUTTY=DIQ(0)
 S DIC="^DPT(",DA=DFN,DIQ="IVM" D EN^DIQ1
 ;S Y=$G(IVM(2,DFN,DR,"I"))
 S Y=$G(IVM(2,DFN,DR,IVMOUTTY))
 K DIC,DIQ,DR,IVM
 Q
AUTOEPC(DFN,UPDEPC) ;
 ; this functionality is copied from IVMLDEM6 and modified to allow
 ; an automated upload of patient communications information
 ;  Input:     DFN  -  as patient IEN
 ;          UPDEPC  -  array contains flag for update/noupdate for all
 ;                     communication types.
 ; Output: IVMFLAG  -  1 if communications fields updated
 ;                     0 if communications fields not updated
 ;
 N IVMFLAG,IVMI,IVMJ,IVMNODE,IVMPTR,Y,UPDT,IVMCVAL,IVMCFLD,SITEFLD,DFLG,CTYP,UPDT
 S IVMFLAG=0  ;initialize flags
 ; - check for required parameters
 Q:'$G(DFN) IVMFLAG
 S IVMDA2=$G(IVM3015)
 Q:'$G(IVMDA2) IVMFLAG
 S IVMDA1=$O(^HL(771.3,"B","PID",""))
 S IVMDA1=$O(^IVM(301.5,IVMDA2,"IN","B",IVMDA1,""),-1)
 Q:'IVMDA1 IVMFLAG
 ;
 S IVMI=0 F  S IVMI=$O(^IVM(301.92,"AD",IVMI)) Q:IVMI']""  D
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..S (UPDT,DFLG)=0
 ..; - check for data node in (#301.511) sub-file
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 ..I ('+IVMNODE)!($P(IVMNODE,"^",2)']"") Q
 ..;Check if fields needs to be updated for particular comm. Type.
 ..S CTYP=0 F  S CTYP=$O(UPDEPC(CTYP)) Q:CTYP=""!UPDT  D
 ...I ("^"_$G(UPDEPC(CTYP))_"^")[("^"_+IVMNODE_"^") S UPDT=1
 ..S IVMCFLD=$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),IVMCVAL=$P(IVMNODE,"^",2)
 ..; - load communications fields rec'd from IVM into DHCP (#2) file
 ..I UPDT D UPLOAD^IVMLDEM6(+DFN,IVMCFLD,IVMCVAL) S IVMFLAG=1
 ..; delete inaccurate Addr Change Site data if Source is not VAMC
 ..; IVM*2.0*167 - Make Home phone records auto-upload to Patient File
 ..;I UPDT,((IVMCFLD=.1311)!(IVMCFLD=.1313)!(IVMCFLD=.137)) D
 ..I UPDT,((IVMCFLD=.1311)!(IVMCFLD=.1313)!(IVMCFLD=.137)!(IVMCFLD=.1322)) D
 ...I IVMCVAL="VAMC" Q
 ...; IVM*2.0*167 - Make Home phone records auto-upload to Patient File
 ...; S SITEFLD=$S(IVMCFLD=.1311:.13111,IVMCFLD=.1313:.1314,IVMCFLD=.137:.138)
 ...S SITEFLD=$S(IVMCFLD=.1311:.13111,IVMCFLD=.1313:.1314,IVMCFLD=.137:.138,IVMCFLD=.1322:.1323)
 ...S FDA(2,+DFN_",",SITEFLD)="@" D UPDATE^DIE("E","FDA")
 ..; - remove entry only for Email, Cell, Home phone and Pager from (#301.511) sub-file
 ..S CTYP=0 F  S CTYP=$O(EPCFARY(CTYP)) Q:CTYP=""!DFLG  D
 ...I ("^"_$G(EPCFARY(CTYP))_"^")[("^"_+IVMNODE_"^") S DFLG=1
 ..I DFLG D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 ;Delete all communication data (Email, Cell phone, Pager, Home phone) if they are not received in Z05.
 I $D(EPCDEL) D
 . N CTYPE,DIE,DR,DA,CNTR,VAL
 . S DR="",CNTR=0,VAL="@"
 . S CTYPE="" F  S CTYPE=$O(EPCDEL(CTYPE)) Q:CTYPE=""  D
 . . F I=1:1:$L(EPCDEL(CTYPE),"^") S CNTR=CNTR+1,$P(DR,";",CNTR)=$P(EPCDEL(CTYPE),"^",I)_"////^S X=VAL"
 . S DIE="^DPT(",DA=DFN
 . D ^DIE K DIE,DA,DR
 Q IVMFLAG
 ;
AUTORINC(DFN) ;
 ; application to automatically upload Rated Incompetent data
 ; Input:     DFN   -   Patient IEN
 N IVMI,IVMJ,IVMDA1,IVMDA2,IVMNODE,IVMFLAG,IVMRIVAL,IVMRIFLD
 S IVMFLAG=0
 S IVMDA2=$G(IVM3015)
 I 'IVMDA2 Q IVMFLAG
 S IVMDA1=$O(^HL(771.3,"B","PID",""))
 S IVMDA1=$O(^IVM(301.5,IVMDA2,"IN","B",IVMDA1,""),-1)
 S IVMI=$O(^IVM(301.92,"C","ZPD08","")) I IVMI="" Q IVMFLAG
 S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,""))
 I IVMJ']"" Q IVMFLAG
 ; - check for data node in (#301.511) sub-file
 S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 I '(+IVMNODE)!($P(IVMNODE,"^",2)']"") Q IVMFLAG
 S IVMRIFLD=$P($G(^IVM(301.92,+IVMNODE,0)),"^",5),IVMRIVAL=$P(IVMNODE,"^",2)
 I IVMRIVAL="""""" S IVMRIVAL="@"
 D UPLOAD^IVMLDEM6(DFN,IVMRIFLD,IVMRIVAL) S IVMFLAG=1
 ; - remove entry from (#301.511) sub-file
 D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)
 Q IVMFLAG
PHONE ; - ask user to delete phone # [Residence] from Patient (#2) file
 ; This tag is moved here from IVMLDEM6 due to routine size limit
 D FULL^VALM1
 W ! S DIR("A")="Is it okay to delete the patient's Phone Number [Residence]"
 W ! S DIR("A",1)="The patient's address has been updated and the phonenumber"
 S DIR("A",2)="remains on file."
 S DIR("A",3)=" "
 S DIR("A",4)="Patient Name: "_$P($$PT^IVMUFNC4(+DFN),"^")_" ("_$P($$PT^IVMUFNC4(+DFN),"^",3)_")"
 S DIR("A",5)="Phone Number [Residence]: "_$P($G(^DPT(+DFN,.13)),"^")
 S DIR("A",6)=" "
 S DIR("?",1)="Enter 'YES' to delete the patient's Phone Number [Residence] that is"
 S DIR("?",2)="currently on file.  Enter 'NO' to quit without deleting the patient's"
 S DIR("?")="Phone Number [Residence]."
 S DIR(0)="Y",DIR("B")="NO"
 D ^DIR K DIR
 S:Y $P(^DPT(DFN,.13),"^")="" W !!,"Patient's Phone Number [Residence] has ",$S(Y:"",1:"not "),"been deleted."
 Q
 ;
AUTOAUP(DFN,UPDAUP,UPDAUPG) ;
 ; automated upload of misc information
 ;  Input:     DFN  -  patient IEN
 ;          UPDAUP  -  array contains fields for auto-upload
 ;         UPDAUPG  -  array contains field group flag for auto-upload
 ;
 N IVMDA2,IVMDA1,IVMI,MULTFLG,IVMXREF,UFLG,IVMJ,IVMNODE,IVMCFLD,IVMCVAL,Y,IVM30192,MULFIL
 Q:'$G(DFN)
 S IVMDA2=$G(IVM3015) Q:'IVMDA2
 S IVMDA1=$O(^HL(771.3,"B","PID",""))
 S IVMDA1=$O(^IVM(301.5,IVMDA2,"IN","B",IVMDA1,""),-1) Q:'IVMDA1
 ;
 S IVMI="" F  S IVMI=$O(UPDAUP(IVMI)) Q:IVMI=""  D
 .;
 .;If DHCP field is a multiple set multiple flag for special filing
 .S MULTFLG=0
 .S IVM30192=$G(^IVM(301.92,IVMI,0)),IVMXREF=$P(IVM30192,"^",2)
 .I IVMXREF="PID10" S MULTFLG=1       ;Race
 .I IVMXREF="PID117C" S MULTFLG=1     ;Conf Addr Category
 .I IVMXREF="PID22" S MULTFLG=1       ;Ethnicity
 .;
 .;Don't file if part of a group & group update flag not set
 .S UFLG=1 I AUPFARY(IVMI)'="",'UPDAUPG(AUPFARY(IVMI)) S UFLG=0
 .;
 .S IVMJ=0 F  S IVMJ=$O(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM","B",IVMI,IVMJ)) Q:IVMJ']""  D
 ..S IVMNODE=$G(^IVM(301.5,IVMDA2,"IN",IVMDA1,"DEM",IVMJ,0))
 ..I $G(AUPFARY(+$P(IVMNODE,"^")))'="",(($P(IVMNODE,"^",2)="")!($P(IVMNODE,"^",2)="""""")) S $P(IVMNODE,"^",2)="@"
 ..I +$G(ZEMADRUP(IVMXREF)),$P(IVMNODE,"^",2)="" S $P(IVMNODE,"^",2)="@"
 ..I ('+IVMNODE)!($P(IVMNODE,"^",2)']"") Q
 ..S IVMCFLD=$P($G(^IVM(301.92,+IVMNODE,0)),"^",5)
 ..S IVMCVAL=$P(IVMNODE,"^",2)
 ..;
 ..I UFLG D
 ...I MULTFLG D AUTOAUPM(+DFN,IVM30192,IVMCVAL)         ;file mult fld
 ...I 'MULTFLG D UPLOAD^IVMLDEM6(+DFN,IVMCFLD,IVMCVAL)  ;file non-mult
 ..D DELENT^IVMLDEMU(IVMDA2,IVMDA1,IVMJ)          ;remove from 301.511
 ..; - if no display or uploadable fields left, delete the PID segment
 ..I '$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,0),'$$DEMO^IVMLDEM5(IVMDA2,IVMDA1,1) D
 ...D DELETE^IVMLDEM5(IVMDA2,IVMDA1," ") ; Dummy up name parameter
 Q
 ;
AUTOAUPM(DFN,IVM30192,IVMVALUE) ;
 ;  Input:       DFN  -  as patient IEN
 ;          IVM30192  -  as '0' node of the 301.92 entry
 ;          IVMVALUE  -  as the value of the field
 ;
 ; Output: None
 ;
 N MFIL,MFLD,DDINFO,DDMNOD,DDMFLD,DA,DIK,DGENDA,MULFIL,DATA,SUB
 S MFIL=$P(IVM30192,"^",4),MFLD=$P(IVM30192,"^",5)
 S DDINFO=$G(^DD(MFIL,MFLD,0))
 S DDMNOD=$P($P(DDINFO,"^",4),";"),DDMFLD=+$P(DDINFO,"^",2)
 ;
 ; - delete values currently in the multiple field
 S DA(1)=DFN,DIK="^DPT("_DFN_","""_DDMNOD_""","
 S DA=0 F  S DA=$O(^DPT(DFN,DDMNOD,DA)) Q:'DA  D ^DIK
 ;
 ; - add new values to multiple field
 S DGENDA(1)=DFN
 ;
 I DDMFLD=2.02 D
 .S DATA(.02)=$$FIND1^DIC(10.3,,,"SELF IDENTIFICATION")
 .S SUB="" F  S SUB=$O(IVMRACE(2,SUB)) Q:SUB=""  D
 ..S DATA(.01)=SUB
 ..; Changed FileMan call for processing of DINUM recs IVM*2.0*159
 ..;I $$ADD^DGENDBS(DDMFLD,.DGENDA,.DATA)
 ..S (X,DINUM)=DATA(.01),DIC="^DPT(DFN,.02,",DA(1)=DFN,DIC(0)="L"
 ..K DO D FILE^DICN K DIC,X,DINUM,DA
 ;
 I DDMFLD=2.06 D
 .S DATA(.01)=IVMVALUE
 .S DATA(.02)=$$FIND1^DIC(10.3,,,"SELF IDENTIFICATION")
 .;Changed Fileman call for processing of Dinum recs IVM*2.0*159-BG
 .;I $$ADD^DGENDBS(DDMFLD,.DGENDA,.DATA)
 .S (X,DINUM)=DATA(.01),DIC="^DPT(DFN,.06,",DA(1)=DFN,DIC(0)="L"
 .K DO D FILE^DICN K DIC,X,DINUM,DA
 ;
 I DDMFLD=2.141 D
 .S DATA(1)="Y"
 .S SUB="" F  S SUB=$O(CONFADCT(SUB)) Q:SUB=""  D
 ..S DATA(.01)=SUB
 ..I $$ADD^DGENDBS(DDMFLD,.DGENDA,.DATA)
 Q
PID12 ;IVM*2.0*187 Called from IVMPREC8 to reset FORADDR
 I $G(AUPFARY(IVMDEMDA))="CA" S IVMADDR=$G(ADDRESS("CA")) ;Conf Addr
 I $G(AUPFARY(IVMDEMDA))'="CA" D
 .S IVMADDR=$S($D(ADDRESS("P")):ADDRESS("P"),$D(ADDRESS("VAB1")):ADDRESS("VAB1"),$D(ADDRESS("VAB2")):ADDRESS("VAB2"),$D(ADDRESS("VAB3")):ADDRESS("VAB3"),$D(ADDRESS("VAB4")):ADDRESS("VAB4"),1:"")
 .I $G(AUPFARY(IVMDEMDA))="RA" S IVMADDR=$G(ADDRESS("R"))
 I IVMADDR="" Q
 S COUNTRY=$P(IVMADDR,$E(HLECH),6)
 S FORADDR=$S(COUNTRY="USA":0,1:1)
 Q
