IBCNBMI ;ALB/ARH-Ins Buffer: move buffer data to insurance files ;09 Mar 2005  11:42 AM
 ;;2.0;INTEGRATED BILLING;**82,184,246,251,299,345,361,371,413,416**;21-MAR-94;Build 58
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
INS(IBBUFDA,IBINSDA,TYPE,RESULT) ;  move buffer insurance company data (file 355.33) to existing Insurance Company (file 36)
 ;
 S IBBUFDA=IBBUFDA_",",IBINSDA=$G(IBINSDA)_","
 D SET("INS",IBBUFDA,IBINSDA,TYPE,.RESULT)
 Q
 ;
GRP(IBBUFDA,IBGRPDA,TYPE,RESULT) ;  move buffer insurance group/plan data (file 355.33) to existing Group/Plan (file 355.33)
 ;
 S IBBUFDA=IBBUFDA_",",IBGRPDA=$G(IBGRPDA)_","
 D SET("GRP",IBBUFDA,IBGRPDA,TYPE,.RESULT)
 D STUFF("GRP",IBGRPDA,.RESULT)
 Q
 ;
POLICY(IBBUFDA,IBPOLDA,TYPE,RESULT) ;  move buffer insurance policy data (file 355.33) to existing Patient Policy (file 2.312)
 ;
 N DFN S DFN=+$G(^IBA(355.33,+$G(IBBUFDA),60)) Q:'DFN
 ;
 S IBBUFDA=IBBUFDA_",",IBPOLDA=$G(IBPOLDA)_","_DFN_","
 D SET("POL",IBBUFDA,IBPOLDA,TYPE,.RESULT)
 D STUFF("POL",IBPOLDA,.RESULT)
 D POLOTH(IBBUFDA,IBPOLDA,.RESULT)
 Q
 ;
SET(SET,IBBUFDA,IBEXTDA,TYPE,RESULT) ; move buffer data to insurance files
 ; Input:  IBBUFDA - ifn of Buffer File entry to move (#355.33)
 ;         IBEXTDA - ifn of insurance entry to update (#36,355.3,2)
 ;         TYPE    - 1 = Merge     (only buffer data moved to blank fields in ins file, no replace)
 ;                   2 = Overwrite (all buffer data moved to ins file, replace existing data)
 ;                   3 = Replace (all buffer data including null move to ins file)
 ;                   4 = Individually Accept (Skip Blanks) (user accepts
 ;  individual diffs b/w buffer data and existing file data (excl blanks)
 ;  to overwrite flds (or addr grp) in existing file)
 ; Output: RESULT - Passed array to return FM errror message if there are
 ;                  errors when filing the buffer data
 ;
 N IBX,IBFLDS,EXTFILE,DRBUF,DREXT,BUFARR,EXTARR,IBBUFFLD,IBEXTFLD,IBBUFVAL,IBEXTVAL,IBCHNG,IBCHNGN,IBERR
 ;
 D FIELDS(SET_"FLD")
 S IBX=$P($T(@(SET_"DR")+1),";;",2),EXTFILE=+$P(IBX,U,1),DRBUF=$P(IBX,U,2),DREXT=$P(IBX,U,3)
 ;
 D GETS^DIQ(355.33,IBBUFDA,DRBUF,"E","BUFARR")
 D GETS^DIQ(EXTFILE,IBEXTDA,DREXT,"E","EXTARR")
 ;
 I +$G(TYPE) S IBBUFFLD=0 F  S IBBUFFLD=$O(BUFARR(355.33,IBBUFDA,IBBUFFLD)) Q:'IBBUFFLD  D
 . ;If not called by ACCEPAPI^IBCNICB API, don't update from these 
 . ;fields:
 . ;   Insurance Company Name - #20.01, Reimburse? - 20.05
 . ;   Is this a Group Policy - #40.01
 . I $G(IBSUPRES)'>0,"^20.01^20.05^40.01^"[("^"_IBBUFFLD_"^") Q
 . ;
 . S IBEXTFLD=$G(IBFLDS(IBBUFFLD)) Q:'IBEXTFLD
 . S IBBUFVAL=BUFARR(355.33,IBBUFDA,IBBUFFLD,"E")
 . S IBEXTVAL=$G(EXTARR(EXTFILE,IBEXTDA,IBEXTFLD,"E"))
 . ;
 . I IBBUFVAL=IBEXTVAL Q
 . I TYPE=1,IBEXTVAL'="" Q
 . I TYPE=2,IBBUFVAL="" Q
 . I TYPE=4,'$D(^TMP($J,"IB BUFFER SELECTED",IBBUFFLD)) Q
 . ;
 . S IBCHNG(EXTFILE,IBEXTDA,IBEXTFLD)=IBBUFVAL
 . ;For ACCEPAPI^IBCNICB do not delete the .01 field. This prevents a
 . ;Data Dictionary Deletion Write message
 . Q:IBEXTFLD=".01"
 . S IBCHNGN(EXTFILE,IBEXTDA,IBEXTFLD)=""
 ;
 I $D(IBCHNGN)>9 D FILE^DIE("E","IBCHNGN","IBERR")
 ;Removed delete errors and move FM errors to RESULT
 D:$D(IBERR)>0 REMOVDEL(.IBERR),EHANDLE(SET,.IBERR,.RESULT)
 K IBERR
 I $D(IBCHNG)>9 D FILE^DIE("E","IBCHNG","IBERR")
 ;Move FM errors to RESULT
 D:$D(IBERR)>0 EHANDLE(SET,.IBERR,.RESULT)
 Q
 ;
STUFF(SET,IBEXTDA,RESULT) ; update fields in insurance files that 
 ;should be automatically set when an entry is edited
 ; Input:  IBEXTDA - ifn of insurance entry to update (#36,356,2)
 ; Output: RESULT - Passed array to return FM errror message if there are
 ;                  errors when filing the data buffer data
 ;
 N IBX,IBFLDS,EXTFILE,IBEXTFLD,IBEXTVAL,IBCHNG,IBCHNGN,IBERR
 ;
 D FIELDS(SET_"A")
 S IBX=$P($T(@(SET_"DR")+1),";;",2),EXTFILE=+$P(IBX,U,1)
 ;
 S IBEXTFLD=0 F  S IBEXTFLD=$O(IBFLDS(IBEXTFLD)) Q:'IBEXTFLD  D
 . S IBEXTVAL=IBFLDS(IBEXTFLD) I IBEXTVAL="DUZ" S IBEXTVAL="`"_DUZ
 . S IBCHNG(EXTFILE,IBEXTDA,IBEXTFLD)=IBEXTVAL
 . S IBCHNGN(EXTFILE,IBEXTDA,IBEXTFLD)=""
 ;
 D FILE^DIE("E","IBCHNGN","IBERR")
 ;Move FM errors to RESULT
 D:$D(IBERR)>0 EHANDLE(SET,.IBERR,.RESULT)
 K IBERR
 D FILE^DIE("E","IBCHNG","IBERR")
 ;Move FM errors to RESULT
 D:$D(IBERR)>0 EHANDLE(SET,.IBERR,.RESULT)
 Q
 ;
FIELDS(SET) ; return array of corresponding fields: IBFLDS(Buffer #)=Ins #
 N IBI,IBLN,IBB,IBE,IBG K IBFLDS,IBADDS,IBLBLS
 F IBI=1:1 S IBLN=$P($T(@(SET)+IBI),";;",2) Q:IBLN=""  I $E(IBLN,1)'=" " D
 . S IBB=$P(IBLN,U,1),IBE=$P(IBLN,U,2),IBG=$P(IBLN,U,4)
 . I IBB'="",IBE'="" D
 .. S IBFLDS(IBB)=IBE
 .. I SET["FLD" S IBLBLS(IBB)=$P(IBLN,U,3) I +IBG S IBADDS(IBB)=IBE
 Q
 ;
INSDR ;
 ;;36^20.01:20.05;21.01:21.06^.01;.131;.132;.133;.111:.116;1
INSFLD ; corresponding fields: Buffer File (355.33) & Insurance Company file (36)
 ;;20.01^.01^Insurance Company Name^  ; Name
 ;;20.02^.131^Phone Number^           ; MM Phone Number
 ;;20.03^.132^Billing Phone^          ; Billing Phone Number
 ;;20.04^.133^Pre-Cert Phone^         ; Pre-Certification Phone Number
 ;;20.05^1^Reimburse?^                ; Will Reimburse?
 ;;21.01^.111^Street [Line 1]^1       ; MM Street Address [Line 1]
 ;;21.02^.112^Street [Line 2]^1       ; MM Street Address [Line 2]
 ;;21.03^.113^Street [Line 3]^1       ; MM Street Address [Line 3]
 ;;21.04^.114^City^1                  ; MM City
 ;;21.05^.115^State^1                 ; MM State
 ;;21.06^.116^Zip^1                   ; MM Zip Code
 ;
GRPDR ;
 ;;355.3^40.01:40.09;40.1;40.11;^.02:.09;6.02;6.03;.12
GRPFLD ;corresponding fields:  Buffer File (355.33) and Insurance Group Plan file (355.3)
 ;;40.01^.02^Is This a Group Policy?^ ; Is this a Group Policy?
 ;;40.02^.03^Group Name^              ; Group Name
 ;;40.03^.04^Group Number^            ; Group Number
 ;;40.1^6.02^BIN^                     ; BIN ;;Daou/EEN
 ;;40.11^6.03^PCN^                    ; PCN ;;Daou/EEN
 ;;40.04^.05^Require UR^              ; Utilization Review Required
 ;;40.05^.06^Require Pre-Cert^        ; Pre-Certification Required
 ;;40.06^.12^Require Amb Cert^        ; Ambulatory Care Certification
 ;;40.07^.07^Exclude Pre-Cond^        ; Exclude Pre-Existing Conditions
 ;;40.08^.08^Benefits Assign^         ; Benefits Assignable
 ;;40.09^.09^Type of Plan^            ; Type of Plan
 ;
GRPA ; auto set fields
 ;;1.05^NOW^                          ; Date Last Edited
 ;;1.06^DUZ^                          ; Last edited By
 ;
POLDR ;
 ;;2.312^60.02:62.06^8;3;1;6;16;17;3.01;3.05:3.1;4.01;4.02;.2;3.12;2.1;2.015;2.11;2.12;2.01:2.08;5.01
POLFLD ; corresponding fields:  Buffer File (355.33) and Insurance Patient Policy file (2.312)
 ;;60.02^8^Effective Date^            ; Effective Date
 ;;60.03^3^Expiration Date^           ; Expiration Date
 ;;60.04^1^Subscriber Id^             ; Subscriber Id
 ;;60.05^6^Whose Insurance^           ; Whose Insurance
 ;;60.06^16^Relationship^             ; Pt. Relationship to Insured
 ;;60.07^17^Name of Insured^          ; Name of Insured
 ;;60.08^3.01^Insured's DOB^          ; Insured's DOB
 ;;60.09^3.05^Insured's SSN^          ; Insured's SSN
 ;;60.1^4.01^Primary Provider^        ; Primary Care Provider
 ;;60.11^4.02^Provider Phone^         ; Primary Care Provider Phone
 ;;60.12^.2^Coor of Benefits^         ; Coordination of Benefits
 ;;60.13^3.12^Insured's Sex^          ; Insured's Sex
 ;;  
 ;;61.01^2.1^Emp Sponsored^           ; ESGHP?
 ;;61.02^2.015^Employer Name^         ; Subscriber's Employer Name
 ;;61.03^2.11^Emp Status^             ; Employment Status
 ;;61.04^2.12^Retirement Date^        ; Retirement Date
 ;;61.05^2.01^Send to Employer^       ; Send Bill to Employer?
 ;;61.06^2.02^Emp Street Ln 1^1       ; Employer Claims Street Line 1
 ;;61.07^2.03^Emp Street Ln 2^1       ; Employer Claims Street Line 2
 ;;61.08^2.04^Emp Street Ln 3^1       ; Employer Claims Street Line 3
 ;;61.09^2.05^Emp City^1              ; Employer Claims City
 ;;61.1^2.06^Emp State^1              ; Employer Claims State
 ;;61.11^2.07^Emp Zip Code^1          ; Employer Claims Zip Code
 ;;61.12^2.08^Emp Phone^              ; Employer Claims Phone
 ;;62.01^5.01^Patient Id^             ; Patient Id
 ;;62.02^3.06^Subscr Addr Ln 1^       ; Subscriber Address Line 1
 ;;62.03^3.07^Subscr Addr Ln 2^       ; Subscriber Address Line 2
 ;;62.04^3.08^Subscr City^            ; Subscriber City
 ;;62.05^3.09^Subscr State^           ; Subscriber State
 ;;62.06^3.1^Subscr Zip^              ; Subscriber Zip Code
 ;
POLA ; auto set fields
 ;;1.03^NOW^                          ; Date Last Verified (default is person that accepts entry)
 ;;1.04^DUZ^                          ; Verified By        (default is person that accepts entry)
 ;;1.05^NOW^                          ; Date Last Edited
 ;;1.06^DUZ^                          ; Last Edited By
 ;
 ;
POLOTH(IBBUFDA,IBPOLDA,RESULT) ; other special cases that can not be transferred using the generic code above, usually because of dependencies
 N IBERR,IB0 S IB0=$G(^IBA(355.33,+IBBUFDA,0))
 ;
 ;  --- if buffer entry was verified before the accept step, then add the correct verifier info to the policy
 I +$P(IB0,U,10) D
 . S IBCHNG(2.312,IBPOLDA,1.03)=$E($P(IB0,U,10),1,12),IBCHNGN(2.312,IBPOLDA,1.03)=""
 . S IBCHNG(2.312,IBPOLDA,1.04)=$P(IB0,U,11),IBCHNGN(2.312,IBPOLDA,1.04)=""
 ;
 I $D(IBCHNGN)>9 D FILE^DIE("I","IBCHNGN","IBERR")
 ;Move FM errors to RESULT
 D:$D(IBERR)>0 EHANDLE("POL",.IBERR,.RESULT)
 K IBERR
 I $D(IBCHNG)>9 D FILE^DIE("I","IBCHNG","IBERR")
 ;Move FM errors to RESULT
 D:$D(IBERR)>0 EHANDLE("POL",.IBERR,.RESULT)
 Q
 ;
PAT(DFN,IBPOLDA) ; Force DOB, SSN & SEX from Patient file (#2) in to Insurance Patient Policy file (2.312)
 N DA,DR,DIE,DOB,SSN,SEX,IENS,WI
 S IENS=IBPOLDA_","_DFN_","
 S WI=$$GET1^DIQ(2.312,IENS,6,"I")
 I WI'="v" Q  ; Only use when Whose Insurance is 'v'
 S DOB=$$GET1^DIQ(2,DFN,.03,"I")
 S SSN=$$GET1^DIQ(2,DFN,.09,"I")
 S SEX=$$GET1^DIQ(2,DFN,.02,"I")
 S DIE="^DPT("_DFN_",.312,",DA(1)=DFN,DA=IBPOLDA
 S DR="3.01///^S X=DOB;3.05///^S X=SSN;3.12///^S X=SEX"
 D ^DIE
 Q
 ;
EHANDLE(SET,FMERR,RESULT) ;
 ;Fileman Error Processing tracking added for ACCEPAPI^IBCNICB API.
 ; INPUT: 
 ;   SET    - File where fileman error occurred
 ;       Value = "INS" --> File 36    --> RESULT(1)
 ;       Value = "GRP" --> File 355.3 --> RESULT(2)
 ;       Value = "POL" --> File 2.312 --> RESULT(3)
 ;   FMERR  - Array that is returned by FM with error messages
 ; OUTPUT:
 ;   RESULT - Passed array to return FM errror message if there are
 ;            errors when filing the data buffer data
 ;
 Q:$G(SET)']""!($D(FMERR)'>0)
 N SUB1,RNUM,ERRNUM,LINENUM
 ;Numeric 1st subscript of RESULT array based on file being updated
 ;File 36 = 1, 355.3 = 2, 2.312 = 3 
 S SUB1=$S(SET="INS":1,SET="GRP":2,SET="POL":3,1:"")
 ;Quit if SUB1 doesn't have a value.
 Q:SUB1']""
 S RNUM=$O(RESULT(SUB1,"ERR",9999999999),-1),ERRNUM=0
 F  S ERRNUM=$O(FMERR("DIERR",ERRNUM)) Q:+ERRNUM'>0  D
 . S LINENUM=0
 . F  S LINENUM=$O(FMERR("DIERR",ERRNUM,"TEXT",LINENUM)) Q:+LINENUM'>0  D
 . . S RNUM=RNUM+1
 . . S RESULT(SUB1,"ERR",RNUM)=FMERR("DIERR",ERRNUM,"TEXT",LINENUM)
 Q
 ;
REMOVDEL(FMERR) ;
 ;Removed field delete errors. SET and STUFF API delete data first and
 ;then update with new data from Insurance Buffer file. Error Code 712
 ;"Deletion was attempted but not allowed" errors will be removed from
 ;the returned FM error array 
 ; INPUT/OUTPUT:
 ;   FMERR  - Array that is returned by FM with error messages
 ;
 Q:$D(FMERR)'>0
 N ERRNUM
 S ERRNUM=0
 F  S ERRNUM=$O(FMERR("DIERR",ERRNUM)) Q:+ERRNUM'>0  D
 . I FMERR("DIERR",ERRNUM)=712 K FMERR("DIERR",ERRNUM)
 Q
