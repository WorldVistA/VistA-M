PXRMEXLR ; SLC/PKR/PJH - List Manager routines for Exchange file actions. ;01/24/2013
 ;;2.0;CLINICAL REMINDERS;**6,17,26**;Feb 04, 2005;Build 404
 ;==================================================
CHF ;Create a host file containing repository entries.
 N IND,FILE,LIST,LENH2,NL,PATH,SUCCESS,TEMP
 ;Get the list to store.
 S LIST=$$GETLIST()
 ;If there is no list quit.
 I LIST="^" S VALMBCK="R" Q
 ;Get the host file to use.
 D CLEAR^VALM1
 S TEMP=$$GETHFN^PXRMEXHF("PRD")
 I TEMP=0 S VALMBCK="R" Q
 S PATH=$P(TEMP,U,1)
 S FILE=$P(TEMP,U,2)
 D CHF^PXRMEXHF(.SUCCESS,LIST,PATH,FILE)
 S VALMHDR(1)="Successfully stored entries:"
 S VALMHDR(2)="Failed to store entries:"
 S LENH2=$L(VALMHDR(2))
 S IND="",NL=0
 F  S IND=$O(SUCCESS(IND)) Q:+IND=0  D
 . S NL=NL+1
 . S TEMP=$S(NL=1:" ",1:", ")
 . I SUCCESS(IND) S VALMHDR(1)=VALMHDR(1)_TEMP_IND
 . E  S VALMHDR(2)=VALMHDR(2)_TEMP_IND
 I $L(VALMHDR(2))=LENH2 K VALMHDR(2)
 S VALMBCK="R"
 Q
 ;
 ;==================================================
CMM ;Create a MailMan message containing packed reminders.
 N LEN,LIST,SUCCESS,TEMP
 ;Get the list to store.
 S LIST=$$GETLIST()
 ;If there is no list quit.
 I LIST="^" S VALMBCK="R" Q
 ;Get a new message number to store the entries in.
 D CMM^PXRMEXMM(.SUCCESS,LIST)
 S LEN=$L(LIST)
 S TEMP=$E(LIST,1,(LEN-1))
 I $D(SUCCESS("XMZ")) S VALMHDR(1)="Successfully stored entries "_TEMP_" in message "_SUCCESS("XMZ")_"."
 E  S VALMHDR(1)="Failed to store entries"_TEMP
 S VALMBCK="R"
 Q
 ;
 ;==================================================
DELETE ;Get a list of repository entries and delete them.
 N IND,LIST,NUM
 ;Get the list to delete.
 S LIST=$$GETLIST()
 ;If there is no list quit.
 I LIST="^" S VALMBCK="R" Q
 S NUM=$L(LIST,",")-1
 D DELETE^PXRMEXU1(LIST)
 ;Rebuild the list for List Manager to display.
 K ^TMP("PXRMEXLR",$J)
 D REXL^PXRMLIST("PXRMEXLR")
 ;
 S VALMHDR(1)="Deleted "_NUM_" Exchange File"
 I NUM>1 S VALMHDR(1)=VALMHDR(1)_" entries."
 I NUM=1 S VALMHDR(1)=VALMHDR(1)_" entry."
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
GETLIST() ;Get a list of entries.
 N DIR,NEXCHE,X,Y
 S NEXCHE=+$G(^TMP("PXRMEXLR",$J,"NEXCHE"))
 I NEXCHE=0 Q 0
 S DIR(0)="L^1:NEXCHE"
 S DIR(0)="L^1:"_NEXCHE
 D ^DIR
 Q Y
 ;
 ;==================================================
INSTALL ;Get a list of repository entries and install them.
 N IND,LIST,LNUM,PXRMRIEN
 ;Get the list to install.
 S LIST=$$GETLIST()
 ;If there is no list quit.
 I LIST="^" S VALMBCK="R" Q
 ;PXRMDONE is newed in PXRMEXLM
 S PXRMDONE=0
 F IND=1:1:$L(LIST,",")-1 Q:PXRMDONE  D
 . S LNUM=$P(LIST,",",IND)
 .;Get the repository ien.
 . S PXRMRIEN=$$RIEN^PXRMEXU1(LNUM)
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
PEXIT ;PXRM EXCH INSTALLATION MENU protocol exit code
 S VALMSG="+ Next Screen   - Prev Screen   ?? More Actions"
 Q
 ;
