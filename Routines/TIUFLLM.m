TIUFLLM ; SLC/MAM - Library; List Manager Related: RTSCROLL(TIUREC,TYPE), PARSE(INFO), NINFO(LINENO,FILEDA,INFO,PINFO,TENDA), PLUSUP(INFO,TIUREC) ;4/6/95  10:48
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
RTSCROLL(TIUREC,TYPE) ; Called by BUFENTRY^TIUFLLM2. For lines being set for
 ;Templates HACJ only. Copy chars 15-20, 44-49 of entry into chars
 ;215-220, 244-249. Depending on rt/left scroll position, replace those
 ;chars w Type.
 ; Requires TIUREC, TYPE from BUFENTRY.
 ; TIUFLFT, TIUFIXED are for updating lines in H/A/C/J from Template D or T.
 S TIUREC=$$SETSTR^VALM1($E(TIUREC,15,20),TIUREC,215,6)
 S TIUREC=$$SETSTR^VALM1($E(TIUREC,43,48),TIUREC,243,6)
 I $G(TIUFLFT)>49 D
 . I TIUFTMPL="J" D  Q
 . . I $G(VALM("FIXED"))=20!($G(TIUFIXED)=20) S TIUREC=$$SETSTR^VALM1(" ",TIUREC,20,1) Q
 . D
 . . S TYPE=" "_TYPE_" "
 . . I $G(VALM("FIXED"))=20!($G(TIUFIXED)=20) S TIUREC=$$SETSTR^VALM1(TYPE,TIUREC,15,6) Q
 . . S TIUREC=$$SETSTR^VALM1(TYPE,TIUREC,43,6)
 Q
 ;
PARSE(INFO) ; Splits INFO into pieces such as LINENO, XPDLCNT, etc.
 ;Sets INFO pieces into subscripts.
 ;Requires INFO, where INFO is either as set in NINFO^TIUFLLM or
 ;in UPDATE^TIUFLLM1 or = ^TMP("TIUFIDX,$J,LINENO).
 ; WARNING: +INFO may be set by NINFO or UPDATE to 0!
 ;          Other pieces of INFO may be 0 or ""!
 N LINENO,FILEDA,XPDLCNT,LEVEL,PLINENO,TENDA,PLINENO
 S LINENO=+INFO,FILEDA=$P(INFO,U,2),XPDLCNT=$P(INFO,U,3),LEVEL=$P(INFO,U,4),PLINENO=$P(INFO,U,5),TENDA=$P(INFO,U,6)
 S INFO("LINENO")=LINENO,INFO("FILEDA")=FILEDA
 S INFO("XPDLCNT")=XPDLCNT,INFO("LEVEL")=LEVEL,INFO("PLINENO")=PLINENO,INFO("TENDA")=TENDA
PARSX Q
 ;
NINFO(LINENO,FILEDA,INFO,PINFO,TENDA) ; Returns INFO for New (anticipated)
 ;LM Entry, where INFO = LINENO^FILEDA^XPDLCNT^LEVEL^PLINENO^TENDA or
 ;INFO = Error msg
 ; Requires LINENO = anticipated List Manager Entry #
 ; Requires FILEDA = 8925.1 IFN of new entry
 ; PINFO, TENDA are required IF new Entry has existing parent LM Entry
 ;on current or parent LM Template H.
 ; PINFO has form of INFO, above, but for LM parent of new entry.
 ; TENDA = LINENO's DA in parent item multiple (10 Node).
 ; XPDLCNT = # of lines entry has been expanded, = 0 for new entry.
 ; LEVEL = LINENO hierarchy level.  Clinical Documents has LEVEL 0.  Used
 ;for right shift for Template H.
 ; Module sets LEVEL,PLINENO,TENDA = 0 IF new entry has no existing parent.
 N XPDLCNT,LEVEL,PLINENO
 S XPDLCNT=0
 S LEVEL=$S($G(PINFO):$P(PINFO,U,4)+1,1:0),PLINENO=+$G(PINFO),TENDA=+$G(TENDA)
 S INFO=LINENO_U_FILEDA_U_XPDLCNT_U_LEVEL_U_PLINENO_U_TENDA
NINFX Q
 ;
PLUSUP(INFO,TIUREC) ; Update the plus item indicator in front of LM Entry Name for Template H.
 ; Assumes Name proper starts at col 8, for level 0. + goes in front of Name.
 ; Returns TIUREC with + added or deleted.
 ; Requires INFO array, where INFO is either as set in NINFO^TIUFLLM or
 ;is = ^TMP("TIUFIDX,$J,LINENO), and where INFO array is as set in
 ;PARSE^TIUFLLM(INFO).
 ; Requires TIUREC = LM Entry as in TIUF1 array.
 ; INFO("XPDLCNT") must anticipate next redisplay of screen - whether
 ;Entry will/not be expanded.
 N HASITEMS,LEVEL,NMCOLUMN,COLUMN,PLUS
 S LEVEL=INFO("LEVEL"),HASITEMS=$$HASITEMS^TIUFLF1(INFO("FILEDA"))
 S PLUS=" "
 I HASITEMS,'INFO("XPDLCNT") S PLUS="+"
 S NMCOLUMN=8,COLUMN=NMCOLUMN+(2*LEVEL)-1
 S TIUREC=$$SETSTR^VALM1(PLUS,TIUREC,COLUMN,1)
 Q TIUREC
 ;
