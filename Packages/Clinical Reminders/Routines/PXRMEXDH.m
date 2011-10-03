PXRMEXDH ; SLC/PJH - Reminder Exchange Dialog help. ;01/25/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;
 ; Entry action for list PXRM EX DIALOG HELP 
 ;
LOAD N DONE,IND,TEXT
 S DONE=0
 K ^TMP("PXRMEXDH",$J)
 S VALMCNT=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(@PXRMTAG+IND),";",3)
 . I TEXT="**End Text**" S DONE=1 Q
 . S VALMCNT=VALMCNT+1
 . S ^TMP("PXRMEXDH",$J,VALMCNT,0)=TEXT
 S ^TMP("PXRMEXDH",$J,"VALMCNT")=VALMCNT
 Q
 ;
DLG ;Dialog Help text
 ;;The following actions are available:
 ;;
 ;;DD  Dialog Details
 ;;    Display all dialog component names for this reminder dialog.
 ;;    (Include PXRM type additional prompts and forced values.)
 ;;
 ;;DF  Dialog Findings
 ;;    Display the finding items associated with the dialog and
 ;;    show if the finding already exists.
 ;;
 ;;DS  Dialog Summary (default)
 ;;    Display dialog component names for this reminder dialog.
 ;;    (Exclude PXRM type additional prompts and forced values.)
 ;;
 ;;DT  Dialog Text
 ;;    Display the dialog text as it should appear in CPRS.
 ;;
 ;;DU  Dialog Usage
 ;;    If components of the reminder dialog already exists display
 ;;    any other reminder dialogs and groups also use these components.
 ;;
 ;;IA  Install All
 ;;    Install the reminder dialog and all its components. The reminder
 ;;    dialog may also be selected by entering the item number '1'.
 ;;
 ;;IS  Install Selected
 ;;    Install selected components from this reminder dialog. The
 ;;    individual components may also be selected by entering an 
 ;;    item number.
 ;;
 ;;QU  Quit
 ;;**End Text**
