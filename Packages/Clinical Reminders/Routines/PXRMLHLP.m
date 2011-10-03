PXRMLHLP ; SLC/PJH,AGP - Reminder Patient List help. ;05/31/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;======================================================================
LOAD(SUB) ;
 ;If necessary load the help text into the ^TMP array.
 ;Check if the help text has already been loaded.
 I $D(^TMP(SUB,$J,"VALMCNT")) D  Q
 . S VALMCNT=^TMP(SUB,$J,"VALMCNT")
 ;
 N DONE,IND,LABEL,TEXT
 S LABEL=$S(SUB["LPP":"TX1",SUB["LPUH":"TX2",SUB["LPAH":"TX3",1:"NOHLP")
 S DONE=0
 S VALMCNT=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(@(LABEL_"+"_IND)),";;",2)
 . I TEXT="**End Text**" S DONE=1 Q
 . S VALMCNT=VALMCNT+1,^TMP(SUB,$J,VALMCNT,0)=TEXT
 S ^TMP(SUB,$J,"VALMCNT")=VALMCNT
 Q
 ;
 ;======================================================================
TX1 ;Help text for a selected patient list
 ;;The following actions are available:
 ;;
 ;;CV   Change View
 ;;     Toggle between display by patient name and display by patient
 ;;     name within facility. Sorting by facility is possible only if
 ;;     the patient's facility has been stored with the list.
 ;;
 ;;HSA  Print Health Summary (All Patients)
 ;;     Print a Health Summary for all patients on the patient list.
 ;;
 ;;HSI  Print Health Summary (Individual Patients)
 ;;     Print a Health Summary for selected patients.
 ;;
 ;;DEM  Demographic Report
 ;;     Display specific demographic data for the patients on the 
 ;;     list in delimited or formatted output.
 ;;
 ;;ED   Edit List (Available only to creator of list)
 ;;     Edit the name and type of list.
 ;;     
 ;;USR  View User (Available only to creator of list)
 ;;     Add, delete, and view users who have access to the list.
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
TX2 ;Main help text for patient lists
 ;;
 ;;Patient Lists have two levels of control: Authorized User and Creator.
 ;;
 ;;Authorized User:
 ;;  Authorized Users can have one of two levels of control assigned to 
 ;;  them: View only access and Full control. Full Control allows an
 ;;  authorized user full access to a Patient List; the only thing an 
 ;;  authorized user cannot do is delete the list. 
 ;;
 ;;Creator:
 ;;  Can view a list, copy a list into a new list, delete a list, and 
 ;;  can copy a list into a OR/RR team list. A Creator is the only
 ;;  person who can delete a private patient list.
 ;;
 ;;The following actions are available:
 ;;
 ;;CO  Copy Patient List
 ;;    Copy all patients in the patient list into a new local patient
 ;;    list.
 ;;
 ;;COE Copy Patient List to OE/RR Team
 ;;    Copy all patients in the patient list into a new OE/RR Team 
 ;;    list.
 ;;
 ;;CR  Create Patient List
 ;;    Use a list rule set to create a new local patient list.
 ;;
 ;;DE  Delete Patient List (Creator Only)
 ;;    Delete selected local patient lists.
 ;;    
 ;;DCD Display Creation Documentation
 ;;    Display documentation that shows how the patient list was
 ;;    created.
 ;;    
 ;;DSP Display Patient List
 ;;    Display a selected patient list with the option to print. Also 
 ;;    view and modify the list of users assigned access to the list.
 ;;
 ;;CV  Change View
 ;;    Change the view between the list of Patient Lists sorted by patient 
 ;;    list name or sorted by type (public or private).
 ;;    
 ;;LRM List Rule Management
 ;;    Create or edit list rules.
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
TX3 ;Help Text for USR option
 ;;The following options require the user to have Creator access:
 ;;
 ;;ADD Add user
 ;;    Add a user as an authorized user to the list.
 ;;
 ;;DEL Delete User
 ;;    Delete one or more authorized users from the List.
 ;;
 ;;QU  Quit
 ;;**End Text**
 Q
 ;
 ;======================================================================
NOHLP ;Help text
 ;;
 ;;No Help Text Available
 ;;
 ;;**End Text**
 Q
