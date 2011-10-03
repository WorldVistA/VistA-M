SPNLRUDT ; ISC-SF/GMB - SCD DATE UTILITIES; 6 JUL 94 [ 07/12/94  6:54 AM ] ;3/27/98  08:34
 ;;2.0;Spinal Cord Dysfunction;**4,5**;01/02/1997
 ; This routine contains all the date utilities.
 ; TESTMATH     routine to test DATEMATH
 ; DATEMATH     function to increment/decrement any FM date
 ; DATEEOM      function to return the last date of the month
 ; DATEFMT      function to format an FM date into a more common form
TESTMATH ;
 N IDATE,INCR
 W !,"Welcome to the DATEMATH test!"
 W !,"Date must be in FM yyymmdd format."
 W !,"Increment must be a positive or negative number followed by D,W,M, or Y."
 W !,"(Stands for Day, Week, Month, or Year)"
 W !,"For example, 2940331 and 1W equals 2940407.  Now you try it...",!
 F  D  Q:IDATE=""!(INCR="")
 . R !,"Enter date:      ",IDATE:DTIME Q:IDATE=""
 . R !,"Enter increment: ",INCR:DTIME Q:INCR=""
 . W !,"Result is:       ",$$DATEMATH(IDATE,INCR),!
 Q
DATEMATH(IDATE,INCR) ;
 ; DATEMATH is a function which will add (or subtract) any number of
 ; days, weeks, months, or years to (or from) a given date.
 ;
 ; IDATE  The given date (FM yyymmdd format)
 ; INCR   The increment, a positive or negative number followed by
 ;        D (day), W (week), M (month), or Y (year).
 ;
 ; Examples:
 ;
 ; S NEXTYEAR=$$DATEMATH("2940501","1Y") ... sets NEXTYEAR to "2950501"
 ; S YESTRDAY=$$DATEMATH("2940501","-1D")... sets YESTRDAY to "2940430"
 ; 
 N RESULT,LEN,TYPE,QUAN,X,X1,X2,ZDAY,MONTHS,MONTH,YEAR,YEARS
 S LEN=$L(INCR)
 S TYPE=$E(INCR,LEN)
 S QUAN=$E(INCR,1,LEN-1)
 I TYPE="W" S QUAN=QUAN*7,TYPE="D"
 I TYPE="D" D  Q X
 . S X1=IDATE
 . S X2=QUAN
 . D C^%DTC
 I TYPE="M" D
 . S MONTHS=$E(IDATE,4,5)+QUAN
 . S YEARS=MONTHS\12
 . S MONTH=MONTHS#12
 . I MONTHS<1 D
 . . S YEARS=YEARS-1
 . . I MONTH=0 S MONTH=12
 . S YEAR=$E(IDATE,1,3)+YEARS
 . S MONTH=$TR($J(MONTH,2)," ","0")
 . S ZDAY=$E(IDATE,6,7) ; Now make sure month may have 31 days...
 . I ZDAY="31","/04/06/09/11/"["/"_MONTH_"/" S ZDAY="30" ; We'll check Feb later.
 . S RESULT=YEAR_MONTH_ZDAY
 E  S RESULT=($E(IDATE,1,3)+QUAN)_$E(IDATE,4,7) ; (TYPE=Y)
 ; Now we need to check for Feb 29,30,31.    Any year divisible by 4 is a
 I $E(RESULT,4,5)="02",$E(RESULT,6,7)>28 D  ;leap year.  However, if the
 . S YEAR=$E(RESULT,1,3) ;year is a century year, it
 . I YEAR#4=0 D  ;must also be divisible by 400.
 . . I YEAR#100=0 S RESULT=YEAR_"02"_$S((YEAR+100)#400=0:"29",1:"28")
 . . E  S RESULT=YEAR_"0229"
 . E  S RESULT=YEAR_"0228"
 Q RESULT
DATEEOM(IDATE) ;
 ; Given a FileMan date (yyymmdd), this function returns the
 ; end-of-month date for the month of the given date.
 ;
 ; Example:  S EOM=$$DATEEOM("2940411")
 ;           ...sets EOM to the last date in April: "2940430"
 ;
 Q $$DATEMATH($$DATEMATH($E(IDATE,1,5)_"01","1M"),"-1D")
DATEFMT(IDATE,TYPEFMT,CHAR) ;
 ; Given a FileMan date (yyymmdd), and optionally, the type of format
 ; desired, and the character to be used, this function returns a
 ; formatted date.
 ;
 ; IDATE    the FileMan date to format
 ; TYPEFMT  1 = mm/dd/yy (default)
 ;          2 = dd/mm/yy
 ;          3 = dd mmm yy
 ;          4 = mm/dd/yyyy ;**MOD,SD/AB,1/27/98, 4-digit year (YR 2000 Compliancy)
 ; CHAR     the character to use as the separator (default="/")
 ;
 ; Example:  W !,$$DATEFMT("2940411",1,"/")
 ;            ... returns 04/11/94
 ;
 S:'$D(TYPEFMT) TYPEFMT=1
 S:'$D(CHAR) CHAR="/"
 I TYPEFMT=1 Q $E(IDATE,4,5)_CHAR_$E(IDATE,6,7)_CHAR_$E(IDATE,2,3)
 I TYPEFMT=2 Q $E(IDATE,6,7)_CHAR_$E(IDATE,4,5)_CHAR_$E(IDATE,2,3)
 I TYPEFMT=3 Q +$E(IDATE,6,7)_" "_$P("Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",",",$E(IDATE,4,5))_" "_$E(IDATE,2,3)
 ;**MOD,SD/AB,1/27/98, Added TYPEFMT=4 to return 4-digit year
 I TYPEFMT=4 Q $E(IDATE,4,5)_CHAR_$E(IDATE,6,7)_CHAR_(1700+$E(IDATE,1,3))
 Q "???"
