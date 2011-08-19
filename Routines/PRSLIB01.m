PRSLIB01 ;JAH/WCIOFO-PAID UTILITIES AND LIBRARY 01 ;Mar 25, 2005
 ;;4.0;PAID;**45,93**;Sep 21, 1995;Build 7
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
MAIN ;DISPLAY MONTHLY CALENDAR FOR ANY DATE
 N OUT
 F  D CALENDAR(.OUT) Q:OUT
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = 
CALENDAR(OUT) ;
 ;  Ask user for a date and quit if not a valid date.
 ;  Get # of days in the month the user has selected.
 ;  Get the weekday for the 1st day of the selected month.
 ;  If necessary get days elapsed from jan 1 to 1st day of selected mo.
 ;  Display the month.
 ;
 S OUT=1
 N ZFMDATE,%DT,DAY1,Y,MONTH,DAYS,YEAR,FIRSTDAY,LASTDAY,SHOWJULI,HIGHLITE
 N COUNT,HDR
 ;
 S %DT="AE" D ^%DT S ZFMDATE=Y ;          Ask date.
 Q:Y<1
 ; if picked month has today-highlight
 S HIGHLITE=0
 I $E(Y,1,5)=$E(DT,1,5) S HIGHLITE=+$E(DT,6,7)
 ;
 ; Ask if they want to see the elapsed days calendar.
 S SHOWJULI=$$ASKJULIA()
 Q:Y<0
 ;
 ;                                        Days in the month.
 S MONTH=$E(ZFMDATE,4,5),YEAR=$E(ZFMDATE,1,3)+1700
 S DAYS=$$DAYSINMO(YEAR,MONTH)
 ;
 S FIRSTDAY=$E(ZFMDATE,1,5)_"01",LASTDAY=$E(ZFMDATE,1,5)_DAYS
 ;
 ;Get the day #s of pay periods in this month
 N PPS
 I FIRSTDAY<3130000 D GETPPS(FIRSTDAY,LASTDAY)
 ;
 S DAY1=$$WEEKDAY1(ZFMDATE) ;             Weekday of the 1st.
 ;
 ;
 S HDR=$$GETHEAD(Y)
 W @IOF,!
 W "---------------",HDR,"------------"
 D DISPMO(DAY1,DAYS,HIGHLITE) ;                    Display month.
 I SHOWJULI D
 .   N JULID1
 .   S JULID1=$$GETJULI(FIRSTDAY,YEAR)
 .   W !!,"-------Elapsed Days Calendar---------"
 .   D DISPJULI(DAY1,DAYS,JULID1)
 W !,"---------------Holidays------------",!
 ;
 ;DISPLAY HOLIDAYS
 ;
 N HO,HD,PRS8D,HOLIDAY
 S PRS8D=$E(ZFMDATE,2,3) D EN^PRS8HD
 S FIRSTDAY=$E(FIRSTDAY,1,5)_"00"
 S HOLIDAY=FIRSTDAY
 S COUNT=0
 I FIRSTDAY<3140000 D
 .F  S HOLIDAY=$O(HD(HOLIDAY)) Q:HOLIDAY>LASTDAY!(HOLIDAY="")  D
 .. W !,?2,$P(HD(HOLIDAY),"^",2)," ",+$E(HOLIDAY,6,7),?15,$P(HD(HOLIDAY),"^")
 .. S COUNT=COUNT+1
 E  W "  Sorry, Can't find holidays past 2013." S COUNT=COUNT+1
 I COUNT<1 W !,"  No Holidays this month."
 W !,"-----------------------------------",!
 S OUT=0
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
SILMO(PRSDT) ;SILENT CALL TO DISPLAY MONTH
 ;  INPUT: PRSDT - must be fileman date
 ;
 N X,Y,%DT,DAY1,Y,MONTH,DAYS,YEAR,FIRSTDAY,LASTDAY,HIGHLITE,COUNT,HDR
 S X=PRSDT D ^%DT Q:Y<0
 ; if month has today-highlight
 S HIGHLITE=0
 I $E(Y,1,5)=$E(DT,1,5) S HIGHLITE=+$E(DT,6,7)
 S MONTH=$E(PRSDT,4,5),YEAR=$E(PRSDT,1,3)+1700
 S DAYS=$$DAYSINMO(YEAR,MONTH)
 S FIRSTDAY=$E(PRSDT,1,5)_"01",LASTDAY=$E(PRSDT,1,5)_DAYS
 ;
 ;Get day #s of pps in month
 N PPS
 I FIRSTDAY<3130000 D GETPPS(FIRSTDAY,LASTDAY)
 S DAY1=$$WEEKDAY1(PRSDT)
 S HDR=$$GETHEAD(Y)
 W @IOF,!,"---------------",HDR,"------------"
 D DISPMO(DAY1,DAYS,HIGHLITE)
 W !,"---------------Holidays------------",!
 ;
 ;holidays
 N HO,HD,PRS8D,HOLIDAY
 S PRS8D=$E(PRSDT,2,3) D EN^PRS8HD
 S FIRSTDAY=$E(FIRSTDAY,1,5)_"00"
 S HOLIDAY=FIRSTDAY
 S COUNT=0
 I FIRSTDAY<3140000 D
 .F  S HOLIDAY=$O(HD(HOLIDAY)) Q:HOLIDAY>LASTDAY!(HOLIDAY="")  D
 .. W !,?2,$P(HD(HOLIDAY),"^",2)," ",+$E(HOLIDAY,6,7),?15,$P(HD(HOLIDAY),"^")
 .. S COUNT=COUNT+1
 E  W "  Sorry, Can't find holidays past 2013." S COUNT=COUNT+1
 I COUNT<1 W !,"  No Holidays this month."
 W !,"-----------------------------------",!
 Q
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
DISPMO(DAYNO,NODAYS,HL) ;DISPLAY ENTIRE MONTH
 ;SAMPLE CALL:  D DISPMO(4,30) Produces a 30 month with day 1
 ;                                 beginning on Wednesday.
 ;
 ;Set up reverse video ON & OFF for today highlight
 I $G(HL)>0 N IORVOFF,IORVON S X="IORVOFF;IORVON" D ENDR^%ZISS
 ;
 N DAYS,DAYPOS,I,PPOFFSET,CNTDWN,BLDTAB
 S PPOFFSET=6,(BLDTAB,CNTDWN)=0
 S DAYS="SUN MON TUE WED THU FRI SAT"
 W !,?PPOFFSET,"  ",DAYS,!
 F I=1:1:NODAYS D
 . S DAYPOS=(DAYNO+I-1)#7
 . I DAYPOS=0 W ! I $G(PPS(I))'="" W PPS(I)
 . I ($G(HL)=I)!($G(CNTDWN)>0) D
 ..  I $G(HL)=I D
 ...   S BLDTAB=(PPOFFSET+((DAYPOS+1)*(4)-$S($L(I)=2:1,1:0)))
 ...   W ?BLDTAB,IORVON,I,IORVOFF
 ...   S BLDTAB=($X-BLDTAB)-$L(I)
 ...;   S BLDTAB=($X-BLDTAB)-1
 ...   S CNTDWN=6-DAYPOS
 ..  E  D
 ...   W ?(BLDTAB+(PPOFFSET+((DAYPOS+1)*(4)-$S($L(I)=2:1,1:0)))),I
 ...   S CNTDWN=CNTDWN-1
 . E  D
 ..  W ?(PPOFFSET+((DAYPOS+1)*(4)-$S($L(I)=2:1,1:0))),I
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;=======================
 ;
ASKJULIA() ;RETURN RESPONSE--DO YOU WANT A CALENDAR A with dates
 ; expressed as the number of days elapsed since January 1?
 N DIR,DIRUT,Y
 W !!
 S DIR("A")="Include Calendar with elapsed days since Jan 1."
 S DIR(0)="Y"
 S DIR("B")="Y"
 S DIR("?",1)="Hit return to display a calendar with dates expressed as"
 S DIR("?",2)="the number of days elapsed since January 1."
 S DIR("?",3)="Days are numbered sequentially from 1 to 365 or 366 in a"
 S DIR("?",4)="leap year.  January 1st is day number 1 and December 31st"
 S DIR("?",5)="is day 365 in a non leap year.  This calendar is often"
 S DIR("?",6)="(but incorrectly), called a Julian Calendar."
 S DIR("?",7)="------------------------------------------------------"
 S DIR("?",8)="Julian Calendar"
 S DIR("?",9)="==============="
 S DIR("?",10)="  The solar calendar introduced by Julius Caesar in Rome "
 S DIR("?",11)="  in 46 B.C., having a year of 12 months and 365 days and"
 S DIR("?",12)="  a leap year of 366 days every fourth year. It was"
 S DIR("?",13)="  eventually replaced by the Gregorian calendar."
 S DIR("?",14)="------------------------------------------------------"
 S DIR("?")=" Hit return to include the elapsed days calendar."
 D ^DIR
 Q Y
 ;=======================
DISPJULI(DAYNO,NODAYS,JULIAND1) ;
 ; DISPLAY GREGORIAN AND JULIAN CALENDAR SIDE BY SIDE
 ;SAMPLE CALL:  D DISPMO(4,30) Produces a 30 month with day 1
 ;                                 beginning on Wednesday.
 ;
 N DAYS,DAYPOS,I,PPOFFSET
 S PPOFFSET=6
 W !
 F I=1:1:NODAYS D
 . S DAYPOS=(DAYNO+I-1)#7
 . I DAYPOS=0 W ! I $G(PPS(I))'="" W PPS(I)
 . W ?(PPOFFSET+((DAYPOS+1)*4-($L(I+JULIAND1)-1))),I+JULIAND1
 Q
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
 ;
PAYROLMO(DAYNO,NODAYS) ;PAYROLL STYLE DISPLAY OF ENTIRE MONTH
 ;SAMPLE CALL:  D DISPMO(4,30) Produces a 30 month with day 1
 ;                                 beginning on Wednessday.
 ;
 N DAYS,DAYPOS,I
 S DAYS="SUN MON TUE WED THU FRI SAT"
 W !,"  ",DAYS,!
 F I=1:1:NODAYS D
 . S DAYPOS=(DAYNO+I-1)#7
 . I DAYPOS=0 W !
 . W ?((DAYPOS+1)*(4)-$S($L(I)=2:1,1:0)),I
 Q
DAYSINMO(Y,M) ; Return number of days in month based on year and month
 ;  Input:  Y = year in 4 digit format between 1700 and 3000
 ;          M = month expressed as an integer from 1 to 12 (Jan - Dec)
 ;
 N GOODY,GOODM S (GOODY,GOODM)=0
 I Y<2700,Y>1700 S GOODY=1
 I M>0,M<13 S GOODM=1
 Q:'(GOODM&GOODY) 0
 Q $P("31^"_(28+$$LEAPYR^PRSLIB00(YEAR))_"^31^30^31^30^31^31^30^31^30^31",U,MONTH)
 ;= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
GETJULI(ZFMDATE,YEAR) ;
 N X1,X2
 S X2=YEAR-1700_"0101"
 S X1=ZFMDATE
 D ^%DTC
 Q X
