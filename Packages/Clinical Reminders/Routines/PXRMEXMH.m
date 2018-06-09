PXRMEXMH ; SLC/PKR - Clinical Reminder Exchange main help. ;04/16/2018
 ;;2.0;CLINICAL REMINDERS;**26,47,42**;Feb 04, 2005;Build 80
 ;======================================================================
HELP ;Display help.
 N DDS,DIR0,DONE,IND,TEXT
 ;DBIA #5746 covers kill and set of DDS. DDS needs to be set or the
 ;Browser will kill some ScreenMan variables.
 S DDS=1,DONE=0
 F IND=1:1 Q:DONE  D
 . S TEXT(IND)=$P($T(HTEXT+IND),";",3,99)
 . I TEXT(IND)="**End Text**" K TEXT(IND) S DONE=1 Q
 D BROWSE^DDBR("TEXT","NR","Reminder Exchange Help")
 S VALMBCK="R"
 Q
 ;
 ;======================================================================
HTEXT ;Help text
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
 ;;LWH Load Web Host File
 ;;    Load a host file containing packed reminder definitions
 ;;    from a web site into the Exchange File. Note that https
 ;;    and Sharepoint sites will not work.
 ;;
 ;;LR  List Reminder Definitions
 ;;    Display a list of all the reminders that are defined in the
 ;;    current UCI.
 ;;
 ;;RI  Reminder Definition Inquiry
 ;;    Display the reminder definition for the selected reminder.
 ;;
 ;;RP  Repack
 ;;    This action can be used to select an existing Reminder Exchange file
 ;;    entry and automatically repack it. If the Exchange file entry was
 ;;    originally packed in a different account the repack may fail because one
 ;;    or more of the components may not exist in the account where the repack is
 ;;    being done.
 ;;
 ;;QU  Quit
 ;;
 ;;**End Text**
 Q
 ;
