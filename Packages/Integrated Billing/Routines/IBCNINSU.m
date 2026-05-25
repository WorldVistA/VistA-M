IBCNINSU ;AITC/TAZ - GENERAL INSURANCE UTILITIES ;8/20/20 12:46p.m.
 ;;2.0;INTEGRATED BILLING;**668,687,713,737,822**;21-MAR-94;Build 21
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
 ;             5 - Filter by Selected Payer only (ONLY used by 'eIV Auto Update Report' (IBCNERPF)) ;IB*737/CKB
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
 ;IB*737/CKB - added Payer (TYPE=5)
 ;Payer
 I TYPE=5 S OK=1 G FILTERX
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
 ;
VALIDDT(X) ; Check for validate date (internal form of the date)  ;IB*737/CKB
 ;   Input:  X - internal date, FM format
 ; Returns:  Y - if date if NOT valid, returns -1
 ;               if the date is "" (null), returns a "" (null)
 ;               if valid date, returns the internal date
 N %DT,Y
 Q:X="" ""
 S %DT="X" D ^%DT
 Q Y
 ; IB*822/DTG look up subscribers by plan for an Insurance
INSSUB(IBINS,IBRET,IBLER,IBPLNTYP,IBINSACT,IBPTACTV) ; IB*822/DTG look up subscribers by plan for an Insurance
 ;
 ; default, Insurance must be active
 ;          Patient / Plans must be active
 ;
 ;
 ; IBINS - Insurance CO.
 ; IBRET - return array
 ; IBLER -  error return
 ; IBPLNTYP -  (optional) Plan Type (A) active, (I) inactive, (B) all   (default is Active)
 ; IBINSACT - (optional) Insurance status  (A) active, (I) inactive, (B) all   (default is Active)
 ; IBPTACTV - (optional) Pt. Active (A) active, (I) inactive, (B) all   (default is Active)
 ;
 ; IBRET return array layout
 ; IBRET(INS_INT) = Ins Co IEN ^ Insurance Company name  ^ Street Address Line 1 ^ City ^ ST ^ ZIP ^ Status
 ; Plans will only be defined if there are patients in the plan for processing
 ;
 ; IBRET(INS_INT,PLAN_INT) = Plan IEN ^ Plan Group Number ^ Plan Group Name ^ group or indiv ^ Plan Active
 ;                           ^ Plan Inactive ^ Type of Plan PTR ^ Type of Plan name
 ;
 ; IBRET(INS_INT,PLAN_INT,PAT_DFN,PAT_FILE_INS_ENTRY-IEN)= Patient's Name (22 chars) ^ Patient's SSN ^  Patient's DOB 
 ;                                                         ^  Subscriber ID (20 chars max) ^ Effective Date 
 ;                                                         ^ Expiration Date ^ Whose Insurance? 
 ;                                                         ^ Patient ID ^ ACTIVE ^  INACTIVE ^ FM DOB ^ FM eff dt 
 ;                                                         ^  FM exp dt ^  FM current verified DT
 ;
 K ^TMP("IBCNINSUL",$J)
 N IBA,IBACT,IBB,IBDOB,IBEFFDT,IBEPT,IBEPTN,IBEXPDT,IBGNAM,IBGNUM,IBGOI,IBIA
 N IBIB,IBIFO,IBIND,IBINSAC,IBNAM,IBPLN,IBPLNAT,IBPLNIT,IBPTAC,IBPTDA,IBPTDFN,IBPTHOLD
 N IBPTIC,IBPTINS,IBPTPLAN,IBTOP,IBTOPN,IBVERDT,IBVERUSR,X,XX
 S IBINS=$G(IBINS),IBRET=$G(IBRET),IBLER=$G(IBLER),IBPLNTYP=$G(IBPLNTYP)
 S IBINSACT=$G(IBINSACT),IBPTACTV=$G(IBPTACTV)
 S IBINSACT=$S(IBINSACT="A":1,IBINSACT="I":2,IBINSACT="B":3,1:"1")
 S IBPLNTYP=$S(IBPLNTYP="A":1,IBPLNTYP="I":2,IBPLNTYP="B":3,1:"1")
 S IBPTACTV=$S(IBPTACTV="A":1,IBPTACTV="I":2,IBPTACTV="B":3,1:"1")
 ;
 I 'IBINS D IER("Missing Insurance") G INSSUBQ
 I IBRET="" D IER("Missing Return") G INSSUBQ
 K @IBRET
 ; get ins info
 K IBIA,IBIB D GETS^DIQ(36,IBINS_",",".01;.05;.111;.114;.115;.116","I","IBIA")
 I $G(IBIA(36,IBINS_",",.01,"I"))="" D IER("Insurance Not Found") G INSSUBQ  ; insurance must have a name
 M IBIB=IBIA(36,IBINS_",")
 ; is insurance active
 S IBINSAC=+$G(IBIB(.05,"I"))  ; +.05=0 - Active,  +.05=1 - Inactive
 I IBINSAC=1&(IBINSACT'=2&(IBINSACT'=3)) D IER("Insurance is inactive, Only want active Insurances") G INSSUBQ
 I IBINSAC'=1&(IBINSACT'=1&(IBINSACT'=3)) D IER("Insurance is active, Only want inactive Insurances") G INSSUBQ
 ;
 ; Ins Co IEN ^ Insurance Company name  ^ Street Address Line 1 ^ City ^ ST ^ ZIP ^ Status
 S IBIFO=IBINS_U_$E($G(IBIB(.01,"I")),1,30)_U_$G(IBIB(.111,"I"))_U_$G(IBIB(.114,"I"))
 S X=$G(IBIB(.115,"I")),XX=$S(X:$$GET1^DIQ(5,X_",",1,"I"),1:"")
 S IBIFO=IBIFO_U_XX_U_$E($G(IBIB(.116,"I")),1,5)_U_IBINSAC
 S ^TMP("IBCNINSUL",$J,"OUT",IBINS)=IBIFO
 ;
 ; get the plans
 K ^TMP("IBCNINSUL",$J,"PLAN")
 S IBPLN=0 F  S IBPLN=$O(^IBA(355.3,"B",IBINS,IBPLN)) Q:'IBPLN  D
 . K IBIA,IBIB D GETS^DIQ(355.3,IBPLN_",",".01;.02;.09;.11;.15;2.02;2.01","IE","IBIA")
 . M IBIB=IBIA(355.3,IBPLN_",")
 . I $G(IBIB(.01,"I"))'=IBINS Q  ; This plan is not associated to the insurance at the data level.
 . S IBGOI=$G(IBIB(.02,"I"))  ; Group or Individual Plan
 . S IBACT=$G(IBIB(.11,"I")),(IBPLNAT,IBPLNIT)="" ; +IBACT=0 - Active,   +IBACT=1 - Inactive
 . I '+IBACT S IBPLNAT=1  ; plan active
 . I +IBACT S IBPLNIT=1  ; plan inactive
 . S IBGNUM=$G(IBIB(2.02,"I")) S:IBGNUM="" IBGNUM="<NO GROUP NUMBER>"
 . S IBGNAM=$G(IBIB(2.01,"I")) S:IBGNAM="" IBGNAM="<NO GROUP NAME>"
 . S IBEPT=$G(IBIB(.15,"I"))  ; Electronic Plan Type code
 . S IBEPTN=$G(IBIB(.15,"E"))  ; Electronic Plan Type description
 . S IBTOP=$G(IBIB(.09,"I")) ; Type of Plan
 . S IBTOPN=$G(IBIB(.09,"I"))  ; Type of Plan Name from 355.1
 . ; Plan IEN ^ Plan Group Number ^ Plan Group Name ^ group or indiv ^ Plan Active ^ Plan Inactive ^ Type of Plan PTR ^ Type of Plan name
 . S ^TMP("IBCNINSUL",$J,"PLAN",(IBACT+1),IBPLN)=IBPLN_U_IBGNUM_U_IBGNAM_U_IBGOI_U_IBPLNAT_U_IBPLNIT_U_IBTOP_U_IBTOPN  ; break out plans by active (1) and inactive (2)
 . S ^TMP("IBCNINSUL",$J,"PLAN",3,IBPLN)=IBPLN_U_IBGNUM_U_IBGNAM_U_IBGOI_U_IBPLNAT_U_IBPLNIT_U_IBTOP_U_IBTOPN  ; all plans
 ;
 ; collect the patients
 ;
 S IBPTDFN=0
 F  S IBPTDFN=$O(^DPT("AB",IBINS,IBPTDFN)) Q:'IBPTDFN  S IBPTINS=0 D
 . F  S IBPTINS=$O(^DPT("AB",IBINS,IBPTDFN,IBPTINS)) Q:'IBPTINS  D
 .. S IBPTDA=IBPTINS_","_IBPTDFN_","
 .. S IBPTPLAN=$$GET1^DIQ(2.312,IBPTDA,.18,"I")
 .. I IBPTPLAN="" Q  ; if no plan
 .. I $D(^TMP("IBCNINSUL",$J,"PLAN",IBPLNTYP,IBPTPLAN)) D
 ... ;get status
 ... S IBIND=$$ZND^IBCNS1(IBPTDFN,IBPTINS)
 ... S X=$$PT^IBEFUNC(IBPTDFN)
 ... S IBNAM=$E($P(X,"^",1),1,22)               ; Patient's Name (22 chars)
 ... S:IBNAM="" IBNAM="<Pt. "_IBPTDFN_" Name Missing>"
 ... S IBPTHOLD=IBNAM
 ... ;
 ... ; Retrieve last 4 of SSN (last 5 if pseudo SSN)
 ... S XX=$$GET1^DIQ(2,IBPTDFN_",",.09,"I")         ; Patient's SSN
 ... S XX=$S($E(XX,$L(XX))="P":$E(XX,$L(XX)-4,$L(XX)),1:$E(XX,$L(XX)-3,$L(XX)))
 ... S $P(IBPTHOLD,"^",2)=XX
 ... ;
 ... S IBDOB=$$GET1^DIQ(2,IBPTDFN_",",.03,"I"),XX=$$DTC5(IBDOB)  ; Patient's DOB
 ... S $P(IBPTHOLD,"^",3)=XX,$P(IBPTHOLD,U,11)=IBDOB
 ... ;
 ... S XX=$P(IBIND,"^",2),XX=$S(XX'="":XX,1:"<NO SUBS ID>")
 ... S $P(IBPTHOLD,"^",4)=XX                         ; Subscriber ID (20 chars max)
 ... ;
 ... S IBEFFDT=$P(IBIND,"^",8),XX=$$DTC5(IBEFFDT)   ; Effective Date
 ... S $P(IBPTHOLD,"^",5)=XX,$P(IBPTHOLD,U,12)=IBEFFDT
 ... ;
 ... S IBEXPDT=$P(IBIND,"^",4),XX=$$DTC5(IBEXPDT)   ; Expiration Date
 ... S $P(IBPTHOLD,"^",6)=XX,$P(IBPTHOLD,"^",13)=IBEXPDT
 ... ;
 ... ; Whose Insurance?
 ... S XX=$P(IBIND,"^",6),XX=$S(XX="v":"VET",XX="s":"SPO",XX="o":"OTH",1:"UNK")
 ... S $P(IBPTHOLD,"^",7)=XX
 ... S XX=$$GET1^DIQ(2.312,IBPTINS_","_IBPTDFN_",",5.01,"I")  ; Patient ID
 ... S $P(IBPTHOLD,"^",8)=XX
 ... ;
 ... S IBVERDT=$$GET1^DIQ(2.312,IBPTINS_","_IBPTDFN_",",1.03,"I")  ; Verified Date
 ... S $P(IBPTHOLD,"^",14)=IBVERDT
 ... S IBVERUSR=$$GET1^DIQ(2.312,IBPTINS_","_IBPTDFN_",",1.04,"I")  ; Verified User
 ... ;
 ... ;  1 - Patient's Name (22 chars) ^ 
 ... ;  2 - Patient's SSN ^ 
 ... ;  3 - Patient's DOB ^ 
 ... ;  4 - Subscriber ID (20 chars max) ^ 
 ... ;  5 - Effective Date ^ 
 ... ;  6 - Expiration Date ^ 
 ... ;  7 - Whose Insurance? ^ 
 ... ;  8 - Patient ID ^ 
 ... ;  9 - ACTIVE ^ 
 ... ; 10 - INACTIVE ^ 
 ... ; 11 -  FM DOB ^
 ... ; 12 -  FM eff dt ^ 
 ... ; 13 -  FM exp dt ^ 
 ... ; 14 -  FM current verified DT
 ... ;
 ... ;active or inactive
 ... ;
 ... S (IBPTAC,IBPTIC)=0 D  S $P(IBPTHOLD,U,9)=IBPTAC,$P(IBPTHOLD,U,10)=IBPTIC
 ... . ;
 ... . I 'IBEFFDT!($P(IBPTHOLD,U,5)="") S IBPTIC=1 Q  ; if not a valid effective date count inactive
 ... . ;
 ... . I (IBEXPDT'=""&($P(IBPTHOLD,U,6)'="")) D  Q  ; if there is a valid expiration date
 ... .. ;
 ... .. I IBEXPDT<DT S IBPTIC=1 Q  ; if the expiration date is less than today count inactive
 ... .. ;
 ... .. S IBPTAC=1  ; otherwise count active
 ... . ;
 ... . I (IBEFFDT&($P(IBPTHOLD,U,5)'="")&(IBEFFDT>DT)) S IBPTIC=1 Q  ; if a valid effective date and the date is greater than today count inactive
 ... . ;
 ... . S IBPTAC=1  ; otherwise count active
 ... . ;
 ... ; if pt policy is not active skip
 ... I IBPTAC'=1&(IBPTACTV'=2&(IBPTACTV'=3)) Q
 ... I IBPTAC=1&(IBPTACTV'=1&(IBPTACTV'=3)) Q
 ... ;
 ... I $G(^TMP("IBCNINSUL",$J,"OUT",IBINS,IBPTPLAN))="" D  ; make sure that plan info is returned
 ... . S ^TMP("IBCNINSUL",$J,"OUT",IBINS,IBPTPLAN)=$G(^TMP("IBCNINSUL",$J,"PLAN",IBPLNTYP,IBPTPLAN))
 ... . ;
 ... S ^TMP("IBCNINSUL",$J,"OUT",IBINS,IBPTPLAN,IBPTDFN,IBPTINS)=IBPTHOLD
 ;
INSSUBQ ; exit point for ins, plan, subscriber collect
 ;
 K @IBRET M @IBRET=^TMP("IBCNINSUL",$J,"OUT")
 ;
 ; clean up temp file
 K ^TMP("IBCNINSUL",$J)
 Q
 ;
 ;
DTC5(IBDTCK) ; check date return external with 4 digit year if valid
 ;
 N IBDT,IBBK S IBDT=""
 I 'IBDTCK G DTCO
 S IBDT=$$FMTE^XLFDT(IBDTCK,"5DZ")
 ;
 G DTCO
 ;
DTCO ; date check exit
 ;
 Q IBDT
 ;
IER(IBMS) ; set error return
 ;
 I IBMS="" Q
 I IBLER="" Q
 S @IBLER=IBMS
 Q
 ;
