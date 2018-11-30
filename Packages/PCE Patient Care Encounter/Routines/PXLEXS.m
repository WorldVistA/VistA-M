PXLEXS ;SLC/PKR - List Manager routines for Lexicon code selection. ;08/01/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;=========================================
ADDSEL(ENUM) ;Add entry ENUM to the selected list and highlight it.
 N CODE
 S CODE=^TMP("PXLEXL",$J,"CODE",ENUM)
 S ^TMP("PXLEXL",$J,"SELECTED",ENUM)=CODE
 D HLITE(ENUM,1)
 Q
 ;
 ;=========================================
BLDLIST ;Build the Lexicon list.
 N ACTIVE,CODE,CODESYS,CODESYSP,DESC,ENUM,FMTSTR,IND,JND
 N NCODES,NL,NLINES,NSEL,NUID,NUM,OUTPUT,START,TAXIEN,TERM,TEXT,UID
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLLL")
 ;List Manager selection. 
 ;Clear the display.
 D KILL^VALM10
 K ^TMP("PXLEXL",$J)
 S CODESYS=^TMP("PXLEXT",$J,"CODING SYSTEM")
 S TERM=^TMP("PXLEXT",$J,"SEARCH TERM")
 S EVENTDT=^TMP("PXLEXT",$J,"EVENT D/T")
 S ACTIVE=^TMP("PXLEXT",$J,"ACTIVE")
 ;Clear the display.
 D KILL^VALM10
 K ^TMP("PXLEXL",$J)
 D LEXLIST(TERM,CODESYS,EVENTDT,.NCODES,.NLINES,.TEXT,ACTIVE)
 ;Get the coding system Lexicon information for building the display.
 ;DBIA #5679
 S CODESYSP=$$CSYS^LEXU(CODESYS)
 S TEXT=^TMP("PXLEXT",$J,"SEARCH TERM")
 S TEXT=$S(($L(TEXT)'>66):TEXT,1:$E(TEXT,1,63)_"...")
 S VALMHDR(1)="Term/Code: "_TEXT
 S VALMHDR(2)=NCODES_" "_$P(CODESYSP,U,4)_$S(NCODES=1:" code was found",1:" codes were found")
 ;Set these so LM shows Page 1 of 1 when there are no codes.
 I NCODES=0 S VALMHDR(2)=VALMHDR(2)_".",^TMP("PXLEXL",$J,1,0)="",VALMCNT=1 Q
 ;
 S VALMCNT=0
 F IND=1:1:NLINES D
 . S NUM=$P(TEXT(IND),U,1),CODE=$P(TEXT(IND),U,2)
 . I NUM'="",CODE'="" S ENUM=NUM,^TMP("PXLEXL",$J,"CODE",NUM)=CODE,START=VALMCNT+1
 . D FORMAT(TEXT(IND),FMTSTR,.NL,.OUTPUT)
 . F JND=1:1:NL D
 .. S VALMCNT=VALMCNT+1,^TMP("PXLEXL",$J,VALMCNT,0)=OUTPUT(JND)
 .. S ^TMP("PXLEXL",$J,"IDX",VALMCNT,ENUM)=""
 . S ^TMP("PXLEXL",$J,"LINES",ENUM)=START_U_VALMCNT
 S ^TMP("PXLEXL",$J,"NCODES")=NCODES
 S ^TMP("PXLEXL",$J,"VALMCNT")=VALMCNT
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXLEXS
 D BLDLIST^PXLEXS
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 M ^TMP("PXLEXT",$J,"SELECTED CODES")=^TMP("PXLEXL",$J,"SELECTED")
 D INITMPG^PXLEXS
 D FULL^VALM1
 D CLEAN^VALM10
 D KILL^VALM10
 D CLEAR^VALM1
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
GETCODE(CODESYS,SRCHTERM,EVENTDT,ACTIVE) ;Given a coding system and search term,
 ;display a list of matches so the user can make a single selection.
 N CODE,SELECTED
 K ^TMP("PXLEXT",$J)
 S ^TMP("PXLEXT",$J,"CODING SYSTEM")=CODESYS
 S ^TMP("PXLEXT",$J,"SEARCH TERM")=SRCHTERM
 S ^TMP("PXLEXT",$J,"EVENT D/T")=EVENTDT
 S ^TMP("PXLEXT",$J,"SINGLE")=1
 ;ACTIVE=1, return only active codes; ACTIVE=0, active and inactive.
 S ^TMP("PXLEXT",$J,"ACTIVE")=ACTIVE
 D EN^VALM("PXCE STANDARD CODES SELECT")
 S SELECTED=$O(^TMP("PXLEXT",$J,"SELECTED CODES",""))
 S CODE=$S(SELECTED="":"",1:^TMP("PXLEXT",$J,"SELECTED CODES",SELECTED))
 K ^TMP("PXLEXT",$J)
 Q CODE
 ;
 ;=========================================
GETCODES(CODESYS,SRCHTERM,EVENTDT,CODELIST,ACTIVE) ;Given a coding system and
 ;a search term, display a list of matches so the user can make a
 ;selection.
 K ^TMP("PXLEXT",$J)
 S ^TMP("PXLEXT",$J,"CODING SYSTEM")=CODESYS
 S ^TMP("PXLEXT",$J,"SEARCH TERM")=SRCHTERM
 S ^TMP("PXLEXT",$J,"EVENT D/T")=EVENTDT
 S ^TMP("PXLEXT",$J,"ACTIVE")=ACTIVE
 D EN^VALM("PXCE STANDARD CODES SELECT")
 M CODELIST=^TMP("PXLEXT",$J,"SELECTED CODES")
 K ^TMP("PXLEXT",$J)
 Q
 ;
 ;=========================================
GETLIST(LIST) ;Let the user input a list of items.
 N DIR,DIR0,INUM,ITEM,LEND,LELEM,NCODES,LSTART,X,Y
 S NCODES=+$G(^TMP("PXLEXL",$J,"NCODES"))
 I NCODES=0 Q
 I NCODES=1 S LIST(1)="" Q
 S DIR0=$S($D(^TMP("PXLEXT",$J,"SINGLE")):"N^1:"_NCODES_":0",1:"LC^1:"_NCODES)
 S DIR(0)=DIR0
 D ^DIR
 I $E(Y,1)="^" Q
 I Y?1.N S LIST(Y)="" Q
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
 S VALMHDR(1)="Select the standard code(s)."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HELP ;Display help.
 N DDS,DIR0,DONE,IND,HTEXT,TEXT
 ;DBIA #5746 covers kill and set of DDS. DDS needs to be set or the
 ;Browser will kill some ScreenMan variables.
 S HTEXT=$S($D(^TMP("PXLEXT",$J,"SINGLE")):"HTEXTS",1:"HTEXT")
 S DDS=1,DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(@HTEXT+IND),";",3,99)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","Lexicon Selection Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HLITE(ENUM,MODE) ;Highlight/unhighlight an entry. MODE=1 turns on
 ;highlighting, MODE=0 turns it off.
 N LINE,START,STOP,VCTRL
 S VCTRL=$S(MODE=1:IOINHI,1:IOINORM)
 S START=$P(^TMP("PXLEXL",$J,"LINES",ENUM),U,1)
 S STOP=$P(^TMP("PXLEXL",$J,"LINES",ENUM),U,2)
 F LINE=START:1:STOP D CNTRL^VALM10(LINE,1,80,VCTRL,IOINORM)
 ;If the entry is marked Use In Dialog turn on marker.
 I MODE=0 D FLDCTRL^VALM10(START,"CODE",IORVOFF,IORVOFF,"")
 Q
 ;
 ;=========================================
HTEXT ;Lexicon selection help text.
 ;;Select one of the following actions:
 ;;
 ;;  SEL  - Select codes to add to the encounter.
 ;;  REM  - Removes selected codes from the encounter.
 ;;
 ;;When you exit by typing 'Q' the selected codes will be added to or removed
 ;;from the encounter depending on the chosen action.
 ;;
 ;;You can select the action first and then be prompted for a list of codes or
 ;;you can input the list and then select the action. Because of the way List
 ;;Manager works, you may be able to select a larger list by selecting the action
 ;;first.
 ;;
 ;;**End Text**
 Q
 ;=========================================
HTEXTS ;Lexicon single selection help text.
 ;;Select one of the following actions:
 ;;
 ;;  SEL  - Select a code to add to the encounter.
 ;;  REM  - Remove a code from the encounter.
 ;;
 ;;When you exit by typing 'Q' the selected code will be added to or removed
 ;;from the encounter depending on the chosen action.
 ;;
 ;;You can select the action first and then be prompted for a code or you
 ;;can select a code and then select the action.
 ;;
 ;;**End Text**
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXLEXL",$J)
 Q
 ;
 ;=========================================
LEXLIST(TERM,CODESYS,EVENTDT,NCODES,NLINES,TEXT,ACTIVE) ;Call Lexicon to get
 ;the list of codes.
 N ACTDT,CODE,CODEI,INACTDT,IND,NUM
 N RESULT,SRC,SDESC,TEMP
 W @IOF,"Searching Lexicon ..."
 K ^TMP("PXLEX",$J)
 ;DBIA #5681
 S RESULT=$$TAX^LEX10CS(TERM,CODESYS,EVENTDT,"PXLEX",ACTIVE)
 S NCODES=+RESULT
 I NCODES=-1 S (NCODES,NLINES)=0 K ^TMP("PXLEX",$J) Q
 I CODESYS="SCT" D SCTDESC("PXLEX")
 S SRC=0
 S (NLINES,NUM)=0
 F  S SRC=$O(^TMP("PXLEX",$J,SRC)) Q:SRC=""  D
 . S CODEI=""
 . F  S CODEI=$O(^TMP("PXLEX",$J,SRC,CODEI)) Q:CODEI=""  D
 .. S NUM=NUM+1,IND=0
 .. F  S IND=$O(^TMP("PXLEX",$J,SRC,CODEI,IND)) Q:IND=""  D
 ... S TEMP=^TMP("PXLEX",$J,SRC,CODEI,IND)
 ... S ACTDT=$P(TEMP,U,1),INACTDT=$P(TEMP,U,2)
 ... S TEMP=^TMP("PXLEX",$J,SRC,CODEI,IND,0)
 ... S CODE=$P(TEMP,U,1),SDESC=$P(TEMP,U,2)
 ... S NLINES=NLINES+1
 ... I IND=1 S TEXT(NLINES)=NUM_U_CODE_U_ACTDT_U_INACTDT_U_SDESC
 ... E  S TEXT(NLINES)=U_U_ACTDT_U_INACTDT_U_SDESC
 K ^TMP("PXLEX",$J)
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
REM(ENUM) ;Remove entry ENUM from the selected list and unhighlight it.
 K ^TMP("PXLEXL",$J,"SELECTED",ENUM)
 D HLITE(ENUM,0)
 Q
 ;
 ;=========================================
REML ;Remove the selected entries from the selected list and unhighlight them.
 N SEL,SELLIST
 ;Get the list.
 D GETLIST(.SELLIST)
 ;If there is no list quit.
 I '$D(SELLIST) Q
 S SEL=""
 F  S SEL=$O(SELLIST(SEL)) Q:SEL=""  D REM(SEL)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
REMX(LIST) ;Remove the selected entries from the selected list and unhighlight
 ;them.
 N ENUM,IND
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . D REM(ENUM)
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
SELL ;Put the selected entries on the selected list and highlight them.
 N SEL,SELLIST
 ;Get the list.
 D GETLIST(.SELLIST)
 ;If there is no list quit.
 I '$D(SELLIST) Q
 S SEL=""
 F  S SEL=$O(SELLIST(SEL)) Q:SEL=""  D ADDSEL(SEL)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
SELX(LIST) ;Put the selected entries on the selected list and highlight
 ;them.
 N ENUM,IND
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . D ADDSEL(ENUM)
 Q
 ;
 ;=========================================
XQORM ; Set range for selection.
 N NCODES
 S NCODES=+$G(^TMP("PXLEXL",$J,"NCODES"))
 I NCODES=0 Q
 S XQORM("#")=$O(^ORD(101,"B","PXCE LEXICON SELECT ENTRY",0))_U_"1:"_NCODES
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PXCE LEXICON SELECT ENTRY.
 N ENUM,IND,LIST,LVALID
 S LIST=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(LIST,$L(LIST))="," S LIST=$E(LIST,1,$L(LIST)-1)
 S LVALID=1
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . I (ENUM<1)!(ENUM>VALMCNT)!('$D(^TMP("PXLEXL",$J,"LINES",ENUM))) D
 .. W !,ENUM," is not a valid selection."
 .. W !,"The range is 1 to ",$O(^TMP("PXLEXL",$J,"LINES",""),-1),"."
 .. H 2
 .. S LVALID=0
 I $D(^TMP("PXLEXT",$J,"SINGLE")),LIST'?1.N D
 . W !,"Only a single code can be selected."
 . S LVALID=0
 . H 2
 I 'LVALID S VALMBCK="R" Q
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Possible actions.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U_"SEL:Select code(s);"
 S DIR(0)=DIR(0)_"REM:Remove code(s);"
 S DIR("A")="Select Action: "
 S DIR("B")="SEL"
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="SEL" D SELX^PXLEXS(.LIST)
 I OPTION="REM" D REMX^PXLEXS(.LIST)
 ;
 S VALMBCK="R"
 Q
 ;
