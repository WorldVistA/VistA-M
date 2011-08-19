PXRMEXMH ; SLC/PKR - Clinical Reminder Exchange main help. ;05/14/2001
 ;;2.0;CLINICAL REMINDERS;;Feb 04, 2005
 ;======================================================================
LOAD ;If necessary load the help text into the ^TMP array.
 ;Check if the help text has already been loaded.
 I $D(^TMP("PXRMEXMH",$J,"VALMCNT")) D  Q
 . S VALMCNT=^TMP("PXRMEXMH",$J,"VALMCNT")
 ;
 N DONE,IND,TEXT
 S DONE=0
 S VALMCNT=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(TEXT+IND),";",3)
 . I TEXT="**End Text**" S DONE=1 Q
 . S VALMCNT=VALMCNT+1
 . S ^TMP("PXRMEXMH",$J,VALMCNT,0)=TEXT
 S ^TMP("PXRMEXMH",$J,"VALMCNT")=VALMCNT
 Q
 ;
 ;======================================================================
TEXT ;Help text
 ;;The following actions are available:
 ;;
 ;;CFE Create Exchange File Entry
 ;;    Create an entry in the Exchange File; this is also called
 ;;    a packed reminder definition. When you select this action
 ;;    you will be prompted for a reminder definition. All the
 ;;    components used in the definition will be "packed" up and
 ;;    included in the packed definition.
 ;;
 ;;CHF Create Host File
 ;;    Create a host file containing selected entries from the
 ;;    Exchange File.
 ;;
 ;;CMM Create MailMan Message
 ;;    Create a MailMan message containing selected entries from
 ;;    the Exchange File.
 ;;
 ;;DFE Delete Exchange File Entry
 ;;    Delete selected entries from the Exchange File.
 ;;
 ;;IFE Install Exchange File Entry
 ;;    Install selected Exchange File entries. Once an entry has
 ;;    been selected you will have the option of installing all
 ;;    the components in the packed reminder or selected
 ;;    components.
 ;;
 ;;IH  Installation History
 ;;    Show the installation history of selected Exchange File
 ;;    entries.
 ;;
 ;;LHF Load Host File
 ;;    Load a host file containing packed reminder definitions
 ;;    into the Exchange File.
 ;;
 ;;LMM Load MailMan Message
 ;;    Load a MailMan message containing packed reminders
 ;;    into the Exchange File.
 ;;
 ;;LR  List Reminder Definitions
 ;;    Display a list of all the reminders that are defined in the
 ;;    current UCI.
 ;;
 ;;RI  Reminder Definition Inquiry
 ;;    Display the reminder definition for the selected reminder.
 ;;
 ;;QU  Quit
 ;;
 ;;**End Text**
 Q
 ;
