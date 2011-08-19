PRS8MSC1 ;HISC/DAD,WCIOFO/MGD,SAB-MISC TIME CARD ADJUST(contd) ;1/30/2007
 ;;4.0;PAID;**56,68,111**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; This routine may automatically charge days to WP (leave without pay)
 ; if the employee has not performed any duty during the week.  This
 ; routine is only called for employees on a daily tour.
 ; The software does not automatically charge NP (Non Pay) since the
 ; effective start or end day may be on a day off such that an entire
 ; week should not be charged to NP.
 ;
 ; This routine is called from PRS8MSC0.
 ;
NODUTY ;
 ; inputs
 ;   PY - pay period IEN
 ;   DFN - employee IEN
 ;
 N CHGDAY,DO,DW,DY,END,EXC,START,TOD,WEEK
 ;
 ; loop thru both weeks in pay period
 F WEEK=1,2 D
 . ; init week counts and list of days that could be charged
 . S (DW,DW("WP"),DW("NP"),DW("HX"),DO("CP"))=0
 . K CHGDAY
 . ;
 . ; loop thru days in week
 . I WEEK=1 S START=1,END=7
 . I WEEK=2 S START=8,END=14
 . F DY=START:1:END D
 . . ; get tour and how day was charged
 . . S TOD=$P($G(^PRST(458,PY,"E",DFN,"D",DY,0)),U,2)
 . . S EXC=$P($G(^PRST(458,PY,"E",DFN,"D",DY,2)),U,3)
 . . ; update if day charged differently due to encapsulation
 . . I $D(^TMP($J,"PRS8",DY,2,0)) S EXC=^TMP($J,"PRS8",DY,2,0)
 . . ;
 . . ; update week counts for the day
 . . I TOD>1 D  ; scheduled work day
 . . . S DW=DW+1
 . . . I EXC="WP" S DW("WP")=DW("WP")+1
 . . . I EXC="NP" S DW("NP")=DW("NP")+1
 . . . I EXC="HX" S DW("HX")=DW("HX")+1,CHGDAY(DY)="" ; add HX to list
 . . I TOD=1 D  ; day off
 . . . I EXC="CP" S DO("CP")=DO("CP")+1
 . . . I EXC="" S CHGDAY(DY)="" ; add not charged day off to list
 . ;
 . ; if all work days were counted as a combination of WP, NP, and HX
 . ; and at least one day was counted as WP and no days off were counted
 . ; as CP then automatically charge appropriate remaining days to WP.
 . I DW("WP")+DW("NP")+DW("HX")'<DW,DW("WP")>0,DO("CP")=0 D
 . . D SET^PRS8EX0(DFN,PY,"WP",3,.CHGDAY)
 ;
 Q
