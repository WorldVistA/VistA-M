PXRMCQLM ;SLC/PKR - List Manager routines for clinical quality measures. ;07/18/2014
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;
 ;=========================================
BLDLIST(NODE) ;Build of list of value set file entries.
 N CMSID,IEN,FMTSTR,IND,NAME,NL,NUM,OUTPUT,START
 K ^TMP(NODE,$J)
 ;Build the list in alphabetical order.
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLL")
 S (NUM,VALMCNT)=0
 S NAME=""
 F  S NAME=$O(^PXRM(802.3,"B",NAME)) Q:NAME=""  D
 . S IEN=""
 . F  S IEN=$O(^PXRM(802.3,"B",NAME,IEN)) Q:IEN=""  D
 .. S NUM=NUM+1
 .. S CMSID=$P(^PXRM(802.3,IEN,1),U,1)
 .. S ^TMP(NODE,$J,"SEL",NUM)=IEN
 .. S ^TMP(NODE,$J,"IEN",IEN)=NUM
 .. D FORMAT(NUM,NAME,CMSID,FMTSTR,.NL,.OUTPUT)
 .. S START=VALMCNT+1
 .. F IND=1:1:NL D
 ... S VALMCNT=VALMCNT+1,^TMP(NODE,$J,VALMCNT,0)=OUTPUT(IND)
 ... S ^TMP(NODE,$J,"IDX",VALMCNT,NUM)=""
 .. S ^TMP(NODE,$J,"LINES",NUM)=START_U_VALMCNT
 S ^TMP(NODE,$J,"VALMCNT")=VALMCNT
 S ^TMP(NODE,$J,"NCQM")=NUM
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXRMCQLM
 D BLDLIST^PXRMCQLM("PXRMCQML")
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXRMCQLM
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
FORMAT(NUMBER,NAME,CMSID,FMTSTR,NL,OUTPUT) ;Format entry number and name for
 ;the LM display.
 N TEMP
 S TEMP=NUMBER_U_NAME_U_CMSID
 D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NL,.OUTPUT)
 Q
 ;
 ;=========================================
GETSEL(TEXT) ;Get a single selection
 N DIR,NCQM,X,Y
 S NCQM=+$G(^TMP("PXRMCQML",$J,"NCQM"))
 I NCQM=0 Q 0
 S DIR(0)="N^1:"_NCQM
 S DIR("A")=TEXT
 D ^DIR
 Q +$G(^TMP("PXRMCQML",$J,"SEL",+Y))
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
 D BROWSE^DDBR("TEXT","NR","Clinical Quality Measures Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="NLM Clinical Quality Measures."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HTEXT ;Taxonomy mangement help text.
 ;;Select one of the following actions:
 ;; INQ - clinical quality measure inquiry.
 ;;
 ;;You can select the action first and then the entry or choose the entry and then
 ;;the action.
 ;;
 ;;**End Text**
 Q
 ;
 ;=========================================
INQ(IEN) ;Display the contents of a measure.
 D BMINQ^PXRMCQIN(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
INQS ;Inquiry for a selected value set.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the value set")
 I IEN=0 S VALMBCK="R" Q
 D INQ^PXRMCQLM(IEN)
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXRMCQML",$J)
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
START ;Main entry point for PXRM Value Set Menu.
 N VALMBCK,VALMSG,X
 S X="IORESET"
 D ENDR^%ZISS
 D EN^VALM("PXRM CQM MENU")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;=========================================
XQORM ;Set range for selection.
 N NCQM
 S NCQM=^TMP("PXRMCQML",$J,"NCQM")
 S XQORM("#")=$O(^ORD(101,"B","PXRM CQM SELECT ENTRY",0))_U_"1:"_NCQM
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PXRM CQM SELECT ENTRY.
 N EDITOK,IEN,SEL
 S SEL=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(SEL,$L(SEL))="," S SEL=$E(SEL,1,$L(SEL)-1)
 ;Invalid selection
 I SEL["," D  Q
 . W !,"Only one item number allowed." H 2
 . S VALMBCK="R"
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("SEL",SEL))) D  Q
 . W !,SEL_" is not a valid item number." H 2
 . S VALMBCK="R"
 ;
 ;Get the IEN.
 S IEN=^TMP("PXRMCQML",$J,"SEL",SEL)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Action list.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U
 S DIR(0)=DIR(0)_"INQ:Inquire;"
 S DIR("A")="Select Action: "
 S DIR("B")="INQ"
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="INQ" D INQ^PXRMCQLM(IEN)
 S VALMBCK="R"
 Q
 ;
