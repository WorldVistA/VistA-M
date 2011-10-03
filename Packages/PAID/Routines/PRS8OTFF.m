PRS8OTFF ;WCIOFO/MGD-OVERTIME/UNSCH FOR CODE R,C FIREFIGHTERS ;01/11/08
 ;;4.0;PAID;**45,54,102,117**;Sep 21, 1995;Build 32
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;  routine called from PRS8ST when a premium pay indicator for
 ;  a firefighter is R or C.
 ;
FFOTUN ;CALCULATE CODE R AND C FIREFIGHTERS OVERTIME AND UNSCHEDULED REGULAR
 ;
 N SCHWRK,XTRAWRK
 ;
 ;Count up scheduled and unscheduled work for week 1 and 2
 ;
 D WORKCNT(.SCHWRK,.XTRAWRK,.XWRK)
 ;
 ; Determine overtime and unscheduled based on 53/106 hour rule
 ; and update the week array with OA/OE, RA/RE and UN/US.
 ; Code C and R firefighters overtime calculation is the same
 ; whether on compressed tour or not.
 ;
 D CALCOT(.SCHWRK,.XTRAWRK,.XWRK)
 ;
 Q
 ;
 ;==============================================================
 ;
WORKCNT(SCHWRK,XTRAWRK,XWRK) ;
 ;
 ;VARIABLE LIST
 ; DAY: current day of pay period--1 through 14 and 1st day of next (15)
 ; WEEK: Week 1 or 2 of pay period--days 1-7 are week 1, 8-14 week 2.
 ; QHRCNT: Counter for a single Quarter Hour segment of day.  There are
 ;         96 quarter hours in a 24 hour day.
 ; EXCSTR: 96 char day string with exceptions
 ; WRKSTR: 96 char string with work codes.
 ; AFFSTR: 96 char string with additional fire fighter hour segments
 ;         coded with 1's.
 ; XWRK: string of extra work time
 ; QHTCODE: Time code for a single quarter hour segment. 
 ;    1:scheduled work        A:annual leave      S:sick leave, 
 ;    W:leave without pay     n:non pay status    U:comp used, 
 ;    E:comp earned           M:military leave    X:training, 
 ;    Y:travel                O:overtime          4:unscheduled,
 ;    T:ot in travel          B:standby           C:on call,
 ;    N:non pay annual lv     h:holiday worked    F:Care and Bereavement
 ;    G:adoption              D:donor leave       R:restored annual leave
 ;    M:military leave        J:jury duty         n:non pay time
 ;    V:continuation of pay   e:sched comp earn   s:scheduled OT
 ;     Note:  T:overtime for travel  is counted elsewhere so it can not
 ;            also be recounted as overtime here.
 ;
 N DAY,WEEK,QHRCNT,QHRSEG,WRKSTR,QHTCODE,HOLIDAY
 ;
 ;Initialize scheduled work and xtra work counters
 ;
 F WEEK=1:1:2 S (SCHWRK(WEEK),XTRAWRK(WEEK))=0,XWRK(WEEK)=""
 ;
 ;Loop through Each day of the pay period
 ;
 F DAY=1:1:14 D
 .S WEEK=$S(DAY>7:2,1:1)
 .S WRKSTR=$G(^TMP($J,"PRS8",DAY,"W")) ; work node includes addt ff hrs.
 .;
 .; loop through each 15 min increment of the current day 
 .; totaling scheduled and unscheduled work
 .;
 .F QHRCNT=1:1:96 S QHTCODE=$E(WRKSTR,QHRCNT) Q:'$L(QHTCODE)  D
 . . ;
 . . ; SET HOLIDAY TO 0,1,2 FOR NO HOLIDAY, HOL EXUSED, OR HOLIDAY WORKED
 . . ;
 . . S HOLIDAY=$$HOLIDAY(QHRCNT,DAY)
 . . ;
 . . ; INCREMENT SCHEDULED WORK IF ACCOUNTED FOR WITH APPROPRIATE CODE.
 . . I "1SLWAUXYBCFGDJRMVnZq"[QHTCODE!(QHTCODE="O"&(HOLIDAY=2)) D
 . . . S SCHWRK(WEEK)=SCHWRK(WEEK)+1
 . . ;
 . . ; Increment any unscheduled work or unscheduled CT or OT
 . . I "4EeOs"[QHTCODE&(HOLIDAY<1) D
 . . . S XTRAWRK(WEEK)=XTRAWRK(WEEK)+1
 . . . S XWRK(WEEK)=XWRK(WEEK)_QHTCODE
 ;
 Q
 ;
 ;==============================================================
 ;
CALCOT(SW,XW,XWS) ;
 ; Update the week array with overtime
 ;
 ;Possible permutations of Scheduled and Unscheduled
 ;                          |
 ;                        53|HRS
 ;                          |
 ; 1.  SSSSSSSSSSSSSSSSSSSSS|SSSSSSSSS
 ; 2.  SSSSSSSSSSSSSSSSSSSSS|SSSSSUUUUUUUUUUUU
 ; 3.  SSSSSSSSSSSSSSSSSSSSS|UUUUUUUUUUUUU
 ; 4.  SSSSSSSSSSSSSSSSUUUUU|UUUUUUUUUUU
 ; 5.  SSSSSSSSSSSSSSSSSS   |
 ; 6.  SSSSSSSSSSSSUUU      |
 ;
 ; |------------------------------------------|
 ; |  After Patch 85          |<= 212 |> 212  |
 ; |------------------------------------------|
 ; |Code|    Type of Time     | Piece | Piece |
 ; |------------------------------------------|
 ; | ** |All Scheduled Time   |       |  26   |
 ; | 4  |Unscheduled Regular  |   9   |  20   |
 ; | E  |Comp Time Earned     |   9   |   7   |
 ; | e  |Scheduled Comp Time  |   9   |  20   |
 ; | O  |Overtime             |   9   |  20   |
 ; | s  |Scheduled Overtime   |   9   |  20   |
 ; |------------------------------------------|
 ;
 N I,P,WEEK,Y,Z
 F WEEK=1:1:2 D
 . ;
 . ; Post Regular Scheduled Hours In Excess of 53 as RA/RE
 . ; Scenarios 1 & 2
 . I SW(WEEK)>212 D
 . . S Y=SW(WEEK)-212,P=26 D SET
 . ;
 . ; Post Extra Hours per chart.  Scenarios 2,3,4 & 6
 . I $L(XWS(WEEK))>0 D
 . . S Y=1
 . . ;
 . . ; step thru extra time segments
 . . F I=1:1:$L(XWS(WEEK)) D
 . . . S Z=$E(XWS(WEEK),I)
 . . . S P=$S(SW(WEEK)+I'>212:9,Z="E":7,Z="e":20,Z="s":20,1:20)
 . . . D SET
 . . . ;
 . . . ; If Scheduled OT or CT after 53 hours, also count as Unscheduled Regular
 . . . I P=26 S P=9 D SET
 Q
 ;
 ;==============================================================
 ;
SET ; Set sleep time into WK array
 S $P(WK(WEEK),"^",P)=$P(WK(WEEK),"^",P)+Y
 Q
 ;
 ;==============================================================
 ;
HOLIDAY(TIMESEG,DAY) ;
 ;INPUT:
 ; DAY--day of pay period 1 through 14 or 15 for 1st day of next pp
 ; TIMESEG--position in 96 character day string (1 to 96)
 ;OUTPUT:
 ;  code for holiday worked, holiday exused or neither from the
 ;  ^TMP($J,"PRS8",DAY,"HOL") global
 ;      holiday worked coded: 2 
 ;      holiday exused coded: 1
 ;      neither coded: 0
 ;
 Q $E($G(^TMP($J,"PRS8",DAY,"HOL")),TIMESEG)
