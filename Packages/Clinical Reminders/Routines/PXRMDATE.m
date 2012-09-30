PXRMDATE ;SLC/PKR - Clinical Reminders date utilities. ;10/27/2011
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17,18**;Feb 04, 2005;Build 152
 ;
 ;==================================================
CEFD(FDA) ;Called by the Exchange Utility only if the input packed
 ;reminder was packed under v1.5.  Move Effective Date to Beginning Date.
 N IND
 S IND=""
 F  S IND=$O(FDA(811.902,IND)) Q:IND=""  D
 . I '$D(FDA(811.902,IND,12)) Q
 .;If the EFFECTIVE PERIOD exists don't do anything.
 . I $D(FDA(811.902,IND,9)) Q
 . S FDA(811.902,IND,9)=FDA(811.902,IND,12)
 . K FDA(811.902,IND,12)
 Q
 ;
 ;==================================================
COMPARE(X) ;Compare beginning and ending dates, give a warning if
 ;Ending Date comes before Beginning Date. Called by ADATE xref in
 ;definitions and terms.
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N BDT,EDT,TEXT
 ;Dates that are only defined during evaluation, i.e., FIEVAL(2,"DATE")
 ;cannot be checked here.
 S BDT=$S(X(1)'="":$$CTFMD^PXRMDATE(X(1)),1:0)
 I BDT=-1 Q
 S EDT=X(2)
 I EDT="" S EDT="T"
 S EDT=$$CTFMD^PXRMDATE(EDT)
 I EDT=-1 Q
 ;If EDT does not contain a time set it to the end of the day.
 I EDT'["." S EDT=EDT_".235959"
 I EDT<BDT D
 . S BDT=$S(X(1)'="":X(1),1:"")
 . S EDT=$S(X(2)'="":X(2),1:"T@2400")
 . S TEXT="Warning the ending date ("_EDT_") is before the beginning date ("_BDT_")"
 . D EN^DDIOL(TEXT)
 Q
 ;
 ;==================================================
COTN(EFP) ;Convert an Effective Period to the new date/time format.
 ;Possible effective periods are ND, NM, or NY where N is an integer.
 S EFP=$$UP^XLFSTR(EFP)
 I (EFP?1N.N1"D")!(EFP?1N.N1"M")!(EFP?1N.N1"Y") D
 . S NUM=+EFP
 . S EFP=$S(NUM=0:"T",1:"T-"_EFP)
 Q EFP
 ;
 ;==================================================
CTD(MULT,NUM) ;Convert months or years to days.
 N DAYS,INTDAYS,FRAC
 S DAYS=MULT*NUM
 ;Round the number of days.
 S INTDAYS=+$P(DAYS,".",1)
 S FRAC=DAYS-INTDAYS
 S DAYS=$S(FRAC<0.5:INTDAYS,1:INTDAYS+1)
 Q DAYS
 ;
 ;==================================================
CTFMD(DATE) ;Convert DATE which may be in any of the FileMan acceptable
 ;forms with additional CR extensions to an internal FileMan date.
 N FMDATE,OFFSET,OP,SYM,SYMV,TDATE
 ;Already in internal FileMan date format?
 I DATE?7N Q DATE
 I DATE?7N1"."1.6N Q DATE
 S TDATE=$TR(DATE," ",""),TDATE=$$UP^XLFSTR(TDATE)
 ;Check for dates in the form SYMBOL+IU,or SYMBOL-IU, where I is
 ;an integer and U is a unit.
 S OP=$S(TDATE["+":"+",TDATE["-":"-",1:"")
 S SYM=$S(OP'="":$P(TDATE,OP,1),1:TDATE)
 S OFFSET=$S(OP'="":$P(TDATE,OP,2),1:"")
 ;If the symbolic part is not on the list of valid symbols try FileMan.
 I '$$VSYM(SYM) D DT^DILF("ST",DATE,.FMDATE) Q FMDATE
 ;Check for a valid offset.
 I OFFSET'="",'$$VOFFSET(OFFSET) Q -1
 I ((SYM="T")!(SYM="TODAY")),OFFSET["H" D  Q -1
 . I $G(PXRMINTR)=1 D EN^DDIOL("Cannot use "_SYM_" with "_OFFSET)
 ;If this is being called by the input transform VDT^PXRMINTR we
 ;are done.
 I $G(PXRMINTR)=1 Q 1
 ;If the symbol does not equate to an internal FM date return -1
 S SYMV=$S(SYM="T":$$TODAY,SYM="TODAY":$$TODAY,SYM="N":$$NOW,SYM="NOW":$$NOW,SYM="NOON":$$NOON,SYM="MID":$$MID,1:+$G(@SYM))
 I '(SYMV?7N0.1"."0.6N) Q -1
 Q $$NEWDATE(SYMV,OP,OFFSET)
 ;
 ;=================================================
DCHECK(DATE) ;Trap for special characters before calling CTFMD^PXRMDATE.
 ;Used in DIR("PRE") for date inputs.
 I $D(DTOUT) Q DATE
 I DATE="" Q DATE
 I DATE["^" Q DATE
 I DATE["?" Q DATE
 Q $$CTFMD^PXRMDATE(DATE)
 ;
 ;==================================================
DDATE(DATE) ;Check for an historical (event) date, format as appropriate,
 ;withou time.
 I DATE=0 Q "00/00/0000"
 Q $$FMTE^XLFDT(DATE,"5DZ")
 ;
 ;==================================================
DUE(DEFARR,RESDATE,FREQ,DUE,DUEDATE,FIEVAL) ;Compute the due date.
 ;This is the date of the resolution finding + the reminder frequency.
 ;Subtract the due in advance time to see if the reminder should be
 ;marked as due soon.
 ;
 N DATE,DIAT,DIATOK,LDATE,PXRMITEM,TDDUE,TODAY
 S PXRMITEM=DEFARR("IEN")
 ;If the final frequency is 0Y then the reminder is not due.
 I FREQ="0Y" S DUE=0,DUEDATE="" Q
 ;
 S DUEDATE=""
 ;Check for custom date due.
 I DEFARR(45)'="" S DUEDATE=$$CDUEDATE^PXRMCDUE(.DEFARR,.FIEVAL)
 I DUEDATE'="",DUEDATE'=-1 G SETDUE
 ;
 ;If there is no resolution logic then frequency is not required.
 I (FREQ="")!(FREQ=-1)&(DEFARR(35)'="") D  Q
 . S ^TMP(PXRMPID,$J,PXRMITEM,"WARNING","NOFREQ")="No reminder frequency - cannot compute due date!"
 . S (DUE,DUEDATE)="CNBD"
 ;
 S LDATE=$S(RESDATE["X":0,1:+RESDATE)
 I LDATE=0 S (DUE,DUEDATE)="DUE NOW" Q
 S DATE=$$FULLDATE(LDATE),DUEDATE=$$NEWDATE(DATE,"+",FREQ)
 ;
SETDUE ;If the due date is less than or equal to today's date the
 ;reminder is due.
 S TODAY=$$TODAY^PXRMDATE
 I +DUEDATE'>TODAY S DUE="DUE NOW"  Q
 ;
 S DIAT=$P(DEFARR(0),U,4)
 I DIAT="" D
 . S DIATOK=0
 . S ^TMP(PXRMPID,$J,PXRMITEM,"WARNING","DIAT")="Warning no do in advance time"
 E  S DIATOK=1
 ;
 S TDDUE=$S(DIATOK=1:$$NEWDATE(DUEDATE,"-",DIAT),1:DUEDATE)
 S DUE=$S(TDDUE'>TODAY:"DUE SOON",1:"RESOLVED")
 Q
 ;
 ;==================================================
DURATION(START,STOP) ;Return the number days between the Start Date and
 ;Stop Date.
 I +START=0 Q 0
 N PXRMNOW
 S PXRMNOW=$$NOW^PXRMDATE
 I START>PXRMNOW Q 0
 I (STOP="")!(STOP>PXRMNOW) S STOP=PXRMNOW
 Q $$FMDIFF^XLFDT(STOP,START)
 ;
 ;==================================================
EDATE(DATE) ;Check for an historical (event) date, format as appropriate,
 ;include time.
 I DATE=0 Q "00/00/0000"
 Q $$FMTE^XLFDT(DATE,"5Z")
 ;
 ;==================================================
FMDATE(DFN,TEST,DATE,VALUE,TEXT) ;FileMan date computed finding.
 I TEST="" S TEST=0 Q
 S (DATE,VALUE)=$$CTFMD^PXRMDATE(TEST)
 S TEST=1
 Q
 ;
 ;==================================================
FULLDATE(DATE) ;See if DATE is a full date, i.e., it has a month and
 ;a day along with a year. If the month is missing assume Jan. If the
 ;day is missing assume the first. Issue a warning so the user knows
 ;what happened. DATE should be in Fileman format.
 N DAY,MISSING,MONTH,TDATE,YEAR
 S TDATE=DATE
 S MISSING=0
 S DAY=$E(DATE,6,7)
 S MONTH=$E(DATE,4,5)
 S YEAR=$E(DATE,1,3)
 I +DAY=0 D
 . S DAY=1
 . S MISSING=1
 . S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","NO DAY")="Encounter date missing the day, using the first for the date due calculation."
 I +MONTH=0 D
 . S MONTH=1
 . S MISSING=1
 . S ^TMP(PXRMPID,$J,PXRMITEM,"INFO","NO MONTH")="Encounter date missing the month, using January for the date due calculation."
 I MISSING D
 . S TDATE=(YEAR*1E4)+(MONTH*1E2)+DAY
 . I DATE["E" S TDATE=TDATE_"E"
 Q TDATE
 ;
 ;==================================================
FRQINDAY(FREQ) ;Given a frequency in the form ND, NM, or NY where N is a
 ;number and D stands for days, M for months, and Y for years return
 ;the value in days. Used for ranking only.
 I FREQ="" Q 0
 N LEN,NUM,UNIT
 S NUM=+FREQ
 S LEN=$L(FREQ)
 S UNIT=$E(FREQ,LEN)
 ;30.42 is average number of days in a month, 365.24 is average number
 ;of days in a year. Unknown unit return 0.
 S NUM=$S(UNIT="D":NUM,UNIT="M":$$CTD(30.42,NUM),UNIT="Y":$$CTD(365.24,NUM),1:0)
 Q NUM
 ;
 ;==================================================
ISLEAP(YEAR) ;Given a 3 digit FileMan year return 1 if it is a leap year,
 ;0 otherwise.
 S YEAR=YEAR+1700
 Q (YEAR#4=0)&'(YEAR#100=0)!(YEAR#400=0)
 ;
 ;==================================================
MCALC(FMDATE,OP,NUM) ;Add or subtract NUM months to FMDATE.
 N DAY,DIM,MONTH,TIME,YEAR
 S YEAR=$E(FMDATE,1,3),MONTH=$E(FMDATE,4,5),DAY=$E(FMDATE,6,7)
 S TIME=$P(FMDATE,".",2)
 I TIME'="" S TIME="."_TIME
 I OP="+" F  Q:'NUM  S NUM=NUM-1,MONTH=MONTH+1 I MONTH=13 S YEAR=YEAR+1,MONTH=1
 I OP="-" F  Q:'NUM  S NUM=NUM-1,MONTH=MONTH-1 I MONTH=0 S YEAR=YEAR-1,MONTH=12
 S DIM="31^"_($$ISLEAP(YEAR)+28)_"^31^30^31^30^31^31^30^31^30^31"
 I DAY>$P(DIM,"^",MONTH) S DAY=$P(DIM,"^",MONTH)
 Q YEAR_"00"+MONTH_"00"+DAY_TIME
 ;
 ;==================================================
MID() ;If the reminder global PXRMDATE is defined return midnight on that day,
 ;otherwise return the current date at midnight.
 Q $S(+$G(PXRMDATE)>0:$E(PXRMDATE,1,7),1:$$DT^XLFDT)_".24"
 ;
 ;==================================================
NEWDATE(FMDATE,OP,OFFSET) ;Given an internal FileMan date, an operator of 
 ;that is + or - ,and an offset of the form I, ID, IW, IM, IY 
 ;where I is a positive integer and H is hours, D is days, W is weeks,
 ;M is months, and Y is years calculate and return the new FM date.
 N DAYS,HOURS,MONTH,NUM,UNIT,YEAR
 I FMDATE=0 Q 0
 S NUM=+OFFSET
 I NUM<0 Q -1
 S YEAR=$E(FMDATE,1,3),MONTH=$E(FMDATE,4,5),DAY=$E(FMDATE,6,7)
 S UNIT=$E(OFFSET,$L(NUM)+1)
 I UNIT="" S UNIT="D"
 I UNIT="H" S HOURS=OP_NUM Q $$FMADD^XLFDT(FMDATE,0,HOURS,0,0)
 I UNIT="D" S DAYS=OP_NUM Q $$FMADD^XLFDT(FMDATE,DAYS,0,0,0)
 I UNIT="W" S DAYS=OP_(NUM*7) Q $$FMADD^XLFDT(FMDATE,DAYS,0,0,0)
 I UNIT="M" Q $$MCALC(FMDATE,OP,NUM)
 I UNIT="Y" Q $$YCALC(FMDATE,OP,NUM)
 Q -1
 ;
 ;==================================================
NOON() ;If the reminder global PXRMDATE is defined return noon on that day,
 ;otherwise return the current date at noon.
 Q $S(+$G(PXRMDATE)>0:$E(PXRMDATE,1,7),1:$$DT^XLFDT)_".12"
 ;
 ;==================================================
NOW() ;If the reminder global PXRMDATE is defined return it, otherwise
 ;return the current date and time.
 I +$G(PXRMDATE)=0 Q $$NOW^XLFDT
 N NOW,TIME
 S TIME=$P(PXRMDATE,".",2)
 I TIME="" S TIME=$P($$NOW^XLFDT,".",2),NOW=PXRMDATE_"."_TIME
 E  S NOW=PXRMDATE
 Q NOW
 ;
 ;==================================================
TODAY() ;If the reminder global PXRMDATE is defined return it, otherwise
 ;return the current date.
 Q $S(+$G(PXRMDATE)>0:$P(PXRMDATE,".",1),1:$$DT^XLFDT)
 ;
 ;==================================================
VDATE(VIEN) ;Given a visit ien return the visit date.
 N DATE
 S DATE=$S(+VIEN>0:$P($G(^AUPNVSIT(VIEN,0)),U,1),1:0)
 I $L(DATE)=0 S DATE=0
 ;Check for historical encounter.
 I $$ISHIST^PXRMVSIT(VIEN) S DATE=DATE_"E"
 Q DATE
 ;
 ;==================================================
VOFFSET(OFFSET) ;Make sure the offset part of a date is valid. It has to
 ;have the form I or IU where I is an integer and U is one of the
 ;following units: H, D, W, M, Y.
 I OFFSET?1.N0.1"H"0.1"D"0.1"W"0.1"M"0.1"Y" Q 1
 Q 0
 ;
 ;==================================================
VSYM(SYM) ;Make sure the symbolic part of a date is valid.
 ;Already in FileMan internal form.
 I SYM?7N Q 1
 I SYM?7N1"."1.6N Q 1
 ;Check for FileMan symbols.
 I (SYM="T")!(SYM="TODAY") Q 1
 I (SYM="N")!(SYM="NOW") Q 1
 I (SYM="NOON") Q 1
 I (SYM="MID") Q 1
 ;Check for Clinical Reminder symbols.
 I SYM="PXRMLAD" Q 1
 I SYM="PXRMDOB" Q 1
 I SYM="PXRMDOD" Q 1
 I SYM?1"FIEVAL("1.N1","0.1(1.N1",")1"""DATE"")" Q 1
 Q 0
 ;
 ;==================================================
YCALC(FMDATE,OP,NUM) ;Add or subtract NUM years to FMDATE.
 N DAY,MONTH,TIME,YEAR
 S YEAR=$E(FMDATE,1,3),MONTH=$E(FMDATE,4,5),DAY=$E(FMDATE,6,7)
 S TIME=$P(FMDATE,".",2)
 I TIME'="" S TIME="."_TIME
 I OP="+" F  Q:'NUM  S NUM=NUM-1,YEAR=YEAR+1
 I OP="-" F  Q:'NUM  S NUM=NUM-1,YEAR=YEAR-1
 ;Handle leap year.
 I MONTH="02",DAY>27,'$$ISLEAP(YEAR) S DAY=28
 Q YEAR_"00"+MONTH_"00"+DAY_TIME
 ;
