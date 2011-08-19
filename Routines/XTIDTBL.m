XTIDTBL ;OAKCIOFO/JLG - TABLE CONTEXT ;04/21/2005  15:12
 ;;7.3;TOOLKIT;**93**;Apr 25, 1995
 Q
 ; Context implementation for "table"
 ; CTX and TERM are passed by ref in all calls
CONTEXT(TFILE,TFIELD,CTX) ; set up Context for "table" type
 ; called from CONTEXT^XTIDCTX(TFILE,TFIELD,CTX)
 ; returns a valid new CTX array
 N SUBFILE
 S TFILE=+$G(TFILE)
 Q:'TFILE!($D(CTX))
 ; determine the subfile for the multi-valued field 
 ; 99.991, EFFECTIVE DATE/TIME
 S SUBFILE=$$GETSUBF(TFILE,99.991)
 Q:'SUBFILE
 S CTX("TYPE")="TABLE"
 S CTX("TERM FILE#")=TFILE
 S CTX("TERM FIELD#")=.01
 S CTX("SOURCE FILE#")=TFILE
 S CTX("TERMSTATUS SUBFILE#")=SUBFILE
 Q
 ;
VALIDREF(CTX,TIREF) ; validate the term, internal ref
 ; test TIREF is a valid value in given context (table)
 ; TIREF must be in IENS form, but will be checked
 ; later as VDUI related data is retrieved
 ; would be nice if we can do an earlier check
 ; based on IENS and the CTX("SOURCE FILE#")
 N VALID
 Q:'$D(CTX)!($G(TIREF)']"") 0
 S VALID=TIREF?.(.N1",")
 Q VALID
 ;
FINDTERM(CTX,TIREF,TERM) ; find term 
 ; called from FINDTERM^XTIDCTX(CTX,TIREF,TERM)
 ; find term for given term IREF
 ; return TERM data as new TERM array
 N IENS
 Q:'$D(CTX)!($D(TERM))
 Q:'$$VALIDREF(.CTX,$G(TIREF))
 S IENS=$G(TIREF)
 Q:IENS']""
 D GETTERM^XTIDCTX(.CTX,CTX("SOURCE FILE#"),IENS,.TERM)
 Q
 ;
SRCHTRMS(CTX,VUID,XTTBARR,MASTER) ; search term index entries
 ; called from SEARCH^XTIDCTX(CTX,VUID,ARRAY,MASTER)
 ; FIND^DIC(FILE,IENS,FIELDS,FLAGS,[.]VALUE,NUMBER,[.]INDEXES,
 ;          [.]SCREEN,IDENTIFIER,TARGET_ROOT,MSG_ROOT)
 N DIERR,FILE,TFILE,INDEXES,MSG,RIEN,VALUE,FLAGS,TARG,MSG,NUMFND
 N FIELDS,SCREEN
 S VUID=$G(VUID),MASTER=+$G(MASTER)
 Q:$G(CTX("TYPE"))'="TABLE"!('VUID)
 S FILE=CTX("SOURCE FILE#"),INDEXES="AVUID",FLAGS="QX"
 S FIELDS="@;99.98I"
 S VALUE(1)=VUID
 S SCREEN="" I MASTER S SCREEN="I $P(^(""VUID""),""^"",2)"
 ; get entries
 D FIND^DIC(FILE,"",FIELDS,FLAGS,.VALUE,"",INDEXES,SCREEN,"","TARG","MSG")
 Q:$D(MSG("DIERR"))
 S NUMFND=+$G(TARG("DILIST",0))
 I NUMFND D  ;  found entries
 . N ITM,TEMP
 . M TEMP=TARG("DILIST",2)
 . M TEMP=TARG("DILIST","ID")
 . F ITM=1:1:NUMFND  D
 . . N STATUS,IENS
 . . S IENS=TEMP(ITM)_","
 . . S STATUS=$$GETSTAT^XTID(CTX("TERM FILE#"),CTX("TERM FIELD#"),IENS,"")
 . . S STATUS=STATUS_"^"_TEMP(ITM,99.98)
 . . D ADDTARRY^XTIDCTX(XTTBARR,CTX("TERM FILE#"),CTX("TERM FIELD#"),IENS,STATUS)
 . ;
 ;
 Q
 ; 
GETSUBF(FILE,MFIELD) ; get subfile #
 ; get subfile for the given file and multiple-valued field
 N DIERR,ATTR,SUBFILE
 S SUBFILE=""
 D FIELD^DID(FILE,MFIELD,"","MULTIPLE-VALUED;SPECIFIER;TYPE","ATTR")
 I ATTR("MULTIPLE-VALUED")=1,ATTR("TYPE")'="WORD-PROCESSING" D
 . S SUBFILE=+$G(ATTR("SPECIFIER"))
 ;
 Q SUBFILE
 ;
