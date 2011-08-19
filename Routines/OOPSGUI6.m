OOPSGUI6 ;WIOFO/LLH-RPC routines for ASISTS Gui ;9/18/01
 ;;2.0;ASISTS;**4,8,7**;Jun 03, 2002
 ;
UNIGET(RESULTS) ; Returns entries in the Union table
 N DATA,CNT,SUP,UIEN,UNI
 S CNT=0,UNI=""
 F  S UNI=$O(^OOPS(2263.7,"B",UNI)) Q:UNI=""  D
 .S UIEN=0
 .F  S UIEN=$O(^OOPS(2263.7,"B",UNI,UIEN)) Q:UIEN=""  D
 ..S DATA=$G(^OOPS(2263.7,UIEN,0))
 ..S SUP=$$GET1^DIQ(200,$P($G(DATA),U,3),.01)
 ..S RESULTS(CNT)=DATA_U_SUP_U_UIEN,CNT=CNT+1
 Q
UNIKILL(RESULTS,INPUT) ;
 ;  Input - INPUT contains the IEN for Union to be deleted
 ; Output - RESULTS will contain a message indicating the record
 ;          was successfully deleted.
 N DA,DIK
 S RESULTS="No Changes Filed"
 S DIK="^OOPS(2263.7,",DA=INPUT
 D ^DIK
 S RESULTS="Record Successfully Deleted"
 Q
UNIADD ; Files a new record in ^OOPS(2263.7 
 N X,DIC,DLAYGO
 K DO
 S DLAYGO=2263.7,DIC="^OOPS(2263.7,",DIC(0)="L",X=NM
 D FILE^DICN
 I Y=-1 S RESULTS="Failed" Q
 S DA=+Y,RESULTS=X_" union added"
 Q
UNIEDT(RESULTS,INPUT) ; Edits the input in ^OOPS(2263.7
 ;  Input - INPUT contains the IEN of Union to be edited or NULL if a
 ;          new union is being added.  Also has the Union Name,
 ;          Acronym, and  Representative in the format:
 ;          IEN^UNION NAME^UNION ACRONYM^UNION REP
 ; Output - RESULTS contains a status message regarding the filing of
 ;          the data
 N DA,DIE,DR,IEN,NM,ACR,REP
 S RESULTS="No Changes Filed"
 S DIE="^OOPS(2263.7,",IEN=$P($G(INPUT),U),NM=$P($G(INPUT),U,2)
 I $G(NM)="" Q
 I $G(IEN)="" D UNIADD S IEN=DA
 I RESULTS="Failed" Q
 S ACR=$P($G(INPUT),U,3),REP=$P($G(INPUT),U,4)
 S DA=IEN,DR=".01///^S X=NM;1///^S X=ACR;2///^S X=REP"
 D ^DIE
 I $G(Y)="" D  Q
 .;if next line executed, then straight edit, not an add
 .I RESULTS="No Changes Filed" S RESULTS="Union Update Successful."
 S RESULTS="Union Update NOT Successful."
 Q
SITEPGET(RESULTS,FORM) ;
 ;  Input - FORM = contains either a blank for 'normal' site parameter
 ;          look ups or 'OSHA300' if for the OSHA 300A summary input
 ; Output - RESULTS is an array whose 0 node contains the Site 
 ;          parameter name, IEN, and District Office in the format:
 ;          SITE NAME^DISTRICT OFFICE^SITE IEN
 ;          Subsequent nodes starting from 1 contain Station information
 ;          in the following format:
 ;          STANM_U_PNM_U_PADD_U_PCTY_U_PST_U_PZIP_U_PTITLE_
 ;          U_CHGBKCODE_U_SUB_U_STA
 N CNT,DOFF,IENS,SIEN,STA,SUB,SNAME,STR,STR2,CBCSUF
 S SIEN=$P($G(^OOPS(2262,0)),U,3)
 N CBC,STANM,STATION,PNM,PADD,PCTY,PST,PZIP,PTITLE
 S (CBC,STATION,PNM,PADD,PCTY,PST,PZIP,PTITLE)=""
 N NA,TTL,PHN,EXT,IND,NAICS,SIC
 S (NA,TTL,PHN,EXT,IND,NAICS,SIC)=""
 I '$G(SIEN) S RESULTS(0)="No Site Parameter File was Found" Q
 L +^OOPS(2262,SIEN):2
 E  S RESULTS(0)="This option in use by another user, try again later." Q
 S SNAME=$$GET1^DIQ(2262,SIEN,.01),DOFF=$$GET1^DIQ(2262,SIEN,2,"E")
 S RESULTS(0)=SNAME_U_DOFF_U_SIEN
 S CNT=1,SUB=""
 F  S SUB=$O(^OOPS(2262,SIEN,SUB)) Q:SUB=""  S STA=0 D
 .F  S STA=$O(^OOPS(2262,SIEN,SUB,STA)) Q:STA'>0  D
 ..S STR=$G(^OOPS(2262,SIEN,SUB,STA,0)),IENS=STA_","_SUB_","
 ..S STR2=$G(^OOPS(2262,SIEN,SUB,STA,1))
 ..S STATION=$$GET1^DIQ(2262.03,IENS,".01:99")
 ..S STANM=$$GET1^DIQ(2262.03,IENS,.01)_" = "_STATION
 ..; Patch 5 llh - if station inactive blank STA
 ..I $$GET1^DIQ(4,$P(STR,U),101)'="" S STA=""
 ..I $G(FORM)="" D
 ...S PNM=$P(STR,U,2),PADD=$P(STR,U,3),PCTY=$P(STR,U,4),PZIP=$P(STR,U,6)
 ...I $P(STR,U,5)'="" S PST=$$GET1^DIQ(2262.03,IENS,4)
 ...I $P(STR,U,7)'="" S PTITLE=$$GET1^DIQ(2262.03,IENS,6)
 ...S CBC=$P(STR,U,8) I $G(CBC)'="" S CBC=$$GET1^DIQ(2263.6,CBC,.01)
 ...;Patch 5 llh - added CBCSUF sets
 ...S CBCSUF=$P(STR,U,9)
 ...S RESULTS(CNT)=STANM_U_PNM_U_PADD_U_PCTY_U_PST_U_PZIP_U_PTITLE_U_CBC_U_SUB_U_STA_U_CBCSUF
 ..I $G(FORM)="OSHA300" D
 ...I $P(STR2,U,1)'="" S NA=$$GET1^DIQ(2262.03,IENS,7)
 ...S TTL=$P(STR2,U,2),PHN=$P(STR2,U,3),EXT=$P(STR2,U,4)
 ...S IND=$P(STR2,U,5),SIC=$$GET1^DIQ(2262.03,IENS,12)
 ...S NAICS=$$GET1^DIQ(2262.03,IENS,13)
 ...S RESULTS(CNT)=STANM_U_NA_U_TTL_U_PHN_U_EXT_U_IND_U_SIC_U_NAICS_U_SUB_U_STA_U_$P(STR,U,1)_U
 ..I $G(FORM)="" S (STANM,PNM,PADD,PCTY,PST,PZIP,PTITLE,CBC,CBCSUF)=""
 ..E  S (NA,TTL,PHN,EXT,IND,NAICS,SIC)=""
 ..S CNT=CNT+1
 L -^OOPS(2262,SIEN)
 Q
SITEPADD ; Creates a new Station Subfile in the Site Parameter
 ;                 File (#2262
 N X,DIC,DLAYGO
 S DLAYGO=2262,DIC="^OOPS(2262,"_SIEN_","_SUBF_",",DIC(0)="L"
 S DA(1)=SIEN,X=STANM
 D FILE^DICN
 I Y=-1 S RESULTS="Failed" Q
 S DA=+Y,RESULTS="Successfully Added"
 Q
SITEPKIL(RESULTS,INPUT) ; Deletes the Station Subfile whose IEN was passed in
 ;  Input - INPUT contains the Site Parameter file IEN, the subfile IEN,
 ;          and the Station IEN in the format: SIEN^SUBF^STAIEN
 ; Output - RESULTS contains a message with the filing status
 N DA,DIK,SIEN,SUBF,STAIEN
 S SIEN=$P($G(INPUT),U),SUBF=$P($G(INPUT),U,2),STAIEN=$P($G(INPUT),U,3)
 I $G(SIEN)=""!($G(SUBF)="")!($G(STAIEN)="") D  Q
 .S RESULTS="Missing Record Identifiers, Cannot file."
 S DIK="^OOPS(2262,"_SIEN_","_SUBF_","
 S DA=STAIEN,DA(1)=SIEN
 D ^DIK
 I $G(Y)="" S RESULTS="Deletion did not occur." Q
 S RESULTS="Record successfully deleted"
 Q
SITEPEDT(RESULTS,INPUT,DATA,FORM) ;
 ;  Edits the Station Subfile whose data and IEN have been passed in
 ;  Input - INPUT contains the IEN of the Site Parameter file, subfile
 ;                & Station IEN.  If adding new station, the Station IEN 
 ;                = "". INPUT format:  SITE IEN^SUBFILE IEN^STATION IEN
 ;          DATA  contains the data to be filed
 ;          FORM  is either "" or "OSHA300" to signify data for filing
 ; Output - RESULTS is a single value with a message regarding the 
 ;          filing status
 N CBC,DA,DIE,DR,PNM,PADD,PCTY,PST,PZIP,PTITLE,SIEN,SUBF,CBCSUF
 N STANM,STAIEN,NA,TTL,PHN,EXT,IND,SIC,NAICS
 S RESULTS="Filing"
 S SIEN=$P($G(INPUT),U),SUBF=$P($G(INPUT),U,2),STAIEN=$P($G(INPUT),U,3)
 I $G(SIEN)="" S RESULTS="Missing Record Identifiers, Cannot file." Q
 I '$G(SUBF) S SUBF=$O(^OOPS(2262,SIEN,0)) I '$G(SUBF) S SUBF=1
 S STANM=$P($G(DATA),U)
 I $G(STANM)="" S RESULTS="Missing Station, Cannot continue." Q
 I $G(STAIEN)="" D SITEPADD S STAIEN=DA
 I $G(STAIEN)="" S RESULTS="Missing Station, cannot file." Q
 S DIE="^OOPS(2262,"_SIEN_","_SUBF_","
 S DA=STAIEN,DA(1)=SIEN,DR=""
 I $G(FORM)="" D
 .S PNM=$P($G(DATA),U,2),PADD=$P($G(DATA),U,3)
 .S PCTY=$P($G(DATA),U,4),PST=$P($G(DATA),U,5),PZIP=$P($G(DATA),U,6)
 .S PTITLE=$P($G(DATA),U,7),CBC=$P($G(DATA),U,8)
 .; Patch 5 llh - Added CBCSUF sets
 .S CBCSUF=$P($G(DATA),U,9)
 .S DR=".7///^S X=CBC;.8///^S X=CBCSUF;1///^S X=PNM;2///^S X=PADD;3///^S X=PCTY;4///^S X=PST;5///^S X=PZIP;6///^S X=PTITLE"
 I $G(FORM)="OSHA300" D
 .S NA=$P($G(DATA),U,2),TTL=$P($G(DATA),U,3),PHN=$P($G(DATA),U,4)
 .S EXT=$P($G(DATA),U,5),IND=$P($G(DATA),U,6),SIC=$P($G(DATA),U,7)
 .S NAICS=$P($G(DATA),U,8)
 .S DR="7///^S X=NA;8///^S X=TTL;9///^S X=PHN;10///^S X=EXT"
 .S DR=DR_";11///^S X=IND;12///^S X=SIC;13///^S X=NAICS"
 I $G(DR)'="" D ^DIE
 I $G(Y)="" D  Q
 .; if line below executed, then no Add, only edit
 .I RESULTS="Filing" S RESULTS="Update Successful"
 S RESULTS="Update was not Successful"
 Q
PARMEDT(RESULTS,INPUT) ; Files changes to top level file (#2262)
 ;  Input:   INPUT - This variable contains the IEN, Site Name, and 
 ;                   District Office Name to be filed in the format:
 ;                   IEN^SITE NAME^DISTRICT OFFICE
 ; Output: RESULTS - Results will contain a filing status message
 N DA,DIE,DR,IEN,SITENM,DISOFF
 S IEN=$P($G(INPUT),U),SITENM=$P($G(INPUT),U,2),DISOFF=$P($G(INPUT),U,3)
 I '$G(IEN) S RESULTS="Cannot File Changes, no Record Number" Q
 S DIE="^OOPS(2262,",DA=IEN
 S DR=".01///^S X=SITENM;2///^S X=DISOFF"
 D ^DIE
 I $G(Y)="" S RESULTS="Update Site data Successful" Q
 S RESULTS="Update Site data was NOT Successful"
 Q
CHGCASE(RESULTS,INPUT,FLD58) ;  File Change Case Status
 ;  Input:    INPUT  - IEN^STAT where IEN = the ASISTS case IEN and
 ;                     STAT = the new case status
 ;          DELETE   - Reason for Deletion, field #58, file #2260
 ; Output: RESULTS   - Message back to client with new Case Status
 ;
 N CURRENT,DR,DIE,IEN,Y,STATUS
 S IEN=$P(INPUT,U),(STATUS,Y)=$P(INPUT,U,2)
 I '$G(IEN) S RESULTS="Missing Record Identifier, cannot file." Q
 I $$GET1^DIQ(2260,IEN,66)'="",(Y=2) D  Q
 .S RESULTS="Case transmitted to DOL, cannot change status to Deleted."
 S CURRENT=$$GET1^DIQ(2260,IEN,51,"I")
CLOSE ; Close
 S DR=""
 S DR="51////"_Y
 ;If current status goes from closed/deleted to Open, reset field 57
 I (CURRENT=1!(CURRENT=2)),(Y=0) S DR=DR_";57////@"
 I FLD58]"" S DR=DR_";58////"_FLD58
 S DIE="^OOPS(2260,",DA=IEN
 D ^DIE K DIE,DA
 I $D(Y)'=0 Q
 S RESULTS="Case Status has been changed to: "_$$GET1^DIQ(2260,IEN,51)
 ;01/02/04 Patch 4 llh- if case = closed, send bulletin
 I STATUS=1 D CLSCASE^OOPSMBUL(IEN)
 Q
