TIUFLA1 ; SLC/MAM - Library; Template A,J (DDEFs by Attribute), (Objects) Related: AUPDATE(NODE0,FILEDA,CNTCHNG,NLINENO), SETENTYA(NODE0,FILEDA,FDALNO), IPOINT(NODE0), NOINUSE ;4/6/95  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;;Jun 20, 1997
 ;
NOINUSE ; If Type is Object for Template A,J blanks out In Use Caption. Called by protocols TIUFA ACTION MENU.
 I $G(TIUFAVAL)="O^OBJECT" D CHGCAP^VALM("INUSE","")
 I $G(TIUFAVAL)'="O^OBJECT" D CHGCAP^VALM("INUSE","In Use")
 Q
 ;
AUPDATE(NODE0,FILEDA,CNTCHNG,FDALNO) ; Updates LM Template A,J (DDEFs by Attribute), (Objects)
 ;with one new or edited LM Line if entry FILEDA matches Template A,J
 ;Attribute, Attribute VAlue, and Start With/Go To Value.
 ; Updates Arrays TIUFINFO, TIUFNOD0 via UPDATE^TIUFLLM1.
 ; Requires CURRENT NODE0 = ^TIU(8925.1,FILEDA,0); Requires FILEDA.
 ; Requires TIUFATTR,TIUFAVAL, and TIUFSTRT.  See HDR^TIUFA.
 ; Returns FDALNO= LM Lineno of new/updated entry FILEDA or = 0 if
 ;no match. Optional.
 ; Returns CNTCHNG = # lines added or deleted (+ or -)
 ;
 N PREVNAME,PREVFDA,INFO,SCRNL,MATCH
 ; DEAL WITH $E(NAME);MAM
 S MATCH=$$MATCH^TIUFLA(FILEDA)&$$STRMATCH^TIUFLA(FILEDA,NODE0)
 S FDALNO=+$O(^TMP("TIUF1IDX",$J,"DAF",FILEDA,0)),INFO=$G(^TMP("TIUF1IDX",$J,FDALNO))
 I INFO="" S INFO=0
 ; FDALNO = lineno of FILEDA's original LM entry.  If no entry, FDALNO=0.
 I MATCH G MATCH
NOMATCH ; If no match, FILEDA has no entry, then Quit.  If no match, FILEDA
 ;has entry, then delete entry, reset TIUFINFO so that piece/subscript
 ;Lineno are 0:
 I 'FDALNO S CNTCHNG=0 Q
 D UPDATE^TIUFLLM1(TIUFTMPL,-1,FDALNO-1) S CNTCHNG=-1
 I FILEDA=$G(TIUFINFO("FILEDA")) S $P(TIUFINFO,U)=0,TIUFINFO("LINENO")=0
 G AUPDX
MATCH ; 
 G:FDALNO HAS
HASNO ; If match, FILEDA has no LM entry, set LM entry. (Happens if setting
 ;rather than updating Template A, or if LM entry was edited in such a
 ;way that it no longer met sort criteria and was deleted as a LM entry.)
 ; If entry=TIUFINFO("FILEDA"), reset lineno piece/subscript of TIUFINFO:
 D SETENTYA(NODE0,FILEDA,.FDALNO) S CNTCHNG=1 G AUPDX
HAS ; I match, FILEDA has LM entry, reset entry.
 D PARSE^TIUFLLM(.INFO),NODE0ARR^TIUFLF(FILEDA,.NODE0) G:$D(DTOUT) AUPDX
 D BUFENTRY^TIUFLLM2(.INFO,.NODE0,TIUFTMPL)
 D UPDATE^TIUFLLM1(TIUFTMPL,0,FDALNO-1)
 S CNTCHNG=0
AUPDX Q
 ;
SETENTYA(NODE0,FILEDA,NLINENO) ; Set LM Template A,J entry w data NODE0, IFN FILEDA at NLINENO.
 ; Requires NODE0,FILEDA
 ; Returns NLINENO
 N INFO
 S NLINENO=$$IPOINT(NODE0,FILEDA)
 D NINFO^TIUFLLM(NLINENO,FILEDA,.INFO),PARSE^TIUFLLM(.INFO)
 D NODE0ARR^TIUFLF(FILEDA,.NODE0) Q:$D(DTOUT)
 D BUFENTRY^TIUFLLM2(.INFO,.NODE0,TIUFTMPL)
 D UPDATE^TIUFLLM1(TIUFTMPL,1,NLINENO-1)
 I FILEDA=$G(TIUFINFO("FILEDA")) S $P(TIUFINFO,U)=NLINENO,TIUFINFO("LINENO")=NLINENO
 Q
 ;
IPOINT(NODE0,FILEDA) ; Function returns Template A,J insertion point for
 ;entry with NODE0, FILEDA. If Name to be added is already in TIUF1 arry,
 ;insertion follows IFN order within Name.  Else after last entry before 
 ;Name in alphabet.
 ; Used for old entries as well as new.  Can't assume insert entry has
 ;larger FILEDA than existing entries w same Name.
 N LINENO,PREVNAME,NLINENO,FDA,INARRAY
 S LINENO=0,PREVNAME=$P(NODE0,U)
 S LINENO=$$LINENO(PREVNAME,FILEDA)
 I LINENO S NLINENO=LINENO+1 G IPOIX
 ; If LINENO=0, go back a name:
 ; Need SACC exempt; MAM
 F  S PREVNAME=$O(^TIU(8925.1,"B",PREVNAME),-1) Q:LINENO!(PREVNAME="")!($P(TIUFSTRT,U)]PREVNAME)  D
 . S (FDA,INARRAY)=0
 . F  S FDA=$O(^TIU(8925.1,"B",PREVNAME,FDA)) Q:'FDA  D
 . . S INARRAY=$O(^TMP("TIUF1IDX",$J,"DAF",FDA,0))
 . . I INARRAY S LINENO=INARRAY
 S NLINENO=LINENO+1
IPOIX Q NLINENO
 ;
LINENO(NAME,FILEDA) ; Function returns Lineno of last entry with name NAME in LM Array TIUF1 whose IFN is less than FILEDA.  If no such entry (EITHER no TIUFI entries with Name OR none with IFN<FILEDA), returns 0.
 N FDA,LINENO,INARRAY
 S FDA="",LINENO=0
 F  S FDA=$O(^TIU(8925.1,"B",NAME,FDA)) Q:'FDA!(FDA'<FILEDA)  D
 . S INARRAY=$O(^TMP("TIUF1IDX",$J,"DAF",FDA,""))
 . S:INARRAY LINENO=INARRAY
LINEX Q LINENO
 ;
