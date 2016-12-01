PSOSPMU3 ;BIRM/MFR - State Prescription Monitoring Program Utility #3 - Customization ;10/07/15
 ;;7.0;OUTPATIENT PHARMACY;**451**;DEC 1997;Build 114
 ;
CLONEVER(FROMVER,NEWVER,DEFTYPE) ; Create an exact copy of another ASAP version 
 ;Input: (r) FROMVER - Source ASAP Version to be cloned (3.0, 4.0, 4.1, 4.2)
 ;       (r) NEWVER  - New ASAP Version to be created (4.3, 4.4, 5.0, etc...)
 ;       (r) DEFTYPE - ASAP Definition Type (S: Standard Only; C: Customized Only, B: Both) 
 I $G(FROMVER)=""!($G(NEWVER)="") Q
 N CUSIEN,ASAPVER,ASAPDEF,NWVERIEN,SEGID,SEGIEN,ELMPOS,ELMID,ELMIEN
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0))
 ; New ASAP Version already exists
 I $D(^PS(58.4,CUSIEN,"VER","B",NEWVER)) Q
 D LOADASAP^PSOSPMU0(FROMVER,DEFTYPE,.ASAPDEF)
 S NWVERIEN=$$SAVEVER(NEWVER,.ASAPDEF) I NWVERIEN'>0 Q
 ;
 S SEGID="999"
 F  S SEGID=$O(ASAPDEF(SEGID)) Q:SEGID=""  D
 . S SEGIEN=$$COPYSEG(FROMVER,.ASAPDEF,NEWVER,SEGID) I SEGIEN'>0 Q
 . S ELMPOS=""
 . F  S ELMPOS=$O(ASAPDEF(SEGID,ELMPOS)) Q:ELMPOS=""  D
 . . S ELMID=$P(ASAPDEF(SEGID,ELMPOS),"^")
 . . S ELMIEN=$$COPYELM(FROMVER,.ASAPDEF,NEWVER,ELMID)
 Q
 ;
SAVEVER(ASAPVER,VERDATA) ; Save an ASAP Version
 ;Input: (r) ASAPVER - ASAP Version ("3.0", "4.0", etc.)
 ;       (r) VERDATA - ASAP Version Data
 ;Output: SAVVER - ASAP Version IEN
 I $G(ASAPVER)=""!($G(VERDATA)="") Q "-1^Invalid Input Parameters"
 N SAVEVER,CUSIEN,VERIEN,VERDEF
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0)) I 'CUSIEN Q "-1^Invalid Custom ASAP Data Definition"
 ; If Custom ASAP Version entry does not exist, create it
 S VERIEN=$O(^PS(58.4,CUSIEN,"VER","B",ASAPVER,0)) I 'VERIEN S VERIEN="+1"
 ;
 S VERDEF(58.4001,VERIEN_","_CUSIEN_",",.01)=ASAPVER
 S VERDEF(58.4001,VERIEN_","_CUSIEN_",",.02)=$P(VERDATA,"^",2)
 S VERDEF(58.4001,VERIEN_","_CUSIEN_",",.03)=$P(VERDATA,"^",3)
 S VERDEF(58.4001,VERIEN_","_CUSIEN_",",.04)=$P(VERDATA,"^",4)
 D UPDATE^DIE("","VERDEF","SAVEVER","")
 S:VERIEN="+1" VERIEN=+$G(SAVEVER(1))
 ; Necessary to force the '@' as a delimiter/terminator
 I $P(VERDATA,"^",2)="@",VERIEN S $P(^PS(58.4,CUSIEN,"VER",VERIEN,0),"^",2)="@"
 I $P(VERDATA,"^",3)="@",VERIEN S $P(^PS(58.4,CUSIEN,"VER",VERIEN,0),"^",3)="@"
 Q VERIEN
 ;
COPYSEG(FROMVER,ASAPDEF,TOVER,SEGID) ; Copy a Segment
 ; Input: (r) FROMVER - Source ASAP Version ("3.0", "4.0", etc.)
 ;        (r) ASAPDEF - Array containig the ASAP Definition to be copied
 ;        (r) TOMVER  - Detin ASAP Version ("3.0", "4.0", etc.)
 ;        (r) SEGID   - Segment ID ("PHA", "DSP", etc.)
 ;Output: SAVESEG - New Segment IEN
 I $G(FROMVER)=""!($G(TOVER)="")!($G(SEGID)="") Q "-1^Invalid Input Parameters"
 N STDIEN,CUSIEN,TOVERIEN,SEGDEF,SEGIEN
 S STDIEN=$O(^PS(58.4,"B","STANDARD ASAP DEFINITION",0))
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0))
 ; From ASAP Version must exist (Standard or Custom)
 I '$D(^PS(58.4,STDIEN,"VER","B",FROMVER)),'$D(^PS(58.4,CUSIEN,"VER","B",FROMVER)) Q "-1^Source ASAP Version does not exist."
 ; To ASAP Version must exist (Custom) - If not, try to create it
 S TOVERIEN=$O(^PS(58.4,CUSIEN,"VER","B",TOVER,9999),-1)
 I 'TOVERIEN S TOVERIEN=$$SAVEVER(TOVER,ASAPDEF) I TOVERIEN<0 Q TOVERIEN
 ; Segment ID already on file (cannot be copied again)
 I $O(^PS(58.4,CUSIEN,"VER",TOVERIEN,"SEG","B",SEGID,0)) Q "-1^Segment ID already on file"
 I '$D(ASAPDEF(SEGID)) Q "-1^Missing new segment data"
 Q $$SAVESEG(TOVER,"+1",ASAPDEF(SEGID),ASAPDEF)
 ;
SAVESEG(ASAPVER,SEGID,SEGDATA,VERDATA) ; Saves a Segment
 ; Input: (r) ASAPVER - ASAP Version ("3.0", "4.0", etc.)
 ;        (r) SEGID   - Segment ID ("PHA", "DSP", etc.) or "+1" to add a new Segment
 ;        (r) SEGDATA - Segment Data
 ;        (o) VERDATA - Version Data (Only needed for 1st custom segment)
 ;Output: SAVESEG - Segment IEN
 I $G(ASAPVER)=""!($G(SEGID)="")!($G(SEGDATA)="") Q "-1^Invalid Input Parameters"
 N SAVESEG,CUSIEN,VERIEN,SEGIEN,SEGDEF
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0)) I 'CUSIEN Q "-1^Invalid Custom ASAP Data Definition"
 ; Custom ASAP Version must exist - If not, create it
 S VERIEN=$O(^PS(58.4,CUSIEN,"VER","B",ASAPVER,9999),-1)
 I 'VERIEN S VERIEN=$$SAVEVER(ASAPVER,VERDATA) I VERIEN<0 Q "-1^Invalid Custom ASAP Version"
 S SEGIEN=SEGID
 I SEGIEN'="+1" S SEGIEN=$O(^PS(58.4,CUSIEN,"VER",VERIEN,"SEG","B",SEGID,9999),-1) I 'SEGIEN Q "-1^Invalid Custom ASAP Segment"
 S SEGDEF(58.40011,SEGIEN_","_VERIEN_","_CUSIEN_",",.01)=$P(SEGDATA,"^",1) ;Segment ID
 S SEGDEF(58.40011,SEGIEN_","_VERIEN_","_CUSIEN_",",.02)=$P(SEGDATA,"^",2) ;Segment Name
 S SEGDEF(58.40011,SEGIEN_","_VERIEN_","_CUSIEN_",",.03)=$P(SEGDATA,"^",3) ;Parent Segment
 S SEGDEF(58.40011,SEGIEN_","_VERIEN_","_CUSIEN_",",.04)=$P(SEGDATA,"^",4) ;Requirement
 S SEGDEF(58.40011,SEGIEN_","_VERIEN_","_CUSIEN_",",.05)=$P(SEGDATA,"^",5) ;Position
 S SEGDEF(58.40011,SEGIEN_","_VERIEN_","_CUSIEN_",",.06)=$P(SEGDATA,"^",6) ;Level
 D UPDATE^DIE("","SEGDEF","SAVESEG","")
 I SEGIEN="+1" S SEGIEN=+$G(SAVESEG(1))
 Q SEGIEN
 ;
COPYELM(FROMVER,ASAPDEF,TOVER,ELMID) ; Copy a Data Element
 ;Input: (r) FROMVER - Source ASAP Version ("3.0", "4.0", etc.)
 ;       (r) ASAPDEF - Array containig the ASAP Definition to be copied
 ;       (r) TOMVER  - Detin ASAP Version ("3.0", "4.0", etc.)
 ;       (r) ELMID  - Data Element ID ("PHA01", "DSP02", etc.)
 ;Output: SAVESEG - Segment IEN
 I $G(FROMVER)=""!'$D(ASAPDEF)!($G(TOVER)="")!($G(ELMID)="") Q "-1^Invalid Input Parameters"
 N STDIEN,CUSIEN,TOVERIEN,TOSEGIEN,ELMDEF,ELMIEN,ELMDATA
 S STDIEN=$O(^PS(58.4,"B","STANDARD ASAP DEFINITION",0))
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0))
 ; From ASAP Version must exist (Standard or Custom)
 I '$D(^PS(58.4,STDIEN,"VER","B",FROMVER)),'$D(^PS(58.4,CUSIEN,"VER","B",FROMVER)) Q "-1^Source ASAP Version does not exist."
 ; To ASAP Version must exist (Custom) - If not, create it
 S TOVERIEN=$O(^PS(58.4,CUSIEN,"VER","B",TOVER,9999),-1)
 I 'TOVERIEN S TOVERIEN=$$SAVEVER(TOVER,ASAPDEF) I TOVERIEN<0 Q "-1^Invalid Custom ASAP Version"
 S SEGID=$$GETSEGID(ELMID) I SEGID="" Q "-1^Invalid Segment ID "_SEGID_"."
 ; Custom ASAP Segment must exist - If not, create it
 S TOSEGIEN=$O(^PS(58.4,CUSIEN,"VER",TOVERIEN,"SEG","B",SEGID,9999),-1)
 I 'TOSEGIEN S TOSEGIEN=$$SAVESEG(TOVER,SEGID,ASAPDEF(SEGID),ASAPDEF) I 'TOSEGIEN Q "-1^Segment ID does not exist in the destin ASAP Version."
 ; Segment ID already on file (cannot be copied again)
 I $O(^PS(58.4,CUSIEN,"VER",TOVERIEN,"SEG",TOSEGIEN,"DAT","B",ELMID,9999),-1) Q "-1^Data Element already on file"
 I '$D(ASAPDEF(SEGID,ELMPOS)) Q "-1^Data Element does not exist in the source ASAP Version."
 K ELMDATA M ELMDATA=ASAPDEF(SEGID,ELMPOS)
 Q $$SAVEELM(TOVER,SEGID,"+1",.ELMDATA)
 ;
SAVEELM(ASAPVER,SEGID,ELMID,ELMDATA) ; Saves a Data Element
 ;Input: (r) ASAPVER - ASAP Version ("3.0", "4.0", etc.)
 ;       (r) SEGID   - Segment ID ("PHA", "DSP", etc.)
 ;       (r) ELMID   - Data Element ID ("PHA01", "DSP05", etc.) or "+1" to add a new Data Element
 ;       (r) ELMDATA - Data Element Data
 ;Output: SAVEELM - Data Element IEN
 I $G(ASAPVER)=""!($G(SEGID)="")!($G(ELMID)="")!($G(ELMDATA)="") Q "-1^Invalid Input Parameters"
 N SAVEELM,CUSIEN,VERIEN,ELMIEN,ELMDEF,SEGIEN
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",0)) I 'CUSIEN Q "-1^Invalid Custom ASAP Data Definition"
 ; Custom ASAP Version must exist
 S VERIEN=$O(^PS(58.4,CUSIEN,"VER","B",ASAPVER,9999),-1) I 'VERIEN Q "-1^Invalid Custom ASAP Version"
 ; Custom ASAP Segment must exist
 S SEGIEN=$O(^PS(58.4,CUSIEN,"VER",VERIEN,"SEG","B",SEGID,9999),-1) I 'SEGIEN Q "-1^Segment ID does not exist in the destin ASAP Version."
 S ELMIEN=ELMID
 I ELMIEN'="+1" S ELMIEN=$O(^PS(58.4,CUSIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT","B",ELMID,9999),-1) I 'ELMIEN Q "-1^Invalid Custom ASAP Data Element"
 ; Saving Data Element
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.01)=$P(ELMDATA,"^",1) ;Element ID
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.02)=$P(ELMDATA,"^",2) ;Element Name
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.03)=$P(ELMDATA,"^",3) ;Data Format
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.04)=$P(ELMDATA,"^",4) ;Maximum Length
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.05)=$P(ELMDATA,"^",5) ;Position
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.06)=$P(ELMDATA,"^",6) ;Requirement
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.07)="ELMDATA(""DES"")" ;Description
 S ELMDEF(58.400111,ELMIEN_","_SEGIEN_","_VERIEN_","_CUSIEN_",",.08)="ELMDATA(""VAL"")" ;Value
 D UPDATE^DIE("","ELMDEF","SAVEELM","")
 I ELMIEN="+1" S ELMIEN=+$G(SAVEELM(1))
 Q ELMIEN
 ;
CUSSEG(ASAPVER,SEGID) ; Customized Segment?
 ;Input: (r) ASAPVER - ASAP Version ("3.0", "4.0", etc.)
 ;       (r) SEGID   - Segment ID
 ;Output: Customized Segment? 1: YES / 0: NO
 I $G(ASAPVER)=""!($G(SEGID)="") Q 0
 N STDASAP,CUSASAP
 D LOADASAP^PSOSPMU0(ASAPVER,"S",.STDASAP) ; Standard ASAP Definition
 D LOADASAP^PSOSPMU0(ASAPVER,"C",.CUSASAP) ; Custom ASAP Definition
 I $G(CUSASAP(SEGID))="" Q 0
 I $G(STDASAP(SEGID))=$G(CUSASAP(SEGID)) Q 0
 Q 1
 ;
DELCUS(ASAPVER,SEGID,ELMID) ; Delete/Reset a Customization
 ;Input: (r) ASAPVER - ASAP Version ("3.0", "4.0", etc.)
 ;       (o) SEGID   - Segment ID ("PHA", "DSP", etc.)
 ;       (o) ELMID  - Data Element ID ("PHA01", "DSP02", etc.)
 I $G(ASAPVER)="" Q
 N STDASAP,CUSASAP,CUSIEN,VERIEN,SEGIEN,ELMIEN,DIK,DA
 D LOADASAP^PSOSPMU0(ASAPVER,"S",.STDASAP) ; Standard ASAP Definition
 D LOADASAP^PSOSPMU0(ASAPVER,"C",.CUSASAP) ; Custom ASAP Definition
 ;
 S CUSIEN=$O(^PS(58.4,"B","CUSTOM ASAP DEFINITION",9999),-1)
 S VERIEN=$O(^PS(58.4,CUSIEN,"VER","B",ASAPVER,9999),-1) I 'VERIEN Q
 I $G(SEGID)'="" D
 . S SEGIEN=$O(^PS(58.4,CUSIEN,"VER",VERIEN,"SEG","B",SEGID,9999),-1)
 I $G(ELMID)'="" D
 . S SEGIEN=$O(^PS(58.4,CUSIEN,"VER",VERIEN,"SEG","B",$$GETSEGID(ELMID),9999),-1) I 'SEGIEN Q
 . S ELMIEN=$O(^PS(58.4,CUSIEN,"VER",VERIEN,"SEG",SEGIEN,"DAT","B",ELMID,9999),-1)
 ;
 I $G(SEGID)'="",'$G(SEGIEN) Q
 I $G(ELMID)'="",'$G(ELMIEN) Q
 ;
 ; Deleting/Resetting a Custom Data Element
 I $G(ELMID)'="" D  Q
 . S DIK="^PS(58.4,"_CUSIEN_",""VER"","_VERIEN_",""SEG"","_SEGIEN_",""DAT"","
 . S DA(3)=CUSIEN,DA(2)=VERIEN,DA(1)=SEGIEN,DA=ELMIEN D ^DIK
 ;
 ; Deleting/Resetting an Entire Custom Segment
 I $G(SEGID)'="" D  Q
 . S DIK="^PS(58.4,"_CUSIEN_",""VER"","_VERIEN_",""SEG"","
 . S DA(2)=CUSIEN,DA(1)=VERIEN,DA=SEGIEN D ^DIK
 ;
 ; Deleting/Resetting an Entire Custom ASAP Version
 S DIK="^PS(58.4,"_CUSIEN_",""VER"","
 S DA(1)=CUSIEN,DA=VERIEN D ^DIK
 Q
 ;
GETSEGID(ELMID) ; Get the Segment ID from the Element ID
 ;Input: (r) ELMID - Data Element ID ("PHA01", "DSP02", etc.)
 N GETSEGID,I
 S GETSEGID=$G(ELMID) F I=$L(ELMID):-1:1 Q:($E(ELMID,I)'?1N)  S $E(GETSEGID,I)=""
 Q GETSEGID
 ;
VALID(ASAPVER,MEXPR) ; Validate the Mumps Expression for the ASAP Version
 ;Input: (r) ASAPVER - ASAP Version ("3.0", "4.0", etc.) (Required for checking the delimiters)
 ;       (r) MEXPR   - M SET Expression Argument to be validated
 I $G(ASAPVER)=""!($G(MEXPR)="") Q "0^Invalid Input Parameters"
 N VALID,VERDATA,ELMDELIM,SEGDELIM,INQUOTES,CHAR,X,I
 S MEXPR=$$UP^XLFSTR(MEXPR)
 I $G(MEXPR)="" Q "0^M SET Expression cannot be empty. Use """" for blank/null values."
 I $F(MEXPR," D ^")!$F(MEXPR," DO ^")!$F(MEXPR,"G ^")!$F(MEXPR,"GO ^") Q "0^M SET Expression cannot call out other routines."
 I $F(MEXPR,"K ^")!$F(MEXPR,"KILL ^") Q "0^M SET Expression cannot contain 'KILL' command."
 I $F(MEXPR," S ^")!$F(MEXPR," SET ^") Q "0^M SET Expression cannot contain 'SET' command."
 I $F(MEXPR," L +")!$F(MEXPR," L ^")!$F(MEXPR," LOCK ") Q "0^M SET Expression cannot contain 'LOCK' command."
 I $F(MEXPR,"$C(") Q "0^M SET Expression cannot contain special characters ($C)."
 S VALID=1,VERDATA=$$VERDATA^PSOSPMU0(ASAPVER,"B")
 S ELMDELIM=$P(VERDATA,"^",2),SEGDELIM=$P(VERDATA,"^",3)
 S INQUOTES=0
 F I=1:1:$L(MEXPR) D  I VALID<0 Q
 . S CHAR=$E(MEXPR,I)
 . I ($A(CHAR)<32)!($A(CHAR)>176) S VALID="0^M SET Expression cannot contain special characters." Q
 . I CHAR="""" S INQUOTES=((INQUOTES+1)#2)
 . I INQUOTES D
 . . I CHAR=ELMDELIM S VALID="0^M SET Expression Cannot contain the character '"_CHAR_"' (Element Delimiter)." Q
 . . I CHAR=SEGDELIM S VALID="0^M SET Expression Cannot contain the character '"_CHAR_"' (Segment Terminator)." Q
 . E  D
 . . I CHAR=" " S VALID="0^No Blank Space characters allowed outside quotes." Q
 ; The concatenated 'X' below is for security purposes
 S X="W "_MEXPR_"_""X""" D ^DIM I '$D(X) Q "0^M SET Expression syntax is invalid."
 Q VALID
 ;
CHKVAR(LEVEL,MEXPR) ; Checks the variables in the M SET Expression
 ; Input: (r) LEVEL - Level of the Segment where the Data Element is located
 ;        (r) MEXPR - Mumps SET Expression value to be verified
 ;Output: $$CHKVAR  - 1: No issues / 0: Invalid Variable use
 I '$G(LEVEL)!$G(MEXPR)="" Q 1
 N CHKVAR,LEVNAM,VAR,OKLST
 S CHKVAR=""
 I LEVEL=4 Q 1
 I LEVEL=1!(LEVEL=6) S OKLST="STATEIEN,"
 I LEVEL=2!(LEVEL=5) S OKLST="STATEIEN,SITEIEN,"
 I LEVEL=3 S OKLST="STATEIEN,SITEIEN,PATIEN"
 F VAR="STATEIEN","SITEIEN","PATIEN","RXIEN","DRUGIEN","FILLNUM","FILLIEN","RPHIEN","PREIEN","RTSREC" D
 . I MEXPR[VAR,OKLST'[VAR S CHKVAR=CHKVAR_$S(CHKVAR'="":",",1:"")_VAR
 I CHKVAR'="" D  Q 0
 . S LEVNAM=$P("MAIN HEADER^PHARMACY HEADER^PATIENT DETAIL^PRESCRIPTION DETAIL^PHARMACY TRAILER^MAIN TRAILER","^",LEVEL)
 . W !,"The variable",$S(CHKVAR[",":"s",1:"")," ",CHKVAR," ",$S(CHKVAR[",":"are",1:"is")," not available at the ",LEVNAM," level.",$C(7),!
 Q 1
 ;
CHKCODE(LEVEL,MEXPR,ERROR) ; Checks the data retrieval code for the Data Element
 ; Input: (r) LEVEL - Level of the Segment where the Data Element is located
 ;        (r) MEXPR - Mumps SET Expression value to be verified
 ;Output: ERROR - Indicate whether an ERROR occurred or not (1: Yes, 0: No)
 I '$G(LEVEL)!$G(MEXPR)="" Q
 N QUIT,STATEIEN,SITEIEN,LASTRD,PATIEN,DFN,RXIEN,DRUGIEN,FILLIEN,FILLNUM,PREIEN,RPHIEN,RTSREC,CODE,X
 N RECTYPE
 S ERROR=0
 I '$G(LEVEL)!$G(MEXPR)="" Q
 S (QUIT,SITEIEN,PATIEN,DFN,RXIEN,DRUGIEN,FILLIEN,PREIEN,RPHIEN,FILLNUM,RTSREC)=0
 D  I QUIT Q
 . S LASTRD=$O(^PSRX("AL",9999999),-1) I 'LASTRD S QUIT=1 Q
 . S RXIEN=$O(^PSRX("AL",LASTRD,0)) I '$D(^PSRX(RXIEN,0)) S QUIT=1 Q
 . S SITEIEN=$$RXSITE^PSOBPSUT(RXIEN,0)
 . S STATEIEN=$$GET1^DIQ(59,SITEIEN,.08,"I")
 . I LEVEL=1!(LEVEL=6) K SITEIEN,PATIEN,DFN,RXIEN,DRUGIEN,FILLIEN,FILLNUM,PREIEN,RPHIEN,RTSREC Q
 . I LEVEL=2!(LEVEL=5) K PATIEN,DFN,RXIEN,DRUGIEN,FILLIEN,FILLNUM,PREIEN,RPHIEN,RTSREC Q
 . S (PATIEN,DFN)=$$GET1^DIQ(52,RXIEN,2,"I") D SETNAME^PSOSPMUT(PATIEN)
 . I LEVEL=3 K RXIEN,DRUGIEN,FILLIEN,FILLNUM,PREIEN,RPHIEN,RTSREC Q
 . S DRUGIEN=$$GET1^DIQ(52,RXIEN,6,"I")
 . S FILLIEN=0,FILLNUM=0,RECTYPE="N"
 . S PREIEN=$$RXPRV^PSOBPSUT(RXIEN,0)
 . S RPHIEN=$$RXRPH^PSOBPSUT(RXIEN,0)
 S CODE="S X="_MEXPR
 N $ETRAP,$ESTACK S $ETRAP="D ERROR^PSOSPMU3"
 X CODE
 Q
 ;
ERROR ; Error Trap to test ASAP Data Retrieval
 N ZE,DIR,DRUT,DTOUT,X,Y
 S ZE=$$EC^%ZOSV
 I ZE["<UNDEFINED>" D
 . W !,"The code will likely throw an <UNDEFINED> error for the "
 . W $S(ZE["*":"variable '",1:"global ^"),$S(ZE["*":$P(ZE,"*",2)_"'",1:$P(ZE,"^",3)),".",$C(7)
 . S DIR(0)="Y",DIR("B")="NO",DIR("A")="Continue Anyway" D ^DIR I '$G(Y) S ERROR=1
 E  W !,"The code will throw a <",$P($P(ZE,"<",2),">"),"> error for this expression.",$C(7) S ERROR=1
 ; Continue on
 W ! G UNWIND^%ZTER
