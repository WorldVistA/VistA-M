PXRMLRHL ; SLC/PJH - List Rule help. ;05/31/2006
 ;;2.0;CLINICAL REMINDERS;**4**;Feb 04, 2005;Build 21
 ;======================================================================
LOAD(SUB) ;
 ;If necessary load the help text into the ^TMP array.
 ;Check if the help text has already been loaded.
 I $D(^TMP(SUB,$J,"VALMCNT")) D  Q
 . S VALMCNT=^TMP(SUB,$J,"VALMCNT")
 ;
 N DONE,IND,LABEL,TEXT
 S LABEL=$S(SUB["LRM":"TX1",SUB["LRED":"TX2",1:"NOHLP")
 S DONE=0
 S VALMCNT=0
 F IND=1:1 Q:DONE  D
 . S TEXT=$P($T(@(LABEL_"+"_IND)),";;",2)
 . I TEXT="**End Text**" S DONE=1 Q
 . S VALMCNT=VALMCNT+1,^TMP(SUB,$J,VALMCNT,0)=TEXT
 S ^TMP(SUB,$J,"VALMCNT")=VALMCNT
 Q
 ;
TX1 ;Help Text
 ;;The following actions are available:
 ;;
 ;;CV  Change View
 ;;    Toggle view between different rule types
 ;;    - Finding Rules (based on Reminder Terms)
 ;;    - Patient List Rules (based on existing Patient Lists)
 ;;    - Reminder Rules (based on reminder definitions)
 ;;    - Rule Sets (containing Finding Rules and Patient List Rules)
 ;;
 ;;CR  Create Rule
 ;;    Create a list rule of the type currently displayed. Finding Rules
 ;;    and Patient List Rules must be created before a Rule Set may be
 ;;    created. 
 ;;
 ;;DR  Display/Edit Rule
 ;;    Display or edit an existing list rule. Only local list rules may
 ;;    be edited.
 ;;
 ;;TEST (Available only for rule sets)
 ;;    Shows how the rule set will be evaluated based on the user's
 ;;    input of list build beginning and ending dates.
 ;;
 ;;QU  Quit
 ;;**End Text**
 ;
 ;
TX2 ;Help Text
 ;;The following actions are available:
 ;;
 ;;ED  Edit Rule
 ;;    Edit a list rule.
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
 ;
