OOPSGUIC ;WIOFO/LLH-RPC routine for GET/SET CA7 ;04/22/04
 ;;2.0;ASISTS;**8,7**;Jun 03, 2002
 ;
CA7LIST(RESULTS,PERSON,CALL) ; builds CA-7 selection list from existing
 ;                         cases - not an add
 ;
 ;   Input:  PERSON  - person's SSN whether CALL="E" or "W"
 ;              CALL - contains the calling menu and file number in the
 ;                     format FILENUM^CALL.
 ;  Output:  RESULTS - returns an array containing
 ;                     CA7 case #^IEN^DATE OF INCIDENT
 K ^TMP("CA7LIST",DUZ)
 N ARR,CA7,CAIEN,CALLER,ESSN,FILE
 S FILE=$P($G(CALL),U),CALLER=$P($G(CALL),U,2)
 I $G(PERSON)=""!($G(CALL)="")!($G(FILE)="") D  Q
 . S ^TMP("CA7LIST",DUZ,1)="Not enough info - can't process request"
 S CAIEN=0,^TMP("CA7LIST",DUZ,1)="No CA-7's Selectable"
 S ESSN=$$GET1^DIQ(200,DUZ,9)
 I CALLER="E",ESSN'=PERSON D  Q
 .S ^TMP("CA7LIST",DUZ,1)="User SSN, file SSN do not match-form aborted"
 F  S CAIEN=$O(^OOPS(FILE,"SSN",PERSON,CAIEN)) Q:CAIEN=""  D
 .;if from emp menu & signed by both, don't give access
 .I CALLER="E",$P($G(^OOPS(FILE,CAIEN,"CA7S7")),U,2)'="",($P($G(^OOPS(FILE,CAIEN,"CA7S15")),U,2)'="") Q
 .I CALLER="W",(ESSN=PERSON) Q
 .S CA7=$$GET1^DIQ(FILE,CAIEN,.01),ARR(CA7)=CAIEN
 ; drop thru here and
SORT ; reverse the order
 N CN,CA7,CAIEN,DOI,NM,SSN
 S ^TMP("CA7LIST",DUZ,0)="",CN=1,CA7=""
 I '$D(ARR) S ^TMP("CA7LIST",DUZ,1)="No CA7's Selectable"
 F  S CA7=$O(ARR(CA7),-1) Q:CA7=""  D
 .S CAIEN=ARR(CA7)
 .S ASISTS=$$GET1^DIQ(2260,$$GET1^DIQ(FILE,CAIEN,.7,"I"),52,"I")
 .S ASISTS="CA-"_$G(ASISTS)
 .S NM=$E($$GET1^DIQ(FILE,CAIEN,.9),1,27)
 .S DOI=$$GET1^DIQ(FILE,CAIEN,7)
 .S SSN=$$GET1^DIQ(FILE,CAIEN,.8)
 .S ^TMP("CA7LIST",DUZ,CN)=CA7_U_DOI_U_NM_U_ASISTS_U_CAIEN_U_SSN_$C(10)
 .S CN=CN+1
 ; then quit
 S RESULTS=$NA(^TMP("CA7LIST",DUZ))
 Q
LISTCA(RESULTS,INPUT) ; returns a list of valid CA (1 or 2) claims that
 ;                 can be selected to create a new CA-7
 ;  Input:   INPUT - 3 pieces to input parameter
 ;                   SSN^FILE^CALLER - CALLER contains either E
 ;                   or W (menu called from).
 ;                   FILE now only contains 2260 (for CA-1 or 2)
 ; Output: RESULTS - contains a array of ASISTS Claims with the
 ;                   claim number, name, and date of injury.  Other
 ;                   default fields returned are, grade, step, pay amt,
 ;                   pay period, FEGLI Code, and Health Ins.
 ;
 K ^TMP("LISTCA",DUZ)
 N ARR,CAIEN,CALLER,CAIEN,CN,CNUM,DOI,FILE,INJ,NM,PAR,PDFLD,SSN
 S PAR=$P($G(INPUT),U),FILE=$P($G(INPUT),U,2),CALLER=$P($G(INPUT),U,3)
 I $G(PAR)=""!($G(FILE)="")!($G(CALLER)="") D  Q
 .S ^TMP("LISTCA",DUZ,0)="Missing parameters - cannot continue"
 S CAIEN=0
 F  S CAIEN=$O(^OOPS(FILE,"SSN",PAR,CAIEN)) Q:CAIEN=""  D
 .I '$$INCLUDE() Q
 .I CALLER="E",($$GET1^DIQ(200,DUZ,9)'=PAR) Q
 .I CALLER="W",($$GET1^DIQ(200,DUZ,9)=PAR) Q
 .S CNUM=$$GET1^DIQ(FILE,CAIEN,.01),ARR(CNUM)=CAIEN
 ; No cases to send back
 I '$D(ARR) D  Q
 .S ^TMP("LISTCA",DUZ,1)="No Cases Selectable"
 .S RESULTS=$NA(^TMP("LISTCA",DUZ))
 ; get reverse order
 S CNUM="",CN=1
 F  S CNUM=$O(ARR(CNUM),-1) Q:CNUM=""  D
 .S CAIEN=ARR(CNUM)
 .S NM=$$GET1^DIQ(FILE,CAIEN,1)
 .S DOI=$$GET1^DIQ(FILE,CAIEN,4)
 .S SSN=$TR($$GET1^DIQ(FILE,CAIEN,5),"-","")
 .S GRD=$$GET1^DIQ(FILE,CAIEN,16)
 .S STP=$$GET1^DIQ(FILE,CAIEN,17)
 .S INJ=$$GET1^DIQ(FILE,CAIEN,52)
 .S RET=$$GET1^DIQ(FILE,CAIEN,60)
 .S PAY=$$GET1^DIQ(FILE,CAIEN,166)
 .S PER=$$GET1^DIQ(FILE,CAIEN,167)
 .; only need to do this 1 time, should never have but 1 different
 .; person in this list, many claims but all for the same person
 .I CN=1 S PDFLD=$$PDDEF()
 .S STR=CNUM_U_DOI_U_NM_U_CAIEN_U_SSN_U_INJ_U_GRD_U_STP_U_PAY_U_PER
 .S ^TMP("LISTCA",DUZ,CN)=STR_U_RET_U_PDFLD_U_DUZ_$C(10)
 .S CN=CN+1
 S RESULTS=$NA(^TMP("LISTCA",DUZ))
 Q
INCLUDE() ; checks to make sure ok to include claim in list
 N CA7OK
 S CA7OK=1
 ; if claim not sent to DOL, can't pick
 I $$GET1^DIQ(FILE,CAIEN,67)="" S CA7OK=0
 ; if deleted, replaced by amendment - can't pick
 I $$GET1^DIQ(FILE,CAIEN,51,"I")>1 S CA7OK=0
 Q (CA7OK)
PDDEF() ; get Fegli Code and Health insurance fields from paid
 N CNT,FEG,FEG1,INS,INS1,PAID
 S (FEG,FEG1,INS,INS1)=""
 D FIND^DIC(450,,"@;226EI;231I","MPSC",SSN,10,"SSN")
 I $G(DIERR) D CLEAN^DILF Q FEG_U_INS
 I $P(^TMP("DILIST",$J,0),U)=0 Q FEG_U_INS
 S PAID=$G(^TMP("DILIST",$J,1,0)),FEG=$P(PAID,U,3)
 ; if A0 - ineligible, B0 - waived therefore No 
 I FEG="A0"!(FEG="B0") S FEG1="N;"
 ; if C0 - only Basic
 I FEG="C0" S FEG1="Y;"
 ; has Fegli, but not basic, additional, get additional code
 I $G(FEG1)="",($L($P(PAID,U,2),"Basic +")>1) S FEG1="Y;"_FEG
 ; now deal with insurance
 S INS=$P(PAID,U,4)
 ; if INS = 000, 001, 002, 003 they don't have insurance
 I (INS?.N)&(+INS<4) S INS1="N;"
 ; otherwise they do, get the code
 I $G(INS1)="" S INS1="Y;"_INS
 Q INS1_U_FEG1
MULTIPLE(RESULTS,INPUT,DATA) ; retrieve data from multiple
 ; NOTE:  When filing into subrecord, the entire subrecord is deleted
 ;        then rebuilt.  Also, the field number for the subrecord
 ;        must be passed with the data.
 ;        WORD PROCESSING fields CANNOT file using this code
 ;   Input:   INPUT - in the format FILE^FIELD^IEN
 ;             DATA - array of data in the format
 ;                    DATA(SIEN)=data where data = P1^P2^P3 etc, where
 ;                    P1 = subfield #;data
 ;                    DATA="" must be true for a GET.
 ;  Output: RESULTS - data from all records in the multiple will
 ;                     be returned.  it will be saved in a pieced
 ;                     string.
 N ACTION,ARR,IEN,FIELD,FILE,ROOT,SAVEDIK,SPEC,SUB
 S FILE=$P($G(INPUT),U),FIELD=$P($G(INPUT),U,2),IEN=$P($G(INPUT),U,3)
 S ACTION="" I $D(DATA)>1 S ACTION=1
 S RESULTS(0)="Record Accessed, no data"
 I $G(IEN)=""!($G(FILE)="")!($G(FIELD)="") D  Q
 . S RESULTS(0)="Invalid parameters cannot continue"
 S ROOT=$$ROOT^DILFD(FILE,0,"GL")
 S SPEC=+$$GET1^DID(FILE,FIELD,"","SPECIFIER")
 S SUB=$$GET1^DID(FILE,FIELD,"","GLOBAL SUBSCRIPT LOCATION")
 I '$$GET1^DID(FILE,FIELD,"","MULTIPLE-VALUED"),'$G(SPEC) D  Q
 . S RESULTS(1)="Field in not a multiple, cannot continue"
 ; now go get data from subfile
 S SAVEDIK=ROOT_IEN_","_$C(34)_$P(SUB,";")_$C(34)_","
 I 'ACTION D GETD
 I ACTION D KILLD,SETD
 Q
GETD ; get the data
 N CNT,DATA,FLDA,FLDS,IENS,SIEN,SFLD,SREC,TYPE
 S CNT=0,IENS=IEN_","
 S FLDA=FIELD_"*"
 ; hate to hardwire, but need data back as entered, not canonical
 I FILE=2262.03,FIELD=15 D FLD15 Q
 D GETS^DIQ(FILE,IENS,FLDA,,"ARR")
 I $D(ARR) S SIEN="",RESULTS(0)="" D
 .F  S SIEN=$O(ARR(SPEC,SIEN)) Q:SIEN=""  D
 ..S SFLD="",SREC=$P(SIEN,",")
 ..F  S SFLD=$O(ARR(SPEC,SIEN,SFLD)) Q:SFLD=""  D
 ...S DATA=ARR(SPEC,SIEN,SFLD)_U
 ...S:$D(RESULTS(CNT))=0 RESULTS(CNT)=""
 ...S RESULTS(CNT)=RESULTS(CNT)_DATA
 ..S CNT=CNT+1
 Q
KILLD ; first kill all records in subfile, then rebuild
 N DA,DIK,NODE
 S NODE=$P(SUB,";"),DA=0,DA(1)=IEN,DIK=SAVEDIK
 F  S DA=$O(@(ROOT_"DA(1),NODE,DA)")) Q:(+DA'>0)  D ^DIK
 Q
SETD ; subrecord cleaned out, now rebuild
 N BAD,CN,DR,DIE,DA,DLAYGO,I,NUM,STR,DIC,TYPE
 K DR
 S RESULTS(0)="Filing successful"
 S CN=0,DLAYGO=FILE,DA(1)=IEN,DIC=SAVEDIK,DIC(0)="L"
 F  S CN=$O(DATA(CN)) Q:CN'>0  S X="",BAD=0 D
 .S STR=DATA(CN),NUM=$L(DATA(CN),U),DIC("DR")=""
 .F I=1:1:NUM S STR1=$P($G(STR),U,I) D:('BAD)
 ..I $P(STR1,";")=.01,$P(STR1,";")="",$P(STR1,";",2)="" S BAD=1 Q
 ..I $P(STR1,";")=.01 D
 ...S TYPE=$$GET1^DID(SPEC,.01,"","TYPE")
 ...I TYPE="DATE/TIME" S X=$$FMTE^XLFDT($P(STR1,";",2),2)
 ...E  S X=$P(STR1,";",2)
 ..S DIC("DR")=DIC("DR")_$P(STR1,";")_"///"_$P(STR1,";",2)_";"
 .D MFILE
 Q
MFILE ; file the multiple
 N PCE,PCE1,TMP
 I X="" S RESULTS(0)=".01 field missing - could not file" Q
 I $G(BAD) S RESULTS(0)="Problems Filing subrecord" Q
 I $L(DIC("DR"))>240 D
 .S PCE=$L(DIC("DR"),";"),TMP=DIC("DR"),PCE1=$P(PCE/2,".")
 .S DIC("DR")=$P(TMP,";",1,PCE1)
 .K DD,DO D FILE^DICN I Y'>0 S BAD=1
 .S DIC("DR")=$P(TMP,";",(PCE1+1),PCE)
 K DD,DO D FILE^DICN I Y'>0 S BAD=1
 I BAD S RESULTS(0)="Problems filing subrecord"
 Q
OSHA300(RESULTS,STA,DATA) ; Files data into subrecord 2262.315
 ;  Input - STA is the station number subrecord IEN
 ;         DATA is an number subscripted array containing the records
 ;              that contain the Emp Numbers and hours worked in the
 ;              OSHA MONTH/YEAR subrecord.
 ; Output - RESULTS indicating the success of the filing.
 ;
 N CNT,IENS,FILE,OSHAFDA,LV1,LV2,PAR,REC,STR
 S CNT=1,FILE=2262.315
 S PAR="^OOPS(2262,0)",PAR=$Q(@PAR),PAR=$Q(@PAR)
 S LV1=$P(PAR,",",2),LV2=$P(PAR,",",3)
 S RESULTS=""
 I $D(DATA)<10 S RESULTS="NO DATA TO FILE, CANNOT CONTINUE" Q
 I '$G(STA) S RESULTS="NOT ENOUGH PARAMETERS, COULDN'T FILE" Q
 I '$D(^OOPS(2262,LV1,LV2,STA)) D  Q
 .S RESULTS="NO STATION RECORD, COULDN'T FILE"
 K ^OOPS(2262,LV1,LV2,STA,2)
 S REC=0 F  S REC=$O(DATA(REC)) Q:REC=""  D
 .S IENS="?+"_CNT_","_STA_","_LV1_","
 .S STR=DATA(REC)
 .S OSHAFDA(FILE,IENS,.01)=$P($P(STR,U,1),";",2)
 .S OSHAFDA(FILE,IENS,1)=$P($P(STR,U,2),";",2)
 .S OSHAFDA(FILE,IENS,2)=$P($P(STR,U,3),";",2)
 .S CNT=CNT+1
 D UPDATE^DIE("E","OSHAFDA","IENS","MSG")
 I '$D(MSG) S RESULTS="Filing Successful"
 K MSG,STR,Y,X,%DT
 Q
FLD15 ; retrieves OSHA 300A Summary data from file 2262
 N CNT,DATE,LV1,LV2,PAR,REC
 S CNT=0,PAR="^OOPS(2262,0)",PAR=$Q(@PAR),PAR=$Q(@PAR)
 S LV1=$P(PAR,",",2),LV2=$P(PAR,",",3),IENS=$P(IEN,",",1),REC=0
 F  S REC=$O(^OOPS(2262,LV1,LV2,IENS,2,REC)) Q:REC'>0  D
 .S STR=$G(^OOPS(2262,LV1,LV2,IENS,2,REC,0))
 .S Y=$P(STR,U,1) D DD^%DT
 .S RESULTS(CNT)=Y_U_$P(STR,U,2,3)
 .S CNT=CNT+1
 Q
