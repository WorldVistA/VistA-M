IBCNINSU ;AITC/TAZ - GENERAL INSURANCE UTILITIES ;8/20/20 12:46p.m.
 ;;2.0;INTEGRATED BILLING;**668,687,713**;21-MAR-94;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PAYER(PIEN,APP,FLDS,FLGS,ARRAY) ;Payer Data Retrieval
 ;INPUT
 ; * = required input
 ; * PIEN     - Payer IEN
 ;   APP      - EIV - Returns all fields for Payer Level and EIV level of file (overrides FLDS)
 ;            - IIU - Returns all fields for Payer Level and IIU level of file (overrides FLDS)
 ; * FLDS     - Required only if APP is null; If APP is populated this parameter is ignored
 ;            - A single field number
 ;            - A list of field numbers, separated by semicolons
 ;            - A range of field numbers, in the form M:N, where M and N are the end points of the inclusive range. 
 ;              All field numbers within this range are retrieved.
 ;            - * for all fields at the top level (no sub-multiple record).
 ;            - ** for all fields including all fields and data in sub-multiple fields.
 ;            - Field number of a multiple followed by an * to indicate all fields and records in the sub-multiple 
 ;              for that field.
 ;   FLGS     - E Returns External values in nodes ending with "E".
 ;            - I Returns Internal values in nodes ending with "I". 
 ;            - NULL Returns External values.
 ; * ARRAY    - Name of the Array that will contain the data (passed by reference)
 ;
 ;OUTPUT
 ;   ARRAY    - Data requested is returned in the array that was passed by reference
 ;
 N APPIEN,APPIENI,IENS
 I '$G(PIEN) S ARRAY(0)="Payer IEN is null or invalid" G PAYERX
 I $G(APP)="",($G(FLDS)="") S ARRAY(0)="No fields requested." G PAYERX
 S FLGS=$G(FLGS)
 I $G(APP)'="" D  G PAYERX
 . S APPIEN=$$FIND1^DIC(365.13,,,APP) I 'APPIEN S ARRAY(0)="Invalid Application" Q
 . S APPIENI=$O(^IBE(365.12,PIEN,1,"B",APPIEN,""))   ; Get the app's internal id for the current payer.
 . ; Get all fields at Top Level
 . S IENS=PIEN_",",FLDS="*"
 . D GETS^DIQ(365.12,IENS,FLDS,FLGS,"ARRAY")
 . ; Get all fields at Application Level
 . S IENS=APPIENI_","_IENS,FLDS=".01:5.01"  ;ignores the log data (history of the settings)
 . D GETS^DIQ(365.121,IENS,FLDS,FLGS,"ARRAY")
 S IENS=PIEN_","
 D GETS^DIQ(365.12,IENS,FLDS,FLGS,"ARRAY")
 ;
PAYERX ; Exit subroutine
 Q
 ;
PYRDEACT(PIEN) ;Check if payer is deactivated
 ;INPUT
 ;  PIEN - Payer IEN
 ;OUTPUT
 ;  DEACTIVATE - Payer Deactivated (Internal Format)
 ;                  0 - No
 ;                  1 - Yes
 ;  DATE/TIME DEACTIVATE - Date and Time the Payer was deactivated (Internal Fileman Format)
 ;
 N PYRARR,IENS
 S IENS=PIEN_","
 D PAYER(PIEN,,".07;.08","I",.PYRARR)
 ;
 Q PYRARR(365.12,IENS,.07,"I")_U_PYRARR(365.12,IENS,.08,"I")
 ;
STOP() ; Determine if user wants to exit out of the whole option
 ; Init vars
 N DIR,DIRUT,STOP,X,Y
 ;
 W !
 S DIR(0)="Y"
 S DIR("A")="Do you want to exit out of this option entirely"
 S DIR("B")="YES"
 S DIR("?",1)="  Enter YES to immediately exit out of this option."
 S DIR("?")="  Enter NO to return to the previous question."
 D ^DIR K DIR
 I $D(DIRUT) S (STOP,Y)=1 G STOPX
 I 'Y S STOP=0
 ;
STOPX ; STOP exit pt
 Q Y
 ;
FOREIGN(VALUE,PIECES,BLANK) ; check for ASCII chars outside (32-126 inclusive)
 ;INPUT:
 ;  VALUE  = the string/field to check
 ;  PIECES = populate if a subcomponent has to be checked (defaults as 1)
 ;  BLANK  = populated if the value is to be cleared out if foreign char
 ;           is encountered (1 tells program to clear out field if it cotains foreign)
 ;
 ; I VALUE had a character, in the pieces that were to be examined, that is
 ;   outside of the ASCII range (32-126) a 1 is returned; otherwise returns ZERO
 ;
 N BAD,DONE,IBI,IBY,PCE,STRNG,XX
 S IBY="",BAD=0
 I '$G(PIECES) S PIECES=1
 F PCE=1:1:$L(PIECES,";") S XX=$P(PIECES,";",PCE) D
 . S STRNG=$P(VALUE,HLECH,XX),DONE=0
 . I STRNG'="" F IBI=1:1 S IBY=$E(STRNG,IBI) Q:IBY=""  D  Q:DONE
 .. I $A(IBY)<32!($A(IBY)>126) D  Q
 ... S (DONE,BAD)=1   ;Foreign character found
 ... I $G(BLANK) S $P(VALUE,HLECH,XX)=""
 Q BAD
 ;
FILTER(STR,FLT) ; Filter Insurance Name, Group Name or Number
 ;IBFLT A^B^C
 ;         A - 1 - Search for Name(s) that begin with
 ;                 the specified text (case insensitive)
 ;             2 - Search for Name(s) that contain
 ;                 the specified text (case insensitive)
 ;             3 - Search for Name(s) in a specified
 ;                 range (inclusive, case insensitive)
 ;             4 - Search for Name(s) that are blank (null)
 ;         B - Begin with text if A=1, Contains Text if A=2 or
 ;             the range start if A=3
 ;         C - Range End text (only present when A=3)
 ;OUTPUT:
 ;  OK -  0 - Does not match Filter, do not include
 ;        1 - Matches Filter, include
 ;
 N BEG,CHR,END,OK,TYPE,YY
 S STR=$$UP^XLFSTR(STR)
 S TYPE=$P(FLT,U,1)
 S BEG=$$UP^XLFSTR($P(FLT,U,2))
 S END=$$UP^XLFSTR($P(FLT,U,3))
 S OK=0
 ;Blank
 I TYPE=4 D  G FILTERX
 . I STR="" S OK=1
 ;Test begins with
 I TYPE=1 D  G FILTERX
 . I ($E(STR,1,$L(BEG))=BEG) S OK=1
 ;Test contains
 I TYPE=2 D  G FILTERX
 . I (STR[BEG) S OK=1
 ;Test range
 I TYPE=3 D  G FILTERX
 . N XX
 . S XX=$E(STR,1,$L(BEG))
 . I XX=BEG D  Q
 .. S YY=$E(STR,1,$L(END)) I YY]END Q
 .. S OK=1             ;Matches begining characters of BEG - include
 . I XX']BEG Q         ;Preceeds Beg search
 . S XX=$E(STR,1,$L(END))
 . I XX=END S OK=1 Q   ;Matches beginning characters of END - include
 . I XX]END Q          ;Follows End search
 . S OK=1
FILTERX ; Exit
 Q OK
