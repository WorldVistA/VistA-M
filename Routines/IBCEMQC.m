IBCEMQC ;ALB/ESG - MRA EOB CRITERIA FOR AUTO-AUTHORIZE ; 11/1/06 10:34am
 ;;2.0;INTEGRATED BILLING;**155,323,302,350,359**;21-MAR-94;Build 9
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 Q   ; must be called at proper entry point
 ;
CRIT(IBEOB) ; Function to determine if EOB entry meets the criteria for
 ; auto-authorization and secondary claim submission
 ;
 ; Input:  IBEOB - internal entry number for an entry in 361.1
 ;
 ; Output:  This function returns a pieced string
 ;          [1] 0 or 1, EOB meets criteria
 ;          [2] error message if the first piece is 0
 ;
 NEW IBM,IBM3,IBM5,IBIFN,PCE,REMC,Z,OK,REASON,STOP,IBPTRESP
 ;
 S OK=0,REASON="Unknown",IBEOB=+$G(IBEOB)
 ;
 S IBM=$G(^IBM(361.1,IBEOB,0)) I IBM="" S REASON="No EOB Data Found" G CRITX
 I $D(^IBM(361.1,IBEOB,"ERR")) S REASON="Filing Errors" G CRITX
 I $P(IBM,U,13)'=1 S REASON="Claim Status is "_$$GET1^DIQ(361.1,IBEOB_",",.13)_".  It must be PROCESSED." G CRITX
 ;
 I $P(IBM,U,4)'=1 S REASON="The EOB Type is not Medicare MRA" G CRITX
 ;
 ; If any other MRA's on file for this bill failed the auto-generation
 ; check, then this MRA must also fail the check
 S IBIFN=+IBM,Z=0,STOP=0
 F  S Z=$O(^IBM(361.1,"B",IBIFN,Z)) Q:'Z  D  Q:STOP
 . I Z=IBEOB Q             ; check different EOB records if they exist
 . I $P($G(^IBM(361.1,Z,0)),U,4)'=1 Q     ; must be an MRA
 . I $P($G(^IBM(361.1,Z,30)),U,1)="" Q    ; no problems recorded
 . S REASON="Another MRA for this bill (ien="_Z_") failed the auto-generation criteria check."
 . S STOP=1
 . Q
 I STOP G CRITX
 ;
 ; If this EOB is a split EOB, then don't allow it
 I $$SPLIT^IBCEMU1(IBEOB) S REASON="Claim level remark code MA15 received.  Multiple MRA's" G CRITX
 ;
 ; Call the function that checks the claim level and/or line level
 ; adjustments for this EOB
 I '$$CAS(IBEOB,"B",.REASON) G CRITX      ; "B" for both
 ;
 ; Make sure the patient responsibility amount for this MRA is greater than $0
 S IBPTRESP=$P($G(^IBM(361.1,IBEOB,1)),U,2)      ; Pt Resp Amt 1.02 field
 I $$FT^IBCEF(IBIFN)=3 S IBPTRESP=$$PTRESPI^IBCECOB1(IBEOB)
 I IBPTRESP'>0 S REASON="Patient responsibility dollar amount is less than or equal to $0" G CRITX
 ;
 ; Check the parameter values last of all
 I '$P($G(^IBE(350.9,1,8)),U,11) S REASON="Automatic MRA Processing parameter is turned off.  File 350.9, Field 8.11." G CRITX
 I '$P($G(^IBE(350.9,1,8)),U,12) S REASON="Allow MRA Processing parameter is turned off.  File 350.9, Field 8.12." G CRITX
 ;
 ; At this point, we're OK
 S OK=1,REASON=""
 ;
CRITX ;
 Q OK_U_REASON
 ;
 ;
CAS(IBEOB,ADJFLAG,REASON) ; This function determines if the EOB
 ; adjustment group codes and reason codes from file 361.1 (either
 ; claim level or line level or both) meet the criteria for auto-
 ; authorization and secondary claim submission.
 ;
 ; Input Parameters
 ;        IBEOB    - ien of entry in file 361.1
 ;      ADJFLAG    - adjustment flag
 ;                   "C" - look at claim level adjustments only
 ;                   "L" - look at line level adjustments only
 ;                   "B" - look at both claim and line level adjustments
 ; Output Parameter
 ;       REASON    - error message describing why it failed
 ;
 ; Function Value is either 0 or 1, indicating if it passed the criteria
 ;
 NEW EOBADJ,OK,OKCOMBO,PATRESP,STOP,LNIEN
 ;
 S IBEOB=+$G(IBEOB)
 S ADJFLAG=$G(ADJFLAG,"B")     ; default is "B" if not passed in
 D BUILD           ; build the array of OK group/reason combinations
 S PATRESP=0       ; patient responsibility flag (default false)
 S STOP=0          ; Stop flag
 S OK=0            ; OK flag (function value)
 S REASON=""       ; error reason text
 ;
 ; claim level adjustments
 I $F(".C.B.","."_ADJFLAG_".") D
 . KILL EOBADJ
 . M EOBADJ=^IBM(361.1,IBEOB,10)
 . D ADJCHK
 . Q
 ;
 ; Get out if the claim level adjustments failed
 I STOP G CASX
 ;
 ; line level adjustments
 I $F(".L.B.","."_ADJFLAG_".") D
 . S LNIEN=0
 . F  S LNIEN=$O(^IBM(361.1,IBEOB,15,LNIEN)) Q:'LNIEN  D  Q:STOP
 .. KILL EOBADJ
 .. M EOBADJ=^IBM(361.1,IBEOB,15,LNIEN,1)
 .. D ADJCHK
 .. Q
 . Q
 ;
 ; Get out if the line level adjustments failed
 I STOP G CASX
 ;
 ; Get out if there was no patient responsibility adjustments found
 I 'PATRESP S REASON="No Patient Responsibility Adjustments found" G CASX
 ;
 ; At this point, we're OK
 S OK=1,REASON=""
CASX ;
 Q OK
 ;
 ;
ADJCHK ; This procedure checks the adjustments for this EOB.  The group codes
 ; and reason codes are in the EOBADJ array structures from file 361.1.
 ;
 ;   Variables STOP and REASON will be returned on an error
 ;   Variable PATRESP will be returned if a valid PR adjustment found
 ;
 NEW ADJIEN,GROUP,RSNIEN,RSNCODE
 S ADJIEN=0
 F  S ADJIEN=$O(EOBADJ(ADJIEN)) Q:'ADJIEN  D  Q:STOP
 . S GROUP=$P($G(EOBADJ(ADJIEN,0)),U,1)
 . I GROUP="LQ" Q      ; line level remark code kludge: 42 rec [3]
 . I GROUP="" S GROUP="<Undefined>"
 . I '$D(OKCOMBO(GROUP)) S STOP=1,REASON="Unacceptable Claim Adjustment Group Code: "_GROUP Q
 . S RSNIEN=0
 . F  S RSNIEN=$O(EOBADJ(ADJIEN,1,RSNIEN)) Q:'RSNIEN  D  Q:STOP
 .. S RSNCODE=$P($G(EOBADJ(ADJIEN,1,RSNIEN,0)),U,1)
 .. ;
 .. ; Ignore some special adjustment data that is filed with the MRA
 .. I GROUP="PR",RSNCODE="AAA" Q    ; Allowed Amount: 41 rec [3]
 .. I GROUP="OA",RSNCODE="AB3" Q    ; Covered Amount: 15 rec [3]
 .. ;
 .. I RSNCODE="" S RSNCODE="<Undefined>"
 .. I '$D(OKCOMBO(GROUP,RSNCODE)) S STOP=1,REASON="Unacceptable Reason Code ("_RSNCODE_") for Claim Adjustment Group Code ("_GROUP_")" Q
 .. ;
 .. ; Set the flag if the group is PR
 .. I GROUP="PR" S PATRESP=1
 .. Q
 . Q
ADJCHKX ;
 Q
 ;
 ;
BUILD ; This procedure builds the OKCOMBO array which identifies which
 ; combinations of group codes and reason codes are acceptable
 ;
 NEW LN,LINE,GROUP,RSNLST,R,RSN
 KILL OKCOMBO
 F LN=1:1 D  Q:$P(LINE,";",4)=""&$D(OKCOMBO)
 . S LINE=$T(OKCOMBO+LN)
 . S GROUP=$P(LINE,";",3) Q:GROUP=""
 . S RSNLST=$P(LINE,";",4) Q:RSNLST=""
 . F R=1:1:$L(RSNLST,",") D
 .. S RSN=$P(RSNLST,",",R) Q:RSN=""
 .. S OKCOMBO(GROUP,RSN)=""
 .. Q
 . Q
BUILDX ;
 Q
 ;
 ;
OKCOMBO ; This section lists OK combinations of adjustment category group codes
 ; and associated reason codes.
 ; The format is as follows - semi-colon delimiter
 ;     [3] Adjustment category (group code)
 ;     [4] List of acceptable reason codes - comma delimiter
 ;
 ; PR-AAA is created by VistA for the Allowed Amount
 ; OA-AB3 is created by VistA for the Covered Amount
 ; LQ-zzz is created by VistA for the Line Level remark
 ;
 ;;CO;A2,B6,42,45,172,94,194
 ;;PR;1,2,66,122,AAA
 ;;OA;AB3
 ;
