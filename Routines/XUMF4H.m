XUMF4H ;CIOFO-SF/RAM - Institution File Clean Up; 06/28/99
 ;;8.0;KERNEL;**206**;Jul 10, 1995
 ;
 ;
 ;
DSTA ; -- duplicate station #s
RDSN ; -- deleted duplicate station number
 ;
 W !!,"This list displays duplicate STATION NUMBER (#99)."
 W !,"The action associated with this list will automatically"
 W !,"remove the value from field #99 for local and duplicate"
 W !,"entries.",!!
 D EOP
 ;
 Q
 ;
 ;
LLCL ; -- local data
 ;
 W !!,"This list displays entries that are in the INSTITUTION (#4)"
 W !,"file but not in the national file."
 W !!,"This list is informational only and has no actions associated"
 W !,"with it.",!!
 D EOP
 ;
 Q
 ;
NATL ; -- national
 ;
 W !!,"This list displays the Master Institutution File data.",!!
 D EOP
 ;
 Q
 ;
MSTA ; -- missing station numbers
 ;
 W !!,"This list displays station numbers that are in the national"
 W !,"file but not in the INSTITUTION (#4) file."
 W !!,"This list is informational only and has no actions associated"
 W !,"with it.",!!
 D EOP
 ;
 Q
 ;
AUTO ; -- auto update with national data
 ;
 W !!,"This action will automatically update the INSTITUTION (#4) file"
 W !,"with national data.",!!
 D EOP
 ;
 Q
 ;
CHCK ; -- check if update is complete
 ;
 W !!,"Use this action to check if the all the required steps have"
 W !,"been performed and the clean up has completed.",!!
 D EOP
 ;
 Q
 ;
 ;
NAME ; -- institution vs. national names
 ;
 W !!,"This main screen displays a side-by-side view of the INSTITUTION"
 W !,"(#4) file and the national file names by station number.",!
 W !,"LLCL - lists local station numbers to be deleted.",!
 W !,"DSTA - automatically deletes local/duplicate station numbers.",!
 W !,"NATL - lists Institution Master File entries to merge.",!
 W !,"AUTO - merges national data with local INSTITUTION (#4) file.",!
 W !,"CHCK - run this action to see pending clean up actions to perform.",!!
 D EOP
 ;
 Q
 ;
EOP ; -- End-of-Page
 ;
 N DIR
 S DIR(0)="E"
 D ^DIR,CLEAR^VALM1
 S VALMBCK="R"
 Q
