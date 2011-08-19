PRSPAPU ;WOIFO/SAB-WOIFO/SAB - AUTO POST UTILITIES FOR EA & LV ;10/30/2004
 ;;4.0;PAID;**93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
 ;
TCLCK(PRSIEN,S1,E1,S2,E2,PPLCK,PPLCKE) ; Time Card Lock for Date Range Change
 ; This API attempts to lock employee timecards for pay periods that
 ; are impacted by a change to a date range.  Only existing pay periods
 ; that are covered by a PTP memo will be locked.
 ;
 ; Input
 ;   PRSIEN   - Employee IEN (file 450)
 ;   S1       - Old Start Date (FileMan internal)
 ;   E1       - Old End Date (Fileman internal)
 ;   S2       - New Start Date (FileMan internal)
 ;   E2       - New End Date (Fileman internal)
 ;   PPLCK()  - Array of Locked Pay Periods passed by reference
 ;   PPLCKE() - Array of Pay Periods with Lock Error passed by reference
 ;   Note that both these arrays are initialized by this API.
 ; Output
 ;   PPLCK()  - Array of Locked Pay Periods may be updated
 ;              format PPLCK(pay period IEN file 458)=""
 ;   PPLCKE() - Array of Pay Periods with Lock Error may be updated
 ;              format PPLCKE(pay period IEN file 458)=""
 ;
 K PPLCK,PPLCKE
 ;
 ;if S1 and E1 have values and S2 and E2 are null then lock from S1 to E1
 I S1,E1,'S2,'E2 D LCK(PRSIEN,S1,E1,.PPLCK,.PPLCKE)
 ;
 ;if S1 and E1 are null and S2 and E2 have values then lock from S2 to E2
 I 'S1,'E1,S2,E2 D LCK(PRSIEN,S2,E2,.PPLCK,.PPLCKE)
 ;
 ;if S1, E1, S2, and E2 have values then lock impacted ranges
 I S1,E1,S2,E2 D
 . N X1,X2
 . ; if new start is less than old start then days from new start to
 . ; lesser of new end and old start-1 were changed from not covered to
 . ;  covered.
 . I S2<S1 D
 . . S X1=S2
 . . S X2=$S(E2<(S1-1):E2,1:S1-1)
 . . D LCK(PRSIEN,X1,X2,.PPLCK,.PPLCKE)
 . ;
 . ; if new start is greater than old start then days from old start to
 . ; lesser of old end and new start-1 were changed from covered to not
 . ; covered.
 . I S2>S1 D
 . . S X1=S1
 . . S X2=$S(E1<(S2-1):E1,1:S2-1)
 . . D LCK(PRSIEN,X1,X2,.PPLCK,.PPLCKE)
 . ;
 . ; if new end is greater than old end then days from greater of old
 . ; end+1 and new start to new end were changed from not covered to
 . ; covered.
 . I E2>E1 D
 . . S X1=$S(E1+1>S2:E1+1,1:S2)
 . . S X2=E2
 . . D LCK(PRSIEN,X1,X2,.PPLCK,.PPLCKE)
 . ;
 . ; if new end is less than old end then days from greater of new end+1
 . ; and old start to old end were changed from covered to not covered.
 . I E2<E1 D
 . . S X1=$S(E2+1>S1:E2+1,1:S1)
 . . S X2=E1
 . . D LCK(PRSIEN,X1,X2,.PPLCK,.PPLCKE)
 ;
 Q
 ;
LCK(PRSIEN,PERSTR,PEREND,PPLCK,PPLCKE) ; Lock Time Cards for a Date Range 
 ; This API attempts to lock the employee timecards for a date range.
 ; Only existing pay periods that are covered by a PTP memo are locked.
 ;
 ; Input
 ;   PRSIEN   - Employee IEN (file 450)
 ;   PERSTR   - Period Start (FileMan internal)
 ;   PEREND   - Period End (Fileman internal)
 ;   PPLCK()  - Array of Locked Pay Periods passed by reference
 ;              format PPLCK(pay period IEN file 458)=""
 ;   PPLCKE() - Array of Pay Periods with Lock Error passed by reference
 ;              format PPLCKE(pay period IEN file 458)=""
 ;   Note that these arrays are not initialized by this API and may
 ;   contain information about already locked timecards.
 ; Output
 ;   PPLCK()  - Array of Locked Pay Periods may be updated
 ;   PPLCKE() - Array of Pay Periods with Lock Error may be updated
 ;
 Q:('$G(PRSIEN))!($G(PERSTR)'?7N)!($G(PEREND)'?7N)  ; required inputs
 ;
 N D1,DAY,EPP4Y,PP4Y,PPE,PPI,SPP4Y,Y
 ;
 ; determine starting and ending pay periods
 S D1=PERSTR D PP^PRSAPPU S SPP4Y=PP4Y
 S D1=PEREND D PP^PRSAPPU S EPP4Y=PP4Y
 Q:SPP4Y=""
 Q:EPP4Y=""
 ;
 ; loop thru pay periods
 S PP4Y=$O(^PRST(458,"AB",SPP4Y),-1) ; set initial value to previous PP
 F  S PP4Y=$O(^PRST(458,"AB",PP4Y)) Q:PP4Y=""!(PP4Y]EPP4Y)  D
 . S PPI=$O(^PRST(458,"AB",PP4Y,0))
 . ; quit if pay period not covered by memo
 . S D1=$P($G(^PRST(458,PPI,1)),U)
 . Q:$$MIEN^PRSPUT1(PRSIEN,D1)'>0
 . ;
 . Q:$D(PPLCK(PPI))  ; already in lock array
 . Q:$D(PPLCKE(PPI))  ; already in lock error array
 . ;
 . ; lock timecard
 . L +^PRST(458,PPI,"E",PRSIEN):2
 . S:'$T PPLCKE(PPI)=""
 . S:$T PPLCK(PPI)=""
 ;
 Q
 ;
 ;
TCULCK(PRSIEN,PPLCK) ; Time Card Unlock
 ; This API unlocks a list of employee timecards.
 ;
 ; Input
 ;   PRSIEN - Employee IEN (file 450)
 ;   PPLCK( - Array of Locked Pay Periods passed by reference
 ;            format PPLCK(pay period IEN file 458)=""
 ; Output
 ;   PPLCK( - Input array is killed since pay periods are unlocked
 ;
 Q:'$G(PRSIEN)  ; required input
 ;
 N PPI
 ;
 ; loop thru pay periods and unlock time card
 S PPI="" F  S PPI=$O(PPLCK(PPI)) Q:'PPI  L -^PRST(458,PPI,"E",PRSIEN)
 ;
 ; init lock array
 K PPLCK
 ;
 Q
 ;
RLCKE(PPLCKE,WRITE,PRSARRN) ; Report Lock Errors
 ; This API writes a list of timecards that could not be locked.
 ;
 ; Input
 ;   PPLCKE( - Array of Pay Periods with Lock Error passed by reference
 ;             format PPLCKE(pay period IEN file 458)=""
 ;   WRITE   - (optional) true (=1) if text should be written (default)
 ;                        false (=0) if array should be returned instead
 ;   PRSARRN - (optional) array name, default value is "PRSARR"
 ; output
 ;   If WRITE is True, the input array name (or "PRSARR" if not
 ;     specified) will be killed.
 ;   If WRITE is False, the input array name will contain the text
 ;
 N LN,PPI
 ;
 S PRSARRN=$G(PRSARRN,"PRSARR")
 S WRITE=$G(WRITE,1)
 ;
 S @PRSARRN@(1)="Unable to make changes because the time card for the following"
 S @PRSARRN@(2)="pay period(s) are being edited by another user!"
 S LN=2
 ; loop thru pay periods
 S PPI="" F  S PPI=$O(PPLCKE(PPI)) Q:'PPI  D
 . S LN=LN+1
 . S @PRSARRN@(LN)="  Pay Period: "_$P($G(^PRST(458,PPI,0)),U)
 ;
 ; if not WRITE then quit (returns text in array to caller)
 Q:'WRITE
 ;
 ; otherwise write text to current device and then kill array of text
 S LN=0 F  S LN=$O(@PRSARRN@(LN)) Q:'LN  D
 . W !,@PRSARRN@(LN)
 K @PRSARRN
 ;
 Q
 ;
 ;PRSPAPU
