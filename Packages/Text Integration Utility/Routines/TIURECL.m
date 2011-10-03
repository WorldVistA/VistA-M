TIURECL ; SLC/PKR,JER - Expand/collapse LM views ;3/14/01
 ;;1.0;TEXT INTETRATION UTILITIES;**88,100**;Jun 20, 1997
 ;======================================================================
COPYCL(LSTART,START,END) ;Copy elements of List into ^TMP("TMPLIST",$J),
 ;starting at START going to END.
 N IND,TEXT
 S ^TMP("TMPLIST",$J,0)=$G(@VALMAR@(0))
 S ^TMP("TMPLIST",$J,"TIURIDX0")=$G(^TMP("TIURIDX",$J,0))
 ; -- Copy numbered lines: --
 F IND=START:1:END D:$D(@VALMAR@(IND,0))
 . S LSTART=LSTART+1
 . S TEXT=@VALMAR@(IND,0)
 . S TEXT=$$SETFLD^VALM1(LSTART,TEXT,"NUMBER")
 . S ^TMP("TMPLIST",$J,LSTART)=TEXT_U_$P($G(^TMP("TIURIDX",$J,IND)),U,2,4)
 ; -- Copy other nodes, skipping "IDX", "IEN", "EXPAND",
 ;    & "IDDATA", where I need >1 subscript: --
 S IND="A"
 F  S IND=$O(@VALMAR@(IND)) Q:IND=""  D
 . Q:$S(IND="IDX":1,IND="IEN":1,IND="EXPAND":1,IND="IDDATA":1,1:0)
 . S ^TMP("TMPLIST",$J,IND)=$G(@VALMAR@(IND))
 ; -- Copy "EXPAND" node: --
 S IND=0
 F  S IND=$O(@VALMAR@("EXPAND",IND)) Q:IND=""  D
 . S ^TMP("TMPLIST",$J,"EXPAND",IND)=$G(@VALMAR@("EXPAND",IND))
 ; -- Copy "IDDATA" node: --
 S IND=0
 F  S IND=$O(@VALMAR@("IDDATA",IND)) Q:IND=""  D
 . S ^TMP("TMPLIST",$J,"IDDATA",IND)=$G(@VALMAR@("IDDATA",IND))
 ; -- Copy "IEN" node: --
 S IND=0
 F  S IND=$O(@VALMAR@("IEN",IND)) Q:IND=""  D
 . N TIUJ S TIUJ=0
 . F  S TIUJ=$O(@VALMAR@("IEN",IND,TIUJ)) Q:+TIUJ'>0  D
 . . S ^TMP("TMPLIST",$J,"IEN",IND,TIUJ)=""
 Q LSTART
 ;
 ;======================================================================
EC(VALMY) ;Expand or contract the tree view in VALMY.
 ;Make sure the request is valid.
 I '$$VEXREQ^TIURECL1(.VALMY) Q
 N TIUI
 S TIUI=""
 ; -- Traverse pick list in reverse to avoid collisions: --
 F  S TIUI=$O(VALMY(TIUI),-1) Q:+TIUI'>0  D EC1(TIUI)
 Q
 ;
 ;======================================================================
EC1(TIUI,HUSH)  ; Expand a single List Element (line TIUI):
 ;    ORIGPFIX = $$PREFIX^TIULA2
 ;             = Indicators followed by space (if there are any).
 ;             EX:"+< ", or "*+< ", etc.
 ;    CURPFIX = Beginning characters of title/pt column, up to
 ;              but not including title/pt itself.
 ;            = Possible spacer characters (e.g. " |_"),
 ;              followed by possible indicators_space 
 ;              (if there are any).  If item is expanded,
 ;              indicators +, <, or +< may be replaced
 ;              with "-".
 ;            EX: "  |_- ", or "  |   |_", etc
 ; When getting indicators for new prefix, EC1 checks for changes
 ;in record being expanded (changes such as getting an addendum).
 ; EC1 updates prefix and ^TMP("TIURIDX",$J,listno) with such
 ;changes.
 ; EC1 does NOT update text of line, or ^TMP("TIUR",$J,"IDDATA",DA).
 N ORIGPFIX,CURPFIX,TIUGDATA,PRMSORT,NEWPFIX
 N TSTART,START,LISTNUM,REBUILD,TEXT
 N TIUDATA,TIUDA,TIUPICK
 S START=1,(REBUILD,TSTART)=0
 K ^TMP("TMPLIST",$J)
 S TIUDATA=$G(^TMP("TIURIDX",$J,TIUI)) Q:'+TIUDATA
 S LISTNUM=$P(TIUDATA,U,1)
 ; -- Retrieve DA, current prefix; get original prefix: --
 S TIUDA=$P(TIUDATA,U,2),CURPFIX=$P(TIUDATA,U,3)
 S ORIGPFIX=$$PREFIX^TIULA2(TIUDA)
 S NEWPFIX=$$UPPFIX^TIURL1(TIUDA,CURPFIX)
 ; ---- If docmt cannot be expanded or collapsed, say so and quit: ----
 I ORIGPFIX'["+",ORIGPFIX'["<",CURPFIX'["-" D  Q
 . N MSG
 . D RESTORE^VALM10(TIUI)
 . I '+$G(HUSH) D
 . . S MSG="** Item #"_TIUI_" cannot be expanded/collapsed. **"
 . . D MSG^VALM10(MSG) H 2
 S TEXT=$G(@VALMAR@(LISTNUM,0))
 ; ---- If docmt not expanded & has addenda but no ID kids,
 ;      expand to show adda: ----
 I CURPFIX'["-",ORIGPFIX["+",ORIGPFIX'["<" D
 . S REBUILD=1
 . ; -- Set lines (from beg to line before TIUI) into ^TMP("TMPLIST",$J):
 . S TSTART=$$COPYCL(TSTART,START,LISTNUM-1)
 . S START=LISTNUM+1
 . ;-- Set line TIUI into ^TMP("TMPLIST",$J), updating flds NUMBER,
 . ;   and TITLE or PATIENT, with new prefix and spacing: --
 . S TSTART=TSTART+1
 . S TEXT=$$SETFLD^VALM1(TSTART,TEXT,"NUMBER")
 . S NEWPFIX=$S(NEWPFIX["+>":$TR(NEWPFIX,"+>","-"),1:$TR(NEWPFIX,"+","-"))
 . S TEXT=$$SETTLPT^TIURECL1(TEXT,TIUDA,NEWPFIX)
 . ; -- Save DA, prefixes, etc., for next time: --
 . S ^TMP("TMPLIST",$J,TSTART)=TEXT_U_TIUDA_U_NEWPFIX
 . ; -- Insert addenda of TIUI: --
 . S TSTART=$$INSADD^TIURECL2(TSTART,TIUDA,NEWPFIX)
 . ; -- Update EXPAND index to compensate for insertion: --
 . I TIUI<+$O(@VALMAR@("EXPAND",""),-1) D BUMPEXP(TIUI,TSTART)
 . ; -- Set new EXPAND node: --
 . S @VALMAR@("EXPAND",TIUI)=TIUDA
 ; ---- If tree view can be collapsed, then collapse it: ----
 I CURPFIX["-" D
 . N TEMP,CONTRACT,LEVEL
 . S REBUILD=1
 . S TSTART=$$COPYCL(TSTART,START,LISTNUM-1)
 . S TSTART=TSTART+1
 . S LEVEL=$L(TEXT,"|")
 . S TEXT=$$SETFLD^VALM1(TSTART,TEXT,"NUMBER")
 . S TEXT=$$SETTLPT^TIURECL1(TEXT,TIUDA,NEWPFIX)
 . S ^TMP("TMPLIST",$J,TSTART)=TEXT_U_TIUDA_U_NEWPFIX
 . S START=TIUI+1
 . S CONTRACT=1
 . F  Q:'CONTRACT  D
 .. S TEMP=$G(@VALMAR@(START,0))
 ..; -- Contract if at a higher level than the main line: --
 .. I TEMP["|",$L(TEMP,"|")>LEVEL S START=START+1
 .. E  S CONTRACT=0
 . I TIUI<+$O(@VALMAR@("EXPAND",""),-1) D SUCKEXP(START,TSTART)
 . K @VALMAR@("EXPAND",TIUI),^TMP("TMPLIST",$J,"EXPAND",TIUI)
 ; ---- If docmt has ID kids & hasn't
 ;    been expanded, then expand it to show ID kids: ----
 I CURPFIX'["-",ORIGPFIX["<" D
 . ; -- Retrieve ID entry order (from docmt parameter): --
 . ;    (Entry order should be ok even if rest needs update.)
 . S TIUGDATA=^TMP("TIUR",$J,"IDDATA",TIUDA)
 . S PRMSORT=$P(TIUGDATA,U,4)
 . S REBUILD=1
 . S TSTART=$$COPYCL(TSTART,START,LISTNUM-1)
 . S START=LISTNUM+1
 . S TSTART=TSTART+1
 . S TEXT=$$SETFLD^VALM1(TSTART,TEXT,"NUMBER")
 . S NEWPFIX=$S(NEWPFIX["+<":$TR(NEWPFIX,"+<","-"),NEWPFIX["<":$TR(NEWPFIX,"<","-"),1:$TR(NEWPFIX,"+","-"))
 . S TEXT=$$SETTLPT^TIURECL1(TEXT,TIUDA,NEWPFIX)
 . S ^TMP("TMPLIST",$J,TSTART)=TEXT_U_TIUDA_U_NEWPFIX
 . S TSTART=$$INSKIDS^TIURECL2(TSTART,TIUDA,NEWPFIX,PRMSORT)
 . S ^TMP("TMPLIST",$J,"IDDATA",TIUDA)=TIUGDATA
 . I TIUI<+$O(@VALMAR@("EXPAND",""),-1) D BUMPEXP(TIUI,TSTART)
 . ; -- Set new EXPAND node: --
 . S @VALMAR@("EXPAND",TIUI)=TIUDA
 ; -- Restore the original video attributes: --
 D RESTORE^VALM10(TIUI)
 I 'REBUILD Q
 ; ---- Add the rest of the list to ^TMP("TMPLIST",$J):
 S LISTNUM=$P(@VALMAR@(0),U,1)
 S TSTART=$$COPYCL(TSTART,START,LISTNUM)
 ; --Rebuild the LM ^TMP arrays: --
 K @VALMAR,^TMP("TIURIDX",$J)
 S VALMCNT=0
 S START=0,@VALMAR@(0)=^TMP("TMPLIST",$J,0)
 S ^TMP("TIURIDX",$J,0)=^TMP("TMPLIST",$J,"TIURIDX0")
 ; -- Rebuild numbered lines and IDX and TIURIDX nodes: --
 N CURPFX
 F  S START=$O(^TMP("TMPLIST",$J,START)) Q:+START'>0  D
 . S VALMCNT=VALMCNT+1
 . S TEMP=^TMP("TMPLIST",$J,START)
 . S TEXT=$P(TEMP,U),TIUDA=$P(TEMP,U,2),CURPFX=$P(TEMP,U,3)
 . S @VALMAR@(START,0)=TEXT
 . D RESTORE^VALM10(START)
 . S @VALMAR@("IDX",START,START)=""
 . S ^TMP("TIURIDX",$J,START)=START_U_TIUDA_U_CURPFX
 . S @VALMAR@("IEN",TIUDA,START)=""
 S $P(@VALMAR@(0),U)=VALMCNT
 ; -- Rebuild other nodes: --
 S START="A"
 F  S START=$O(^TMP("TMPLIST",$J,START)) Q:START=""  D
 . Q:START="EXPAND"
 . Q:START="IDDATA"
 . Q:START="IEN"
 . S @VALMAR@(START)=$G(^TMP("TMPLIST",$J,START))
 ; -- Rebuild EXPAND node: --
 S START=0
 F  S START=$O(^TMP("TMPLIST",$J,"EXPAND",START)) Q:+START'>0  D
 . S @VALMAR@("EXPAND",START)=$G(^TMP("TMPLIST",$J,"EXPAND",START))
 ; -- Rebuild IDDATA node: --
 S START=0
 F  S START=$O(^TMP("TMPLIST",$J,"IDDATA",START)) Q:+START'>0  D
 . Q:'$D(@VALMAR@("IEN",START))
 . S @VALMAR@("IDDATA",START)=$G(^TMP("TMPLIST",$J,"IDDATA",START))
 ; -- Rebuild # node: --
 S TIUPICK=+$O(^ORD(101,"B","TIU ACTION SELECT LIST ELEMENT",0))
 S @VALMAR@("#")=TIUPICK_U_"1:"_+$G(VALMCNT)
 ; -- Update # of documents in header: --
 K VALMHDR,^TMP("TMPLIST",$J)
 Q
 ;=======================================================================
BUMPEXP(TIUI,TSTART)    ; Bump EXPAND index to compensate for insertion
 N TIUJ,GAP S TIUJ="",GAP=TSTART-TIUI
 F  S TIUJ=$O(@VALMAR@("EXPAND",TIUJ),-1) Q:TIUJ'>TIUI  D
 . S @VALMAR@("EXPAND",TIUJ+GAP)=$G(@VALMAR@("EXPAND",TIUJ))
 . K @VALMAR@("EXPAND",TIUJ),^TMP("TMPLIST",$J,"EXPAND",TIUJ)
 Q
 ;=======================================================================
SUCKEXP(START,TSTART)    ; Remove EXPAND index to compensate for collapse
 N TIUJ,GAP S TIUJ=START,GAP=(START-TSTART)-1
 F  S TIUJ=$O(@VALMAR@("EXPAND",TIUJ)) Q:TIUJ'>0  D
 . S @VALMAR@("EXPAND",TIUJ-GAP)=$G(@VALMAR@("EXPAND",TIUJ))
 . K @VALMAR@("EXPAND",TIUJ),^TMP("TMPLIST",$J,"EXPAND",TIUJ)
 Q
