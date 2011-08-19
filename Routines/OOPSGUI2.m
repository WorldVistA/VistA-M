OOPSGUI2 ;WIOFO/CVW-RPC routines ;9/19/01
 ;;2.0;ASISTS;**2,4,8**;Jun 03, 2002
 ;
GET(RESULTS,INPUT) ; Get Case data from 2260 or 2264
 ;NOTE:  changed in patch 5 to set the file to retrieve data from
 ;       based on the form sent in.
 ;  Input:    INPUT - IEN^FORM where IEN = ASISTS IEN and 
 ;                    FORM = Either "CA1","CA2","CA7","2162", or "DUAL"
 ; Output:  RESULTS - Array of data from the file, each element in the
 ;                    is based on the field number in the file.
 N NODE,PIECE,FNUM,IEN,VAR,FORM,FLDCNT,INVFLDS,FILE
 ;Define fields that should never be returned
 S INVFLDS="^19^20^21^22^23^24^25^122^224^"
 S IEN=+$G(INPUT),FORM=$P($G(INPUT),U,2),FLDCNT=0
 I '$G(IEN) Q
 S FILE=2260 I $G(FORM)="CA7" S FILE=2264,INVFLDS=""
 I '$D(^OOPS(FILE,$G(IEN),0)) D  Q
 . S (RESULTS,RESULTS(1))="-1^IEN:"_IEN_" not found in the file"
 I "CA1^CA2^CA7^2162^DUAL"'[FORM!(FORM="") D  Q
 . S (RESULTS,RESULTS(1))="-2^FORM:"_FORM_" not valid, must be CA1, CA2, CA7, DUAL or 2162"
 S NODE="" F  S NODE=$O(^DD(FILE,"GL",NODE)) Q:NODE=""  D
 .S PIECE=0 F  S PIECE=$O(^DD(FILE,"GL",NODE,PIECE)) Q:PIECE=""  D
 ..S FNUM=0 F  S FNUM=$O(^DD(FILE,"GL",NODE,PIECE,FNUM)) Q:FNUM=""  D
 ...I INVFLDS[("^"_FNUM_"^") Q
 ...I ($E(NODE,1,$L(FORM))'=FORM),(NODE'=0),(NODE'="CA"),(NODE'["WC"),(NODE'["DUAL") Q
 ...;patch 5 if form = DUAL, only get DUAL nodes (there are 2) data
 ...I FORM["DUAL",($E(NODE,1,4)="DUAL") D
 ....S RESULTS(FNUM)=$$GET1^DIQ(FILE,IEN,FNUM)
 ...I FORM'="DUAL",($E(NODE,1,4)'="DUAL") D
 ....S RESULTS(FNUM)=$$GET1^DIQ(FILE,IEN,FNUM)
 ....I FILE=2260 D
 .....I FNUM=13 S RESULTS(FNUM)=RESULTS(FNUM)_" = "_$$GET1^DIQ(2260,IEN,FNUM_":99")
 .....I FNUM=53!(FNUM=53.1) S RESULTS(FNUM)=RESULTS(FNUM)_"^"_$$GET1^DIQ(2260,IEN,FNUM,"I")
 .....I FNUM=76!(FNUM=79) S RESULTS(FNUM)=$$GET1^DIQ(2260,IEN,FNUM,"I")
 ...S FLDCNT=FLDCNT+1
 Q
WITR(RESULTS,IEN)     ;Return entries from the witness multiple
 ;  Input:     IEN - The ASISTS IEN used to pull info from file 2260.
 ; Output: RESULTS - array with Witness data and associated comment
 ;
 N SUBN,COUNT,STATE,WDT
 S (SUBN,COUNT)=0,(STATE,WDT)=""
 F  S SUBN=$O(^OOPS(2260,IEN,"CA1W",SUBN)) Q:'SUBN  D
 . S RESULTS(COUNT)=$G(^OOPS(2260,IEN,"CA1W",SUBN,0))
 . S STATE=$$EXTERNAL^DILFD(2260.0125,3,"",$P(RESULTS(COUNT),U,4))
 . S WDT=$$EXTERNAL^DILFD(2260.0125,5,"",$P(RESULTS(COUNT),U,6))
 . S $P(RESULTS(COUNT),U,4)=STATE,$P(RESULTS(COUNT),U,6)=WDT
 . S $P(RESULTS(COUNT),U,7)=SUBN
 . S COUNT=COUNT+1
 . S RESULTS(COUNT)=$G(^OOPS(2260,IEN,"CA1W",SUBN,1))
 . S COUNT=COUNT+1
 Q
DEFMD(RESULTS,IEN)      ;
 ;Send in the Case IEN, return an array of 
 ;(0)="1^Valid Results" or "0^No Valid Results"
 ;(1)=PROVIDER NAME
 ;(2)=PROVIDER ADDRESS
 ;(3)=PROVIDER CITY
 ;(4)=PROVIDER STATE
 ;(5)=PROVIDER ZIP CODE
 ;(6)=PROVIDER TITLE
 N STA,PSTA,PIEN
 S (STA,PSTA,PIEN)=""
 S RESULTS(0)="0^No Valid Results"
 Q:+IEN'>0
 S STA=$P($G(^OOPS(2260,IEN,"2162A")),U,9)
 Q:+STA'>0
 S PIEN=$O(^OOPS(2262,1,1,"B",STA,PIEN))
 Q:+PIEN'>0
 I $P($G(^OOPS(2262,1,1,PIEN,0)),U,2)'="" D
 .S RESULTS(0)="1^Valid Results"
 .S RESULTS(1)=$P($G(^OOPS(2262,1,1,PIEN,0)),U,2)
 .S RESULTS(2)=$P($G(^OOPS(2262,1,1,PIEN,0)),U,3)
 .S RESULTS(3)=$P($G(^OOPS(2262,1,1,PIEN,0)),U,4)
 .S PSTA=$$FIND1^DIC(2262.03,",1,","Q",STA)
 .I PSTA S PSTA=PSTA_",1," S RESULTS(4)=$$GET1^DIQ(2262.03,PSTA,"4:.01")
 .S RESULTS(5)=$P($G(^OOPS(2262,1,1,PIEN,0)),U,6)
 .S RESULTS(6)=$P($G(^OOPS(2262,1,1,PIEN,0)),U,7)
 .S RESULTS(6)=$$EXTERNAL^DILFD(2262.03,6,"",RESULTS(6))
 Q
REPLWP(RESULTS,INPUT,DATA) ;
 ;Replace Word Processing Fields
 ;  Input:   INPUT - The file, field and IEN of record to WP field to
 ;                   be changed in the format FILE^FIELD^IEN
 ;  Input     DATA - List or pointer for data that is to replace the
 ;                   existing WP data. 
 ; Output: RESULTS - array with results or messages.
 ; Retrieve file and field information.
 N FILE,FIELD,IEN,ROOT,NODE,LINE,CNT,NEWTXT
 S FILE=$P($G(INPUT),U),FIELD=$P($G(INPUT),U,2),IEN=$P($G(INPUT),U,3)
 S ROOT=$$ROOT^DILFD(FILE,0,"GL")
 S NODE=$$GET1^DID(FILE,FIELD,"","GLOBAL SUBSCRIPT LOCATION")
 S NODE=$P(NODE,";",1)
 ; Kill the existing WP data/node
 K @(ROOT_"IEN,NODE)")
 ; Insert the new data
 S (LINE,CNT)=0
 K NEWTXT
 F  D  Q:+LINE'>0
 .S LINE=$O(DATA(LINE)) Q:+LINE'>0  S CNT=LINE
 .S NEWTXT=$G(DATA(LINE))
 .S @(ROOT_"IEN,NODE,LINE,0)")=NEWTXT
 S @(ROOT_"IEN,NODE,0)")="^^"_CNT_"^"_CNT_"^"_DT_"^^"
 Q
DTVALID(RESULTS,IDT,PDT,FLAG) ;Compare Date(s)/Time(s)
 ;  Input IDT - This is the base date/time in external form
 ;        PDT - This is the compare date/time in external form
 ;       FLAG - -2 means PDT must be <  IDT (The DAY only)
 ;       FLAG - -1 means PDT must be <  IDT (The DAY&TIME)
 ;       FLAG -  1 means PDT must be >  IDT (The DAY&TIME)
 ;       FLAG -  2 means PDT must be > IDT (The DAY only)
 ;Output RESULTS - "VALID DATE" for valid, "DATE ERROR" for invalid
 S FLAG=+$G(FLAG)
 I FLAG="" S RESULTS(0)="FLAG ERROR" Q
 I IDT="" S RESULTS(0)="DATE ERROR" Q
 I PDT="" S RESULTS(0)="DATE ERROR" Q
 S IDT=$$DTI^OOPSGUI2(IDT)
 S PDT=$$DTI^OOPSGUI2(PDT)
 I FLAG=-2 D
 .S IDT=$P(IDT,"."),PDT=$P(PDT,".")
 .I (PDT<IDT)!(PDT=IDT) S RESULTS(0)="VALID DATE" Q
 .I PDT>IDT S RESULTS(0)="DATE ERROR" Q
 I FLAG=-1 D
 .I PDT<IDT S RESULTS(0)="VALID DATE" Q
 .I (PDT>IDT)!(PDT=IDT) S RESULTS(0)="DATE ERROR" Q
 I FLAG=0 D
 .I PDT=IDT S RESULTS(0)="VALID DATE" Q
 .I (PDT<IDT)!(PDT>IDT) S RESULTS(0)="DATE ERROR" Q
 I FLAG=1 D
 .I PDT>IDT S RESULTS(0)="VALID DATE" Q
 .I (PDT<IDT)!(PDT=IDT) S RESULTS(0)="DATE ERROR" Q
 I FLAG=2 D
 .S IDT=$P(IDT,"."),PDT=$P(PDT,".")
 .I (PDT>IDT)!(PDT=IDT) S RESULTS(0)="VALID DATE" Q
 .I PDT<IDT S RESULTS(0)="DATE ERROR" Q
 Q
DTI(X) ;Convert and External date to an internal one
 N Y,%DT
 S %DT="T" D ^%DT
 Q Y
SETFIELD(RESULTS,INPUT,VALUE) ;Set a single field in file 2260
 ;Input  - INPUT Contains the IEN of the record and the field number to
 ;               be modified in the format IEN^FIELD
 ;         VALUE This required parm is the external value to be used.
 ;Output - RESULTS - status message of the file/set. 
 N DA,DIE,DR,IEN,FLDNUM
 S DR=""
 S RESULTS(0)="UPDATE FAILED"
 S IEN=$P($G(INPUT),U)
 I '$G(IEN) Q
 S FLDNUM=$P($G(INPUT),U,2)
 I '$D(^OOPS(2260,IEN,0))!(FLDNUM="") Q
 S DIE="^OOPS(2260,",DA=IEN
 S DR(1,2260,1)=FLDNUM_"///^S X=VALUE"
 D ^DIE
 I $G(Y)="" D
 . S RESULTS(0)="UPDATE COMPLETE"
 . ; if setting field 71, need to send bulletin
 . I FLDNUM=71,($$GET1^DIQ(2260,IEN,71,"I")'="Y") D WCPBOR^OOPSMBUL(IEN)
 . ; 01/02/04 Patch 4 llh - if case closed, sent bulletin
 . I FLDNUM=51,(VALUE="Closed") D CLSCASE^OOPSMBUL(IEN)
 Q 
ADDWITN(RESULTS,IEN,INFO,COMMENT) ;Add Witness info for IEN in 2260
 ;  Input - IEN - IEN of case that needs witness info created. 
 ;         INFO - Name, Street, City, State, Zip, Date of Witness in
 ;                format, NAME^STREET^CITY^STATE^ZIP
 ;      COMMENT - Witness Comment Text
 ; Output - RESULTS Text indicating status of insert
 N DR,DIE,DA,DIC,DD,DO,DLAYGO,INPUT,NAME,STREET,CITY,STATE,ZIP,WITDATE
 S RESULTS(0)="WITNESS CREATION FAILED"
 I '$G(IEN) Q
 I '$D(^OOPS(2260,IEN,0)) Q
 S DA(1)=IEN
 S DLAYGO=2260,DIC="^OOPS(2260,"_DA(1)_",""CA1W"","
 S DIC(0)="L"
 S X=$P(INFO,U)
 D FILE^DICN
 S DA=+Y
 S DIE="^OOPS(2260,"_DA(1)_",""CA1W"",",DR=""
 I DA=-1 Q
 S NAME=$P($G(INFO),U)
 S STREET=$P($G(INFO),U,2)
 S CITY=$P($G(INFO),U,3)
 S STATE=$P($G(INFO),U,4)
 S ZIP=$P($G(INFO),U,5)
 S WITDATE=$P($G(INFO),U,6)
 S DR(1,2260.0125,1)=".01///^S X=NAME"
 S DR(1,2260.0125,2)="1///^S X=STREET"
 S DR(1,2260.0125,3)="2///^S X=CITY"
 S DR(1,2260.0125,4)="3///^S X=STATE"
 S DR(1,2260.0125,5)="4///^S X=ZIP"
 S DR(1,2260.0125,6)="5///^S X=WITDATE"
 D ^DIE
 S DR="6///^S X=COMMENT"
 D ^DIE
 S RESULTS(0)="WITNESS CREATION SUCCESSFUL"
 Q
DELWITN(RESULTS,INPUT) ;Deletes the Witness information for a claim
 ;  Input - INPUT, this is the IEN for the case and the witness number 
 ;          format IEN^witness number for the selected witness
 ; Output - RESULTS - String indicating the status of the delete
 N DA,DIK,IEN,WITNO
 S RESULTS(0)="DELETION FAILED"
 I INPUT="" Q
 S IEN=$P($G(INPUT),U)
 I '$G(IEN) Q
 S WITNO=$P($G(INPUT),U,2)
 I '$G(WITNO) Q
 I '$D(^OOPS(2260,IEN,"CA1W",WITNO,0)) Q
 S DA(1)=IEN
 S DA=WITNO
 S DIK="^OOPS(2260,"_DA(1)_",""CA1W"","
 D ^DIK
 I $G(Y)'="" D  Q 
 .S RESULTS(0)="SUCCESSFULLY DELETED"
 Q
EDTWITN(RESULTS,INPUT,INFO,COMMENT) ;Update Witness Info for 2260 rec
 ;  Input:INPUT - IEN and Witness Number in format IEN^WIT
 ;        INFO  - Name, Street, City, State, Zip, Date of Witness in 
 ;                format, NAME^STREET^CITY^STATE^ZIP
 ;        COMMENT - Text of Witness comment
 ; Output:RESULTS - String listing result of update. 
 N DA,DIE,DR,NAME,STREET,CITY,STATE,ZIP,WITDATE,IEN,WITNO
 S RESULTS(0)="EDIT FAILED"
 S IEN=$P($G(INPUT),U)
 S WITNO=$P($G(INPUT),U,2)
 I '$D(^OOPS(2260,IEN,"CA1W",WITNO,0)) Q
 S DA(1)=IEN,DR=""
 S DA=WITNO
 S DIE="^OOPS(2260,"_DA(1)_",""CA1W"","
 S NAME=$P($G(INFO),U)
 S STREET=$P($G(INFO),U,2)
 S CITY=$P($G(INFO),U,3)
 S STATE=$P($G(INFO),U,4)
 S ZIP=$P($G(INFO),U,5)
 S WITDATE=$P($G(INFO),U,6)
 S DR(1,2260.0125,1)=".01///^S X=NAME"
 S DR(1,2260.0125,2)="1///^S X=STREET"
 S DR(1,2260.0125,3)="2///^S X=CITY"
 S DR(1,2260.0125,4)="3///^S X=STATE"
 S DR(1,2260.0125,5)="4///^S X=ZIP"
 S DR(1,2260.0125,6)="5///^S X=WITDATE"
 D ^DIE
 S DR="6///^S X=COMMENT"
 D ^DIE
 S RESULTS(0)="EDIT SUCCESSFULL"
 Q
