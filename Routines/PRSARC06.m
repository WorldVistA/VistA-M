PRSARC06 ;WOIFO/JAH - Recess Tracking ListManger Inteface ;10/16/06
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
MAIN(LSTART,LISTI,LINE,PRSDT,PRSFYRNG) ; BUILD LIST OF CALENDER FROM PP WITH PRSDT
 ; THROUGH PP CONTAINING SEPTEMBER 30
 ;
 ; PRSNMDT - date for new month
 ;
 ; Q:$G(PRSOUT)=1
 N FIRSTPP,PRSNMDT,FFPPE,LFPPE,EOFYDT,OUT,PRSDY,PRSMO,PRSNXTMO,PRSYR
 ;
 ; Get PP with PRSDT and convert PRSDT to the 1st day of that pp
 ;
 S FIRSTPP=$$GETPPDY^PRSARC04(PRSDT)
 S FFPPE=$P(FIRSTPP,U,2)
 S (PRSDT,PRSNMDT)=$P(FIRSTPP,U,1)
 ;
 ; lookup which week of the fiscal year the schedule begins
 ; this week # will be the first selectable item in the list
 ;
 S (LSTART,LISTI)=$G(FMWKS(PRSDT))
 ;
 ; Get the last PP of the fiscal year and it's last day.
 S LFPPE=$P(PRSFYRNG,U,4)
 S EOFYDT=$P(PRSFYRNG,U,2)
 ;
 ; if the first week in the AWS schedule is not both the 1st day
 ; of a PP and the first day of the month, then we need
 ; special code for that month, so that a partial month is used
 ; including only the pps that are part of the schedule.
 ;
 S (OUT,LINE,MONTHCNT)=0
 I $E(PRSDT,6,7)'="01" D
 .  S STARTDAY=$E(PRSDT,6,7)
 .  D ARAYMO(.LISTI,.LINE,PRSDT,MONTHCNT,STARTDAY,0)
 .  S PRSMO=$E(PRSDT,4,5),PRSYR=$E(PRSDT,1,3),PRSDY=$E(PRSDT,6,7)
 .  S PRSNXTMO=PRSMO+1 I $L(PRSNXTMO)=1 S PRSNXTMO="0"_PRSNXTMO
 .  S PRSNMDT=$S(PRSMO=12:PRSYR+1_"01"_PRSDY,1:PRSYR_PRSNXTMO_"01")
 ;
 ; loop through the calendar building list items for every week in 
 ; the year until we reach october.  All agreements are through
 ; the end of the fiscal year.
 ;
 S OUT=0
 F  D  Q:OUT
 .  S MONTHCNT=MONTHCNT+1
 .  D ARAYMO(.LISTI,.LINE,PRSNMDT,MONTHCNT,1,0)
 .  S PRSMO=$E(PRSNMDT,4,5),PRSYR=$E(PRSNMDT,1,3),PRSDY=$E(PRSNMDT,6,7)
 .  S PRSNXTMO=PRSMO+1 I $L(PRSNXTMO)=1 S PRSNXTMO="0"_PRSNXTMO
 .  S PRSNMDT=$S(PRSMO=12:PRSYR+1_"01"_PRSDY,1:PRSYR_PRSNXTMO_"01")
 .  ;if we hit september 30 or october quit
 .  I PRSNXTMO=10!(PRSNMDT>EOFYDT) S OUT=1
 ;
 ; Include any weeks in October that are part of the PP
 ; with September 30, thus the fiscal year spills into october by
 ; no more than 13 days 
 ;
 I PRSNXTMO=10&(PRSNMDT'>EOFYDT) D
 .  S MONTHCNT=MONTHCNT+1
 .  D ARAYMO(.LISTI,.LINE,PRSNMDT,MONTHCNT,1,+$E(EOFYDT,6,7))
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = 
 ;
ARAYMO(LISTI,LINE,PRSDT,MONTHCNT,STARTDAY,SHORT) ;SILENT CALL TO PLACE MONTH IN ARRAY
 ;  INPUT: PRSDT - must be fileman date
 ;         SHORT - set to # of days to show if a short month
 ;                 is desired.  i.e. to stop listing after the 
 ;                  first PP then specify the # of
 ;                 days to that date from the 1st of the month
 ;
 N X,Y,%DT,DAY1,Y,MONTH,DAYS,YEAR,FIRSTDAY,LASTDAY,COUNT,HDR
 S X=PRSDT D ^%DT Q:Y<0
 S MONTH=$E(PRSDT,4,5),YEAR=$E(PRSDT,1,3)+1700
 I SHORT D
 .   S DAYS=SHORT
 E  D
 .   S DAYS=$$DAYSINMO(YEAR,MONTH)
 S FIRSTDAY=$E(PRSDT,1,5)_"01",LASTDAY=$E(PRSDT,1,5)_DAYS
 ;
 ;Get day #s of pps in month
 N PPS
 I FIRSTDAY<3130000 D GETPPS(FIRSTDAY,LASTDAY)
 S DAY1=$$WEEKDAY1(PRSDT)
 S HDR=$$GETHEAD(Y)
 S LINE=LINE+1
 S ^TMP("PRSARC",$J,LINE,0)="        ============="_HDR_"============"
 ;
 D DISPMO(.LISTI,.LINE,DAY1,DAYS,1,STARTDAY)
 ;S LINE=LINE+1
 ;D HOLIDAY
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
DISPMO(LISTI,LINE,DAYNO,NODAYS,SKPW1,STRTDY) ;store a month into an array
 ;SAMPLE CALL:  D DISPMO(4,30,.L,0) Produces a 30 day month with day 1
 ;                                 beginning on Wednesday.
 ;SAMPLE CALL:  D DISPMO(4,30,.L,1) Produces a 30 day month starting
 ;                                  in week 2 Sunday--day 5
 ;
 ;INPUT:
 ;  DAYNO : integer value of weekday (0=sun,1=mon,2=tues,...,6=sat)
 ;  NODAYS: integer value of days in month, i.e. 30 days has sept...
 ;  SKIPW1: set to true if you want to skip partial 1st week
 ;  STRTDY: set to day of month to start calendar.
 ;
 N DAYS,DAYPOS,I,PPOFFSET,CNTDWN,BLNKS,LEADBLNK,WRTAB
 S PPOFFSET="     ",CNTDWN=NODAYS
 ;
 ; keep track of selectable items in the list (LISTI) and 
 ; lines in the list
 ;
 ; start with second week when SKPW1 is true and the first week
 ; of the month isn't a full week.
 ;   also I STARTDAY is > 1 then use it (we only want a partial month)
 I (STRTDY=1)&SKPW1&(DAYNO'=0) S STRTDY=8-DAYNO
 F I=STRTDY:1:NODAYS D
 . S DAYPOS=(DAYNO+I-1)#7
 . I DAYPOS=0 D
 ..  S LINE=LINE+1
 ..  S LEADBLNK=$E("   ",1,(3-$L(LISTI)))
 ..  S BLNKS="     "
 ..  I $G(PPS(I))'="" D
 ...   ; index of items that are selectable (weeks only, no month heads)
 ...   S ^TMP("PRSLI",$J,LISTI)=LINE
 ...   ; ListManager's items
 ...   S ^TMP("PRSARC",$J,LINE,0)=LEADBLNK_LISTI_BLNKS_PPS(I)
 ..  E  D
 ...   S ^TMP("PRSLI",$J,LISTI)=LINE
 ...   S ^TMP("PRSARC",$J,LINE,0)=LEADBLNK_LISTI_BLNKS_PPOFFSET
 ..  S LISTI=LISTI+1
 . I ($G(CNTDWN)>0) D
 ..   S WRTAB=$S($L(I)=2:"  ",1:"   ")
 ..   S ^TMP("PRSARC",$J,LINE,0)=$G(^TMP("PRSARC",$J,LINE,0))_WRTAB_I
 ..   S CNTDWN=CNTDWN-1
 ;
 ; add first days of next month to the last week
 ;
 I DAYPOS'=6 D
 .  F I=1:1:7-(DAYPOS+1) S ^TMP("PRSARC",$J,LINE,0)=$G(^TMP("PRSARC",$J,LINE,0))_"   "_I
 Q
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
GETPPS(FIRSTDAY,LASTDAY) ;
 N D1,PPE,PPDAY,PPI,PP4Y
 S D1=FIRSTDAY D PP^PRSAPPU
 D NX^PRSAPPU
 I D1<FIRSTDAY S PPE=$E($$NXTPP^PRSAPPU(PPE),3,7) D NX^PRSAPPU
 S PPDAY=+$E(D1,6,7)
 S PPS(PPDAY)=PPE
 F  D  Q:D1>LASTDAY
 .  S PPE=$E($$NXTPP^PRSAPPU(PPE),3,7) D NX^PRSAPPU
 .  Q:D1>LASTDAY
 .  S PPDAY=+$E(D1,6,7)
 .  S PPS(PPDAY)=PPE
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
GETHEAD(Y) ;
 N YEAR,MONTH,HDR,LENOFDT
 S HDR=$$FMTE^XLFDT(Y,"1D")
 S MONTH=$P(HDR," ")
 S LENOFDT=$L(HDR," ")
 S YEAR=$P(HDR," ",LENOFDT)
 Q MONTH_" "_YEAR
 ;
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
WEEKDAY1(ZDATE) ;get the weekday of the 1st day of the month
 ; INPUT:   ZDATE   - FileMan date, used as the month to display
 ; OUTPUT:  return - Integer corresponding to day of week 
 ;                   (i.e. Sunday[1], Monday[2]) for the 1st day of
 ;                   the month
 S ZDATE=$E(ZDATE,1,5)_"01"
 Q $$DOW^XLFDT(ZDATE,1)
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
DAYSINMO(Y,M) ; Return # of days in month based on year and month
 ;  Input:  Y = year in 4 digit format between 1700 and 3000
 ;          M = month expressed as an integer from 1 to 12 (Jan - Dec)
 ;
 N GOODY,GOODM S (GOODY,GOODM)=0
 I Y<2700,Y>1700 S GOODY=1
 I M>0,M<13 S GOODM=1
 Q:'(GOODM&GOODY) 0
 Q $P("31^"_(28+$$LEAPYR^PRSLIB00(YEAR))_"^31^30^31^30^31^31^30^31^30^31",U,MONTH)
