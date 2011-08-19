PXBHLP4 ;ISL/JVS,ALB/Zoltan - HELP FOR PROCEDURES (CPT CODES) ;10/30/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**62**;Aug 12, 1996
 ;
 ;
 ;
 ; If you edit the text be sure to change the length next to the TAG
 ;   eg===  ;;4
 ;  you can put a line feed '!' at the end of the last line if necess.
 ;
 ;
 W !,"THIS IS NOT AN ENTRY POINT " Q
INTRO ;;6
 W !,"Enter a PROCEDURE associated with this patient ENCOUNTER."
 W !,"You can enter partial names or code numbers to receive a short list."
 W !,"Above is a list of PROCEDURES already entered. If there are any"
 W !,"additional ones, they should be entered at this time."
 W !," * indicates that this entry has been visited during this session."
 I $G(WHAT)="INTV" W !,"a '^^' (double up arrow) will take you out of the interview"
 W !,"For more detailed ",IOINHI,"HELP",IOINLOW," and selection lists enter ",IOINHI,"??",IOINLOW,!
 Q
BODY ;;10
 W !,"To receive detailed help for ",IOINHI,"ADD",IOINLOW," or ",IOINHI,"DELETE",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"A",IOINLOW,"   to get help on how to ADD procedures."
 W !,"  ",IOINHI,"D",IOINLOW,"   to get help on how to DELETE procedures."
 W !,"  ",IOINHI,"E",IOINLOW,"   to get help on how to EDIT procedures."
 W !
 W !,"To receive more ",IOINHI,"SELECTION LISTS",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"1",IOINLOW,"   to get a list of ALL active procedures."
 W !,"  ",IOINHI,"2",IOINLOW,"   to get a list of ENCOUNTER FORM procedures"
 Q
A ;;4
 W !,"To ",IOINHI,"ADD",IOINLOW," a PROCEDURE enter one of the following:"
 W !,"  PROCEDURE NAME or partial PROCEDURE NAME (eg. ABL or ABLATION)"
 W !,"  CPT PROCEDURE CODE (eg 30801)"
 W !,"  Several CPT PROCEDURE CODEs at once (eg 30801,10080,10081,27256)"
 Q
E ;;8
 W !,"To ",IOINHI,"EDIT",IOINLOW," a PROCEDURE enter one of the following:"
 W !,"  PROCEDURE NAME (eg. ABLATION)"
 W !,"  CPT PROCEDURE CODE (eg 30801)"
 W !,"  ITEM NUMBER on the left side of the list of the PROCEDURES (eg. 7)"
 W !
 W !,"To edit the QUANTITY on a procedure do the following:"
 W !,"  select the a current procedure"
 W !,"  answer with the quantity at the QUANTITY prompt"
 Q
D ;;3
 W !,"To ",IOINHI,"DELETE",IOINLOW," a PROCEDURE enter one of the following:"
 W !,"  an '@' followed by the ITEM NUMBER (eg. @1 or @3)"
 W !,"  Several ITEM NUMBERS can be selected (eg. @1,3,5 or @1-3,6,9)"
 Q
PROMPT ;---Prompt for the help prompt
 N DIR,OK,POSS
 D WIN17^PXBCC(PXBCNT)
 W !!,"Enter '^' to leave HELP CENTER"
 W !,"Enter a letter or number for additional help: "
 R Y:DTIME
 S POSS="aAdDeE12^" I POSS[Y,$L(Y)=1!(Y="") S TAG=Y
 S TAG=$TR(TAG,"aed","AED")
 I POSS'[Y!($L(Y)>1) S TAG="BODY"
 ;
 ;
 Q
ROUTINE ;---routine executed when selection lists are selected
 ;W !,"ROUTINES FOR SELECTION LISTS"
1 ;;10
 S (Y,DATA,EDATA,UDATA)=$$DOUBLE^PXBGCPT2(WHAT)
 Q
2 ;;10
 S (Y,DATA,EDATA,UDATA)=$$DOUBLE1^PXBGCPT4(WHAT)
 Q
 ;
