PXRMEXLR ; SLC/PKR/PJH - List Manager routines for existing repository entries. ;12/02/2009
 ;;2.0;CLINICAL REMINDERS;**6,17**;Feb 04, 2005;Build 102
 ;==================================================
CHF ;Create a host file containing repository entries.
 N IND,FILE,LENH2,PATH,SUCCESS,TEMP,VALMY
 ;Get the list to store.
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 ;Get the host file to use.
 D CLEAR^VALM1
 S TEMP=$$GETHFN^PXRMEXHF("PRD")
 I TEMP=0 S VALMBCK="R" Q
 S PATH=$P(TEMP,U,1)
 S FILE=$P(TEMP,U,2)
 D CHF^PXRMEXHF(.SUCCESS,.VALMY,PATH,FILE)
 S VALMHDR(1)="Successfully stored entries"
 S VALMHDR(2)="Failed to store entries"
 S LENH2=$L(VALMHDR(2))
 S IND=""
 F  S IND=$O(SUCCESS(IND)) Q:+IND=0  D
 . I SUCCESS(IND) S VALMHDR(1)=VALMHDR(1)_" "_IND
 . E  S VALMHDR(2)=VALMHDR(2)_" "_IND
 I $L(VALMHDR(2))=LENH2 K VALMHDR(2)
 S VALMBCK="R"
 Q
 ;
 ;==================================================
CMM ;Create a MailMan message containing packed reminders.
 N SUCCESS,TEMP,VALMY
 ;Get the list to store.
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 ;Get a new message number to store the entries in.
 D CMM^PXRMEXMM(.SUCCESS,.VALMY)
 I $D(SUCCESS("XMZ")) S VALMHDR(1)="Successfully stored entries in message "_SUCCESS("XMZ")_"."
 E  S VALMHDR(1)="Failed to store entries"
 S VALMBCK="R"
 Q
 ;
 ;==================================================
DELETE ;Get a list of repository entries and delete them.
 N COUNT,DELLIST,IEN,IND,RELIST,VALMY
 ;Get the list to delete.
 D MIENLIST(.DELLIST)
 S COUNT=+$G(DELLIST("COUNT"))
 I COUNT=0 Q
 D DELETE^PXRMEXU1(.DELLIST)
 ;Rebuild the list for List Manager to display.
 K ^TMP("PXRMEXLR",$J)
 D REXL^PXRMLIST("PXRMEXLR")
 ;
 S VALMHDR(1)="Deleted "_DELLIST("COUNT")_" Exchange File"
 I COUNT>1 S VALMHDR(1)=VALMHDR(1)_" entries."
 I COUNT=1 S VALMHDR(1)=VALMHDR(1)_" entry."
 I COUNT=0 S VALMHDR(1)="No entries selected."
 S VALMHDR(2)=" "
 S VALMBCK="R"
 Q
 ;
 ;==================================================
EXIT ; Exit code
 D CLEAN^VALM10
 D FULL^VALM1
 S VALMBCK="R"
 K ^TMP("PXRMEXLR",$J)
 Q
 ;
 ;==================================================
INSTALL ;Get a list of repository entries and install them.
 N IND,PXRMRIEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 ;PXRMDONE is newed in PXRMEXLM
 S PXRMDONE=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:(+IND=0)!(PXRMDONE)  D
 .;Get the repository ien.
 . S PXRMRIEN=^TMP("PXRMEXLR",$J,"SEL",IND)
 .;The list template calls INSTALL^PXRMEXLI
 . D EN^VALM("PXRM EX LIST COMPONENTS")
 . K ^TMP("PXRMEXLC",$J)
 Q
 ;
 ;==================================================
HDR ; Header code
 S VALMHDR(1)=""
 D CHGCAP^VALM("RNAME","Reminder Name")
 D CHGCAP^VALM("PNAME","Date Loaded")
 Q
 ;
 ;==================================================
HELP ; Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
 ;==================================================
MIENLIST(LIST) ;Get a list of List Manager repository entries and turn it
 ;into iens.
 N COUNT,IEN,VALMY
 D EN^VALM2(XQORNOD(0))
 ;If there is no list quit.
 I '$D(VALMY) Q
 S COUNT=0
 S IND=""
 F  S IND=$O(VALMY(IND)) Q:+IND=0  D
 . S COUNT=COUNT+1
 . ;S IEN=^TMP("PXRMEXLR",$J,"IDX",IND,IND)
 . S IEN=^TMP("PXRMEXLR",$J,"SEL",IND)
 . S LIST(IEN)=""
 S LIST("COUNT")=COUNT
 Q
 ;
 ;==================================================
PEXIT ;PXRM EXCH INSTALLATION MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
