PXRMTXLS ;SLC/PKR - List Manager routines for taxonomy all selected codes. ;05/22/2017
 ;;2.0;CLINICAL REMINDERS;**26,47,42**;Feb 04, 2005;Build 80
 ;
 ;=========================================
ADDSEL(ENUM,UID) ;Add entry ENUM to the selected list and highlight it.
 N CODESYS,NDUP,UIDT
 S CODESYS=$P(^TMP("PXRMTXSC",$J,"CODE",ENUM,1),U,2)
 S UIDT=$S('UID:0,1:$$UIDOK^PXRMUID(CODESYS))
 D HLITE(ENUM,1,UIDT)
 S NDUP=0
 F  S NDUP=$O(^TMP("PXRMTXSC",$J,"CODE",ENUM,NDUP)) Q:NDUP=""  D
 . S ^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)=^TMP("PXRMTXSC",$J,"CODE",ENUM,NDUP)
 . S $P(^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP),U,4)=UIDT
 Q
 ;
 ;=========================================
BLDLIST ;Build the list of all selected codes.
 N CODE,CODESYS,CODESYSP,ENUM,FMTSTR,IND,JND,NDUP,NL,NLINES
 N NSEL,NUID,NUM,OUTPUT,START,TERM,TEXT,UID,UIDOK,UIDMSG
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLLL")
 ;^TMP("PXRMTAX",$J) is set in VEALLSEL^PXRMTXSM which invokes the List
 ;Manager screen PXRM TAXONOMY ALL SELECTED MENU. It is also set in
 ;UIDE^PXRMTAXL which starts the UID edit.
 ;Clear the display.
 D KILL^VALM10
 K ^TMP("PXRMTXSC",$J)
 I '$D(^TMP("PXRMCODES",$J)) D  Q
 . S VALMHDR(2)="No codes have been selected.",^TMP("PXRMTXSC",$J,1,0)=""
 . S VALMCNT=1,VALMBCK="R"
 ;Build the display list grouped by coding system.
 S TERM=""
 F  S TERM=$O(^TMP("PXRMCODES",$J,TERM)) Q:TERM=""  D
 . S CODESYS=""
 . F  S CODESYS=$O(^TMP("PXRMCODES",$J,TERM,CODESYS)) Q:CODESYS=""  D
 .. S CODE=""
 .. F  S CODE=$O(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) Q:CODE=""  D
 ... S ^TMP("PXRMTXSC",$J,"CODES",CODESYS,CODE)=^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)
 ... S ^TMP("PXRMTXSC",$J,"CODES",CODESYS,CODE,TERM)=^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)
 ;
 S (ENUM,NLINES,NUID,VALMCNT)=0
 S CODESYS=""
 F  S CODESYS=$O(^TMP("PXRMTXSC",$J,"CODES",CODESYS)) Q:CODESYS=""  D
 .;Get the Lexicon coding system information for building the display.
 .;DBIA #5679
 . S CODESYSP=$$CSYS^LEXU(CODESYS)
 . S UIDOK=$$UIDOK^PXRMUID(CODESYS)
 . S UIDMSG=" (This coding system "_$S(UIDOK:"can",1:"cannot")_" be used in a dialog.)"
 . S VALMCNT=VALMCNT+1,^TMP("PXRMTXSC",$J,VALMCNT,0)=""
 . S VALMCNT=VALMCNT+1,^TMP("PXRMTXSC",$J,VALMCNT,0)=$P(CODESYSP,U,4)_UIDMSG
 . S CODE=""
 . F  S CODE=$O(^TMP("PXRMTXSC",$J,"CODES",CODESYS,CODE)) Q:CODE=""  D
 .. S ENUM=ENUM+1,START=VALMCNT+1
 .. D LEXPER(ENUM,CODE,CODESYS,.NLINES,.TEXT)
 .. F IND=1:1:NLINES D
 ... D FORMAT(TEXT(IND),FMTSTR,.NL,.OUTPUT)
 ... F JND=1:1:NL S VALMCNT=VALMCNT+1,^TMP("PXRMTXSC",$J,VALMCNT,0)=OUTPUT(JND)
 .. S ^TMP("PXRMTXSC",$J,"IDX",START,ENUM)=""
 .. S ^TMP("PXRMTXSC",$J,"LINES",ENUM)=START_U_VALMCNT
 .. S UID=+^TMP("PXRMTXSC",$J,"CODES",CODESYS,CODE)
 .. I UID S NUID=NUID+1
 .. D HLITE(ENUM,1,UID)
 .. S TERM="",NDUP=0
 .. F  S TERM=$O(^TMP("PXRMTXSC",$J,"CODES",CODESYS,CODE,TERM)) Q:TERM=""  D
 ... S NDUP=NDUP+1
 ... S TEMP=TERM_U_CODESYS_U_CODE_U_UID
 ... S ^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)=TEMP
 ... S ^TMP("PXRMTXSC",$J,"CODE",ENUM,NDUP)=TEMP
 S ^TMP("PXRMTXSC",$J,"NCODES")=ENUM
 S ^TMP("PXRMTXSC",$J,"VALMCNT")=VALMCNT
 ;Set these so LM shows Page 1 of 1 when there are no codes.
 I ENUM=0 S VALMHDR(2)="No codes have been selected.",^TMP("PXRMTXSC",$J,1,0)="",VALMCNT=1 Q
 S VALMHDR(2)=ENUM_" codes have been selected, "_NUID_" are marked UID."
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXRMTXLS
 D HDR^PXRMTXLS
 D BLDLIST^PXRMTXLS
 D XQORM^PXRMTXLS
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXRMTXLS
 D FULL^VALM1
 D CLEAN^VALM10
 D KILL^VALM10
 D CLEAR^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
EXITS ;Exit and save action.
 D SAVE^PXRMTXLS
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
 S NCODES=+$G(^TMP("PXRMTXSC",$J,"NCODES"))
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
 S VALMHDR(1)="All selected codes in this taxonomy."
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
 S START=$P(^TMP("PXRMTXSC",$J,"LINES",ENUM),U,1)
 S STOP=$P(^TMP("PXRMTXSC",$J,"LINES",ENUM),U,2)
 F LINE=START:1:STOP D CNTRL^VALM10(LINE,1,80,VCTRL,IOINORM)
 ;If the entry is marked Use In Dialog turn on marker.
 I MODE=1,UID=1 D FLDCTRL^VALM10(START,"CODE",IORVON,IORVOFF,"")
 I MODE=0 D FLDCTRL^VALM10(START,"CODE",IORVOFF,IORVOFF,"")
 Q
 ;
 ;=========================================
HTEXT ;Lexicon selection help text. PROBABLY CAN REMOVE AND USE ORIGINAL
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
 N CODESYS,ENUM,IND,NDUP
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . D ADDSEL(ENUM,UID)
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXRMTXSC",$J)
 Q
 ;
 ;=========================================
LEXPER(ENUM,CODE,CODESYS,NLINES,TEXT) ;Call PERIOD^LEXU to get the code
 ;information.
 N ACTDT,DESC,INACTDT,PDATA,RESULT
 ;DBIA #5679
 S RESULT=$$PERIOD^LEXU(CODE,CODESYS,.PDATA)
 I +RESULT=-1 S NLINES=0 Q
 S (ACTDT,NLINES)=0
 F  S ACTDT=$O(PDATA(ACTDT)) Q:ACTDT=""  D
 . S INACTDT=$P(PDATA(ACTDT),U,1)
 . S DESC=PDATA(ACTDT,0)
 . I CODESYS="SCT" S DESC=DESC_" "_$$SCTHIER^PXRMTXIN(CODE,ACTDT)
 . S NLINES=NLINES+1
 . I NLINES=1 S TEXT(NLINES)=ENUM_U_CODE_U_ACTDT_U_INACTDT_U_DESC
 . E  S TEXT(NLINES)=U_U_ACTDT_U_INACTDT_U_DESC
 Q
 ;
 ;=========================================
PEXIT ; Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM^PXRMTXLS
 Q
 ;
 ;=========================================
RFD(ENUM) ;Remove UID from the selected entry.
 N NDUP,START
 S NDUP=0
 F  S NDUP=$O(^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)) Q:NDUP=""  D
 . S $P(^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP),U,4)=0
 S START=$P(^TMP("PXRMTXSC",$J,"LINES",ENUM),U,1)
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
 N CODE,CODESYS,DEL,NDUP,TEMP,TERM
 S NDUP=0
 F  S NDUP=$O(^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)) Q:NDUP=""  D
 . S TEMP=^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)
 . S ^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)=TEMP_U_"@"
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
SAVE ;Save the selected entries in the taxonomy. This amounts to rebuilding
 ;^TMP("PXRMCODES",$J).
 N CODE,CODESYS,DEL,ENUM,NDUP,TEMP,TERM,UID
 S ENUM=0
 F  S ENUM=$O(^TMP("PXRMTXSC",$J,"SELECTED",ENUM)) Q:ENUM=""  D
 . S NDUP=0
 . F  S NDUP=$O(^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)) Q:NDUP=""  D
 .. S TEMP=^TMP("PXRMTXSC",$J,"SELECTED",ENUM,NDUP)
 .. S TERM=$P(TEMP,U,1),CODESYS=$P(TEMP,U,2)
 .. S CODE=$P(TEMP,U,3),UID=$P(TEMP,U,4)
 .. I TEMP["@" K ^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)
 .. E   S ^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)=UID
 ;Check for terms that should be deleted.
 S TERM=""
 F  S TERM=$O(^TMP("PXRMCODES",$J,TERM)) Q:TERM=""  D
 . S DEL=$$TERMDEL(TERM)
 . I DEL S ^TMP("PXRMCODES",$J,TERM)="@" Q
 . S CODESYS=""
 . F  S CODESYS=$O(^TMP("PXRMCODES",$J,TERM,CODESYS)) Q:CODESYS=""  D
 ..;(TERM,CODESYS) exists but has no codes if $D=1
 .. I $D(^TMP("PXRMCODES",$J,TERM,CODESYS))=1 S ^TMP("PXRMCODES",$J,TERM,CODESYS)=""
 S VALMBCK="R"
 Q
 ;
 ;=========================================
TERMDEL(TERM) ;Determine how many codes this term contains. If there are none
 ;then ask the user if they want the term deleted.
 N CODE,CODESYS,DEL,DIR,IENS,IND,KFDA,MSG,NCODES,TEXT,X,Y
 S CODESYS="",NCODES=0
 S CODESYS=""
 F  S CODESYS=$O(^TMP("PXRMCODES",$J,TERM,CODESYS)) Q:CODESYS=""  D
 . S CODE=""
 . F  S CODE=$O(^TMP("PXRMCODES",$J,TERM,CODESYS,CODE)) Q:CODE=""  S NCODES=NCODES+1
 ;
 I NCODES>0 Q 0
 ;Have the user verify the term deletion is OK.
 S TEXT(1)=""
 S TEXT(2)="All the codes in term "_TERM
 S TEXT(3)="have been selected for removal from the taxonomy."
 S TEXT(4)=""
 D EN^DDIOL(.TEXT)
 S DIR(0)="YAO"
 S DIR("A")="Do you want this term deleted too? "
 S DIR("B")="Y"
 D ^DIR
 ;The user said not to delete the term.
 I +Y=0 Q 0
 K TEXT
 S TEXT(1)="The term will be deleted when the editing session is saved."
 S TEXT(2)=""
 D EN^DDIOL(.TEXT) H 2
 Q 1
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
XQORM ; Set range for selection.
 N NCODES
 S NCODES=+$G(^TMP("PXRMTXSC",$J,"NCODES"))
 I NCODES=0 Q
 S XQORM("#")=$O(^ORD(101,"B","PXRM TAXONOMY ALL SELECTED SELECT",0))_U_"1:"_NCODES
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PXRM TAXONOMY ALL SELECTED SELECT.
 N ENUM,IND,LIST,NCODES,LVALID
 S LIST=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(LIST,$L(LIST))="," S LIST=$E(LIST,1,$L(LIST)-1)
 S LVALID=1
 S NCODES=+$O(^TMP("PXRMTXSC",$J,"LINES",""),-1)
 F IND=1:1:$L(LIST,",") D
 . S ENUM=$P(LIST,",",IND)
 . I (ENUM<1)!(ENUM>NCODES) D
 .. W !,ENUM," is not a valid selection."
 .. W !,"The range is 1 to ",NCODES,"."
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
 S DIR(0)=DIR(0)_"RFD:Remove from dialog;"
 S DIR(0)=DIR(0)_"UID:Use in dialog;"
 S DIR("A")="Select Action: "
 S DIR("B")="ADD"
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="ADD" D INCX^PXRMTXLS(.LIST,0)
 I OPTION="RFD" D RFDX^PXRMTXLS(.LIST)
 I OPTION="RFT" D RFTX^PXRMTXLS(.LIST)
 I OPTION="UID" D INCX^PXRMTXLS(.LIST,1)
 ;
 S VALMBCK="R"
 Q
 ;
