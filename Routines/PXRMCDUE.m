PXRMCDUE ;SLC/PKR - Custom date due calculation routines. ;08/29/2008
 ;;2.0;CLINICAL REMINDERS;**4,6,12**;Feb 04, 2005;Build 73
 ;
 ;========================================================
CDBUILD(STRING,DA) ;Given a custom date due string build the data
 ;structure. This is called by a new-style cross-reference after
 ;the date due string has passed the input transform so we don't need
 ;to validate the elements.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 N FDA,FILIST,FREQLIST,FUNCTION,IENB,IENS,IND,MSG,NARGS,PFSTACK
 S STRING=$$UP^XLFSTR(STRING)
 D PARSE(STRING,.FUNCTION,.NARGS,.FILIST,.FREQLIST)
 S IENS=DA_","
 S FDA(811.9,IENS,46)=FUNCTION,FDA(811.9,IENS,47)=NARGS
 S IENB=DA
 F IND=1:1:NARGS D
 . S IENB=IENB+1
 . S IENS="+"_IENB_","_DA_","
 . S FDA(811.948,IENS,.01)=FILIST(IND)
 . S FDA(811.948,IENS,.02)=FREQLIST(IND)
 D UPDATE^DIE("","FDA","","MSG")
 I $D(MSG) D
 . W !,"The update failed, UPDATE^DIE returned the following error message:"
 . D AWRITE^PXRMUTIL("MSG")
 Q
 ;
 ;========================================================
CDUEDATE(DEFARR,FIEVAL) ;Do the custom date due calculation and return
 ;the due date.
 N DATE,DDUE,DLIST,FI,FREQ,FUNCTION,IND,NARGS,TEMP
 S FUNCTION=$P(DEFARR(46),U,1)
 S NARGS=$P(DEFARR(46),U,2)
 F IND=1:1:NARGS D
 . S TEMP=DEFARR(47,IND,0)
 . S FI=$P(TEMP,U,1)
 . S FREQ=$P(TEMP,U,2)
 . S DATE=$S(FIEVAL(FI):+FIEVAL(FI,"DATE"),1:0)
 . I DATE>0 S DATE=$$FULLDATE^PXRMDATE(DATE)
 . S DLIST(IND)=$$NEWDATE^PXRMDATE(DATE,FREQ)
 S TEMP=$S(FUNCTION="MAX_DATE":$$MAXDATE(NARGS,.DLIST),FUNCTION="MIN_DATE":$$MINDATE(NARGS,.DLIST),FUNCTION="RANK_DATE":$$RANKDATE(NARGS,.DLIST),1:0)
 S DDUE=$P(TEMP,U,1)
 I DDUE=0 Q -1
 S IND=$P(TEMP,U,2)
 S TEMP=DEFARR(47,IND,0)
 S FI=$P(TEMP,U,1)
 S FREQ=$P(TEMP,U,2)
 S DATE=+$G(FIEVAL(FI,"DATE"))
 S ^TMP(PXRMPID,$J,PXRMITEM,"zCDUE")=FI_U_FREQ_U_DATE
 Q DDUE
 ;
 ;========================================================
CDKILL(X,DA) ;
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q
 K ^PXD(811.9,DA,46),^PXD(811.9,DA,47)
 Q
 ;
 ;========================================================
MAXDATE(NARGS,DLIST) ;Return the maximum date from a list of dates in DLIST.
 N IND,INDS,MAXDATE
 S (INDS,MAXDATE)=0
 F IND=1:1:NARGS I DLIST(IND)>MAXDATE S MAXDATE=DLIST(IND),INDS=IND
 Q MAXDATE_U_INDS
 ;
 ;========================================================
MINDATE(NARGS,DLIST) ;Return the minimum date from a list of dates in DLIST.
 ;Only return 0 if there is no "real" date in the list.
 N DATE,IND,INDS,MINDATE
 S INDS=0
 S MINDATE=9991231
 F IND=1:1:NARGS S DATE=DLIST(IND) I DATE<MINDATE,DATE'=0 S MINDATE=DATE,INDS=IND
 I MINDATE=9991231 S MINDATE=0
 Q MINDATE_U_INDS
 ;
 ;========================================================
OUTPUT(CDUEDATA,DEFARR) ;Build the custom date due output text.
 N CDUEFI,ENTRY,FINAME,TEXT,VPTR
 S CDUEFI=$P(CDUEDATA,U,1)
 S VPTR=$P(^PXD(811.9,DEFARR("IEN"),20,CDUEFI,0),U,1)
 S ENTRY="^"_$P(VPTR,";",2)_$P(VPTR,";",1)_",0)"
 S FINAME=$P(@ENTRY,U,1)
 S TEXT="Custom date due based on date of finding "_CDUEFI_" ("_FINAME_")"
 S TEXT=TEXT_" plus frequency of "_$P(CDUEDATA,U,2)_"."
 Q TEXT
 ;
 ;========================================================
PARSE(STRING,FUNCTION,NARGS,FILIST,FREQLIST) ;Parse a custom date due
 ;string and return the function, number of arguments, finding list,
 ;and frequency list. An argument has the form M+NF where M is a
 ;finding number, N is an integer, and F is D, M, or Y.
 N IND,OPER,PFSTACK
 S OPER=","
 D POSTFIX^PXRMSTAC(STRING,OPER,.PFSTACK)
 S FUNCTION=$$UP^XLFSTR(PFSTACK(1))
 S NARGS=0
 F IND=2:1:PFSTACK(0) D
 . I PFSTACK(IND)=OPER Q
 . S NARGS=NARGS+1
 . S FILIST(NARGS)=$P(PFSTACK(IND),"+",1)
 . S FREQLIST(NARGS)=$P(PFSTACK(IND),"+",2)
 Q
 ;
 ;========================================================
RANKDATE(NARGS,DLIST) ;Return the first non-zero date from the list of dates
 ;in DLIST. Return 0 if DLIST is all zeroes.
 N DATE,IND,INDS
 S (DATE,INDS)=0
 F IND=1:1:NARGS I DLIST(IND)>0 S DATE=DLIST(IND),INDS=IND Q
 Q DATE_U_INDS
 ;
 ;========================================================
VCDUE(STRING,DA) ;Make sure a custom date due string is valid.
 ;Do not execute as part of a verify fields.
 I $G(DIUTIL)="VERIFY FIELDS" Q 1
 ;Do not execute as part of exchange.
 I $G(PXRMEXCH) Q 1
 I '$D(DA) Q 1
 I $L(STRING)>245 Q 0
 N FILIST,FREQLIST,FUNCTION,IND,NARGS,TEXT,VALID
 D PARSE(STRING,.FUNCTION,.NARGS,.FILIST,.FREQLIST)
 S VALID=$$VFUN(FUNCTION)
 I 'VALID D
 . S TEXT=FUNCTION_" is not a valid custom date due function."
 . D EN^DDIOL(TEXT)
 F IND=1:1:NARGS D
 . I '$D(^PXD(811.9,DA,20,FILIST(IND),0)) D
 .. S TEXT="Finding number "_FILIST(IND)_" is not a valid reminder finding"
 .. D EN^DDIOL(TEXT)
 .. S VALID=0
 . I '$$VFREQ(FREQLIST(IND)) D
 .. S TEXT=FREQLIST(IND)_" is not a valid frequency."
 .. D EN^DDIOL(TEXT)
 .. S VALID=0
 Q VALID
 ;
 ;========================================================
VFREQ(FREQ) ;Make sure FREQ is a valid frequency.
 N VALID
 S VALID=1
 S FREQ=$$UP^XLFSTR(FREQ)
 I (FREQ'?1N.N1"D"),(FREQ'?1N.N1"M"),(FREQ'?1N.N1"Y") S VALID=0
 Q VALID
 ;
 ;========================================================
VFUN(FUNCTION) ;Make sure FUNCTION is a valid function.
 I FUNCTION="MIN_DATE" Q 1
 I FUNCTION="MAX_DATE" Q 1
 I FUNCTION="RANK_DATE" Q 1
 Q 0
 ;
 ;========================================================
XHELP ;Executable help for custom date due.
 N DONE,IND,TEXT
 S DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(TEXT+IND),";",3)
 . I TEXT="**End Text**" S DONE=1 Q
 . W !,TEXT
 Q
 ;
 ;========================================================
TEXT ;Custom Date Due help text.
 ;;The general form for a Custom Date Due string is:
 ;; FUNCTION(ARG1,ARG2,...,ARGN)
 ;;
 ;;FUNCTION can be one of the following:
 ;; MAX_DATE - return the maximum date from the argument list
 ;; MIN_DATE - return the minimum date from the argument list
 ;; RANK_DATE - going from left to right return the first non-zero date
 ;;             from the argument list
 ;;
 ;;The arguments have the form:
 ;; M+FREQ where M is a finding number and FREQ is a number followed by
 ;; D for days, M for months, or Y for years. Each argument is converted
 ;; to a date by adding the frequency to the date of the finding.
 ;;
 ;;Here is an example: MAX_DATE(1+6M,3+1Y)
 ;;This will take the date of finding 1 and add 6 months, the date of finding 3
 ;;and add 1 year and set the date due to the maximum of those two dates.
 ;;
 ;;**End Text**
 Q
 ;
