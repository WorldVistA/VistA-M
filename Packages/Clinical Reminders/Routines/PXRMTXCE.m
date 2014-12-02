PXRMTXCE ;SLC/PKR - List Manager routines for taxonomy choose entries. ;05/21/2013
 ;;2.0;CLINICAL REMINDERS;**26**;Feb 04, 2005;Build 404
 ;
 ;=========================================
ENTRY ;Entry code
 K ^TMP("PXRMTAXCE",$J)
 I '$D(^TMP("PXRMTAXL",$J)) D BLDLIST^PXRMTAXL("PXRMTAXL")
 M ^TMP("PXRMTAXCE",$J)=^TMP("PXRMTAXL",$J)
 D XQORM
 Q
 ;
 ;=========================================
EXIT ;Exit code
 K ^TMP("PXRMTAXCE",$J)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="Taxonomy File Entries."
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
 D BROWSE^DDBR("TEXT","NR","Taxonomy Choose Entries Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HLITE(ENUM,MODE,PXRMTIEN) ;Highlight/unhighlight an entry. MODE=1 turns on
 ;highlighting, MODE=0 turns it off.
 N LINE,START,STOP,VCTRL
 S VCTRL=$S(MODE=1:IOINHI,1:IOINORM)
 S START=$P(^TMP("PXRMTAXCE",$J,"LINES",ENUM),U,1)
 S STOP=$P(^TMP("PXRMTAXCE",$J,"LINES",ENUM),U,2)
 F LINE=START:1:STOP D CNTRL^VALM10(LINE,1,80,VCTRL,IOINORM)
 S VALMHDR(1)=$$SLIST(.PXRMTIEN)
 Q
 ;
 ;=========================================
HTEXT ;Taxonomy choose entries help text.
 ;;Select one of the following actions:
 ;; SEL  - select a taxonomy to add to the list.
 ;; REM  - remove a taxonomy from the list.
 ;; INQ  - taxonomy inquiry.
 ;; DONE - done building the selection list.
 ;;**End Text**
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
REMTAX ;Remove a taxonomy.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL^PXRMTAXL("Remove which taxonomy from selection list?")
 I IEN=0 S VALMBCK="R" Q
 D REMOVE(IEN)
 Q
 ;
 ;=========================================
REMOVE(IEN) ;
 N ENUM
 K PXRMTIEN(IEN)
 S ENUM=+$G(^TMP("PXRMTAXCE",$J,"IEN",IEN))
 I ENUM>0 D HLITE(ENUM,0,.PXRMTIEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
SELECTED(IEN) ;
 N ENUM
 S ENUM=+$G(^TMP("PXRMTAXCE",$J,"IEN",IEN))
 S PXRMTIEN(IEN)=ENUM
 I ENUM>0 D HLITE(ENUM,1,.PXRMTIEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
SELTAX ;Select a taxonomy.
 N IEN
 ;Get the entry
 S IEN=+$$GETSEL^PXRMTAXL("Add which taxonomy to selection list?")
 I IEN=0 S VALMBCK="R" Q
 D SELECTED(IEN)
 Q
 ;
 ;=========================================
SLIST(PXRMTIEN) ;
 N IEN,ENUM,ENUMLIST,SLIST
 S IEN=""
 F  S IEN=$O(PXRMTIEN(IEN)) Q:IEN=""  S ENUMLIST(PXRMTIEN(IEN))=""
 S ENUM=$O(ENUMLIST("")),SLIST=ENUM
 F  S ENUM=$O(ENUMLIST(ENUM)) Q:ENUM=""  S SLIST=SLIST_", "_ENUM
 I SLIST="" S SLIST="none"
 Q "Selected taxonomies: "_SLIST_"."
 ;
 ;=========================================
START ;Main entry point for PXRM TAXONOMY SELECTION
 W !,"Select a taxonomy or taxonomies to import from." H 2
 D EN^VALM("PXRM TAXONOMY CHOOSE ENTRIES")
 Q
 ;
 ;=========================================
XQORM ;Set range for selection.
 N NTAX
 S NTAX=^TMP("PXRMTAXCE",$J,"NTAX")
 S XQORM("#")=$O(^ORD(101,"B","PXRM TAXONOMY CHOOSE ENTRY",0))_U_"1:"_NTAX
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=========================================
XSEL ;Entry action for protocol PXRM TAXONOMY CHOOSE ENTRY.
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
 S IEN=^TMP("PXRMTAXL",$J,"SEL",SEL)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Action list.
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U
 S DIR(0)=DIR(0)_"SEL:Select;REM:Remove;INQ:Inquire"
 S DIR("A")="Select Action: "
 S DIR("B")="SEL"
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="INQ" D INQ^PXRMTAXL(IEN)
 I OPTION="REM" D REMOVE^PXRMTXCE(IEN)
 I OPTION="SEL" D SELECTED^PXRMTXCE(IEN)
 S VALMBCK="R"
 Q
 ;
