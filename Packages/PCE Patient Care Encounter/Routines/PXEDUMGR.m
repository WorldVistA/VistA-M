PXEDUMGR ;SLC/PKR - List Manager routines for Education Topics. ;09/19/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;=========================================
ADD ;Add a new entry.
 S VALMBCK="R"
 D CLEAR^VALM1
 N DA,DIC,DLAYGO,DTOUT,DUOUT,NEW,Y
 S DIC="^AUTTEDT("
 S DIC(0)="AEKLQ"
 S DIC("A")="Enter a new Education Topic Name: "
 S DLAYGO=9999999.09
 D ^DIC
 I ($D(DTOUT))!($D(DUOUT))!(Y=-1) S VALMBCK="R" Q
 S NEW=$P(Y,U,3)
 I 'NEW D EN^DDIOL("That entry already exists, use EDIT instead.") H 2
 I NEW D
 . S DA=$P(Y,U,1)
 . D SMANEDIT^PXEDUSM(DA,1)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
BLDLIST(NODE) ;Build of list of Education Topic file entries.
 N IEN,DESC,NAME
 K ^TMP(NODE,$J)
 ;Build the list in alphabetical order.
 S NAME="",VALMCNT=0
 F  S NAME=$O(^AUTTEDT("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTEDT("B",NAME,""))
 . S VALMCNT=VALMCNT+1
 . S ^TMP(NODE,$J,"SEL",VALMCNT)=IEN
 . S ^TMP(NODE,$J,"IEN",IEN)=VALMCNT
 . S DESC=$G(^AUTTEDT(IEN,201,1,0))
 . S ^TMP(NODE,$J,VALMCNT,0)=$$FORMAT(VALMCNT,NAME,DESC)
 . S ^TMP(NODE,$J,"IDX",VALMCNT,VALMCNT)=""
 . S ^TMP(NODE,$J,"LINES",VALMCNT)=VALMCNT_U_VALMCNT
 S ^TMP(NODE,$J,"VALMCNT")=VALMCNT
 S ^TMP(NODE,$J,"NEDU")=VALMCNT
 Q
 ;
 ;=========================================
CLOG(IEN) ;Display the change log.
 D LMCLBROW^PXRMSINQ(9999999.09,"110*",IEN)
 Q
 ;
 ;=========================================
CLOGS ;Display Change Log for a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display the change log for which education topic?")
 S VALMBCK="R"
 I IEN=0 S VALMBCK="R" Q
 D CLOG(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
COPY(IEN) ;Copy a selected entry to a new name.
 D FULL^VALM1
 D COPY^PXCOPY(9999999.09,IEN)
 D BLDLIST^PXEDUMGR("PXEDUL")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
COPYS ;Copy a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select education topic to copy")
 I IEN=0 S VALMBCK="R" Q
 D COPY(IEN)
 Q
 ;
 ;=========================================
EDITS ;Edit a selected entry.
 S VALMBCK="R"
 N CLASS,IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the education topic to edit")
 I IEN=0 S VALMBCK="R" Q
 D SMANEDIT^PXEDUSM(IEN,0)
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXEDUMGR
 D BLDLIST^PXEDUMGR("PXEDUL")
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXEDUMGR
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
 N DIR,NEDU,X,Y
 S NEDU=+$G(^TMP("PXEDUL",$J,"NEDU"))
 I NEDU=0 Q 0
 S DIR(0)="N^1:"_NEDU
 S DIR("A")=TEXT
 D ^DIR
 Q +$G(^TMP("PXEDUL",$J,"SEL",+Y))
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
 D BROWSE^DDBR("TEXT","NR","Education Topic Management Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="Eduction Topic File Entries."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HTEXT ;Education Topic mangement help text.
 ;;Select one of the following actions:
 ;; ADD  - add a new education topic.
 ;; EDIT - edit an education topic.
 ;; COPY - copy an existing education topic to a new education topic.
 ;; INQ  - education topic inquiry.
 ;; EH   - education topic edit history.
 ;;
 ;;You can select the action first and then the entry or choose the entry and then
 ;;the action.
 ;;
 ;;**End Text**
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXEDUL",$J)
 Q
 ;
 ;=========================================
INQ(IEN) ;Education Topic inquiry.
 S VALMBCK="R"
 D BEDUINQ^PXEDUINQ(IEN)
 Q
 ;
 ;=========================================
INQS ;Display inquiry for selected entries.
 S VALMBCK="R"
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display inquiry for which education topic?")
 I IEN=0 S VALMBCK="R" Q
 D INQ(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
ISMAPPED(IEN) ;Return 1 if the Education Topic has mapped codes.
 I +$P($G(^AUTTEDT(IEN,210,0)),U,4)>0 Q 1
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
START ;Main entry point for PX Education Topic Management
 N VALMBCK,VALMSG,X
 S X="IORESET"
 D ENDR^%ZISS
 D EN^VALM("PX EDUCATION TOPICS MANAGEMENT")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;=========================================
XQORM ;Set range for selection.
 N NEDU
 S NEDU=^TMP("PXEDUL",$J,"NEDU")
 S XQORM("#")=$O(^ORD(101,"B","PX EDUCATION TOPICS SELECT ENTRY",0))_U_"1:"_NEDU
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PX EDUCATION TOPICS SELECT ENTRY.
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
 S IEN=^TMP("PXEDUL",$J,"SEL",SEL)
 S CLASS=$P(^AUTTEDT(IEN,100),U,1)
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
 I OPTION="COPY" D COPY^PXEDUMGR(IEN)
 I OPTION="EDIT" D SMANEDIT^PXEDUSM(IEN,0)
 I OPTION="INQ" D BEDUINQ^PXEDUINQ(IEN)
 I OPTION="CL" D CLOG^PXEDUMGR(IEN)
 S VALMBCK="R"
 Q
 ;
