XTIDCTX ;OAKCIOFO/JLG - TERM/CONCEPT CONTEXT directories ;04/20/2005  15:12
 ;;7.3;TOOLKIT;**93**;Apr 25, 1995
 ; Reference to global "^DD" supported by IA #4634
 Q
 ; encapsulates the location (directory) of term/concept
 ; references based on FILE/FIELD.  
 ; It eventually encapsulates the retrieval of
 ; specific term/concept references (TERM defined in XTIDTERM) based 
 ; on the internal reference (IREF).
 ; There are two current implementations: one for terms defined
 ; as "set of codes"; the other defined in VistA files that have
 ; been updated to contain VUID-related data in their DD.
 ; CTX and TERM are passed by reference in all the subroutines
 ; 
CONTEXT(TFILE,TFIELD,CTX) ;  determine and create context impl
 ; returns new CTX array
 ; CTX("TYPE")=<"SET" or "TABLE" or "ROOT">
 ; CTX("TERM FILE#")=<TFILE or "">
 ; CTX("TERM FIELD#")=<TFIELD or "">
 ; CTX("SOURCE FILE#")=<8985.1 or TFILE or "">
 ; CTX("TERMSTATUS SUBFILE#")=
 ;       <subfile for the multi-valued field 
 ;        99.991, EFFECTIVE DATE/TIME or "">
 N TTYPE
 Q:$D(CTX)
 S TFILE=$G(TFILE),TFIELD=$G(TFIELD)
 S TTYPE=$$GETTYPE(TFILE,TFIELD)
 Q:TTYPE=""
 I TTYPE="SET" D CONTEXT^XTIDSET(TFILE,TFIELD,.CTX) Q
 I TTYPE="TABLE" D CONTEXT^XTIDTBL(TFILE,.01,.CTX) Q
 I TTYPE="ROOT" D ROOTCTX(.CTX) Q
 Q
 ;
VALIDREF(CTX,TIREF) ; validate IREF
 ; validate internal reference against given CTX
 N VALID S VALID=1
 Q:'$D(CTX) 'VALID
 I CTX("TYPE")="SET" D  Q VALID
 . S VALID=$$VALIDREF^XTIDSET(.CTX,$G(TIREF))
 ;
 I CTX("TYPE")="TABLE" D  Q VALID
 . S VALID=$$VALIDREF^XTIDTBL(.CTX,$G(TIREF))
 ;
 Q 'VALID
FINDTERM(CTX,TIREF,TERM) ; find term 
 ; find the single term reference for given term IREF
 ; return TERM data as new TERM array
 ; IREF is unique within a given CTX, except for "RO0T" context
 ; on success, attach CTX to TERM array
 Q:'$D(CTX)!($D(TERM))
 I CTX("TYPE")="SET" D FINDTERM^XTIDSET(.CTX,$G(TIREF),.TERM)
 I CTX("TYPE")="TABLE" D FINDTERM^XTIDTBL(.CTX,$G(TIREF),.TERM)
 ; don't find term reference for "ROOT" type, where IREF is not unique
 ; on success, attach CTX to TERM
 I $D(TERM) M TERM("CTX")=CTX
 Q
 ;
NEWTERM(CTX,TIREF,VUID) ; create a new term reference with given VUID
 ; only for "set of codes"
 ; on success (term entry), new TERM array is returned
 ; create a new entry in the Kernel (8985.1) file only (set of codes)
 N SUCCESS
 S TIREF=$G(TIREF),VUID=+$G(VUID)
 Q:'$D(CTX)!('VUID) 0
 ; create new term reference entry only for "set of codes"
 Q:CTX("TYPE")'="SET" 0
 Q $$NEWTERM^XTIDSET(.CTX,TIREF,VUID)
 ;
GETTERM(CTX,FILE,IENS,TERM) ; get term
 ; return TERM data as new TERM array
 ; called from CTX implementations only
 ; subroutine might be moved to XTIDTERM
 ; D GETS^DIQ(FILE,IENS,FIELD,FLAGS,TARGET_ROOT,MSG_ROOT)
 N DIERR,MSG
 S FILE=+$G(FILE),IENS=$G(IENS)
 ; ensure only CTX implementations use this for callback
 Q:'$D(CTX)!($D(TERM))!('FILE)!(IENS']"")
 D GETS^DIQ(FILE,IENS,"**","IR","TERM","MSG")
 Q:$D(MSG("DIERR"))
 Q
 ;
SRCHTRMS(CTX,VUID,XTCARR,MASTER) ; search term reference entries
 ; search term reference entries based on VUID and its context
 S VUID=$G(VUID),XTCARR=$G(XTCARR),MASTER=+$G(MASTER)
 ; CTX must be defined
 Q:'$D(CTX)!(XTCARR']"")!('VUID)
 I CTX("TYPE")="SET" D SRCHTRMS^XTIDSET(.CTX,VUID,XTCARR,MASTER) Q
 I CTX("TYPE")="TABLE" D SRCHTRMS^XTIDTBL(.CTX,VUID,XTCARR,MASTER) Q
 I CTX("TYPE")="ROOT" D  Q
 . ; each CTX implementation should contribute to XTCARR array
 . N FL
 . ; search "set of codes" first
 . ; temporarily set context info
 . S CTX("TYPE")="SET"
 . S CTX("SOURCE FILE#")=8985.1
 . D SRCHTRMS^XTIDSET(.CTX,VUID,XTCARR,MASTER)
 . ; search all "table" files
 . ; temporarily set context info
 . S CTX("TYPE")="TABLE"
 . S FL=0
 . F  S FL=$O(^DIC(FL)) Q:'FL  D
 . . Q:'$D(^DD(FL,99.991))
 . . Q:FL=8985.1
 . . S CTX("SOURCE FILE#")=FL
 . . S CTX("TERM FILE#")=FL
 . . S CTX("TERM FIELD#")=.01
 . . D SRCHTRMS^XTIDTBL(.CTX,VUID,XTCARR,MASTER)
 . ;
 . ; reset context info
 . S CTX("TYPE")="ROOT"
 . S CTX("SOURCE FILE#")=""
 . S CTX("TERM FILE#")=""
 . S CTX("TERM FIELD#")=""
 ;
 Q
 ;
ADDTARRY(XTC2ARR,FILE,FIELD,IREF,VALUE) ;
 ; adds element and value to XTC2ARR array (by name)
 ; called by CTX implementations of SRCHTRMS()
 ; increased count 
 N COUNT
 S COUNT=$G(@XTC2ARR)
 S @XTC2ARR@(+$G(FILE),+$G(FIELD),$G(IREF))=$G(VALUE)
 S @XTC2ARR=COUNT+1
 Q
 ;
GETTYPE(FILE,FIELD) ; determine type of context
 ; based on FILE and FIELD combination
 ; D FIELD^DID(FILE,FIELD,FLAGS,ATTRIBUTES,TARGET_ROOT,MSG_ROOT)
 N DIERR,ATTR,MSG,TYPE
 S FILE=+$G(FILE),FIELD=$G(FIELD)
 S TYPE=""
 ; file may be empty in GETIREF^XTID use-case
 I 'FILE S TYPE="ROOT" Q TYPE
 ; determine if "table" type, by checking VUID DD
 I FIELD=""!(FIELD=.01) D
 . N VFIELD
 . S VFIELD=99.99 ; test existence of VUID field
 . D FIELD^DID(FILE,VFIELD,"","LABEL","ATTR","MSG")
 . ;Q:$D(MSG("DIERR"))  ; INVALID type returned
 . I $G(ATTR("LABEL"))="VUID" S TYPE="TABLE"
 ;
 Q:TYPE'="" TYPE
 ; determine if FIELD is a SET OF CODES
 ; D FIELD^DID(FILE,FIELD,"","TYPE","ATTR","MSG")
 ; Q:$D(MSG("DIERR")) TYPE
 ; I $G(ATTR("TYPE"))="SET" S TYPE="SET" Q TYPE
 ; DS requested to assume "SET"
 S TYPE="SET"
 Q TYPE
 ;
ROOTCTX(CTX) ; set up Context for "ROOT" type
 ; called from CONTEXT^XTIDCTX(TFILE,TFIELD,CTX)
 ; called only when TFILE is not defined
 S CTX("TYPE")="ROOT"
 S CTX("TERM FILE#")=""
 S CTX("TERM FIELD#")=""
 ; the default source file 
 S CTX("SOURCE FILE#")=""
 ; TERMSTATUS 99.991, EFFECTIVE DATE/TIME subfile
 S CTX("TERMSTATUS SUBFILE#")=""
 Q
 ;
