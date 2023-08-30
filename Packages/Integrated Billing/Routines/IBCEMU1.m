IBCEMU1 ;ALB/DSM - IB MRA Utility ;26-MAR-2003
 ;;2.0;INTEGRATED BILLING;**135,155,432,718,727,743**;21-MAR-94;Build 18
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
MRAUSR() ;; Function
 ; Returns IEN (Internal Entry Number) from file #200 for
 ; the Bill Authorizer of acceptable MRA secondary claims,
 ; namely, AUTHORIZER,IB MRA
 ;
 ; Output:    -1   if record not on file
 ;            IEN  if record is on file
 ;
 N DIC,X,Y
 S DIC(0)="MO",DIC="^VA(200,",X="AUTHORIZER,IB MRA"
 ; call FM lookup utility
 D ^DIC
 ; if record is already on file, return IEN
 ; else  return -1
 Q +Y
 ;
 ;
MRA(IBIFN) ; Utility driver procedure - this is what gets called
 I $$MRAEXIST(IBIFN) D PRINTMRA(IBIFN)
MRAX ;
 Q
 ;
 ;
MRAEXIST(IBIFN) ; This function determines if any MRA exists for the
 ; passed bill (IBIFN).
 ;
 ; This function is called from the IB package as well as the AR package.
 ;
 ; This function returns a true value (1) under the following
 ; conditions:
 ;
 ; - The current payer sequence is secondary or tertiary for the bill
 ; - Medicare WNR is a payer on the bill
 ; - At least one MRA EOB is on file for the bill
 ; - Medicare is primary, bill is 2nd/3rd
 ; - or, Medicare is secondary, bill is 3rd
 ;
 NEW OK,IBCOB,PRIMBILL
 S IBIFN=+$G(IBIFN)
 S OK=0
 I '$D(^DGCR(399,IBIFN,0)) G MRAEX         ; Check for valid bill
 S IBCOB=$$COBN^IBCEF(IBIFN)               ; Current payer sequence
 I IBCOB=1 G MRAEX                         ; Must be secondary or tert
 I '$$MCRONBIL^IBEFUNC(IBIFN) G MRAEX      ; Medicare not on bill
 ;
 ; If bill is secondary and Medicare is primary, then we know the bill#
 I IBCOB=2,$$WNRBILL^IBEFUNC(IBIFN,1) S OK=$$CHK(IBIFN) G MRAEX
 ;
 ; Similarly if bill is tert and Medicare is 2nd, then we know the bill#
 I IBCOB=3,$$WNRBILL^IBEFUNC(IBIFN,2) S OK=$$CHK(IBIFN) G MRAEX
 ;
 ; If bill is tert and Medicare is first, then we have to get the bill#
 I IBCOB=3,$$WNRBILL^IBEFUNC(IBIFN,1) D  G MRAEX
 . S PRIMBILL=+$P($G(^DGCR(399,IBIFN,"M1")),U,5)
 . I PRIMBILL S OK=$$CHK(PRIMBILL)
 . Q
 ;
MRAEX ;
 Q OK
 ;
CHK(IBIFN) ; This function returns 1 if there is at least 1 MRA EOB for
 ; this bill# in file 361.1.
 NEW OK,IEN
 S (OK,IEN)=0
 F  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  D  Q:OK
 . I $P($G(^IBM(361.1,IEN,0)),U,4)=1 S OK=1 Q
 . Q
CHKX ;
 Q OK
 ;
 ;
PRINTMRA(IBIFN) ; This procedure is called when the user is printing bills
 ; and we know that one or more MRA's exist for this bill.  We ask the
 ; user if the MRA(s) should be printed at this time too.
 ;
 NEW CNT,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT
 S IBIFN=+$G(IBIFN) I 'IBIFN G PRMRAX
 S CNT=$$MRACNT(IBIFN) I 'CNT G PRMRAX
 ;
 S DIR(0)="YO",DIR("B")="YES"
 S DIR("A",1)="There is an MRA associated with this bill."
 S DIR("A")="Do you want to print this MRA now"
 I CNT>1 D
 . S DIR("A",1)="There are "_CNT_" MRA's associated with this bill."
 . S DIR("A")="Do you want to print these MRA's now"
 . Q
 S DIR("?")="Please answer Yes or No.  If you answer Yes, then you will be asked to supply the output device and all MRA's associated with this bill will then be printed."
 W !!
 D ^DIR K DIR
 I 'Y G PRMRAX
 ;
 ; At this point, the user wants to print the MRA's
 D MRA^IBCEMRAA(IBIFN)
 ;
PRMRAX ;
 Q
 ;
 ;
MRACNT(IBIFN,IBMRANOT) ; This function counts up the number of MRA EOB's in file  ;WCJ IB*2.0*432
 ; 361.1 for this bill#
 NEW CNT,IEN
 S (CNT,IEN)=0
 F  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  D
 . I $P($G(^IBM(361.1,IEN,0)),U,4)'=$S($G(IBMRANOT):0,1:1) Q  ;WCJ IB*2.0*432
 . S CNT=CNT+1
 . Q
MRACNTX ;
 Q CNT
 ;
 ;WCJ;IB727;adding a parameter to return IB361.1 IENs of these split MRA's
 ;SPLTMRA(IBIFN) ; This function returns the number of Split MRA's for a 
SPLTMRA(IBIFN,IBMRARET) ; This function returns the number of Split MRA's for a
 ; given bill#.
 ; IBIFN = claim number
 ; IBMRARET = if passed in, return the 361.1 IENs
 ;
 NEW NUM,IEN
 S (NUM,IEN)=0
 ;  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  I $$SPLIT(IEN) S NUM=NUM+1  ;WCJ;IB727;
 F  S IEN=$O(^IBM(361.1,"B",+$G(IBIFN),IEN)) Q:'IEN  I $$SPLIT(IEN) S NUM=NUM+1 S IBMRARET(IEN)=""  ;WCJ;IB727;
SPLTX ;
 Q NUM
 ;
SPLIT(IBEOB) ; This function returns whether or not the given EOB is a
 ; split EOB as indicated in the claim level remark code.
 ; Check the remittance advice remark codes looking for code MA15.  This
 ; code indicates that the claim has been separated to expedite
 ; handling.  This means that this is an incomplete EOB.
 ;
 NEW SPLIT,IBM3,IBM5,PCE,REMC
 S SPLIT=0,IBEOB=+$G(IBEOB)
 S IBM3=$G(^IBM(361.1,IBEOB,3))
 S IBM5=$G(^IBM(361.1,IBEOB,5))
 F PCE=3:1:7 S REMC=$P(IBM3,U,PCE) I REMC="MA15" S SPLIT=1 Q
 I SPLIT G SPLITX
 F PCE=1:1:5 S REMC=$P(IBM5,U,PCE) I REMC="MA15" S SPLIT=1 Q
 ;WCJ;IB*2.0*718;check new field for potential split
 I 'SPLIT,$$GET1^DIQ(361.1,IBEOB_",",.22,"I") S SPLIT=1
 ;
SPLITX ;
 Q SPLIT
 ;
SPLIT2(IBEOB,IBALLORONE) ; All lines Covered? aka SPLIT2
 ;
 ; This was written because a medicare claims processor couldn't follow simple agreed upon instructions.
 ; They were supposed to send an MA15 whenever an MRA was split, but they didn't.
 ; Consequently, VistA was sending out secondary claims with MRAs that only covered part of the original claim - an X12 violation
 ;
 ; This function is passed an MRA.
 ; depending on the second parameter
 ; It either 
 ; a) gets all the MRAs like it (same claim/payer #) and compares the lines on the claim to the lines in the MRAs 
 ;    to make sure every line is accounted for.
 ; or
 ; b) checks only the one passed into see if it covers all
 ;
 ; Passed in:
 ; IBEOB = the ien of the EOB entry in file 361.1
 ; also passed IBALLORONE - 1 checks just the IBEOB passed in
 ; anything else (or nothing) checks all the EOBS for the same claim number and payer sequence
 ;
 ; Returns -1 Couldn't tell (bad data?)
 ;          0 All lines not covered
 ;          1 All lines covered
 ;
 N IBIFN,IBFT,IBZDATA,IBLOOP,RESULT
 N IBLOOPEOB,IBLINE,IBFT,IBZDATA,IBLINE,IBPAYSEQ
 N IBXSAVE,IBXARRAY,IBXARRY,IBXERR,IBRC,IBMRAF   ; output formatter set these.  want this to be self-cleaning so added here.
 ;
 S RESULT=-1
 I '+$G(IBEOB) Q RESULT  ; no EOB sent in - off to a bad start
 ; 
 ; gotta be an MRA cause that's all we allow to be split so far
 Q:$$GET1^DIQ(361.1,IBEOB_",",.04,"I")'=1 RESULT
 ;
 ; must be PROCESSED or DENIED
 Q:".1.2."'[("."_$$GET1^DIQ(361.1,IBEOB_",",.13,"I")_".") RESULT
 ;
 ; filing errors - can't check ;WCJ;IB718;v21}
 I $D(^IBM(361.1,IBEOB,"ERR")) Q RESULT
 ;
 ; no lines returned so nothing to check if it's partial
 I '$D(^IBM(361.1,IBEOB,15)) Q RESULT ;WCJ;IB718;v21}
 ;
 ; get File 399 CLAIM #
 S IBIFN=$$GET1^DIQ(361.1,IBEOB_",",.01,"I")
 I '+IBIFN Q RESULT
 I $$INPAT^IBCEF(IBIFN,1),$$INSPRF^IBCEF(IBIFN) Q RESULT   ;logic does not work for inpatient institutional as they return at the claim level ;WCJ;IB718;v21
 ;
 ; call the appropriate OUTPUT FORMATTER FUNCTION to determine how many lines went out
 ; first get the form type
 S IBFT=$$GET1^DIQ(399,IBIFN_",",.19,"I")
 I 'IBFT Q RESULT
 ;
 ; only 3 valid form types but you already know that
 I ".2.3.7."'[("."_IBFT_".") Q RESULT
 ;
 I IBFT=3 D F^IBCEF("N-UB-04 SERVICE LINE (EDI)","IBZDATA",,IBIFN)
 I IBFT=2 D F^IBCEF("N-HCFA 1500 SERVICE LINE (EDI)","IBZDATA",,IBIFN)
 I IBFT=7 D F^IBCEF("N-HCFA SERVICE LINE CALLABLE","IBZDATA",,IBIFN)
 ;
 ; get payer sequence from the EOB
 S IBPAYSEQ=$$GET1^DIQ(361.1,IBEOB_",",.15,"I")
 I '+IBPAYSEQ Q RESULT
 ;
 S RESULT=1
 I '+$O(IBZDATA(0)) Q RESULT  ; no lines on the claim so technically they are all covered
 ;
 ; gets all the EOBs for that bill number
 S IBLOOPEOB=0
 F  S IBLOOPEOB=$O(^IBM(361.1,"B",IBIFN,IBLOOPEOB)) Q:'IBLOOPEOB  D  Q:RESULT=-1
 . I $G(IBALLORONE)=1,IBLOOPEOB'=IBEOB Q  ; only want to see if this one EOB fully covers claim
 . Q:$$GET1^DIQ(361.1,IBLOOPEOB_",",.04,"I")'=1  ; remember, only MRAs
 . Q:".1.2."'[("."_$$GET1^DIQ(361.1,IBLOOPEOB_",",.13,"I")_".")  ; must be PROCESSED or DENIED
 . Q:$$GET1^DIQ(361.1,IBLOOPEOB_",",.15,"I")'=IBPAYSEQ  ; must be for same payer seq as EOB passed in
 . ;WCJ;IB743;wrong variable as it kept checking the same EOB for filing errors
 .; I $D(^IBM(361.1,IBEOB,"ERR")) S RESULT=-1 Q  ; filing errors, can't tell
 . I $D(^IBM(361.1,IBLOOPEOB,"ERR")) S RESULT=-1 Q  ; filing errors, can't tell
 . S IBLINE=0
 . F  S IBLINE=$O(IBZDATA(IBLINE)) Q:'IBLINE  D
 .. I $D(^IBM(361.1,IBLOOPEOB,15,"AC",IBLINE)) K IBZDATA(IBLINE) ; remove the lines local array that are in an acceptable MRA
 ;
 ; This will be set if there were filing errors in any of the MRAs since you can't tell what processed
 I RESULT=-1 Q RESULT
 ;
 ; and voila
 ; if all lines are covered then there shouldn't be any left in the array
 ;
 Q:'$O(IBZDATA(0)) RESULT
 ;
 Q 0   ; no dice, we have lines left
 ;
 ;
EOBLST(IBEOB) ; Standard FileMan lister code for entries in the EOB file
 ; Input parameter IBEOB is the IEN into file 361.1
 ; This can be used by setting DIC("W")="D EOBLST^IBCEMU1(Y)" prior
 ; to FileMan lister calls.
 ;
 NEW IBM,IBIFN,IB,PATNAME,INSCO,SEQ
 NEW EOBDT,EOBTYP,CLMSTAT
 S IBM=$G(^IBM(361.1,IBEOB,0))
 S IBIFN=+IBM
 S IB=$G(^DGCR(399,IBIFN,0))
 S PATNAME=$P($G(^DPT(+$P(IB,U,2),0)),U,1)
 S INSCO=" "_$$EXTERNAL^DILFD(361.1,.02,,$P(IBM,U,2))
 S SEQ=$E($$EXTERNAL^DILFD(361.1,.15,,$P(IBM,U,15)),1,3)
 S EOBDT=" "_$$FMTE^XLFDT($P($P(IBM,U,6),".",1),"2Z")
 S EOBTYP=" "_$P("EOB^MRA",U,$P(IBM,U,4)+1)
 S CLMSTAT=" "_$$EXTERNAL^DILFD(361.1,.13,"",$P(IBM,U,13))
 W $E(PATNAME,1,19)," (",$E(SEQ),")",$E(INSCO,1,17),?56,EOBDT
 W ?66,EOBTYP,?70,CLMSTAT
EOBLSTX ;
 Q
 ;
SEL(IBIFN,MRAONLY,IBDA) ; Function to display and allow user selection
 ; of an EOB/MRA on file in 361.1 for the given bill.
 ;
 ; Input:  IBIFN   - internal bill number (required)
 ;         MRAONLY - 1 if only MRA EOB's should be included here
 ;         IBDA    - list entry number of user selection (optional)
 ;
 ; Function Value:  IEN to file 361.1 or nil if no selection made
 ;
 NEW IBEOB,EOBDATE,COUNT,IEN,IBM,INSCO,SEQ,EOBDT,EOBTYP,CLMSTAT,LIST
 NEW J,A,DIR,X,Y,DTOUT,DUOUT,DIRUT,DIROUT,IBM1
 S IBEOB="",IBIFN=+$G(IBIFN),EOBDATE=0,COUNT=0,IBDA=+$G(IBDA)
 F  S EOBDATE=$O(^IBM(361.1,"ABD",IBIFN,EOBDATE)) Q:'EOBDATE  D
 . S IEN=0
 . F  S IEN=$O(^IBM(361.1,"ABD",IBIFN,EOBDATE,IEN)) Q:'IEN  D
 .. S IBM=$G(^IBM(361.1,IEN,0))
 .. I '$G(IBMRANOT),$G(MRAONLY),'$P(IBM,U,4) Q     ; mra only check
 .. I $G(IBMRANOT),$G(MRAONLY),$P(IBM,U,4) Q     ; EOB only check
 .. S INSCO=$$EXTERNAL^DILFD(361.1,.02,,$P(IBM,U,2))
 .. S SEQ=$E($$EXTERNAL^DILFD(361.1,.15,,$P(IBM,U,15)),1)
 .. S EOBDT=$$FMTE^XLFDT($P($P(IBM,U,6),".",1),"2Z")
 .. S EOBTYP=$P("EOB^MRA",U,$P(IBM,U,4)+1)
 .. S CLMSTAT=$$EXTERNAL^DILFD(361.1,.13,"",$P(IBM,U,13))
 .. S COUNT=COUNT+1
 .. S LIST(COUNT)=IEN_U_SEQ_U_INSCO_U_EOBDT_U_EOBTYP_U_CLMSTAT
 .. Q
 . Q
 ;
 I 'COUNT G SELX                           ; no mra/eob data found
 ;
 ; Display mra/eob data
 S J="EOB's/MRA's"
 ;I $G(MRAONLY) S J="MRA's"
 S:$G(IBMRANOT)'=1 J="MRA's"
 I COUNT>1 W !!,"The selected bill has multiple ",J," on file.  Please choose one."
 W !!?7,"#",?11,"Seq",?17,"Insurance Company",?40,"EOB Date"
 W ?51,"Type",?57,"Claim Status"
 F J=1:1:COUNT S A=LIST(J) D
 . W !?5,$J(J,3),?11,"(",$P(A,U,2),")",?17,$E($P(A,U,3),1,20)
 . W ?40,$P(A,U,4),?51,$P(A,U,5),?57,$P(A,U,6)
 . Q
 ;
 ; User Selection
 W ! S DIR(0)="NO^1:"_COUNT,DIR("A")="Select an EOB/MRA"
 ;I $G(MRAONLY) S DIR("A")="Select an MRA"
 S:$G(IBMRANOT)'=1 DIR("A")="Select an MRA"
 D ^DIR K DIR
 I 'Y G SELX    ; no selection made
 S IBEOB=+$G(LIST(Y))
 ;
 ; At this point we need to update the scratch globals with this
 ; EOB specific data
 S IBM=$G(^IBM(361.1,IBEOB,0)) I IBM="" G SELX
 S IBM1=$G(^IBM(361.1,IBEOB,1))
 ;
 I IBDA,$P($G(^TMP("IBCECOB",$J,IBDA)),U,2)=IBIFN D
 . S $P(^TMP("IBCECOB",$J,IBDA),U,3)=$P(IBM,U,19)    ; ptr 364
 . S $P(^TMP("IBCECOB",$J,IBDA),U,4)=IBEOB           ; 361.1 ien
 . Q
 ;
 I IBDA,$D(^TMP("IBCECOB1",$J,IBDA)) D
 . S $P(^TMP("IBCECOB1",$J,IBDA),U,10)=IBEOB         ; 361.1 ien
 . S $P(^TMP("IBCECOB1",$J,IBDA),U,13)=$P(IBM,U,6)   ; eob paid date
 . S $P(^TMP("IBCECOB1",$J,IBDA),U,15)=$P(IBM,U,19)  ; ptr 364
 . S $P(^TMP("IBCECOB1",$J,IBDA),U,16)=$P(IBM,U,15)  ; ins seq
 . S $P(^TMP("IBCECOB1",$J,IBDA),U,17)=$P(IBM1,U,1)  ; payer paid amt
 . Q
SELX ;
 Q IBEOB
 ;
 ;
CHKSUM(IBARRAY) ; Incoming 835 checksum calculation
 ; This function calculates the checksum of the raw 835 data from
 ; the data in array IBARRAY.  This is done to prevent duplicates.
 ; Input parameter IBARRAY is the array reference where the data exists
 ;    at @IBARRAY@(n,0) where n is a sequential #
 ; For file 364.2, IBARRAY = "^IBA(364.2,IBIEN,2)" where IBIEN = the ien
 ;    of the entry in file 364.2 being evaluated
 ;
 NEW Y,LN,DATA,IBREC,POS,EOBFLG
 S Y=0,EOBFLG=0
 S LN=0
 F  S LN=$O(@IBARRAY@(LN)) Q:'LN  D
 . S DATA=$$EXT($G(@IBARRAY@(LN,0))) Q:DATA=""
 . S IBREC=$P(DATA,U,1)
 . I IBREC="835EOB"!(IBREC="835ERA") S EOBFLG=1 Q      ; set the EOB flag
 . I IBREC<1 Q             ; rec# too low
 . I IBREC'<99 Q           ; rec# too high
 . F POS=1:1:$L(DATA) S Y=Y+($A(DATA,POS)*POS)
 . Q
 ;
 I 'EOBFLG S Y=0   ; if this array is not an 835
 Q Y
 ;
EXT(DATA) ; Extracts from the text in DATA if the text contains 
 ;  "##RAW DATA: "
 Q $S(DATA["##RAW DATA: ":$P(DATA,"##RAW DATA: ",2,99),1:DATA)
 ;
