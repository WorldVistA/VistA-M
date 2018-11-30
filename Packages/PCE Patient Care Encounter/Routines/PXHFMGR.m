PXHFMGR ;SLC/PKR - List Manager routines for Health Factors. ;11/09/2017
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**211**;Aug 12, 1996;Build 244
 ;
 ;=========================================
ADD ;Add a new entry.
 S VALMBCK="R"
 D CLEAR^VALM1
 N CAT,CLASS,DIR,DIRUT,DOHS,ETYPE,L3C,LEN,NAME,TEXT,X,Y
NAME S DIR(0)="9999999.64,.01A"
 S DIR("A")="Enter a new Health Factor Name: "
 D ^DIR
 I $D(DIRUT) Q
 S NAME=X
 I $D(^AUTTHF("B",NAME)) D  G NAME
 . S TEXT(1)=NAME_" already exists, choose a different name."
 . S TEXT(2)=" "
 . D EN^DDIOL(.TEXT)
 ;
 S DIR(0)="9999999.64,.1A"
 S DIR("A")="Enter the Entry Type: "
 D ^DIR
 I $D(DIRUT) Q
 S ETYPE=Y(0)
 ;If the Entry Type is "C" check the name for the appended "[C]".
 I ETYPE="CATEGORY" S NAME=$$CATNCHKN(NAME)
 I NAME="^" G NAME
 S LEN=$L(NAME),L3C=$E(NAME,(LEN-2),LEN)
 ;If the name has the appended '[C]' make sure the Entry Type is
 ;category.
 I (ETYPE="FACTOR"),(L3C="[C]") D  G NAME
 . S TEXT(1)="Factor names cannot end with '[C]', try again."
 . S TEXT(2)=" "
 . D EN^DDIOL(.TEXT)
 ;
 ;Category is required for factors.
 I ETYPE="FACTOR" D
 . S DIR(0)="9999999.64,.03A"
 . S DIR("A")="Enter the Category: "
 . D ^DIR
 . I '$D(DIRUT) S CAT=$P(Y,U,2)
 I $D(DIRUT) Q
 ;
 S DIR(0)="9999999.64,100A"
 S DIR("A")="Enter the Class: "
 D ^DIR
 I $D(DIRUT) Q
 S CLASS=Y(0)
 ;
 S DIR(0)="9999999.64,.08A"
 S DIR("A")="Enter Display on Health Summary: "
 D ^DIR
 I X="^" Q
 S DOHS=Y(0)
 N FDA,IEN,MSG
 S FDA(9999999.64,"+1,",.01)=NAME
 I $G(CAT)'="" S FDA(9999999.64,"+1,",.03)=CAT
 S FDA(9999999.64,"+1,",.08)=DOHS
 S FDA(9999999.64,"+1,",.1)=ETYPE
 S FDA(9999999.64,"+1,",100)=CLASS
 D UPDATE^DIE("E","FDA","IEN","MSG")
 I $D(MSG) D  Q
 . D EN^DDIOL("FileMan could not create the new entry, the FileMan error message is:")
 . D AWRITE^PXUTIL("MSG")
 . H 3
 D SMANEDIT^PXHFSM(IEN(1),1)
 Q
 ;
 ;=========================================
BLDLIST(NODE) ;Build the list of Health Factor file entries.
 N IEN,DESC,NAME
 K ^TMP(NODE,$J)
 ;Build the list in alphabetical order.
 S NAME="",VALMCNT=0
 F  S NAME=$O(^AUTTHF("B",NAME)) Q:NAME=""  D
 . S IEN=$O(^AUTTHF("B",NAME,""))
 . S VALMCNT=VALMCNT+1
 . S ^TMP(NODE,$J,"SEL",VALMCNT)=IEN
 . S ^TMP(NODE,$J,"IEN",IEN)=VALMCNT
 . S DESC=$G(^AUTTHF(IEN,201,1,0))
 . S ^TMP(NODE,$J,VALMCNT,0)=$$FORMAT(VALMCNT,NAME,DESC)
 . S ^TMP(NODE,$J,"IDX",VALMCNT,VALMCNT)=""
 . S ^TMP(NODE,$J,"LINES",VALMCNT)=VALMCNT_U_VALMCNT
 S ^TMP(NODE,$J,"VALMCNT")=VALMCNT
 S ^TMP(NODE,$J,"NHF")=VALMCNT
 Q
 ;
 ;=========================================
CATNCHK(IEN) ;If a category has been added, make sure the name is
 ;appended with [C].
 N CNAME,NAME
 S NAME=$P(^AUTTHF(IEN,0),U,1)
 S LEN=$L(NAME),L3C=$E(NAME,(LEN-2),LEN)
 I L3C="[C]" Q 1
 D EN^DDIOL("Category names must end with '[C]', appending it for you.")
 H 3
 S CNAME=NAME_" [C]"
 I $L(CNAME)>64 D  Q 0
 . D EN^DDIOL(CNAME)
 . D EN^DDIOL("exceeds 64 characters, it cannot be added, try again!")
 . H 3
 . D RENAME^PXUTIL(9999999.64,NAME,"@")
 D RENAME^PXUTIL(9999999.64,NAME,CNAME)
 Q 1
 ;
 ;=========================================
CATNCHKN(NAME) ;If the Entry Type is category make sure the name is
 ;appended with [C].
 N CNAME
 S LEN=$L(NAME),L3C=$E(NAME,(LEN-2),LEN)
 I L3C="[C]" Q 1
 D EN^DDIOL("Category names must end with '[C]', appending it for you.")
 S CNAME=NAME_" [C]"
 D EN^DDIOL(CNAME)
 I $L(CNAME)>64 D
 . D EN^DDIOL("exceeds 64 characters, it cannot be added, try again!")
 . S CNAME="^"
 Q CNAME
 ;
 ;=========================================
CLOG(IEN) ;Display the change log.
 D LMCLBROW^PXRMSINQ(9999999.64,"110*",IEN)
 Q
 ;
 ;=========================================
CLOGS ;Display Change Log for a selected entry.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display the change log for which health factor?")
 S VALMBCK="R"
 I IEN=0 S VALMBCK="R" Q
 D CLOG(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
COPY(IEN) ;Copy a selected entry to a new name.
 D FULL^VALM1
 D COPY^PXCOPY(9999999.64,IEN)
 D BLDLIST^PXHFMGR("PXHFL")
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
 N CLASS,IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the health factor to edit")
 I IEN=0 S VALMBCK="R" Q
 D SMANEDIT^PXHFSM(IEN,0)
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXHFMGR
 D BLDLIST^PXHFMGR("PXHFL")
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXHFMGR
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
FORMAT(NUMBER,NAME,DESC) ;Format  entry number, name,
 ;and first line of description for LM display.
 N CAT,LNAME,TEXT,TDESC,TNAME
 S LNAME=$L(NAME)
 I LNAME<56 S TNAME=NAME
 E  D
 . N CAT
 . S CAT=$S($E(NAME,(LNAME-2),LNAME)="[C]":1,1:0)
 . S TNAME=$S('CAT:$E(NAME,1,52)_"...",1:$E(NAME,1,49)_"...[C]")
 S TEXT=$$RJ^XLFSTR(NUMBER,5,"  ")_"  "_TNAME
 S TDESC=$S(DESC="":"",$L(DESC)<17:DESC,1:$E(DESC,1,13)_"...")
 I TDESC'="" S TEXT=TEXT_$$REPEAT^XLFSTR(" ",(63-$L(TEXT)))_TDESC
 Q TEXT
 ;
 ;=========================================
GETSEL(TEXT) ;Get a single selection
 N DIR,NHF,X,Y
 S NHF=+$G(^TMP("PXHFL",$J,"NHF"))
 I NHF=0 Q 0
 S DIR(0)="N^1:"_NHF
 S DIR("A")=TEXT
 D ^DIR
 Q +$G(^TMP("PXHFL",$J,"SEL",+Y))
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
 D BROWSE^DDBR("TEXT","NR","Health Factor Management Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="Health Factor File Entries."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HTEXT ;Health Factor mangement help text.
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
 K ^TMP("PXHFL",$J)
 Q
 ;
 ;=========================================
INQ(IEN) ;Health Factor inquiry.
 S VALMBCK="R"
 D BHFINQ^PXHFINQ(IEN)
 Q
 ;
 ;=========================================
INQS ;Display inquiry for selected entries.
 S VALMBCK="R"
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Display inquiry for which health factor?")
 I IEN=0 S VALMBCK="R" Q
 D INQ(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
ISMAPPED(IEN) ;Return 1 if the health factor has mapped codes.
 I +$P($G(^AUTTHF(IEN,210,0)),U,4)>0 Q 1
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
START ;Main entry point for PX Health Factor Management
 N VALMBCK,VALMSG,X
 S X="IORESET"
 D ENDR^%ZISS
 D EN^VALM("PX HEALTH FACTOR MANAGEMENT")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;=========================================
XQORM ;Set range for selection.
 N NHF
 S NHF=^TMP("PXHFL",$J,"NHF")
 S XQORM("#")=$O(^ORD(101,"B","PX HEALTH FACTOR SELECT ENTRY",0))_U_"1:"_NHF
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PX HEALTH FACTOR SELECT ENTRY.
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
 S IEN=^TMP("PXHFL",$J,"SEL",SEL)
 S CLASS=$P(^AUTTHF(IEN,100),U,1)
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
 I OPTION="COPY" D COPY^PXHFMGR(IEN)
 I OPTION="EDIT" D SMANEDIT^PXHFSM(IEN,0)
 I OPTION="INQ" D BHFINQ^PXHFINQ(IEN)
 I OPTION="CL" D CLOG^PXHFMGR(IEN)
 S VALMBCK="R"
 Q
 ;
