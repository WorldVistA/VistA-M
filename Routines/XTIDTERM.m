XTIDTERM ;OAKCIOFO/JLG - TERM/CONCEPT index entry ;03/18/2005  15:12
 ;;7.3;TOOLKIT;**93**;Apr 25, 1995
 Q
 ; encapsulates a term/concept index entry for both
 ; "set of codes" and "table" indexes
 ; it interfaces through FileMan
 ; TERM is by reference and is in FDA format + CTX data
 ; only exceptions are $$GETSTAT and $$SETSTAT
 ; FDA format is left for convenience but future
 ; implementations might customize it.
 ; TERM is passed by ref in all calls
GETVUID(TERM) ; return VUID value
 ;
 N FILE,IENS
 Q:'$D(TERM)
 S FILE=TERM("CTX","SOURCE FILE#")
 S IENS=$O(TERM(FILE,""))
 Q $G(TERM(FILE,IENS,"VUID","I"))
 ;
GETMASTR(TERM) ; return MASTER VUID value
 ; 
 N FILE,IENS
 Q:'$D(TERM)
 S FILE=TERM("CTX","SOURCE FILE#")
 S IENS=$O(TERM(FILE,""))
 Q $G(TERM(FILE,IENS,"MASTER ENTRY FOR VUID","I"))
 ;
GETSTAT(TERM,DATE) ; return MASTER VUID value
 ; 
 N FILE,SFILE,IENS,STATUS
 Q:'$D(TERM)
 S:'$G(DATE) DATE=$$NOW^XLFDT
 S FILE=TERM("CTX","SOURCE FILE#")
 S SFILE=TERM("CTX","TERMSTATUS SUBFILE#")
 S IENS=","_$O(TERM(FILE,""))
 S STATUS=$$FINDSTAT(SFILE,IENS,DATE)
 ;I 'STATUS Q "^status not found for given date/time"
 Q $P(STATUS,"^",2,4)
 ;
SETVUID(TERM,VUID) ; set new VUID to existing TERM
 ;
 N DIERR,FLAGS,FILE,IENS,MSG,MYFDA,SUCCESS
 S VUID=$G(VUID)
 Q:'$D(TERM)!('VUID) 0
 ; check constraints first
 Q:$$CNSTR1() 0
 S SUCCESS=0,FLAGS="KS"
 S FILE=TERM("CTX","SOURCE FILE#")
 S IENS=$O(TERM(+FILE,""))
 Q:IENS']"" SUCCESS
 S MYFDA(FILE,IENS,99.99)=VUID
 D FILE^DIE(FLAGS,"MYFDA","MSG")
 I '$D(MSG("DIERR")) D
 . S SUCCESS=1
 . ; update the cached TERM array
 . S TERM(FILE,IENS,"VUID","I")=VUID
 ;
 Q SUCCESS
 ;
SETMASTR(TERM,MVUID) ; set MASTER ENTRY flag to existing TERM
 ;
 N DIERR,FLAGS,FILE,IENS,MSG,MYFDA,SUCCESS
 S MVUID=+$G(MVUID)
 Q:'$D(TERM) 0
 ; check constraints first and override VUID flag
 I MVUID,$$CNSTR2() S MVUID=0
 S FILE=TERM("CTX","SOURCE FILE#")
 S IENS=$O(TERM(+FILE,""))
 Q:IENS']"" 0
 S SUCCESS=0,FLAGS="KS"
 S MYFDA(FILE,IENS,99.98)=MVUID
 D FILE^DIE(FLAGS,"MYFDA","MSG")
 I '$D(MSG("DIERR")) D
 . S SUCCESS=1
 . ; update the cached TERM array
 . S TERM(FILE,IENS,"MASTER ENTRY FOR VUID","I")=MVUID
 ;
 Q SUCCESS
 ;
SETSTAT(TERM,STATUS,DATE) ; set status
 ; set status and date for the given term 
 N DIERR,FLAGS,FILE,SFILE,MYFDA,MSG,SUCCESS,IENS
 S STATUS=$G(STATUS),DATE=$G(DATE)
 Q:'$D(TERM)!(STATUS']"") 0
 S SUCCESS=0,FLAGS="KS"
 S STATUS=+$G(STATUS)
 S:'$G(DATE) DATE=$$NOW^XLFDT
 S FILE=TERM("CTX","SOURCE FILE#")
 S SFILE=TERM("CTX","TERMSTATUS SUBFILE#")
 S IENS="?+1,"_$O(TERM(FILE,""))
 S MYFDA(SFILE,IENS,.01)=DATE
 S MYFDA(SFILE,IENS,.02)=STATUS
 D UPDATE^DIE(FLAGS,"MYFDA","","MSG")
 S:'$D(MSG("DIERR")) SUCCESS=1
 Q SUCCESS
 ;
FINDSTAT(FILE,IENS,DATE) ; find status info 
 ; find status of term for given DATE
 ; D LIST^DIC(FILE,IENS,FIELDS,FLAGS,NUMBER,[.]FROM,[.]PART,INDEX,[.]SCREEN,IDENTIFIER,TARGET_ROOT,MSG_ROOT)
 N DIERR,FIELDS,FLAGS,FROM,MSG,MYSTAT,NUMBER,STATUS
 S STATUS="^^^"
 S:'$G(DATE) DATE=$$NOW^XLFDT
 S FROM=DATE+.000001
 S FIELDS="@;.01IE;.02IE",FLAGS="B",NUMBER=1
 D LIST^DIC(FILE,IENS,FIELDS,FLAGS,NUMBER,FROM,"","","","","MYSTAT","MSG")
 Q:$D(MSG("DIERR")) STATUS
 I $D(MYSTAT("DILIST","ID",1)) D
 . N ESTAT,IDATE,IENSTAT,ISTAT
 . S IENSTAT=$G(MYSTAT("DILIST",2,1))
 . S ISTAT=$G(MYSTAT("DILIST","ID",1,.02,"I"))
 . S ESTAT=$G(MYSTAT("DILIST","ID",1,.02,"E"))
 . S IDATE=$G(MYSTAT("DILIST","ID",1,.01,"I"))
 . S STATUS=IENSTAT_"^"_ISTAT_"^"_IDATE_"^"_ESTAT
 ;
 Q STATUS
 ;
DUPLMSTR(FILE,FIELD,TVUID) ; check duplicates
 ; used to determine existence of duplicate
 ; entries with the same VUID and master flag
 ; can potentially use this from DD trigger
 N XTTARR,DUPL
 S DUPL=0
 D GETIREF^XTID(FILE,FIELD,TVUID,"XTTARR",1)
 I +$G(XTTARR) S DUPL=1
 Q DUPL
 ;
CNSTR1() ; check constraints when setting VUID
 ; called from SETVUID()
 ; only one MASTER ENTRY FOR VUID can exist
 N CONSTR,DUPL,MFLAG,TFILE,TFIELD
 S CONSTR=1
 S MFLAG=$$GETMASTR(.TERM)
 Q:'MFLAG 'CONSTR ; no constraint
 S TFILE=TERM("CTX","TERM FILE#")
 S TFIELD=TERM("CTX","TERM FIELD#")
 S DUPL=$$DUPLMSTR(TFILE,TFIELD,VUID)
 Q:'DUPL 'CONSTR ; no constraint
 Q CONSTR ; constrained
 ;
CNSTR2() ; check constraints when setting MASTER ENTRY flag
 ; called from SETMASTR()
 ; only one MASTER ENTRY FOR VUID can exist
 N CONSTR,DUPL,MFLAG,TFILE,TFIELD,TVUID
 S CONSTR=1
 S MFLAG=$$GETMASTR(.TERM)
 Q:MFLAG 'CONSTR ; TERM is already MASTER
 S TFILE=TERM("CTX","TERM FILE#")
 S TFIELD=TERM("CTX","TERM FIELD#")
 S TVUID=$$GETVUID(.TERM)
 S DUPL=$$DUPLMSTR(TFILE,TFIELD,TVUID)
 Q:'DUPL 'CONSTR ; no constraint
 Q CONSTR ; constrained
 ;
