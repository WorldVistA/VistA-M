PXRMDATE ; SLC/PKR - Clinical Reminders date utilities. ;10/30/2009
 ;;2.0;CLINICAL REMINDERS;**4,6,12,17**;Feb 04, 2005;Build 102
 ;
 ;==================================================
CEFD(FDA) ;Called by the Exchange Utility only if the input packed
 ;reminder was packed under v1.5  Move Effective Date to Beginning Date.
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
 S BDT=$S(X(1)'="":$$CTFMD^PXRMDATE(X(1)),1:0)
 S EDT=X(2)
 I EDT="" S EDT="T"
 S EDT=$$CTFMD^PXRMDATE(EDT)
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
 ;forms as well as T-NY to a FileMan date. Also understands LAD for
 ;Last Admission Date.
 N %DT,ND,X,Y
 ;Already a FileMan date?
 S ND=+DATE
 I (ND'<1000000),(ND'>9991231) Q DATE
 ;Check for a date FileMan understands.
 S X=DATE,%DT="ST"
 D ^%DT
 ;If it is not a FileMan date check for a symbolic date.
 I Y=-1 S Y=$$SYMDATE(DATE)
 ;If it is not a date that is understood by SYMDATE return -1
 I Y=-1 Q -1
 I $G(PXRMDATE)'="",$$ISVSYMD(DATE) D
 . N DIFFS
 . S DIFFS=-$$FMDIFF^XLFDT(DT,PXRMDATE,2)
 . S Y=$$FMADD^XLFDT(Y,0,0,0,DIFFS)
 I DATE["LAD" D
 . I $G(PXRMLAD)="" S Y=0
 . E  D
 .. N DIFFS
 .. S DIFFS=-$$FMDIFF^XLFDT(DT,$G(PXRMLAD),2)
 .. S Y=$$FMADD^XLFDT(Y,0,0,0,DIFFS)
 Q Y
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
 ;No custom date due, do regular date calculation.
 I (FREQ="")!(FREQ=-1) D  Q
 . S ^TMP(PXRMPID,$J,PXRMITEM,"WARNING","NOFREQ")="No reminder frequency - cannot compute due date!"
 . S (DUE,DUEDATE)="CNBD"
 ;
 S LDATE=$S(RESDATE["X":0,1:+RESDATE)
 I LDATE=0 S (DUE,DUEDATE)="DUE NOW" Q
 S DATE=$$FULLDATE(LDATE),DUEDATE=$$NEWDATE(DATE,FREQ)
 ;
SETDUE ;If the due date is less than or equal to today's date the reminder
 ;is due.
 S TODAY=$$NOW^PXRMDATE
 I +DUEDATE'>TODAY S DUE="DUE NOW"  Q
 ;
 S DIAT="-"_$P(DEFARR(0),U,4)
 I DIAT="-" D
 . S DIATOK=0
 . S ^TMP(PXRMPID,$J,PXRMITEM,"WARNING","DIAT")="Warning no do in advance time"
 E  S DIATOK=1
 ;
 S TDDUE=$S(DIATOK=1:$$NEWDATE(DUEDATE,DIAT),1:DUEDATE)
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
EDATE(DATE) ;Check for an historical (event) date, format as appropriate.
 I DATE=0 Q "00/00/0000"
 Q $$FMTE^XLFDT(DATE,"5DZ")
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
 ;the value in days.
 I FREQ="" Q 0
 N LEN,NUM,UNIT
 S LEN=$L(FREQ)
 S NUM=+$E(FREQ,1,LEN-1)
 S UNIT=$E(FREQ,LEN)
 ;30.42 is average number of days in a month, 365.24 is average number
 ;of days in a year. Unknown unit return 0.
 S NUM=$S(UNIT="D":NUM,UNIT="M":$$CTD(30.42,NUM),UNIT="Y":$$CTD(365.24,NUM),1:0)
 Q NUM
 ;
 ;==================================================
ISVSYMD(DATE) ;Return true if DATE is a valid symbolic date.
 N P1,P1OK,P2,P2OK,OP,PAT
 S DATE=$P(DATE,"@",1)
 S OP=$S(DATE["+":"+",1:"-")
 S P1=$P(DATE,OP,1),P1OK=0
 F PAT="T","TODAY","N","NOW" I P1=PAT S P1OK=1 Q:P1OK
 I PAT=DATE Q 1
 S P2=$P(DATE,OP,2),P2OK=0
 F PAT="1N.N","1N.N1""D""","1N.N1""M""","1N.N1""Y""" I P2?@PAT S P2OK=1 Q:P2OK
 Q P1OK&P2OK
 ;
 ;==================================================
NEWDATE(FMDATE,OFFSET) ;Given a date in VA Fileman format (FMDATE) and an
 ;offset of the form NY, NM, ND where N is a number and Y stands for
 ;years, M for months, and D for days return the new date in VA Fileman
 ;format. 
 I FMDATE=0 Q 0
 N LEN,NEWDATE,NUM,UNIT
 S LEN=$L(OFFSET)
 S NUM=+$E(OFFSET,1,LEN-1)
 S UNIT=$E(OFFSET,LEN)
 ;30.42 is average number of days in a month, 365.24 is average number
 ;of days in a year. Unknown unit return 0.
 S NUM=$S(UNIT="D":NUM,UNIT="M":$$CTD(30.42,NUM),UNIT="Y":$$CTD(365.24,NUM),1:0)
 Q +$$FMADD^XLFDT(FMDATE,NUM)
 ;
 ;==================================================
NOW() ;If the reminder global PXRMDATE is defined return it, otherwise
 ;return the current date and time.
 Q $S(+$G(PXRMDATE)>0:PXRMDATE,1:$$NOW^XLFDT)
 ;
 ;==================================================
SYMDATE(DATE) ;Convert a symbolic date into a FileMan date.
 N %DT,OPER,PFSTACK,SYM,TIME,X,Y
 S TIME=$P(DATE,"@",2),DATE=$P(DATE,"@",1)
 S X=$S(DATE="LAD":$G(PXRMLAD),1:"")
 I X="" D
 . S OPER="+-"
 . D POSTFIX^PXRMSTAC(DATE,OPER,.PFSTACK)
 I PFSTACK(0)=3 D
 . S SYM=PFSTACK(1)
 . S SYM=$S(SYM="LAD":"T",SYM="N":"N",SYM="NOW":"N",SYM="T":"T",SYM="TODAY":"T",1:"")
 . I SYM="" S Y=-1 Q
 .;FileMan only handles D, W, or M so convert Y to months.
 . I PFSTACK(2)["Y" S PFSTACK(2)=+PFSTACK(2)*12_"M"
 . S X=SYM_PFSTACK(3)_PFSTACK(2)
 I PFSTACK(0)=1 S X=PFSTACK(1)
 I TIME'="" S X=X_"@"_TIME
 S %DT="ST"
 D ^%DT
 Q Y
 ;
 ;==================================================
VDATE(VIEN) ;Given a visit ien return the visit date.
 N DATE
 I +VIEN>0 S DATE=$P($G(^AUPNVSIT(VIEN,0)),U,1)
 E  S DATE=0
 I $L(DATE)=0 S DATE=0
 ;Check for historical encounter.
 I $$ISHIST^PXRMVSIT(VIEN) S DATE=DATE_"E"
 Q DATE
 ;
