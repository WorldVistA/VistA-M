PRS8WE2 ;WCIOFO/MGD-DECOMPOSITION, WEEKEND PREMIUM PART 2 ;3/23/07
 ;;4.0;PAID;**90,92,96,112,119**;Sep 21, 1995;Build 4
 ;;Per VHA Directive 2004-038, this routine should not be modified.
COUNT(DAYN,SEG) ; Increase count of premium for tour
 ; input
 ;   DAYN = day # (0-15) being counted
 ;   SEG  = segment # (1-96) in DAYN being counted
 ;   D(DAYN)
 ;   P(DAYN)
 ;   H(DAYN)
 ;   CNT(DAYN,shift) - optional
 ; output
 ;   CNT(DAYN,shift) = current count for tour being processed
 ;
 N DAT,FND,M1,NODE,NOTELG,POST,PREVDAY,RC,SC,SHIFT,TDAY,TOUR,TOURS,TS
 ; perform final checks
 I ("EetOscbT"[$E(D(DAYN),SEG)),$E(H(DAYN),SEG)'=2,$E(P(DAYN),SEG) Q
 I TYP["P","4"[$E(D(DAYN),SEG),$E(H(DAYN),SEG)'=2,$E(P(DAYN),SEG)=0 Q
 ;
 ; If Hybrid employee as defined by Public Law P.L. 107-135, check
 ; to see if the time was on a tour of duty or an exception.  Tours
 ; worked on Sat or Sun qualify for Premium time.  If the time was
 ; an exception, check the Remarks Code to see if the segment can be
 ; counted as Premium time.
 ;
 S (FND,NOTELG)=0
 ; Quit if Sunday and employee is not entitled to Sun Prem Pay
 Q:SATNOSUN&("^1^8^15^"[(U_DAY_U))&(TP="SUN")
 I HYBRID!(PMP'=""&("^S^T^U^V^"[(U_PMP_U))) D  Q:NOTELG
 . ; Check to see if the time was on a tour or an exception
 . N INC,END
 . F TOURS=1,4,2 D  Q:NOTELG!(FND)
 . . S TOUR=$G(^TMP($J,"PRS8",DAYN,TOURS))
 . . Q:TOUR=""
 . . S INC=$S(TOURS=2:4,1:3)
 . . S END=$S(TOURS=2:25,1:19)
 . . F POST=1:INC:END I $P(TOUR,"^",POST)'="" D  Q:NOTELG!(FND)
 . . . ; Quit if SEG is not within the start/stop time
 . . . Q:SEG<$P(TOUR,"^",POST)!(SEG>$P(TOUR,"^",POST+1))
 . . . S FND=1
 . . . Q:TOURS=1!(TOURS=4)  ; If on a Tour it counts as Premium
 . . . S RC=$P(TOUR,"^",POST+3)
 . . . ; Remarks Code must be OT/CT on Premium (#9), Tour Coverage (#12),
 . . . ; CB - Premium T&L (#14) or OT/CT With Premiums (#17) to qualify for Premium pay.
 . . . I "^9^12^14^17^"'[("^"_RC_"^") S NOTELG=1
 . Q:FND
 . ;
 . ; If we didn't find SEG in either of the two tours or the
 . ; exceptions then check to see if it crossed over into this day.
 . S PREVDAY=DAYN-1
 . N INC,END
 . F TOURS=1,4,2 D  Q:NOTELG!(FND)
 . . S TOUR=$G(^TMP($J,"PRS8",PREVDAY,TOURS))
 . . Q:TOUR=""
 . . S INC=$S(TOURS=2:4,1:3)
 . . S END=$S(TOURS=2:25,1:19)
 . . F POST=1:4:25 I $P(TOUR,"^",POST)'="" D  Q:NOTELG!(FND)
 . . . ; Quit if SEG is not within the start/stop time
 . . . Q:(SEG+96)<$P(TOUR,"^",POST)!((SEG+96)>$P(TOUR,"^",POST+1))
 . . . S FND=1
 . . . Q:TOURS=1!(TOURS=4)  ; If on a Tour it counts as Premium
 . . . S RC=$P(TOUR,"^",POST+3)
 . . . ; Remarks Code must be OT/CT on Premium (#9), Tour Coverage (#12),
 . . . ; CB - Premium T&L (#14) or OT/CT With Premiums to qualify for premium pay.
 . . . I "^9^12^14^17^"'[("^"_RC_"^") S NOTELG=1
 ;
 I $E(H(DAYN),SEG)=1!($E(P(DAYN),SEG)=5) Q
 ; determine special code
 S SHIFT=1
 I TP="SUN",TYP["W" D
 . ; Check to see if shift 2 or 3 is recorded for the segment worked
 . I "^2^3^"[(U_$E(D(DAYN),SEG)_U) S SHIFT=$E(D(DAYN),SEG) Q
 . S FND=0,SC=""
 . ; Check for Holiday Worked on a Holiday
 . I $E(D(DAYN),SEG)="O",$E(H(DAYN),SEG)=2 D
 . . F TDAY=DAYN,DAYN-1 D  Q:FND
 . . . S M1=$S(TDAY=DAYN:SEG,1:SEG+96)
 . . . ; loop through both tours in day
 . . . F NODE=1,4 S DAT=$G(^TMP($J,"PRS8",TDAY,NODE)) Q:DAT=""  D  Q:FND
 . . . . ; loop through tour segments in tour
 . . . . F TS=1:1:7 Q:$P(DAT,U,(TS-1)*3+1)=""  D  Q:FND
 . . . . . ; check if time is contained in tour segment
 . . . . . I M1'<$P(DAT,U,(TS-1)*3+1),M1'>$P(DAT,U,(TS-1)*3+2) D
 . . . . . . S SC=$P(DAT,U,(TS-1)*3+3),SHIFT=$S(SC=6:2,SC=7:3,1:1)
 . . . . . . I "^2^3^"[(U_SHIFT_U) S FND=1
 ;
 ;Set shift 2 for 36/40 AWS nurses with premium time outside tour
 ;for this time segment  i.e. overtime(O), comp time(C) or called in from
 ;on-call(c)
 I +NAWS=36,"cOE"[$E(D(DAYN),SEG) S SHIFT=2
 ; add to count
 S CNT(DAYN,SHIFT)=$G(CNT(DAYN,SHIFT))+1
 Q
 ;
SAVE ; Update WK array with final count for tour
 ; input
 ;   TP  - type of premium (SAT or SUN)
 ;   CNT(day,shift)=amount
 ;
 N AMT,DAYN,PC,SHIFT,WEEK
 S DAYN=0 F  S DAYN=$O(CNT(DAYN)) Q:DAYN=""  D
 . Q:DAYN<1!(DAYN>14)
 . S WEEK=$S(DAYN<8:1,1:2)
 . S SHIFT="" F  S SHIFT=$O(CNT(DAYN,SHIFT)) Q:SHIFT=""  D
 . . S AMT=CNT(DAYN,SHIFT)
 . . S PC=$S(TP="SAT":0,1:SHIFT)+12
 . . ;Shift 2 used for 36/40 nurses premium time within tour using the 2080 divisor (40*52).
 . . ;Saturday Premium-AWS (SR/SS) and Sunday Premium-AWS (SD/SH)
 . . ;Paid at the AAC with the 1872 divisor for the hourly rate (36*52)
 . . ;for time outside the tour.
 . . S:+NAWS=36 PC=$S(SHIFT=2:$S(TP="SAT":12,1:13),TP="SAT":49,1:50)
 . . S $P(WK(WEEK),U,PC)=$P(WK(WEEK),U,PC)+AMT
 Q
 ;
 ;PRS8WE
