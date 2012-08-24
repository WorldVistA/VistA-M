IBCAPP1 ;ALB/WCJ - Claims Auto Processing Utilities;27-AUG-10
 ;;2.0;INTEGRATED BILLING;**432,447**;21-MAR-94;Build 80
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 G AWAY
AWAY Q
 ;
 ; Borrowed heavily from the Medicare auto processing 
CRIT(IBIFN,IBEOB) ; Function to determine if a claim meets the criteria for auto-authorization and
 ; secondary/tertiary claim submission for NON MEDICARE claims
 ;
 ; Input:  IBIFN - internal entry number for an entry in 399
 ;         IBEOB - by reference to it can be returned
 ; Output:  This function returns a pieced string
 ;          [1] 0 or 1, EOB meets criteria
 ;          [2] error message if the first piece is 0
 ;
 ; The IB system shall automatically generate a non-Medicare secondary/tertiary claim to the next payer on
 ; the claim when all services lines on the previous EOB(s) meet the following criteria:
 ;
 ; Adjustment group code of CO is associated with one of the following reason codes:
 ; A2; B6; 42; 45; 102; 104; 118; 131; 23; 232; 44; 59; 94; 97; or 10
 ; Patient Responsibility group code of PR is associated with one of the following reason codes:
 ; 1; 2; or 66 
 ; The sum of the deductible, coinsurance and co-payment amounts is greater than $0.00
 ; The claim status is Approved; and
 ; The CLP02 equals one of the following:1; 2; or 3
 N IB0,IBCT,IBI,IBILLCNT,IBPTRESP,IBSHEOB,REASON,Z,ERR
 S OK=0,REASON="Unknown",IBEOB=0
 ;
 ; Check the parameter value (Make sure this bad boy is turned on).
 I '+IBIFN S REASON="IB807:Need to pass in an internal claim number" G CRITX
 ;
 ; Check the parameter value (Make sure this baby is turned on).
 I '$P($G(^IBE(350.9,1,8)),U,17) S REASON="IB800:Automatic EOB Processing parameter is turned off.  File 350.9, Field 8.17." G CRITX
 ;
 ; Quit if we don't have any EOBs
 I '$D(^IBM(361.1,"B",IBIFN)),'$D(^IBM(361.1,"C",IBIFN)) S REASON="IB801:No EOB Data Found" G CRITX
 ;
 ; Let's go get us some EOBs
 S IBCT=0,IBI=0
 F  S IBI=$O(^IBM(361.1,"B",IBIFN,IBI)) Q:'IBI  D
 . S IB0=$G(^IBM(361.1,IBI,0))
 . Q:IB0=""
 . Q:$P(IB0,U,4)'=0  ; do not care about MRAs, only EOBs
 . S Z=+$O(^IBM(361.1,IBI,8,0))
 . I '$O(^IBM(361.1,IBI,8,Z)) S IBCT=IBCT+1,IBSHEOB(IBI)=0  ; Entire EOB belongs to the bill
 ;
 S IBI=0
 F  S IBI=$O(^IBM(361.1,"C",IBIFN,IBI)) Q:'IBI  D
 . S IB0=$G(^IBM(361.1,IBI,0))
 . Q:IB0=""
 . Q:$P(IB0,U,4)'=0  ; do not care about MRAs, only EOBs
 . I '$D(IBSHEOB(IBI)) S IBCT=IBCT+1 ; don't count it twice
 . S IBSHEOB(IBI)=1 ; EOB has been reapportioned at the site
 ;
 I '$D(IBSHEOB) S ERR=1,REASON="IB801:No EOB Data Found" G CRITX
 I $G(IBCT)>1 S ERR=1,REASON="IB802:Multiple EOBs found for this claim" G CRITX
 ;
 ; only one EOB
 S ERR=0
 S IBEOB=$O(IBSHEOB(0))
 ;
 I $D(^IBM(361.1,IBEOB,"ERR")) S REASON="IB803:EOB Filing Errors" G CRITX
 ;
 S IB0=$G(^IBM(361.1,IBEOB,0))
 I $P(IB0,U,13)'=1 S REASON="IB804:Claim Status must be PROCESSED" G CRITX
 ;
 ; If this EOB is a split EOB, then don't allow it
 I $$SPLIT^IBCEMU1(IBEOB) S REASON="IB805:Claim level remark code MA15 received.  Multiple EOBs." G CRITX
 ;
 ; More than one claim on this EOB
 S Z=0 F  S Z=$O(^IBM(361.1,IBEOB,8,Z)) Q:'Z  I $P($G(^IBM(361.1,IBEOB,8,Z,0)),U,3)'=IBIFN S REASON="IB809:EOB Split to more claims" G CRITX
 ;
 ; Call the function that checks the claim level and/or line level
 ; adjustments for this EOB
 I '$$CAS(IBEOB,"B",.REASON) S REASON="IB808:Failed adjustment criteria selection" G CRITX  ; "B" for both
 ;
 ; Make sure the balance remaining amount is greater than $0 IB*2.0*447
 S IBPTRESP=$$TOT^IBCECOB2(IBIFN,1)
 I IBPTRESP'>0 S REASON="IB806:Balance remaining dollar amount is less than or equal to $0" G CRITX
 ;
 ; At this point, we're OK
 S OK=1,REASON=""
 ;
CRITX ;
 ;
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
 ;;CO;A2,B6,42,45,102,104,118,131,23,232,44,59,94,97,10
 ;;PR;1,2,66
 ;
