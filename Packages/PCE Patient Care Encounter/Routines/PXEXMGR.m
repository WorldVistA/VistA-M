PXEXMGR ;SLC/PKR - List Manager routines for Exams. ;09/19/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;=========================================
ADD ;Add a new entry.
 S VALMBCK="R"
 D CLEAR^VALM1
 N DA,DIC,DLAYGO,DTOUT,DUOUT,NEW,Y
 S DIC="^AUTTEXAM("
 S DIC(0)="AEKLQ"
 S DIC("A")="Enter a new Exam Name: "
 S DLAYGO=9999999.15
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT))!(Y=-1) S VALMBCK="R" Q
 S NEW=$P(Y,U,3)
 I 'NEW D EN^DDIOL("That entry already exists, use EDIT instead.") H 2
 I NEW D
 . S DA=$P(Y,U,1)
 . D SMANEDIT^PXEXSM(DA,1)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
BLDLIST(NODE) ;Build of list of Exam file entries.
 N IEN,DESC,NAME
 K ^TMP(NODE,$J)
 ;Build the list in alphabetical order.
 S NAME="",VALMCNT=0
 F  S NAME=$O(^AUTTEXAM("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEXAM("B",NAME,""))
 . S VALMCNT=VALMCNT+1
 . S ^TMP(NODE,$J,"SEL",VALMCNT)=IEN
 . S ^TMP(NODE,$J,"IEN",IEN)=VALMCNT
 . S DESC=$G(^AUTTEXAM(IEN,201,1,0))
 . S ^TMP(NODE,$J,VALMCNT,0)=$$FORMAT(VALMCNT,NAME,DESC)
 . S ^TMP(NODE,$J,"IDX",VALMCNT,VALMCNT)=""
 . S ^TMP(NODE,$J,"LINES",VALMCNT)=VALMCNT_U_VALMCNT
 S ^TMP(NODE,$J,"VALMCNT")=VALMCNT
 S ^TMP(NODE,$J,"NEXAM")=VALMCNT
 Q
 ;
 ;=========================================
CLOG(IEN) ;Display the change log.
 D LMCLBROW^PXRMSINQ(9999999.15,"110*",IEN)
 Q
 ;
 ;=========================================
CLOGS ;Display Change Log for a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display the change log for which exam?")
 S VALMBCK="R"
 I IEN=0 S VALMBCK="R" Q
 D CLOG(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
COPY(IEN) ;Copy a selected entry to a new name.
 D FULL^VALM1
 D COPY^PXCOPY(9999999.15,IEN)
 D BLDLIST^PXEXMGR("PXEXAML")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
COPYS ;Copy a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select exam to copy")
 I IEN=0 S VALMBCK="R" Q
 D COPY(IEN)
 Q
 ;
 ;=========================================
EDITS ;Edit a selected entry.
 S VALMBCK="R"
 N CLASS,IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the exam to edit")
 I IEN=0 S VALMBCK="R" Q
 D SMANEDIT^PXEXSM(IEN,0)
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXEXMGR
 D BLDLIST^PXEXMGR("PXEXAML")
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXEXMGR
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
FORMAT(NUMBER,NAME,DESC) ;Format  entry number, name, and first line of
 ;description for LM display.
 N TEXT,TDESC,TNAME
 S TNAME=$S($L(NAME)<56:NAME,1:$E(NAME,1,52)_"...")
 S TEXT=$$RJ^XLFSTR(NUMBER,5,"  ")_"  "_TNAME
 S TDESC=$S(DESC="":"",$L(DESC)<17:DESC,1:$E(DESC,1,13)_"...")
 I TDESC'="" S TEXT=TEXT_$$REPEAT^XLFSTR(" ",(63-$L(TEXT)))_TDESC
 Q TEXT
 ;
 ;=========================================
GETSEL(TEXT) ;Get a single selection
 N DIR,NEXAM,X,Y
 S NEXAM=+$G(^TMP("PXEXAML",$J,"NEXAM"))
 I NEXAM=0 Q 0
 S DIR(0)="N^1:"_NEXAM
 S DIR("A")=TEXT
 D ^DIR
 Q +$G(^TMP("PXEXAML",$J,"SEL",+Y))
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
 D BROWSE^DDBR("TEXT","NR","Exam Management Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="Exam File Entries."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HTEXT ;Exam mangement help text.
 ;;Select one of the following actions:
 ;; ADD  - add a new exam.
 ;; EDIT - edit an exam.
 ;; COPY - copy an existing exam to a new exam.
 ;; INQ  - exam inquiry.
 ;; EH   - exam edit history.
 ;;
 ;;You can select the action first and then the entry or choose the entry and then
 ;;the action.
 ;;
 ;;**End Text**
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXEXAML",$J)
 Q
 ;
 ;=========================================
INQ(IEN) ;Exam inquiry.
 S VALMBCK="R"
 D BEXINQ^PXEXINQ(IEN)
 Q
 ;
 ;=========================================
INQS ;Display inquiry for selected entries.
 S VALMBCK="R"
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display inquiry for which exam?")
 I IEN=0 S VALMBCK="R" Q
 D INQ(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
ISMAPPED(IEN) ;Return 1 if the exam has mapped codes.
 I +$P($G(^AUTTEXAM(IEN,210,0)),U,4)>0 Q 1
 Q 0
 ;
 ;=========================================
PEXIT ; Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
 ;=========================================
START ;Main entry point for PX Exam Management
 N VALMBCK,VALMSG,X
 S X="IORESET"
 D ENDR^%ZISS
 D EN^VALM("PX EXAM MANAGEMENT")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;=========================================
XQORM ;Set range for selection.
 N NEXAM
 S NEXAM=^TMP("PXEXAML",$J,"NEXAM")
 S XQORM("#")=$O(^ORD(101,"B","PX EXAM SELECT ENTRY",0))_U_"1:"_NEXAM
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PX EXAM SELECT ENTRY.
 N CLASS,EDITOK,IEN,SEL
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
 S IEN=^TMP("PXEXAML",$J,"SEL",SEL)
 S CLASS=$P(^AUTTEXAM(IEN,100),U,1)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Action list.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U
 S EDITOK=$S(CLASS'="N":1,1:($G(PXNAT)=1)&($G(DUZ(0))="@"))
 I EDITOK S DIR(0)=DIR(0)_"EDIT:Edit;"
 S DIR(0)=DIR(0)_"COPY:Copy;"
 S DIR(0)=DIR(0)_"INQ:Inquire;"
 S DIR(0)=DIR(0)_"CL:Change Log;"
 S DIR("A")="Select Action: "
 S DIR("B")=$S(CLASS="N":"INQ",1:"EDIT")
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="COPY" D COPY^PXEXMGR(IEN)
 I OPTION="EDIT" D SMANEDIT^PXEXSM(IEN,0)
 I OPTION="INQ" D BEXINQ^PXEXINQ(IEN)
 I OPTION="CL" D CLOG^PXEXMGR(IEN)
 S VALMBCK="R"
 Q
 ;
