PXRMVSLM ;SLC/PKR - List Manager routines for value sets. ;11/20/2014
 ;;2.0;CLINICAL REMINDERS;**47**;Feb 04, 2005;Build 289
 ;
 ;=========================================
BLDLIST(NODE) ;Build of list of value set file entries.
 N IEN,FMTSTR,IND,OID,OIDL,NAME,NL,NUM,OUTPUT,START,UCNAME,VDATE
 K ^TMP(NODE,$J)
 ;Build the list in alphabetical order.
 S FMTSTR=$$LMFMTSTR^PXRMTEXT(.VALMDDF,"RLLL")
 S (NUM,VALMCNT)=0
 S UCNAME=""
 F  S UCNAME=$O(^PXRM(802.2,"AUNVD",UCNAME)) Q:UCNAME=""  D
 . S VDATE=""
 . F  S VDATE=$O(^PXRM(802.2,"AUNVD",UCNAME,VDATE)) Q:VDATE=""  D
 .. S IEN=""
 .. F  S IEN=$O(^PXRM(802.2,"AUNVD",UCNAME,VDATE,IEN)) Q:IEN=""  D
 ... S NAME=$P(^PXRM(802.2,IEN,0),U,1)
 ... S OID=$P(^PXRM(802.2,IEN,1),U,1)
 ... S OIDL(OID)=""
 ... S NUM=NUM+1
 ... S ^TMP(NODE,$J,"SEL",NUM)=IEN
 ... S ^TMP(NODE,$J,"IEN",IEN)=NUM
 ... D FORMAT(NUM,NAME,OID,VDATE,FMTSTR,.NL,.OUTPUT)
 ... S START=VALMCNT+1
 ... F IND=1:1:NL D
 .... S VALMCNT=VALMCNT+1,^TMP(NODE,$J,VALMCNT,0)=OUTPUT(IND)
 .... S ^TMP(NODE,$J,"IDX",VALMCNT,NUM)=""
 ... S ^TMP(NODE,$J,"LINES",NUM)=START_U_VALMCNT
 S ^TMP(NODE,$J,"VALMCNT")=VALMCNT
 S ^TMP(NODE,$J,"NVS")=NUM
 Q
 ;
 ;=========================================
CRETAX(IEN) ;Create a taxonomy from a value set.
 D FULL^VALM1
 D BLDTAX^PXRMVSTX(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
CRETAXS(IEN) ;Select a value set for creating a taxonomy.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select value set for creating a taxonomy")
 I IEN=0 S VALMBCK="R" Q
 D CRETAX(IEN)
 Q
 ;
 ;=========================================
ENTRY ;Entry code
 D INITMPG^PXRMVSLM
 D BLDLIST^PXRMVSLM("PXRMVSL")
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXRMVSLM
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
FORMAT(NUMBER,NAME,OID,VDATE,FMTSTR,NL,OUTPUT) ;Format entry number, name and
 ;version date for the LM display.
 N TEMP
 S TEMP=NUMBER_U_NAME_"\\"_"("_OID_")"_U_$$FMTE^XLFDT(VDATE)
 D COLFMT^PXRMTEXT(FMTSTR,TEMP," ",.NL,.OUTPUT)
 Q
 ;
 ;=========================================
GETSEL(TEXT) ;Get a single selection
 N DIR,NVS,X,Y
 S NVS=+$G(^TMP("PXRMVSL",$J,"NVS"))
 I NVS=0 Q 0
 S DIR(0)="N^1:"_NVS
 S DIR("A")=TEXT
 D ^DIR
 Q +$G(^TMP("PXRMVSL",$J,"SEL",+Y))
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
 D BROWSE^DDBR("TEXT","NR","Value Set Management Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="NLM Value Sets"
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=========================================
HTEXT ;Taxonomy mangement help text.
 ;;Select one of the following actions:
 ;; CT  - create a taxonomy from a value set.
 ;; INQ - value set inquiry.
 ;; CS  - code search, list all value sets containing a specified code.
 ;;
 ;;You can select the action first and then the entry or choose the entry and then
 ;;the action.
 ;;
 ;;**End Text**
 Q
 ;
 ;=========================================
INQ(IEN) ;Display the contents of a value set.
 D BVSINQ^PXRMVSIN(IEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
INQS ;Inquiry for a selected value set.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL("Select the value set")
 I IEN=0 S VALMBCK="R" Q
 D INQ^PXRMVSLM(IEN)
 Q
 ;
 ;=========================================
INITMPG ;Initialize all the ^TMP globals.
 K ^TMP("PXRMVSL",$J)
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
 D EN^VALM("PXRM VS MENU")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;=========================================
XQORM ;Set range for selection.
 N NVS
 S NVS=^TMP("PXRMVSL",$J,"NVS")
 S XQORM("#")=$O(^ORD(101,"B","PXRM VS SELECT ENTRY",0))_U_"1:"_NVS
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PXRM VS SELECT ENTRY.
 N IEN,SEL
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
 S IEN=^TMP("PXRMVSL",$J,"SEL",SEL)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Action list.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U
 S DIR(0)=DIR(0)_"CT:Create Taxonomy;"
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
 I OPTION="CT" D CRETAX^PXRMVSLM(IEN)
 I OPTION="INQ" D INQ^PXRMVSLM(IEN)
 S VALMBCK="R"
 Q
 ;
