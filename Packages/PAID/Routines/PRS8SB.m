PRS8SB ;HISC/MRL-DECOMPOSITION, STAND-BY ;3/25/93  10:02
 ;;4.0;PAID;;Sep 21, 1995
 ;
 ;Standby is computed based on hours entered either as part of a
 ;regularly scheduled tour (scheduled SB) or as an exception.  An
 ;exception would be, for instance, a case where one individual
 ;substitutes for another who's scheduled.  Sleep time is associated
 ;with the T&L which the employee is assigned to.  It can be any
 ;time (in 15-minute increments) during the day and covers a period
 ;of 8-hours.  When a person is called in during SB the callback is
 ;entered in the system as OT.  No OT is actually paid, however, any
 ;hours reported during the 8-hour sleeptime period are recorded.
 ;Sleep time is reduced by the actual number of hours called in until
 ;the total hits 5 hours.  Once that happens then no Sleep Time is
 ;recorded for that date.
 ;
 ;Called by Routines:  PRS8AC
 ;
 ;B = Standby
 ;b = OT during Standby (used to figure sleep time)
 ;
 S SBY=1,X=$S(VAR1="C":"B",VAR1="c":"b",1:VAR1)
 I 'DOUB,"Cct"[VAR1 Q  ;quit if PPI'="W" & OC
 S D=$S(T<97:DAY,1:DAY+1) ;proper reporting date
 S SB(D)=$G(SB(D))+1 ;increment standby time
 Q
 ;
UP ; --- update counter for standby
 S D=0
 ;
UP1 ; --- standby time update
 S D=$O(SB(D)) I D S X=$G(SB(D)) I X S P=34 D SET G UP1
 ;
UP2 ; --- sleep time
 K SL,SB,SBY,ST Q
 ;
SET ; --- set WK array
 I D<1!(D>14) Q
 S W=$S(D<8:1,1:2)
 S $P(WK(W),"^",P)=$P(WK(W),"^",P)+X Q
