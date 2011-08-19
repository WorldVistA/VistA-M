PRS8EX0 ;HISC/MRL,WOIFO/JAH,SAB-DECOMP,EXCEPTIONS (cont'd) ;1/30/2007
 ;;4.0;PAID;**2,22,56,111**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
ENCAP ;
 ; This routine checks if the current day encapsulates other days that
 ; should be automatically charged to WP or NP by the software. If so,
 ; appropriate encapsulated days are charged.  This routine is only
 ; called when the employee has a daily tour.
 ; inputs
 ;   PY - current pay period IEN
 ;   DY - current day number
 ;   TT - type of time posted on current day
 ;   TT(1) - data from ACT^PRS8EX for the type of time in TT
 ;   DFN - employee IEN
 ;
 ; day must be in pay period and posted with WP or NP
 Q:(DY<1)!(DY>14)
 Q:"^NP^WP^"'[(U_TT_U)
 ;
 N SCHDY,SCHEX,SCHPY,CHGDAY
 ;
 ; find prior scheduled work day that is not holiday excused
 D WORKDAY(DFN,PY,DY,-1,.SCHPY,.SCHDY,.SCHEX,.CHGDAY)
 ;
 ; If prior work day is in a previous pay period and has same exception
 ; as the current day then charge the encapsulated days found between.
 ; Note: If prior work day is in current pay period then no action
 ; needed since the look forward from that prior day would have
 ; already taken care of encapsulated days.
 I SCHEX=TT,$D(CHGDAY),SCHPY'=PY D SET(DFN,PY,TT,$P(TT(1),U,4),.CHGDAY)
 ;
 ; find next scheduled work day that is not holiday excused
 D WORKDAY(DFN,PY,DY,1,.SCHPY,.SCHDY,.SCHEX,.CHGDAY)
 ;
 ; If next work day has same exception as current day then charge
 ; encapsulated days found between.
 I SCHEX=TT,$D(CHGDAY) D SET(DFN,PY,TT,$P(TT(1),U,4),.CHGDAY)
 ;
 Q
 ;
WORKDAY(DFN,PY,DY,PRSDIR,SCHPY,SCHDY,SCHEX,CHGDAY) ; find work day
 ; inputs
 ;   DFN - employee IEN
 ;   PY  - current pay period IEN
 ;   DY  - current day number
 ;   PRSDIR - direction (-1 to look back or +1 to look forward)
 ; outputs
 ;   SCHPY - passed by reference, work day pay period or null
 ;   SCHDY - passed by reference, work day day number or null
 ;   SCHEX - passed by reference, work day exception or null
 ;   CHGDAY() - passed by reference, array of days in current pay period
 ;              that could be charged due to encapsulation and were
 ;              encounted during the search for the work day
 ;              format ENCDAY(day number)=null value
 ;
 N DONE,EXC,LOOPPY,LOOPDY,PPCNT,TOD
 ; init outputs
 S (SCHPY,SCHDY,SCHEX)=""
 K CHGDAY
 ;
 ; loop thru days to find the first scheduled work day that is
 ; not holiday excused
 S DONE=0,LOOPPY=PY,LOOPDY=DY,PPCNT=1
 F  D  I DONE Q
 . ; move one day in appropriate direction
 . S LOOPDY=LOOPDY+PRSDIR
 . ;
 . ; check if loop day moved into a different pay period
 . I LOOPDY<1 S LOOPPY=$O(^PRST(458,LOOPPY),-1),LOOPDY=14,PPCNT=PPCNT+1
 . I LOOPDY>14 S LOOPPY=$O(^PRST(458,LOOPPY),1),LOOPDY=1,PPCNT=PPCNT+1
 . ;
 . ; check for loop ending conditions (related to pay period/time card)
 . I PPCNT>2 S DONE=1 Q  ; only check current and one other pay period
 . I LOOPPY'>0 S DONE=1 Q  ; ran out of pay periods
 . I '$D(^PRST(458,LOOPPY,"E",DFN,0)) S DONE=1 Q  ; no empl. time card
 . ;
 . ; determine tour and exception for loop day
 . S TOD=$P($G(^PRST(458,LOOPPY,"E",DFN,"D",LOOPDY,0)),U,2)
 . S EXC=$P($G(^PRST(458,LOOPPY,"E",DFN,"D",LOOPDY,2)),U,3)
 . ;
 . ; check if work day found
 . I TOD'=1,EXC'="HX" S SCHPY=LOOPPY,SCHDY=LOOPDY,SCHEX=EXC,DONE=1 Q
 . ;
 . ; work day was not found yet
 . ; add this day to list if it could potentially be charged
 . Q:LOOPPY'=PY  ; not in current pay period
 . Q:$D(^TMP($J,"PRS8",LOOPDY,2,0))  ; day already charged
 . I TOD=1,"^CP^NP^"'[(U_EXC_U) S CHGDAY(LOOPDY)="" ; add day off to list
 . I TOD>1,EXC="HX" S CHGDAY(LOOPDY)="" ; add holiday to list
 Q
 ;
SET(DFN,PY,TT,PC,CHGDAY) ; automatically charge days
 ;
 ; inputs
 ;   DFN - employee IEN
 ;   PY - pay period IEN
 ;   TT - type of time to charge
 ;   PC - 4th piece of data from ACT^PRS8EX for TT
 ;   CHGDAY - array of days passed by reference, CHGDAY(day number)=""
 ;
 N LOOPDY,PC3,WEEK
 ;
 ; loop thru days in list
 S LOOPDY=0 F  S LOOPDY=$O(CHGDAY(LOOPDY)) Q:'LOOPDY  D
 . ;
 . ; increment WK() count
 . I +PC S WEEK=$S(LOOPDY>7:2,1:1),$P(WK(WEEK),"^",+PC)=$P(WK(WEEK),"^",+PC)+1
 . E  S PC3=$A(PC)-64,$P(WK(3),"^",+PC3)=$P(WK(3),"^",+PC3)+1
 . ;
 . ; track days have been automatically charged in ^TMP
 . S ^TMP($J,"PRS8",LOOPDY,2,0)=TT
 . ;
 . ; update time card if decomp called from pay period certification
 . I $G(APDT) D
 . . S $P(^PRST(458,PY,"E",DFN,"D",LOOPDY,2),"^",3)=TT
 . . S ^PRST(458,PY,"E",DFN,"D",LOOPDY,3)="Leave posted automatically"
 . . S $P(^PRST(458,PY,"E",DFN,"D",LOOPDY,10),"^",1,4)="T^.5^"_APDT_"^2"
 Q
