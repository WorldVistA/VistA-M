PRSARCH ;;WOIFO/JAH - Recess Tracking Help List ;11-DEC-2006
 ;;4.0;PAID;**112**;Sep 21, 1995;Build 54
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 Q
EN ;
 D EN^VALM("PRSA RECESS TRACKING HELP")
 S VALMBCK="R"
 Q
HDR ; -- header code
 S VALMHDR(1)="Help Screen for 9 Mo. AWS Recess Tracking Actions"
 S VALMHDR(2)="Enter QU to return to the Schedule"
 Q
 ;
INIT ; -- init variables and list array
 ;
 N TEXT,LEN
 S VALMCNT=0
 F  D  Q:TEXT=""
 .  S VALMCNT=VALMCNT+1
 .  S TEXT=$P($T(HLPTXT+VALMCNT),";",3)
 .  I $E(TEXT,1)?1A D
 ..    S LEN=$L(TEXT)
 ..    S TEXT="              "_TEXT
 ..    D SET^VALM10(VALMCNT,TEXT)
 ..    D CNTRL^VALM10(VALMCNT,15,LEN,IORVON,IORVOFF,0)
 ..   ; D RESTORE^VALM10(VALMCNT)
 .  E  D
 ..   D SET^VALM10(VALMCNT,TEXT)
 Q
HLPTXT ;
 ;;SE  Select Recess Weeks
 ;;    Enter SE at the Select Action prompt to select weeks by the number
 ;;    in the left hand column of the list.  You may select multiple
 ;;    weeks by entering week numbers separated by commas and you may
 ;;    select a range of weeks by using a hyphen.  For example: 3,6-10,12
 ;;    is a valid response to select weeks.  This action will then prompt
 ;;    for the hours to enter for all of the weeks selected.  If the
 ;;    weeks are in the past the tour of duty hours stored in the
 ;;    employee's timecard may be used by accepting the default to use
 ;;    tour of duty hours.  Alternatively you can choose to use the 
 ;;    employee's current tour hours from the timecard as the recess 
 ;;    hours or you may specify the recess hours for each week of the
 ;;    pay period for the weeks selected.  In all cases the recess hours
 ;;    specified are applied to all the weeks selected.
 ;;EH  Edit Recess Hours
 ;;    Enter EH at the Select Action prompt to select any of the weeks
 ;;    in the list by number.  You will be prompted to enter the recess
 ;;    hours for each week that you selected.
 ;;CR  Cancel Recess Weeks
 ;;    Enter CR at the Select Action prompt to select any of the weeks
 ;;    in the list by number.  Any recess hours from the selection will
 ;;    be removed.
 ;;NS  Change AWS Start
 ;;    Enter NS at the Select Action prompt to change when the AWS
 ;;    schedule takes effect.  Any recess scheduled during the fiscal
 ;;    year that occurs before the new start date is removed.  If you
 ;;    enter a date other than the first day of a pay period the action
 ;;    will automatically set the AWS start date to the first day of 
 ;;    the pay period that the date you entered falls within.
 ;;    The number of weeks available for recess is 25% of the weeks
 ;;    from the start date to the end of the fiscal year.
 ;;GH  Recess Hours Summary
 ;;    Enter GH to see a summary screen with recess totals.  Be sure 
 ;;    to scroll down to see the whole report.
 ;;SV  Save Recess Schedule
 ;;    Enter SV to save any edits you have made to the schedule and
 ;;    continue editing.
 ;;EX  Exit and Save Recess
 ;;    Enter EX to save any edits you have made to the schedule and exit
 ;;    the option.
 ;;QU  Quit without Saving
 ;;    Enter QU to quit and not save any of the changes you made.
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 Q
 ;
EXPND ; -- expand code
 Q
 ;
