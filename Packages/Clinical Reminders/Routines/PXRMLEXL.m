PXRMLEXL ;SLC/PKR - List Manager routines for Taxonomies and Lexicon. ;10/30/2013
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;=========================================
ADDSEL(ENUM,UID) ;Add entry ENUM to the selected list and highlight it.
 N CODE
 S CODE=^TMP("PXRMLEXL",$J,"CODE",ENUM)
 S ^TMP("PXRMLEXL",$J,"SELECTED",ENUM)=CODE_U_UID
 D HLITE(ENUM,1,UID)
 Q
 ;
 ;=========================================
BLDLIST ;Build the Lexicon list.
 N CODE,CODESYS,CODESYSP,DESC,ENUM,FMTSTR,IND,JND
 N NCODES,NL,NLINES,NSEL,NUID,NUM,OUTPUT,START,TAXIEN,TERM,TEXT,UID
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLLL")
 ;^TMP("PXRMLEXTC",$J) nodes are set in PXRMTXSM which calls this
 ;List Manager selection. 
 ;Clear the display.
 D KILL^VALM10
 K ^TMP("PXRMLEXL",$J)
 S CODESYS=^TMP("PXRMLEXTC",$J,"CODESYS")
 S TAXIEN=^TMP("PXRMLEXTC",$J,"TAX IEN")
 S TERM=^TMP("PXRMLEXTC",$J,"LEX TERM")
 ;Clear the display.
 D KILL^VALM10
 K ^TMP("PXRMLEXL",$J)
 I '$D(^TMP("PXRMLEXS",$J,TERM,CODESYS)) D
 . D LEXLIST(TAXIEN,TERM,CODESYS,.NCODES,.NLINES,.TEXT)
 . M ^TMP("PXRMTEXT",$J,TERM,CODESYS,"TEXT")=TEXT
 . S ^TMP("PXRMTEXT",$J,TERM,CODESYS,"NCODES")=NCODES
 . S ^TMP("PXRMTEXT",$J,TERM,CODESYS,"NLINES")=NLINES
 I $D(^TMP("PXRMTEXT",$J,TERM,CODESYS)) D
 . S NCODES=^TMP("PXRMTEXT",$J,TERM,CODESYS,"NCODES")
 . S NLINES=^TMP("PXRMTEXT",$J,TERM,CODESYS,"NLINES")
 ;Get the coding system Lexicon information for building the display.
 ;DBIA #5679
 S CODESYSP=$$CSYS^LEXU(CODESYS)
 S TEXT=^TMP("PXRMLEXTC",$J,"LEX TERM")
 S TEXT=$S(($L(TEXT)'>66):TEXT,1:$E(TEXT,1,63)_"...")
 S VALMHDR(1)="Term/Code: "_TEXT
 S VALMHDR(2)=NCODES_" "_$P(CODESYSP,U,4)_$S(NCODES=1:" code was found",1:" codes were found")
 I NCODES=1,'$$UIDOK S VALMHDR(2)=VALMHDR(2)_" It cannot be used in a dialog."
 I NCODES>1,'$$UIDOK S VALMHDR(2)=VALMHDR(2)_" These cannot be used in a dialog."
 ;Set these so LM shows Page 1 of 1 when there are no codes.
 I NCODES=0 S VALMHDR(2)=VALMHDR(2)_".",^TMP("PXRMLEXL",$J,1,0)="",VALMCNT=1 Q
 ;
 ;If the display list has been saved restore it, if not build it.
 I $D(^TMP("PXRMLEXS",$J,TERM,CODESYS)) D
 . M ^TMP("PXRMLEXL",$J)=^TMP("PXRMLEXS",$J,TERM,CODESYS)
 . S VALMCNT=^TMP("PXRMLEXS",$J,TERM,CODESYS,"VALMCNT")
 I '$D(^TMP("PXRMLEXS",$J,TERM,CODESYS)) D
 . S VALMCNT=0
 . F IND=1:1:NLINES D
 .. S NUM=$P(TEXT(IND),U,1),CODE=$P(TEXT(IND),U,2)
 .. I NUM'="",CODE'="" S ENUM=NUM,^TMP("PXRMLEXL",$J,"CODE",NUM)=CODE,START=VALMCNT+1
 .. D FORMAT(TEXT(IND),FMTSTR,.NL,.OUTPUT)
 .. F JND=1:1:NL D
 ... S VALMCNT=VALMCNT+1,^TMP("PXRMLEXL",$J,VALMCNT,0)=OUTPUT(JND)
 ... S ^TMP("PXRMLEXL",$J,"IDX",VALMCNT,ENUM)=""
 .. S ^TMP("PXRMLEXL",$J,"LINES",ENUM)=START_U_VALMCNT
 . S ^TMP("PXRMLEXL",$J,"NCODES")=NCODES
 . S ^TMP("PXRMLEXL",$J,"VALMCNT")=VALMCNT
 ;If the display list has not been saved, save it.
 I '$D(^TMP("PXRMLEXS",$J,TERM,CODESYS)) M ^TMP("PXRMLEXS",$J,TERM,CODESYS)=^TMP("PXRMLEXL",$J)
 ;
 ;Mark any entries that were previously selected.
 S ENUM="",(NSEL,NUID)=0
 F  S ENUM=$O(^TMP("PXRMLEXL",$J,"CODE",ENUM)) Q:ENUM=""  D
 . S CODE=^TMP("PXRMLEXL",$J,"CODE",ENUM)
 . I CODE'="",$D(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) D  Q
 .. S NSEL=NSEL+1
 .. S UID=+^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)
 .. I UID S NUID=NUID+1
 .. D ADDSEL(ENUM,UID)
 S VALMHDR(2)=VALMHDR(2)_", "_NSEL_" are selected."
 S PXRMLEXV="ALL"
 I $D(PXRMBGS("ALL")) S VALMBG=PXRMBGS("ALL")
 Q
 ;
 ;=========================================
BLDSLIST ;Build the Lexicon list, selected or UID codes only.
 N CODE,CODESYS,CODESYSP,DONE,FMTSTR,IND,JND,KND
 N NL,NSEL,NUID,OUTPUT,START,TERM,TEXT,UID
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLLL")
 ;^TMP("PXRMLEXTC",$J) nodes are set in PXRMTXSM which calls this
 ;List Manager selection.
 ;Clear the display.
 D KILL^VALM10
 K ^TMP("PXRMLEXL",$J)
 S CODESYS=^TMP("PXRMLEXTC",$J,"CODESYS")
 ;DBIA #5679
 S CODESYSP=$$CSYS^LEXU(CODESYS)
 S TERM=^TMP("PXRMLEXTC",$J,"LEX TERM")
 S TEXT=^TMP("PXRMLEXTC",$J,"LEX TERM")
 S TEXT=$S(($L(TEXT)'>66):TEXT,1:$E(TEXT,1,63)_"...")
 ;Get the entries that were previously selected.
 S NLINES=^TMP("PXRMTEXT",$J,TERM,CODESYS,"NLINES")
 S (NSEL,NUID,VALMCNT)=0
 F IND=1:1:NLINES D
 . S TEMP=^TMP("PXRMTEXT",$J,TERM,CODESYS,"TEXT",IND)
 . S CODE=$P(TEMP,U,2)
 . I (CODE'=""),'$D(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) Q
 .;Skip additional activation/inactivation lines for non-selected codes.
 . I CODE="" Q
 . I CODE'="" S UID=^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)
 . I UID S NUID=NUID+1
 . S NSEL=NSEL+1
 . S ^TMP("PXRMLEXL",$J,"CODE",NSEL)=CODE,START=VALMCNT+1
 . S TEXT=NSEL_U_CODE_U_$P(TEMP,U,3,5)
 . D FORMAT(TEXT,FMTSTR,.NL,.OUTPUT)
 . F JND=1:1:NL D
 .. S VALMCNT=VALMCNT+1,^TMP("PXRMLEXL",$J,VALMCNT,0)=OUTPUT(JND)
 .. S ^TMP("PXRMLEXL",$J,"IDX",VALMCNT,NSEL)=""
 . ;S ^TMP("PXRMLEXL",$J,"LINES",NSEL)=START_U_VALMCNT
 . ;D ADDSEL(NSEL,UID)
 .;Check for additional activation/inactivation lines.
 . S KND=IND
 . S DONE=$S(IND<NLINES:0,1:1)
 . F  Q:DONE  D
 .. S KND=KND+1
 .. S TEMP=^TMP("PXRMTEXT",$J,TERM,CODESYS,"TEXT",KND)
 .. I $P(TEMP,U,2)'="" S DONE=1 Q
 .. I KND=NLINES S DONE=1
 .. S IND=KND
 .. D FORMAT(TEMP,FMTSTR,.NL,.OUTPUT)
 .. F JND=1:1:NL D
 ... S VALMCNT=VALMCNT+1,^TMP("PXRMLEXL",$J,VALMCNT,0)=OUTPUT(JND)
 ... S ^TMP("PXRMLEXL",$J,"IDX",VALMCNT,NSEL)=""
 . S ^TMP("PXRMLEXL",$J,"LINES",NSEL)=START_U_VALMCNT
 . D ADDSEL(NSEL,UID)
 S ^TMP("PXRMLEXL",$J,"NCODES")=NSEL
 S ^TMP("PXRMLEXL",$J,"VALMCNT")=VALMCNT
 S VALMHDR(1)="Term/Code: "_TERM
 S VALMHDR(2)="Selected "_$P(CODESYSP,U,4)_": "_NSEL_" selected codes, "_NUID_" UID codes."
 S PXRMLEXV="SEL"
 S VALMBG=$S($D(PXRMBGS("SEL")):PXRMBGS("SEL"),1:1)
 Q
 ;
 ;=========================================
CPLIST(TAXIEN,TERM,CODESYS,NCODES,NLINES,TEXT) ;Build the list for a copy from
 ;a range list of codes.
 N ACTDT,CODE,DATA,INACTDT,NUM,SDESC,TEMP
 S CODE="",(NCODES,NLINES)=0
 F  S CODE=$O(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) Q:CODE=""  D
 . K DATA
 .;DBIA #1997, #3991
 . I CODESYS="CPC" D PERIOD^ICPTAPIU(CODE,.DATA)
 . I CODESYS="CPT" D PERIOD^ICPTAPIU(CODE,.DATA)
 . I CODESYS="ICD" D PERIOD^ICDAPIU(CODE,.DATA)
 . I CODESYS="ICP" D PERIOD^ICDAPIU(CODE,.DATA)
 . I +DATA(0)=-1 Q
 . S NCODES=NCODES+1
 . S (ACTDT,NUM)=0
 . F  S ACTDT=$O(DATA(ACTDT)) Q:ACTDT=""  D
 .. S TEMP=DATA(ACTDT)
 .. S NUM=NUM+1
 .. S INACTDT=$P(TEMP,U,1)
 .. S SDESC=$P(TEMP,U,2)
 .. S NLINES=NLINES+1
 .. I NUM=1 S TEXT(NLINES)=NCODES_U_CODE_U_ACTDT_U_INACTDT_U_SDESC
 .. E  S TEXT(NLINES)=U_U_ACTDT_U_INACTDT_U_DESC
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXRMLEXL
 D BLDLIST^PXRMLEXL
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXRMLEXL
 D FULL^VALM1
 D CLEAN^VALM10
 D KILL^VALM10
 D CLEAR^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
EXITS ;Exit and save action.
 D SAVE^PXRMLEXL
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
FORMAT(TEXT,FMTSTR,NL,OUTPUT) ;Format  entry number, code,
 ;activation date, inactivation date, short text for LM display.
 N ACTDT,INACTDT
 S ACTDT=$P(TEXT,U,3),INACTDT=$P(TEXT,U,4)
 S ACTDT=$$FMTE^XLFDT(ACTDT,5)
 S INACTDT=$$FMTE^XLFDT(INACTDT,5)
 S $P(TEXT,U,3)=ACTDT,$P(TEXT,U,4)=INACTDT
 D COLFMT^PXRMTEXT(FMTSTR,TEXT," ",.NL,.OUTPUT)
 Q
 ;
 ;=========================================
GETLIST(LIST) ;Let the user input a list of items.
 N INUM,ITEM,LEND,LELEM,NCODES,LSTART,X,Y
 S NCODES=+$G(^TMP("PXRMLEXL",$J,"NCODES"))
 I NCODES=0 Q
 I NCODES=1 S LIST(1)="" Q
 S DIR(0)="LC^1:"_NCODES
 D ^DIR
 I $E(Y,1)="^" Q
 ;Populate the list.
 F INUM=1:1:($L(Y,",")-1) D
 . S LELEM=$P(Y,",",INUM)
 . I LELEM?1.N  S LIST(LELEM)=""
 . S LSTART=$P(LELEM,"-",1),LEND=$P(LELEM,"-",2)
 . F ITEM=LSTART:1:LEND S LIST(ITEM)=""
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="Select Lexicon items to include in the taxonomy."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HELP ;Display help.
 N DDS,DIR0,DONE,IND,TEXT
 ;DBIA #5746 covers kill and set of DDS. DDS needs to be set or the
 ;Browser will kill some ScreenMan variables.
 S DDS=1,DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(HTEXT+IND),";",3,99)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","Lexicon Selection Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HLITE(ENUM,MODE,UID) ;Highlight/unhighlight an entry. MODE=1 turns on
 ;highlighting, MODE=0 turns it off.
 N LINE,START,STOP,VCTRL
 S VCTRL=$S(MODE=1:IOINHI,1:IOINORM)
 S START=$P(^TMP("PXRMLEXL",$J,"LINES",ENUM),U,1)
 S STOP=$P(^TMP("PXRMLEXL",$J,"LINES",ENUM),U,2)
 F LINE=START:1:STOP D CNTRL^VALM10(LINE,1,80,VCTRL,IOINORM)
 ;If the entry is marked Use In Dialog turn on marker.
 I MODE=1,UID=1 D FLDCTRL^VALM10(START,"CODE",IORVON,IORVOFF,"")
 I MODE=0 D FLDCTRL^VALM10(START,"CODE",IORVOFF,IORVOFF,"")
 Q
 ;
 ;=========================================
HTEXT ;Lexicon selection help text.
 ;;Select one of the following actions:
 ;;
 ;;  ADD  - adds selected codes to the taxonomy.
 ;;  RFT  - removes selected codes from the taxonomy.
 ;;  RFD  - removes selected codes from being used in a dialog.
 ;;  UID  - adds selected codes to the taxonomy and marks them for use in a dialog.
 ;;  SAVE - saves all selected codes. Even if codes have been selected, they will
 ;;         not be stored until they are saved. Finally, a save must be done when
 ;;         exiting the ScreenMan form or no changes will be saved.
 ;;  EXIT - saves then exits.
 ;;
 ;;Some coding systems cannot be used in a dialog; in those cases, the RFD and UID
 ;;actions cannot be selected. Actions that cannot be selected have their text
 ;;description surrounded by parentheses. For example, when a coding system can be
 ;;used in a dialog, the UID action will look like this:
 ;; UID  Use in dialog
 ;;When the coding system cannot be used in a dialog, it will look like this:
 ;; UID  (Use in dialog)
 ;;
 ;;You can select the action first and then be prompted for a list of codes or
 ;;you can input the list and then select the action. Because of the way List
 ;;Manager works, you may be able to select a larger list by selecting the action
 ;;first.
 ;;
 ;;**End Text**
 Q
 ;
 ;=========================================
IMPLIST(TAXIEN,TERM,CODESYS,NCODES,NLINES,TEXT) ;Build the list for an
 ;imported set of codes.
 N ACTDT,CODE,DESC,INACTDT,NUM,PDATA,RESULT
 S CODE="",(NCODES,NLINES)=0
 F  S CODE=$O(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) Q:CODE=""  D
 . K PDATA
 .;DBIA #5679
 . S RESULT=$$PERIOD^LEXU(CODE,CODESYS,.PDATA)
 . I +RESULT=-1 Q
 . S NCODES=NCODES+1
 . S (ACTDT,NUM)=0
 . F  S ACTDT=$O(PDATA(ACTDT)) Q:ACTDT=""  D
 .. S INACTDT=$P(PDATA(ACTDT),U,1)
 .. S DESC=PDATA(ACTDT,0)
 .. S NUM=NUM+1
 .. S NLINES=NLINES+1
 .. I NUM=1 S TEXT(NLINES)=NCODES_U_CODE_U_ACTDT_U_INACTDT_U_DESC
 .. E  S TEXT(NLINES)=U_U_ACTDT_U_INACTDT_U_DESC
 Q
 ;
 ;=========================================
INCL ;Put the selected entries on the selected list and highlight them.
 N SEL,SELLIST
 ;Get the list.
 D GETLIST(.SELLIST)
 ;If there is no list quit.
 I '$D(SELLIST) Q
 S SEL=""
 F  S SEL=$O(SELLIST(SEL)) Q:SEL=""  D ADDSEL(SEL,"")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
INCX(LIST,UID) ;Put the selected entries on the selected list and highlight
 ;them.
 N ENUM,IND
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . D ADDSEL(ENUM,UID)
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXRMLEXL",$J)
 Q
 ;
 ;=========================================
LEXLIST(TAXIEN,TERM,CODESYS,NCODES,NLINES,TEXT) ;Call Lexicon to get the list
 ;of codes.
 I $E(TERM,1,9)="Copy from" D CPLIST(TAXIEN,TERM,CODESYS,.NCODES,.NLINES,.TEXT) Q
 I TERM["(imported)" D IMPLIST(TAXIEN,TERM,CODESYS,.NCODES,.NLINES,.TEXT) Q
 N ACTDT,CODE,CODEI,INACTDT,IND,NUM
 N RESULT,SRC,SDESC,TEMP
 W @IOF,"Searching Lexicon ..."
 K ^TMP("LEXTAX",$J)
 ;DBIA #5681
 S RESULT=$$TAX^LEX10CS(TERM,CODESYS,DT,"LEXTAX",0)
 S NCODES=+RESULT
 I NCODES=-1 S (NCODES,NLINES)=0 K ^TMP("LEXTAX",$J) Q
 S SRC=+$O(^TMP("LEXTAX",$J,0))
 I CODESYS="SCT" D SCTDESC("LEXTAX")
 S CODEI="",(NLINES,NUM)=0
 F  S CODEI=$O(^TMP("LEXTAX",$J,SRC,CODEI)) Q:CODEI=""  D
 . S NUM=NUM+1,IND=0
 . F  S IND=$O(^TMP("LEXTAX",$J,SRC,CODEI,IND)) Q:IND=""  D
 .. S TEMP=^TMP("LEXTAX",$J,SRC,CODEI,IND)
 .. S ACTDT=$P(TEMP,U,1),INACTDT=$P(TEMP,U,2)
 .. S TEMP=^TMP("LEXTAX",$J,SRC,CODEI,IND,0)
 .. S CODE=$P(TEMP,U,1),SDESC=$P(TEMP,U,2)
 .. S NLINES=NLINES+1
 .. I IND=1 S TEXT(NLINES)=NUM_U_CODE_U_ACTDT_U_INACTDT_U_SDESC
 .. E  S TEXT(NLINES)=U_U_ACTDT_U_INACTDT_U_SDESC
 K ^TMP("LEXTAX",$J)
 Q
 ;
 ;=========================================
PEXIT ; Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
 ;=========================================
RFD(ENUM) ;Remove UID from the selected entry.
 N START
 S $P(^TMP("PXRMLEXL",$J,"SELECTED",ENUM),U,2)=0
 S START=$P(^TMP("PXRMLEXL",$J,"LINES",ENUM),U,1)
 D FLDCTRL^VALM10(START,"CODE",IORVOFF,IORVOFF,"")
 Q
 ;
 ;=========================================
RFDL ;Remove UID from the selected entries.
 N SEL,SELLIST
 ;Get the list.
 D GETLIST(.SELLIST)
 ;If there is no list quit.
 I '$D(SELLIST) Q
 S SEL=""
 F  S SEL=$O(SELLIST(SEL)) Q:SEL=""  D RFD(SEL)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
RFDX(LIST) ;Remove UID from the selected entries.
 N ENUM,IND
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . D RFD(ENUM)
 Q
 ;
 ;=========================================
RFT(ENUM) ;Remove entry ENUM from the selected list and unhighlight it.
 K ^TMP("PXRMLEXL",$J,"SELECTED",ENUM)
 D HLITE(ENUM,0,0)
 Q
 ;
 ;=========================================
RFTL ;Remove the selected entries from the selected list and unhighlight them.
 N SEL,SELLIST
 ;Get the list.
 D GETLIST(.SELLIST)
 ;If there is no list quit.
 I '$D(SELLIST) Q
 S SEL=""
 F  S SEL=$O(SELLIST(SEL)) Q:SEL=""  D RFT(SEL)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
RFTX(LIST) ;Remove the selected entries from the selected list and unhighlight
 ;them.
 N ENUM,IND
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . D RFT(ENUM)
 Q
 ;
 ;=========================================
SAVE ;Save the selected entries in the taxonomy.
 N CODE,CODESYS,ENUM,TEMP,TERM,UID
 ;^TMP("PXRMLEXTC",$J) nodes are set in PXRMTXSM which calls this
 ;List Manager selection. 
 S CODESYS=^TMP("PXRMLEXTC",$J,"CODESYS")
 S TERM=^TMP("PXRMLEXTC",$J,"LEX TERM")
 K ^TMP("PXRMCODES",$J,TERM,CODESYS)
 ;Mark this coding system as having been edited so it is not reloaded
 ;from the taxonomy in CODELIST^PXRMTXSM.
 S ^TMP("PXRMCODES",$J,TERM,CODESYS)=""
 S ENUM=0,NSEL=0
 F  S ENUM=$O(^TMP("PXRMLEXL",$J,"SELECTED",ENUM)) Q:ENUM=""  D
 . S TEMP=^TMP("PXRMLEXL",$J,"SELECTED",ENUM)
 . S CODE=$P(TEMP,U,1),UID=$P(TEMP,U,2)
 . S ^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)=UID
 S VALMBCK="R"
 Q
 ;
 ;=========================================
SCTDESC(NODE) ;Append the SNOMED hierarchy to the description and then
 ;sort the list by description.
 N ACTDT,CODEI,CODE,DESC,FSN,HE,HIER,HS,NUM,SRC
 K ^TMP($J,"DESC"),^TMP($J,"SORT")
 S SRC=$O(^TMP(NODE,$J,0))
 S CODEI=""
 F  S CODEI=$O(^TMP(NODE,$J,SRC,CODEI)) Q:CODEI=""  D
 . S ACTDT=$P(^TMP(NODE,$J,SRC,CODEI,1),U,1)
 . S CODE=$P(^TMP(NODE,$J,SRC,CODEI,1,0),U,1)
 . S DESC=$P(^TMP(NODE,$J,SRC,CODEI,1,0),U,2)
 .;DBIA #5007
 . S FSN=$$GETFSN^LEXTRAN1(SRC,CODE,ACTDT)
 . S HS=$F(FSN,"(")
 . S HE=$F(FSN,")",HS)
 . S HIER=$E(FSN,HS-1,HE-1)
 . S DESC=DESC_" "_HIER
 . S ^TMP($J,"DESC",DESC,CODEI)=""
 S DESC="",NUM=0
 F  S DESC=$O(^TMP($J,"DESC",DESC)) Q:DESC=""  D
 . S CODEI=""
 . F  S CODEI=$O(^TMP($J,"DESC",DESC,CODEI)) Q:CODEI=""  D
 .. S NUM=NUM+1
 .. M ^TMP($J,"SORT",SRC,NUM)=^TMP(NODE,$J,SRC,CODEI)
 .. S $P(^TMP($J,"SORT",SRC,NUM,1,0),U,2)=DESC
 K ^TMP(NODE,$J)
 M ^TMP(NODE,$J)=^TMP($J,"SORT")
 K ^TMP($J,"DESC"),^TMP($J,"SORT")
 Q
 ;
 ;=========================================
UIDL ;Mark selected entries as UID.
 N SEL,SELLIST
 ;Get the list.
 D GETLIST(.SELLIST)
 ;If there is no list quit.
 I '$D(SELLIST) Q
 S SEL=""
 F  S SEL=$O(SELLIST(SEL)) Q:SEL=""  D ADDSEL(SEL,1)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
UIDOK() ;Check the coding system to determine if it can be used in a dialog.
 N CODESYS
 S CODESYS=^TMP("PXRMLEXTC",$J,"CODESYS")
 I CODESYS="10D" Q 1
 I CODESYS="CPC" Q 1
 I CODESYS="CPT" Q 1
 I CODESYS="ICD" Q 1
 I CODESYS="SCT" Q 1
 S (XQORQUIT,XQORPOP)=1
 Q 0
 ;
 ;=========================================
VIEW() ;Select the view.
 S VALMBCK="R"
 Q
 ;I PXRMLEXV="ALL" S PXRMBGS("ALL")=VALMBG D BLDSLIST Q
 ;I PXRMLEXV="SEL" S PXRMBGS("SEL")=VALMBG D BLDLIST Q
 ;Q
 ;
 ;=========================================
XQORM ; Set range for selection.
 N NCODES
 S NCODES=+$G(^TMP("PXRMLEXL",$J,"NCODES"))
 I NCODES=0 Q
 S XQORM("#")=$O(^ORD(101,"B","PXRM LEXICON SELECT ENTRY",0))_U_"1:"_NCODES
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PXRM LEXICON SELECT ENTRY.
 N ENUM,IND,LIST,LVALID
 S LIST=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(LIST,$L(LIST))="," S LIST=$E(LIST,1,$L(LIST)-1)
 S LVALID=1
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . I (ENUM<1)!(ENUM>VALMCNT)!('$D(^TMP("PXRMLEXL",$J,"LINES",ENUM))) D
 .. W !,ENUM," is not a valid selection."
 .. W !,"The range is 1 to ",$O(^TMP("PXRMLEXL",$J,"LINES",""),-1),"."
 .. H 2
 .. S LVALID=0
 I 'LVALID S VALMBCK="R" Q
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Possible actions.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U_"ADD:Add to taxonomy;"
 S DIR(0)=DIR(0)_"RFT:Remove from taxonomy;"
 I $$UIDOK D
 . S DIR(0)=DIR(0)_"RFD:Remove from dialog;"
 . S DIR(0)=DIR(0)_"UID:Use in dialog;"
 S DIR("A")="Select Action: "
 S DIR("B")="ADD"
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="ADD" D INCX^PXRMLEXL(.LIST,0)
 I OPTION="RFD" D RFDX^PXRMLEXL(.LIST)
 I OPTION="RFT" D RFTX^PXRMLEXL(.LIST)
 I OPTION="UID" D INCX^PXRMLEXL(.LIST,1)
 ;
 S VALMBCK="R"
 Q
 ;
