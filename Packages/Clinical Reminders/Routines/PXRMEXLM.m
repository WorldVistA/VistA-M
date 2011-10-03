PXRMEXLM ; SLC/PKR/PJH - Clinical Reminder Exchange List Manager routines. ;12/02/2009
 ;;2.0;CLINICAL REMINDERS;**6,12,17**;Feb 04, 2005;Build 102
 ;
 ;=====================================================
CRE ;Create a packed reminder and store it in the repository.
 D FULL^VALM1
 D CRE^PXRMEXPD
 S VALMBCK="R"
 Q
 ;
 ;=====================================================
DEFINQ ;Reminder definition inquiry.
 N GBL,IEN,PXRMROOT,VALMCNT
 S GBL="^TMP(""PXRMRINQ"",$J)"
 S GBL=$NA(@GBL)
 S PXRMROOT="^PXD(811.9,"
 S IEN=$$SELECT^PXRMINQ(PXRMROOT,"Select Reminder Definition: ","")
 S IEN=$P(IEN,U,1)
 I IEN=-1 S VALMBCK="R" Q
 K ^TMP("PXRMRINQ",$J)
 D REMVAR^PXRMINQ(GBL,IEN)
 S VALMCNT=$O(^TMP("PXRMRINQ",$J,""),-1)
 D EN^VALM("PXRM EX DEFINITION INQUIRY")
 K ^TMP("PXRMRINQ",$J)
 S VALMBCK="R"
 Q
 ;
 ;=====================================================
ENTRY ;Entry code
 D INITMPG^PXRMEXLM
 D BLDLIST^PXRMEXLC(0)
 D XQORM
 Q
 ;
 ;=====================================================
EXIT ;Exit code
 D INITMPG^PXRMEXLM
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="Q"
 K PXRMIGDS,PXRMINST
 Q
 ;
 ;=====================================================
HDR ; Header code
 S VALMHDR(1)="Exchange File Entries."
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
 ;=====================================================
HELP ;Help code
 ;The following variables have to be newed so that when we return
 ;from the help display they will be defined.
 N ORU,ORUPRMT,XQORM
 D EN^VALM("PXRM EX MAIN HELP")
 Q
 ;
 ;=====================================================
INIT ;Init
 S VALMCNT=0
 Q
 ;
 ;=====================================================
INITMPG ;Initialized all the ^TMP globals.
 K ^TMP("PXRMEXDH",$J)
 K ^TMP("PXRMEXDGH",$J)
 K ^TMP("PXRMEXHF",$J)
 K ^TMP("PXRMEXFND",$J)
 K ^TMP("PXRMEXIA",$J)
 K ^TMP("PXRMEXIAD",$J)
 K ^TMP("PXRMEXID",$J)
 K ^TMP("PXRMEXIH",$J)
 K ^TMP("PXRMEXLC",$J)
 K ^TMP("PXRMEXLD",$J)
 K ^TMP("PXRMEXLHF",$J)
 K ^TMP("PXRMEXLMM",$J)
 K ^TMP("PXRMEXLR",$J)
 K ^TMP("PXRMEXMH",$J)
 K ^TMP("PXRMEXMM",$J)
 K ^TMP("PXRMEXRI",$J)
 K ^TMP("PXRMEXTMP",$J)
 K ^TMP("PXRMEXTXT",$J)
 K ^TMP($J,"HS TYPE")
 K ^TMP($J,"HS OBJECT")
 K ^TMP($J,"TIU OBJECT")
 K ^TMP($J,"ORDER DIALOG")
 Q
 ;
 ;=====================================================
LDHF ;Load a host file into the repository.
 N IND,FILE,PATH,RBL,SUCCESS,TEMP
 ;Select the host file to load.
 D CLEAR^VALM1
 S TEMP=$$GETEHF^PXRMEXHF("PRD")
 I TEMP="" S VALMBCK="R" Q
 S PATH=$P(TEMP,U,1)
 S FILE=$P(TEMP,U,2)
 D LHF^PXRMEXHF(.SUCCESS,PATH,FILE)
 S RBL=SUCCESS
 I SUCCESS D
 . S VALMHDR(1)="Host file "_PATH_FILE_" successfully loaded."
 E  D
 . S VALMHDR(1)="There were problems loading host file "_PATH_FILE_"."
 . S TEMP=""
 . S IND=""
 . F  S IND=$O(SUCCESS(IND)) Q:+IND=0  D
 .. I SUCCESS(IND) S RBL=1 Q
 .. I +$O(SUCCESS(IND))=0 S TEMP=TEMP_IND
 .. E  S TEMP=TEMP_IND_", "
 . S VALMHDR(2)="Entries with problems were "_TEMP_"."
 ;Rebuild the list for display.
 D BLDLIST^PXRMEXLC(RBL)
 S VALMBCK="R"
 Q
 ;
 ;=====================================================
LDMM ;Load a MailMan message into the repository.
 N IND,RBL,TEMP,XMZ
 ;Select the MailMan message to load.
 D CLEAR^VALM1
 S XMZ=$$GETMESSN^PXRMEXMM
 I XMZ=-1 W !,"No packed reminder definitions selected/found!" H 2
 I +XMZ'>0 S VALMBCK="R" Q
 D LMM^PXRMEXMM(.SUCCESS,XMZ)
 S RBL=SUCCESS
 I SUCCESS D
 . S VALMHDR(1)="MailMan message "_XMZ_" successfully loaded."
 .;Rebuild the list for display.
 . D BLDLIST^PXRMEXLC(1)
 E  D
 . S VALMHDR(1)="There were problems loading MailMan message "_XMZ_"."
 . S TEMP=""
 . S IND=""
 . F  S IND=$O(SUCCESS(IND)) Q:+IND=0  D
 .. I SUCCESS(IND) S RBL=1 Q
 .. I +$O(SUCCESS(IND))=0 S TEMP=TEMP_IND
 .. E  S TEMP=TEMP_IND_", "
 . S VALMHDR(2)="Entries with problems were "_TEMP_"."
 ;Rebuild the list for display.
 D BLDLIST^PXRMEXLC(RBL)
 S VALMBCK="R"
 Q
 ;
 ;=====================================================
LRDEF ;List the name and print name of all reminder definitions.
 N VALMCNT
 I $D(^TMP("PXRMEXLD",$J,"VALMCNT")) S VALMCNT=^TMP("PXRMEXLD",$J,"VALMCNT")
 E  D
 . N ARO,DEFLIST
 . S ARO=$$QUERYAO^PXRMLIST
 . S ^TMP("PXRMEXLD",$J,"ARO")=ARO
 . D RDEF^PXRMLIST(.DEFLIST,ARO)
 . M ^TMP("PXRMEXLD",$J)=DEFLIST
 . S VALMCNT=DEFLIST("VALMCNT")
 I '$G(^TMP("PXRMEXLD",$J,"ARO")) D CHGCAP^VALM("INACTIVE","Inactive")
 D EN^VALM("PXRM EX REMINDER LIST")
 Q
 ;
 ;=====================================================
PEXIT ;PXRM EXCH MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 ;Reset after page up/down etc
 D XQORM
 Q
 ;
 ;=====================================================
START ;Main entry point for PXRM EXCHANGE
 N PXRMDONE,PXRMNMCH
 ;PXRMDONE is set to true if the user enters an action of Quit.
 S PXRMDONE=0
 ;PXRMNMCH is used to store name change information. If a finding
 ;is copied to a new name or is replaced by another finding the
 ;information is stored here. It is used when installing definitions
 ;or dialogs so they use the new or replaced finding.
 N VALMBCK,VALMSG,X,XMZ
 S X="IORESET"
 D ENDR^%ZISS
 D EN^VALM("PXRM EX REMINDER EXCHANGE")
 W IORESET
 D KILL^%ZISS
 Q
 ;
 ;=====================================================
XQORM S XQORM("#")=$O(^ORD(101,"B","PXRM EXCH SELECT ENTRY",0))_U_"1:"_VALMCNT
 S XQORM("A")="Select Action: "
 Q
 ;
 ;=====================================================
XSEL ;PXRM EXCH SELECT COMPONENT validation
 N SEL,PXRMRIEN
 S SEL=$P(XQORNOD(0),"=",2)
 ;Remove trailing ,
 I $E(SEL,$L(SEL))="," S SEL=$E(SEL,1,$L(SEL)-1)
 ;Invalid selection
 I SEL["," D  Q
 .W $C(7),!,"Only one item number allowed." H 2
 .S VALMBCK="R"
 I ('SEL)!(SEL>VALMCNT)!('$D(@VALMAR@("SEL",SEL))) D  Q
 .W $C(7),!,SEL_" is not a valid item number." H 2
 .S VALMBCK="R"
 ;
 ;Get the repository ien.
 S PXRMRIEN=^TMP("PXRMEXLR",$J,"SEL",SEL)
 ;
 ;Full screen mode
 D FULL^VALM1
 ;
 ;Option to Install, Delete or Install History
 N DIR,DIROUT,DIRUT,DTOUT,DUOUT,OPTION,X,Y
 S DIR(0)="SBM"_U_"IFE:Install Exchange File Entry;"
 S DIR(0)=DIR(0)_"DFE:Delete Exchange File Entry;"
 S DIR(0)=DIR(0)_"IH:Installation History;"
 S DIR("A")="Select Action: "
 S DIR("B")="IFE"
 S DIR("?")="Select from the codes displayed. For detailed help type ??"
 S DIR("??")=U_"D HLP^PXRMEXIX(3)"
 D ^DIR
 I $D(DIROUT)!$D(DIRUT) S VALMBCK="R" Q
 I $D(DTOUT)!$D(DUOUT) S VALMBCK="R" Q
 S OPTION=Y
 ;
 ;Install
 I OPTION="IFE" D
 .D EN^VALM("PXRM EX LIST COMPONENTS")
 .K ^TMP("PXRMEXLC",$J)
 ;
 I OPTION="DFE" D
 .N COUNT,DELLIST,IEN,IND,RELIST,VALMY
 .S DELLIST(PXRMRIEN)=""
 .D DELETE^PXRMEXU1(.DELLIST)
 .;Rebuild the list for List Manager to display.
 .K ^TMP("PXRMEXLR",$J)
 .D REXL^PXRMLIST("PXRMEXLR")
 .S VALMCNT=^TMP("PXRMEXLR",$J,"VALMCNT")
 .S VALMHDR(1)="Deleted 1 exchange file entry",VALMHDR(2)=" ",VALMBCK="R"
 ;
 I OPTION="IH" D START^PXRMEXIH
 ;
 S VALMBCK="R"
 Q
 ;
