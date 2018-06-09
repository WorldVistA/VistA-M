PXRMUIDE ;SLC/PKR - List Manager routines for taxonomy UID edit. ;05/22/2017
 ;;2.0;CLINICAL REMINDERS;**26,47,42**;Feb 04, 2005;Build 80
 ;
 ;=========================================
ENTRY ;Entry code
 N TAXIEN
 S TAXIEN=^TMP("PXRMTAX",$J,"TAXIEN")
 D INITMPG^PXRMTXLS
 K ^TMP("PXRMCODES",$J)
 D HDR^PXRMUIDE
 D CODELIST^PXRMTXSM(TAXIEN)
 D BLDLIST^PXRMTXLS
 D XQORM^PXRMUIDE
 Q
 ;
 ;=========================================
EXIT ;Exit code
 D INITMPG^PXRMTXLS
 K ^TMP("PXRMCODES",$J)
 D FULL^VALM1
 D CLEAN^VALM10
 D KILL^VALM10
 D CLEAR^VALM1
 S VALMBCK="Q"
 Q
 ;
 ;=========================================
EXITS ;Exit and save action.
 D SAVE^PXRMUIDE
 D EXIT^PXRMUIDE
 Q
 ;
 ;=========================================
HDR ; Header code
 S VALMHDR(1)="Edit UID for all selected codes in this taxonomy."
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
 D BROWSE^DDBR("TEXT","NR","UID Edit Help")
 S VALMBCK="R"
 Q
 ;
 ;=========================================
HTEXT ;Lexicon selection help text. PROBABLY CAN REMOVE AND USE ORIGINAL
 ;;Select one of the following actions:
 ;;
 ;;  RFD  - removes selected codes from being used in a dialog.
 ;;  UID  - adds selected codes to the taxonomy and marks them for use in a dialog.
 ;;  SAVE - saves all selected codes. Even if codes have been selected, they will
 ;;         not be stored until they are saved. Finally, a save must be done when
 ;;         exiting the ScreenMan form or no changes will be saved.
 ;;  EXIT - saves then exits.
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
PEXIT ; Protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM^PXRMUIDE
 Q
 ;
 ;=========================================
SAVE ;Save the changes.
 N TAXIEN
 S TAXIEN=^TMP("PXRMTAX",$J,"TAXIEN")
 D SAVE^PXRMTXLS
 D POSTSAVE^PXRMTXSM(TAXIEN)
 S VALMBCK="R"
 Q
 ;
 ;=========================================
XQORM ; Set range for selection.
 N NCODES
 S NCODES=+$G(^TMP("PXRMTXSC",$J,"NCODES"))
 I NCODES=0 Q
 S XQORM("#")=$O(^ORD(101,"B","PXRM TAXONOMY UIDE SELECT ENTRY",0))_U_"1:"_NCODES
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
 S DIR(0)="SBM"_U_"RFD:Remove from dialog;"
 S DIR(0)=DIR(0)_"UID:Use in dialog;"
 S DIR("A")="Select Action: "
 S DIR("B")="UID"
 S DIR("?")="Select from the actions displayed."
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 D CLEAR^VALM1
 ;
 I OPTION="RFD" D RFDX^PXRMTXLS(.LIST)
 I OPTION="UID" D INCX^PXRMTXLS(.LIST,1)
 ;
 S VALMBCK="R"
 Q
 ;
