IBTRH5C ;ALB/FA - HCSR Create 278 Request ;12-AUG-2014
 ;;2.0;INTEGRATED BILLING;**517**;21-MAR-94;Build 240
 ;;Per VA Directive 6402, this routine should not be modified.
 ;;
 ; Contains Entry points and functions used in creating a 278 request from a
 ; selected entry in the HCSR Response worklist
 ;
 ; --------------------------   Entry Points   --------------------------------
 ; AMBTI        - Called from within the input template to see if any of the 
 ;                Ambulance Transport Information fields have a value
 ;                Fields: 18.01, 18.02, 18.03, 18.04, 18.05, 18.06, 18.09, 18.1 
 ; ATTPHY       - Returns the Attending Physician of the entry
 ; CERTCD       - Dictionary Screen function for Certification Type Code (2.02)
 ; CONTPH       - Input Validation method for fields 20, 21, 22
 ; CRTENTRY     - Creates a new worklist entry from a specified worklist entry.
 ;                Copies all the request data from the specified entry into the
 ;                new entry
 ; OXYET        - Called from within the input template to determine if one of
 ;                Oxygen Equipment Type fields = 'D' or 'E'. Fields 8.01, 8.02
 ;                8.03
 ; REQCAT       - Dictionary Screen function for Request Category Field 2.01
 ;                and field 356.2216/.15
 ; SLDXDUP      - Dictionary Screen function for Service Line Diagnosis fields
 ;                Checks to insure the diagnosis is NOT a duplicate entry AND 
 ;                points to a valid diagnosis multiple.
 ;                Fields: 2216,2.01, 2216,2.02, 2216,2.03, 2216,2.04 
 ; TOOTHSP      - Called from within the Input Template to check if subsequent
 ;                Tooth Surfaces have values
 ;-----------------------------------------------------------------------------
 ;
CONTPH(FIELD)   ;EP
 ; Input validation method for Requester Contact Numbers 1,2 and 3 (fields 20,
 ; 21 and 22)
 ; Input:   FIELD   - Requester Contact Number field being validated
 ;          DA      - IEN of the 356.22 entry being edited
 ;          X       - Internal Value of the user response
 ; Output:  None
 ; Returns: 1 - Answer is valid, 0 - Otherwise
 N RETURN,TYPE,XX
 S XX=$S(FIELD=20:19.01,FIELD=21:19.02,FIELD=22:19.03,1:0)
 Q:XX=0 0                                       ; Invalid FIELD
 S RETURN=1                                     ; Assume valid
 S TYPE=$$GET1^DIQ(356.22,DA_",",XX,"I")        ; Requester Contact Qualifier
 S TYPE=$$GET1^DIQ(365.021,TYPE_",",.01)        ; Requester Contact Qualifier Code
 ;
 I (TYPE="ED")!(TYPE="EM")!(TYPE="UR")!(TYPE="EX") D  Q RETURN
 . S RETURN=$S($L(X)'>250:1,1:0)
 S XX=$TR(X,"-","")                             ; Remove dashes
 I XX'?10N S RETURN=0
 Q RETURN
 ;
CRTENTRY(IBTRIEN,RIEN,IEN312,REQBY,DELCCDE,DELAY,NOOUTPUT,TTYPE)   ;EP
 ; Creates a new entry in 356.22 by copying fields from an existing entry. Used
 ; to create a request from a Response by copying the request entry pointed to
 ; from the response entry
 ; Input:   IBTRIEN - IEN of the entry to be copied
 ;          RIEN    - IEN of the response entry
 ;          IEN312  - IEN of the insurance multiple to set into field .03
 ;                    Optional, if not passed, this field is copied from the
 ;                    existing entry
 ;          REQBY   - DUZ of the Requested By user to set into field .11
 ;                    Optional, if not passed, this field is copied from the
 ;                    existing entry
 ;          DELCCDE - 1 to clear the value for Certification Type (field 2.02)
 ;                    Optional, if not passed, defaults to 0
 ;          DELAY   - 'D' or a future date to set a next review date and status
 ;                    to '08'
 ;                    Optional, if not passed, defaults to ""
 ;          NOOUTPUT - suppress error message output, if not passed, defaults to 0 (false)
 ;          TTYPE   - UM02 value for 278x215 if cancel
 ;
 ; Output:  New entry created in 356.22
 ; Returns: 0 - Copy was NOT successful and error messages were displayed
 ;          Otherwise, IEN of the new entry in 356.22 is returned
 N ERROR,FLDS,IENARRY,IENS,NEWENTRY,NIENS,NIENS16,OLDENTRY,STOPFLG,XX,Z,Z1,XX1
 S:'$D(NOOUTPUT) NOOUTPUT=0
 S:'$D(IEN312) IEN312=""
 S:'$D(REQBY) REQBY=""
 S:'$D(DELCCDE) DELCCDE=0
 S:'$D(DELAY) DELAY=""
 S IENS=IBTRIEN_","
 S FLDS=".02;.03:.07;.11;.16;2.01:2.25;3*;4.01:4.14;5.01:5.18;6.01:6.18"
 S FLDS=FLDS_";7.01:7.13;8.01:8.08;9.01:9.08;10.01:10.13;11*;12;14*;15*;18.01:18.1;19.01:19.03;20:22"
 D GETS^DIQ(356.22,IENS,FLDS,"NI","OLDENTRY","ERROR")
 I $D(ERROR) D COPYERR(0,.ERROR) Q 0            ; Unsuccessful read of initial entry
 ;
 ; Copy internal data from the specified entry to a new array
 M NEWENTRY(356.22,"+1,")=OLDENTRY(356.22,IENS)
 D COPYINT(.NEWENTRY)
 ;
 ; Set the Event Date to 'NOW'
 S NEWENTRY(356.22,"+1,",.01)=$$NOW^XLFDT()
 S:IEN312'="" NEWENTRY(356.22,"+1,",.03)=IEN312  ; Set Insurance Multiple IEN
 S NEWENTRY(356.22,"+1,",.08)=$S(DELAY'="":"08",1:0) ; Initialize status to 0
 S:REQBY'="" NEWENTRY(356.22,"+1,",.11)=REQBY
 I DELCCDE D
 . S NEWENTRY(356.22,"+1,",2.02)=""  ; Clear Certification Type field
 . S NEWENTRY(356.22,"+1,",.18)=1    ; Flag creation from Response
 I $G(TTYPE)="C" S NEWENTRY(356.22,"+1,",2.02)=3
 S:DELAY'="" NEWENTRY(356.22,"+1,",.17)=DELAY   ; Delayed until DELAY
 S XX=$$GET1^DIQ(356.22,RIEN_",",103.02) ; Auth. or Ref. number from response
 S XX1=$$GET1^DIQ(356.22,RIEN_",",103.01) ; CERT ACT CODE
 I $F(",A1,A2,A6,",","_XX1_",") S NEWENTRY(356.22,"+1,",17.01)=XX
 I $F(",A3,A4,C,CT,NA,",","_XX1_",") D
 . I XX="" S XX=$$GET1^DIQ(356.22,RIEN_",",17.02)
 . S NEWENTRY(356.22,"+1,",17.02)=XX
 K IENARRY
 D UPDATE^DIE(,"NEWENTRY","IENARRY","ERROR")    ; File the initial data
 I $D(ERROR) D COPYERR(1,.ERROR) Q 0            ; Unsuccessful copy of initial data
 ; update field .27 of response message
 I DELCCDE D  I $D(ERROR) D COPYERR(1,.ERROR) Q 0
 . N UPDRSP
 . S UPDRSP(356.22,RIEN_",",.27)=1
 . D FILE^DIE("I","UPDRSP","ERROR")
 . Q
 ;
 ; Next copy multiples IENs of the new entry in 356.22 (top level)
 S NIENS=IENARRY(1)_","
 ;
 ; File Diagnosis multiples (356.223)
 I '$$MLTCPY(356.223,NIENS) Q 0
 ;
 ; File Attachment multiples (356.2211)
 I '$$MLTCPY(356.2211,NIENS) Q 0
 ;
 ; File Patient Event Transport multiples (356.2214)
 I '$$MLTCPY(356.2214,NIENS) Q 0
 ;
 ; File Other UMO multiples (356.2215)
 I '$$MLTCPY(356.2215,NIENS) Q 0
 ;
 ; File Provider multiples (356.2213)
 ; NOTE: not all fields are being copied, each entry needs to be handled separately
 S Z=0,STOPFLG=0
 F  D  Q:'Z!STOPFLG
 . S Z=$O(^IBT(356.22,IBTRIEN,13,Z))
 . Q:'Z
 . S IENS=Z_","_IBTRIEN_","
 . K NEWENTRY,OLDENTRY
 . D GETS^DIQ(356.2213,IENS,".01:.03","NI","OLDENTRY","ERROR")
 . I $D(ERROR) D COPYERR(0,.ERROR) S STOPFLG=1 Q
 . M NEWENTRY(356.2213,"+1,"_NIENS)=OLDENTRY(356.2213,IENS)
 . D COPYINT(.NEWENTRY)
 . D UPDATE^DIE(,"NEWENTRY",,"ERROR")
 . I $D(ERROR) D COPYERR(1,.ERROR) S STOPFLG=1
 Q:STOPFLG 0
 ;
 ; File Service Line multiples (356.2216)
 ; NOTE: not all fields are being copied, each entry needs to be handled separately
 S Z=0,STOPFLG=0
 F  D  Q:'Z!STOPFLG
 . S Z=$O(^IBT(356.22,IBTRIEN,16,Z))
 . Q:'Z
 . S IENS=Z_","_IBTRIEN_","
 . K OLDENTRY
 . S FLDS=".01:.14;1.01:1.12;2.01:2.09;3.01:3.07;4*;5.01:5.08;6*;7"
 . D GETS^DIQ(356.2216,IENS,FLDS,"NI","OLDENTRY","ERROR")
 . I $D(ERROR) D COPYERR(0,.ERROR) S STOPFLG=1 Q
 . K NEWENTRY
 . M NEWENTRY(356.2216,"+1,"_NIENS)=OLDENTRY(356.2216,IENS)
 . D COPYINT(.NEWENTRY)
 . K IENARRY
 . D UPDATE^DIE(,"NEWENTRY","IENARRY","ERROR")
 . I $D(ERROR) D COPYERR(1,.ERROR) S STOPFLG=1
 . S NIENS16=IENARRY(1)_","_NIENS               ; IENs of the new Service Line in 356.2216
 . ;
 . ; File Service Line Tooth Information multiples (356.22164)
 . I '$$MLTCPY(356.22164,NIENS16) S STOPFLG=1 Q
 . ;
 . ; File Service Line Attachment multiple (356.22166)
 . I '$$MLTCPY(356.22166,NIENS16) S STOPFLG=1 Q
 . ;
 . ; File Service Line Provider Data multiples (356.22168)
 . ; NOTE - not all fields are being copied, each entry needs to be handled separately
 . S Z1=0
 . F  D  Q:'Z1!STOPFLG
 . . S Z1=$O(^IBT(356.22,IBTRIEN,16,Z,8,Z1))
 . . Q:'Z1
 . . S IENS=Z1_","_Z_","_IBTRIEN_","
 . . K NEWENTRY,OLDENTRY
 . . D GETS^DIQ(356.22168,IENS,".01:.03","NI","OLDENTRY","ERROR")
 . . I $D(ERROR) D COPYERR(0,.ERROR) S STOPFLG=1 Q
 . . M NEWENTRY(356.22168,"+1,"_NIENS16)=OLDENTRY(356.22168,IENS)
 . . D COPYINT(.NEWENTRY)
 . . D UPDATE^DIE(,"NEWENTRY",,"ERROR")
 . . I $D(ERROR) D COPYERR(1,.ERROR) S STOPFLG=1
 I STOPFLG Q 0
 Q $P(NIENS,",",1)
 ;
COPYERR(TYPE,ERROR) ; Displays any errors encountered while copying a request
 ; Input:   TYPE    - 0 - Error while reading data
 ;                  - 1 - Error while filing data
 ;          ERROR   - Array used for FM error reporting
 ; Output:  Error(s) are displayed
 I '$G(NOOUTPUT) Q  ;IF NOT TO DISPLAY OUTPUT, for background job
 N STR,Z,Z1
 Q:'$D(ERROR)
 W !,"Unable to copy - the following error was encountered while "
 W $S(TYPE:"filing",1:"retrieving")," the data:"
 S Z=0
 F  D  Q:'Z
 . S Z=$O(ERROR("DIERR",Z))
 . Q:'Z
 . S STR=$G(ERROR("DIERR",Z))
 . W:STR'="" !,"Error code: "_STR
 . S STR=$G(ERROR("DIERR",Z,"PARAM","FILE"))
 . W:STR'="" !,"File number: "_STR
 . S STR=$G(ERROR("DIERR",Z,"PARAM","FIELD"))
 . W:STR'="" !,"Field number: "_STR
 . W !,"Error text:"
 . S Z1=0
 . F  D  Q:'Z1
 . . S Z1=$O(ERROR("DIERR",1,"TEXT",Z1))
 . . Q:'Z1
 . . W !,ERROR("DIERR",1,"TEXT",Z1)
 Q
 ;
MLTCPY(SFNUM,NEWIENS) ; Copies the specified multiple 
 ; Input:   SFNUM       - Sub-file number of the multiple to copy
 ;          NIENS       - IENs of the new entry (copied to)
 ;          OLDENTRY    - FDA array to get data from (defined in the calling tag)
 ; Returns: 1 on successful copy, 0 on failure
 ;
 N ERROR,NEWENTRY,RES,STOPFLG,Z
 S RES=1,STOPFLG=0
 S Z=0
 F  D  Q:'Z!STOPFLG
 . S Z=$O(OLDENTRY(SFNUM,Z))
 . Q:'Z
 . K NEWENTRY
 . M NEWENTRY(SFNUM,"+1,"_NEWIENS)=OLDENTRY(SFNUM,Z)
 . D COPYINT(.NEWENTRY)
 . D UPDATE^DIE(,"NEWENTRY",,"ERROR")
 . I $D(ERROR) D COPYERR(1) S STOPFLG=1,RES=0
 Q RES
 ;
COPYINT(NEW) ; Copies an array of internal values to a new array
 ; Input:   NEW     - Current Array of internal values
 ;                    Retrieved using D GETS^DIQ(356.22,IENS,FLDS,"NI","OLD","ERROR")
 ;                    e.g. NEW(356.223,"+1,19,",.02,"I")=7209320
 ; Output:  NEW     - Updated array of internal values, stripping off the "I" subscript
 ;                    e.g. NEW(356.223,"+1,19,",.02)=7209320
 N ARRAY,NEW2,YY
 S ARRAY="NEW("""")"
 F  D  Q:ARRAY=""
 . S ARRAY=$Q(@ARRAY)
 . Q:ARRAY=""
 . I ARRAY[",""I"")" D  Q
 . . S YY=$P(ARRAY,",""I"")",1)_")"
 . . S YY="NEW2("_$P(YY,"(",2)
 . . S @YY=@ARRAY
 . S YY="NEW2("_$P(ARRAY,"(",2)
 . S @YY=@ARRAY
 K NEW
 M NEW=NEW2
 Q
 ;
OXYET(IBTRIEN)  ;EP
 ; Called from within the input template
 ; Checks to see if any of the currently filed Oxygen Equipment
 ; Types have a value of 'D' or 'E'
 ; Input:   IBTRIEN - IEN of the Patient Event
 ; Returns: 1 - at least one of the Oxygen Equipment Types is 'D' or 'E'
 ;          0 Otherwise
 N NDE
 S NDE=$G(^IBT(356.22,IBTRIEN,8))
 I ($P(NDE,"^",1)=4)!($P(NDE,"^",1)=5) Q 1
 I ($P(NDE,"^",2)=4)!($P(NDE,"^",2)=5) Q 1
 I ($P(NDE,"^",3)=4)!($P(NDE,"^",3)=5) Q 1
 Q 0
 ;
ATTPHY(IBTRIEN) ;EP
 ; Returns the Attending Physician for the admission of the
 ; specified Inpatient event
 ; Input:   IBTRIEN - IEN of the Inpatient Event
 ; Returns: IEN in file 200 of the Attending Physician or ""
 N ADATE,DA,DFN,DT,EVENT,FOUND,IADATE
 S EVENT=$G(^IBT(356.22,IBTRIEN,0))
 S DFN=$P(EVENT,"^",2)                          ; DFN of the patient
 S ADATE=$P($P(EVENT,"^",7),"-",1)              ; Internal Admit date
 S IADATE=9999999.9999999-ADATE
 S DA=$O(^DGPM("ATID1",DFN,IADATE,""))          ; DBIA419
 Q:DA="" ""                                     ; No Patient Movement admission record
 Q $$GET1^DIQ(405,DA_",",.19,"I")
 ;
REQCAT(FIELD)    ;EP
 ; Dictionary Screen for Request Category (2.01) 
 ; Checks the Request Category (2.01 OR 356.2216/.15) to make sure the answer
 ; is valid for the event type 
 ; Input:   FIELD   - Only passed when called from 356.2216/.15
 ;          DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Output:  None
 ; Returns: 1 - Answer is valid, 0 - Otherwise
 N RETURN,STAT
 I $D(FIELD) D  Q RETURN
 . S RETURN=1
 . I Y'=2,Y'=4 S RETURN=0
 ;
 S STAT=$P($G(^IBT(356.22,DA,0)),"^",4)
 I STAT="I",Y'=1 Q 0
 I STAT="O",Y=1 Q 0
 Q 1
 ;
CERTCD()    ;EP
 ; Dictionary screen for field Certification Type Code 2.02
 ; Checks the code to make sure the answer is valid for the event type 
 ; Input:   DA      - IEN of the 356.22 entry being edited
 ;          Y       - Internal Value of the user response
 ; Output:  None
 ; Returns: 1 - Answer is valid, 0 - Otherwise
 N FREP
 I '$F(",3,5,",","_Y_",") Q 0
 S FREP=$P($G(^IBT(356.22,DA,0)),"^",18)
 I FREP=1,Y=5 Q 0
 Q 1
 ;
AMBTI(IBTRIEN) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST to check if any of the
 ; Ambulance Transport Information fields has a value. Used to potentially
 ; skip to potentially skip the Patient Event Transport Information questions
 ; Input:   IBTRIEN     - IEN of the 356.22 entry being edited
 ; Returns: 1 - At least one field has a value, 0 otherwise
 N NDE
 S NDE=$G(^IBT(356.22,IBTRIEN,18))
 I $P(NDE,"^",1)'="" Q 1
 I $P(NDE,"^",2)'="" Q 1
 I $P(NDE,"^",3)'="" Q 1
 I $P(NDE,"^",4)'="" Q 1
 I $P(NDE,"^",5)'="" Q 1
 I $P(NDE,"^",6)'="" Q 1
 I $P(NDE,"^",9)'="" Q 1
 I $P(NDE,"^",10)'="" Q 1
 Q 0
 ;
SLDXDUP(FIELD)    ;EP
 ; Dictionary Screen Function
 ; Checks to see if the specified Service Line Diagnosis is a duplicate entry
 ; AND points to valid Diagnosis multiple.
 ; Fields: 2216,2.01, 2216,2.02, 2216,2.03, 2216,2.04 
 ; Input:   FIELD   - Field number of the field being checked
 ;          DA(1)   - IEN of the 356.22 entry being edited
 ;          DA      - IEN of the service line multiple
 ;          Y       - Internal Value of the user response
 ; Output:  None
 ; Returns: 1 - Answer is valid, 0 - Otherwise
 N NDE,RETURN
 S RETURN=1                                     ; Assume Valid Input
 Q:Y="" 1                                       ; No value entered
 ;
 ; Not a valid service line multiple
 I '$D(^IBT(356.22,DA(1),3,Y,0)) Q 0
 ;
 ; Check for duplicates
 S NDE=$G(^IBT(356.22,DA(1),16,DA,2))
 I FIELD="2.01" D  Q RETURN
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 I FIELD="2.02" D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 I FIELD="2.03" D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",4)=Y S RETURN=0 Q
 I FIELD="2.04" D  Q RETURN
 . I $P(NDE,"^",1)=Y S RETURN=0 Q
 . I $P(NDE,"^",2)=Y S RETURN=0 Q
 . I $P(NDE,"^",3)=Y S RETURN=0 Q
 Q 1
 ;
TOOTHSP(FIELD) ;EP
 ; Called from Input Template IB CREATE 278 REQUEST for Service Line Tooth
 ; Surface fields. Checks to see if subsequent Tooth Surfaces have values.
 ; Input:   FIELD   - Field # of the field being checked
 ;          DA      - IEN of the Tooth multiple being edited
 ;          DA(1)   - IEN of the Service Line Multiple being edited
 ;          DA(2)   - IEN of the 356.22 entry being edited
 ; Returns: 1 - Subsequent entries have values, 0 otherwise
 N NDE,RETURN
 S NDE=$G(^IBT(356.22,DA(2),16,DA(1),4,DA,0))
 I FIELD=.02 D  Q RETURN
 . I $P(NDE,"^",2)'="" S RETURN=1 Q
 . I $P(NDE,"^",3)'="" S RETURN=1 Q
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=.03 D  Q RETURN
 . I $P(NDE,"^",4)'="" S RETURN=1 Q
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=.04 D  Q RETURN
 . I $P(NDE,"^",5)'="" S RETURN=1 Q
 . I $P(NDE,"^",6)'="" S RETURN=1 Q
 . S RETURN=0
 I FIELD=.05,$P(NDE,"^",6)'="" Q 1
 Q 0
 ;
