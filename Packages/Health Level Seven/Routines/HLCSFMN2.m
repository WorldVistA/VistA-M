HLCSFMN2 ;ALB/JRP - FILER MONITOR UTILITIES;13-FEB-95 ;10/15/99  07:16
 ;;1.6;HEALTH LEVEL SEVEN;**57**;Oct 13, 1995
 ;
SELECT(INARR,ENTITY) ;SELECTION UTILITY
 ;INPUT  : INARR - Array whose first subscript denotes the list of
 ;                 selectable numbers (full global reference)
 ;               - $O(INARR(x)) yields all selectable numbers
 ;         ENTITY - What's being selected
 ;                - Defaults to 'Entry' (prompt is 'Select Entry')
 ;OUTPUT : X - Number selected
 ;         0 - Nothing selected
 ;        -1 - Bad input / nothing to select from
 ;        -2 - Timeout / abort
 ;NOTES  : User does not have to select an entry
 ;       : Number selected will be validated (must be in INARR).  This
 ;         allows gaps to exist in INARR(x).
 ;       : Only whole numbers greater than zero are selectable
 ;
 ;CHECK INPUT
 Q:($G(INARR)="") -1
 Q:('$O(@INARR@(0))) -1
 S:($G(ENTITY)="") ENTITY="Entry"
 ;DECLARE VARIABLES
 N DIR,X,Y,DTOUT,DUOUT,DIRUT,FRSTENT,LSTENT,LOOP,DONE
 ;DETERMINE FIRST AND LAST ENTRY NUMBERS
 S FRSTENT=+$O(@INARR@(""))
 S LSTENT=+$O(@INARR@(""),-1)
 ;ONLY ONE ITEM - AUTO SELECT
 Q:(FRSTENT=LSTENT) FRSTENT
 ;PROMPT USER FOR VALID SELECTION
 F DONE=0:0 D  Q:(DONE)
 .K DIR,DTOUT,DUOUT,DIRUT,X,Y
 .S DIR(0)="NAO^"_FRSTENT_":"_LSTENT_":0"
 .S DIR("A")="Select "_ENTITY_" ("_FRSTENT_"-"_LSTENT_"): "
 .S DIR("?",1)="Response must be a number between "_FRSTENT_" and "_LSTENT
 .S DIR("?")="Enter '??' to see a list of valid selections"
 .S DIR("??")="^W !!,""Valid Selections: "" S LOOP=0 F  S LOOP=+$O(@INARR@(LOOP)) Q:('LOOP)  W:(LOOP'=FRSTENT) "","" W:(($X+$L(LOOP)+1)>79) !,?18 W LOOP"
 .D ^DIR
 .;TIMEOUT/ABORT
 .I (($D(DTOUT))!($D(DUOUT))) S Y=-2,DONE=1 Q
 .;NOTHING SELECTED
 .I ($D(DIRUT)) S Y=0,DONE=1 Q
 .;VALIDATE SELECTION
 .I ($D(@INARR@(Y))) S DONE=1 Q
 .;INVALID SELECTION
 .W $C(7),!!,Y," is not a valid selection"
 .W !,"Enter '??' to see a list of valid selections"
 .W !
 ;DONE
 Q Y
