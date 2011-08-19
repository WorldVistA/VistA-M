SCDXPRGD ;ALB/JRP - DATE UTILITIES FOR ACRP PURGING;04-SEP-97
 ;;5.3;Scheduling;**128**;AUG 13, 1993
 ;
FY4DT(DATE) ;Return fiscal year given date falls within
 ;
 ;Input  : DATE - Date (FileMan) (Defaults to TODAY)
 ;Output : YYYY - Fiscal year date falls within (ex: 1997)
 ;
 ;Check input
 S DATE=+$P($G(DATE),".",1)
 S:(DATE'?7N) DATE=$$DT^XLFDT()
 ;Declare variables
 N YEAR,MONTH
 ;Pull year from given date
 S YEAR=$E(DATE,1,3)
 ;Pull month from given date
 S MONTH=+$E(DATE,4,5)
 ;Fiscal year begins in October (add one to year for Oct, Nov, and Dec)
 S:(MONTH>9) YEAR=YEAR+1
 ;Convert year to external format
 S YEAR=YEAR+1700
 ;Done
 Q YEAR
 ;
PREVFY(DATE) ;Return previous fiscal year from given date
 ;
 ;Input  : DATE - Date (FileMan) (Defaults to TODAY)
 ;Output : YYYY - Previous fiscal year from given date (ex: 1996)
 ;
 ;Check input
 S DATE=+$P($G(DATE),".",1)
 S:(DATE'?7N) DATE=$$DT^XLFDT()
 ;Declare variables
 N YEAR
 ;Convert date to same date of previous year
 S YEAR=+$E(DATE,1,3)
 S YEAR=YEAR-1
 S DATE=YEAR_$E(DATE,4,7)
 ;Return fiscal year for date in last year (done)
 Q $$FY4DT(DATE)
 ;
DR4FY(FISCAL) ;Return date range for a given fiscal year
 ;
 ;Input  : FISCAL - Year (external) (Default to current year)
 ;Ouput  : Begin ^ End - Beginning and ending dates (FileMan)
 ;
 ;Check input
 S FISCAL=+$G(FISCAL)
 S:(FISCAL'?4N) FISCAL=1700+$E($$DT^XLFDT(),1,3)
 ;Declare variables
 N BEGIN,END
 ;Fiscal year begins in October of previous year
 S BEGIN=((FISCAL-1)-1700)_"1001"
 ;Fiscal year ends in September of given year
 S END=(FISCAL-1700)_"0930"
 ;Done
 Q (BEGIN_"^"_END)
 ;
LASTDBCO(DATE) ;Return last NPCD database close-out from given date
 ;
 ;Input  : DATE - Date (FileMan) (Defaults to TODAY)
 ;Output : Date - Date that NPCD was last closed for database credit
 ;Notes  : If the database close-out date for the input date can not
 ;         be determined, the first day of the fiscal year will be
 ;         returned.  The same holds true if the database close-out
 ;         date for a previous month can not be determined.
 ;
 ;Check input
 S DATE=+$P($G(DATE),".",1)
 S:(DATE'?7N) DATE=$$DT^XLFDT()
 ;Declare variables
 N MONTH,YEAR,CLOSEOUT,DBCLOSE,TMP
 ;Get current database close-out date
 S DBCLOSE=+$$CLOSEOUT^SCDXFU04(DATE)
 ;Error - return first day of fiscal year
 I (DBCLOSE<0) S YEAR=$$FY4DT(DATE) Q +$$DR4FY(YEAR)
 S CLOSEOUT=DBCLOSE
 ;Break year & month off of given date
 S YEAR=$E(DATE,1,3)
 S MONTH=$E(DATE,4,5)
 ;Go backwards, one month at a time, from given month
 ; Stop when database close-out date is prior to current close-out date
 F  S MONTH=MONTH-1 D  Q:(CLOSEOUT<DBCLOSE)
 .;Account for jump from Jan to Dec
 .I ('MONTH) S MONTH=12,YEAR=YEAR-1
 .;Create FileMan date out of year/month
 .S MONTH="00"_MONTH
 .S TMP=$L(MONTH)
 .S MONTH=$E(MONTH,(TMP-1),TMP)
 .S TMP=YEAR_MONTH_"01"
 .;Get database close-out date
 .S CLOSEOUT=+$$CLOSEOUT^SCDXFU04(TMP)
 ;Error - return first day of fiscal year
 I (CLOSEOUT<0) S YEAR=$$FY4DT(DATE) Q +$$DR4FY(YEAR)
 ;Done
 Q CLOSEOUT
 ;
PREVMNTH(DATE) ;Return first day of previous month
 ;
 ;Input  : DATE - Month/year to return previous month from (FileMan)
 ;                Defaults to TODAY
 ;Output : Date - First day of previous month (FileMan)
 ;
 ;Check input
 S DATE=+$P($G(DATE),".",1)
 S:(DATE'?7N) DATE=$$DT^XLFDT()
 ;Declare variables
 N MONTH,YEAR,TMP
 ;Break year & month off of given date
 S YEAR=$E(DATE,1,3)
 S MONTH=$E(DATE,4,5)
 ;Decrement month by 1
 S MONTH=MONTH-1
 ;Account for jump from Jan to Dec
 I ('MONTH) S MONTH=12,YEAR=YEAR-1
 ;Re-build FileMan date
 S MONTH="00"_MONTH
 S TMP=$L(MONTH)
 S MONTH=$E(MONTH,(TMP-1),TMP)
 S TMP=YEAR_MONTH_"01"
 ; Done - Return first day of previous month
 Q TMP
 ;
LASTDAY(DATE) ;Return last day of specified month
 ;
 ;Input  : DATE - Month/year to return last day of (FileMan)
 ;                Defaults to TODAY
 ;Output : Date - Last day of month (FileMan)
 ;Notes  : This call does not return the number of days in the month
 ;
 ;Check input
 S DATE=+$P($G(DATE),".",1)
 S:(DATE'?7N) DATE=$$DT^XLFDT()
 ;Declare variables
 N MONTH,YEAR,TMP
 ;Break year & month off of given date
 S YEAR=$E(DATE,1,3)
 S MONTH=$E(DATE,4,5)
 ;Last day of month is day before first day of next month
 ; Increment month by 1
 S MONTH=MONTH+1
 ; Account for jump from Dec to Jan
 I (MONTH=13) S MONTH=1,YEAR=YEAR+1
 ; Build FileMan date denoting first day of next month
 S MONTH="00"_MONTH
 S TMP=$L(MONTH)
 S MONTH=$E(MONTH,(TMP-1),TMP)
 S TMP=YEAR_MONTH_"01"
 ; Done - Return day prior to first day of next month
 Q $$FMADD^XLFDT(TMP,-1,0,0,0)
