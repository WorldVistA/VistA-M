ONCDTUTL ;Hines OIFO/SG - CALENDAR UTILITIES  ; 9/13/06 2:35pm
 ;;2.11;ONCOLOGY;**46**;Mar 07, 1995;Build 39
 ;
 ; $$DIM, DTDIFF, and $$ISLEAP are M translations of functions from
 ; the Orpheus package (http://sourceforge.net/projects/tporpheus/).
 ;
 ; ONCDTUTL      OvcDate.pas
 ; --------      -----------
 ; DTDIFF        DateDiff
 ; $$DIM         DaysInMonth
 ; $$ISLEAP      IsLeapYear
 ;
 Q
 ;
 ;***** DTDIFF^ONCDTUTL USAGE EXAMPLE
DEMO ;
 D DEMO1(3061201,62)
 D DEMO1(3061231,62)
 D DEMO1(3000415,-700)
 D DEMO1(3051020,0)
 W !
 Q
 ;
DEMO1(DATE1,ND) ;
 N DATE2,DAYS,MONTHS,YEARS
 S DATE2=$$FMADD^XLFDT(DATE1,ND)
 D DTDIFF^ONCDTUTL(DATE1,DATE2,.DAYS,.MONTHS,.YEARS)
 W !,$$FMTE^XLFDT(DATE1)_" - "_$$FMTE^XLFDT(DATE2)
 W ?35,"Days: "_$J(DAYS,2),"  Months: "_$J(MONTHS,2),"  Years: "_YEARS
 Q
 ;
 ;***** RETURNS NUMBER OF DAYS IN THE MONTH
 ;
 ; M             Month
 ; Y             Year
 ;
DIM(M,Y) ;
 Q:(M=1)!(M=3)!(M=5)!(M=7)!(M=8)!(M=10)!(M=12) 31
 Q:(M=4)!(M=6)!(M=9)!(M=11) 30
 Q:M=2 $S($$ISLEAP(Y):29,1:28)
 Q 0
 ;
 ;***** CALCULATES DIFFERENCE BETWEEN TWO DATES
 ;
 ; DATE1         First date  (FileMan)
 ; DATE2         Second date (FileMan)
 ;
 ; .DAYS         Number of days is returned via this parameter
 ; .MONTHS       Number of months is returned via this parameter
 ; .YEARS        Number of years is returned via this parameter
 ;
DTDIFF(DATE1,DATE2,DAYS,MONTHS,YEARS) ;
 N DAY1,DAY2,DT1,DT2,MONTH1,MONTH2,TMP,YEAR1,YEAR2
 ;--- We want DATE2 > DATE1; convert to YYYY/MM/DD
 I DATE1>DATE2  D
 . S DT1=$$FMTE^XLFDT(DATE2,"7D")
 . S DT2=$$FMTE^XLFDT(DATE1,"7D")
 E  D
 . S DT1=$$FMTE^XLFDT(DATE1,"7D")
 . S DT2=$$FMTE^XLFDT(DATE2,"7D")
 ;--- Convert dates to day, month, year
 S YEAR1=$P(DT1,"/"),MONTH1=$P(DT1,"/",2),DAY1=$P(DT1,"/",3)
 S YEAR2=$P(DT2,"/"),MONTH2=$P(DT2,"/",2),DAY2=$P(DT2,"/",3)
 ;--- Days first
 S:DAY1=$$DIM(MONTH1,YEAR1) DAY1=0,MONTH1=MONTH1+1
 S:DAY2=$$DIM(MONTH2,YEAR2) DAY2=0,MONTH2=MONTH2+1
 I DAY2<DAY1  D
 . S MONTH2=MONTH2-1
 . S:'MONTH2 MONTH2=12,YEAR2=YEAR2-1
 . S DAYS=DAY2+$$DIM(MONTH1,YEAR1)-DAY1
 E  S DAYS=DAY2-DAY1
 ;--- Now months and years
 S:MONTH2<MONTH1 MONTH2=MONTH2+12,YEAR2=YEAR2-1
 S MONTHS=MONTH2-MONTH1,YEARS=YEAR2-YEAR1
 Q
 ;
 ;***** INDICATES LEAP YEAR
 ;
 ; YEAR          Year (4 digits)
 ;
 ; Return Values:
 ;        0  Regular year
 ;        1  Leap year
 ;
ISLEAP(YEAR) ;
 Q (YEAR#4=0)&(YEAR#4000'=0)&((YEAR#100'=0)!(YEAR#400=0))
