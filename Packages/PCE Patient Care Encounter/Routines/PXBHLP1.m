PXBHLP1 ;ISL/JVS - FIRST HELP ROUITINE FOR STOP CODES STP ;5/21/96  11:47
 ;;1.0;PCE PATIENT CARE ENCOUNTER;;Aug 12, 1996
 ;
 ;
 ;
 ; If you edit the text besure to change the length nest to the TAG
 ;   eg===  ;;4
 ;  you can put a line feed '!' at the end of the last line if necess.
 ;
 ;
 W !,"THIS IS NOT AN ENTRY POINT " Q
INTRO ;;6
 W !,"Enter a STOP CODE associated with this patient ENCOUNTER."
 W !,"You can enter partial codes or descriptions to receive a short list."
 W !,"Above is a list of STOP CODES already entered. If there are any"
 W !,"additional ones, they should be entered at this time."
 W !," * indicates that the entry had been visited during this session"
 I $G(WHAT)="INTV" W !,"a '^^' (double up arrow) will take you out of the interview"
 W !,"For more detailed ",IOINHI,"HELP",IOINLOW," and 'selection lists' enter ",IOINHI,"??",IOINLOW,!
 Q
BODY ;;8
 W !,"To receive detailed help for ",IOINHI,"ADD",IOINLOW," or ",IOINHI,"DELETE",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"A",IOINLOW,"   to get help on how to ADD stop codes."
 W !,"  ",IOINHI,"D",IOINLOW,"   to get help on how to DELETE stop codes."
 W !
 W !,"To receive more ",IOINHI,"SELECTION LISTS",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"1",IOINLOW,"   to get a list of ALL active stop codes."
 Q
A ;;4
 W !,"To ",IOINHI,"ADD",IOINLOW," a STOP CODE Enter one of the following:"
 W !,"  STOP CODE (eg. 305)"
 W !,"  NAME or PARTIAL NAME of the STOP CODE (eg. AL or ALCOHOL)"
 W !,"  Multiple STOP CODES seperated by a comma (eg. 305,121,314,555,654)"
 Q
E ;;0
D ;;3
 W !,"To ",IOINHI,"DELETE",IOINLOW," a STOP CODE Enter one of the following:"
 W !,"  an '@' followed by the ITEM NUMBER (eg. @1 or @3)"
 W !,"  Multiple ITEM NUMBERS (eg. @1,3,5 or @1-3,6,9)"
 Q
PROMPT ;---Prompt for the help prompt
 N DIR,OK,POSS
 D WIN17^PXBCC(PXBCNT)
 W !!,"Enter '^' to leave HELP CENTER"
 W !,"Enter a letter or number for additional help: "
 R Y:DTIME
 S POSS="aAdD12^" I POSS[Y,$L(Y)=1!(Y="") S TAG=Y
 S TAG=$TR(TAG,"ade","ADE")
 I POSS'[Y!($L(Y)>1) S TAG="BODY"
 ;
 Q
ROUTINE ;---routine excuted when SELECTION LISTS are selected
 ;W !,"ROUTINES FOR SELECTION LISTS"
1 ;;10
 S (Y,DATA,EDATA)=$P($$DOUBLE^PXBGSTP2(WHAT),"^2")
 Q
