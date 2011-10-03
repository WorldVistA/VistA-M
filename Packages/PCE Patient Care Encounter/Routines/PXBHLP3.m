PXBHLP3 ;ISL/JVS,ALB/Zoltan - HELP FOR DIAGNOSIS ;10/30/98
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**11,19,62**;Aug 12, 1996
 ;
 ;
 ; If you edit the text be sure to change the length next to the TAG
 ;   eg===  ;;4
 ;  you can put a line feed '!' at the end of the last line if necessary.
 ;
 ;
 W !,"THIS IS NOT AN ENTRY POINT " Q
INTRO ;;6
 W !,"Enter a DIAGNOSIS associated with this patient ENCOUNTER."
 W !,"You can enter partial names to receive a short list."
 W !,"Above is a list of DIAGNOSES already entered. If there are any"
 W !,"additional ones, they should be entered at this time."
 W !," * indicates that this entry has been visited during this session."
 I $G(WHAT)="INTV" W !,"a '^^' (double up arrow) will take you out of the interview"
 W !,"For more detailed ",IOINHI,"HELP",IOINLOW," and selection lists enter ",IOINHI,"??",IOINLOW,!
 Q
BODY ;;12
 W !,"To receive detailed help for ",IOINHI,"ADD",IOINLOW," or ",IOINHI,"DELETE",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"A",IOINLOW,"   to get help on how to ADD diagnoses."
 W !,"  ",IOINHI,"D",IOINLOW,"   to get help on how to DELETE diagnoses."
 W !,"  ",IOINHI,"E",IOINLOW,"   to get help on how to EDIT diagnoses."
 W !
 W !,"To receive more ",IOINHI,"SELECTION LISTS",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"1",IOINLOW,"   to get a list of ALL active diagnoses."
 W !,"  ",IOINHI,"2",IOINLOW,"   to get a list of PATIENT PROBLEMS."
 W !,"  ",IOINHI,"3",IOINLOW,"   to get a list of CLINIC diagnoses."
 W !,"  ",IOINHI,"4",IOINLOW,"   to get a list of ENCOUNTER FORM diagnoses."
 Q
A ;;5
 W !,"To ",IOINHI,"ADD",IOINLOW," a DIAGNOSIS enter one of the following:"
 W !,"  DIAGNOSIS NAME (eg. GASTROPARESIS)"
 W !,"  PARTIAL NAME of the DIAGNOSIS at least 3 letters in length(eg. GAS or GASTRO)"
 W !,"  ICD CODE number (eg 536.3)"
 W !,"  Several ICD CODE numbers at once (eg 536.3,250.61)"
 Q
E ;;10
 W !,"To ",IOINHI,"EDIT",IOINLOW," a DIAGNOSIS enter one of the following:"
 W !,"  DIAGNOSIS NAME (eg. GASTROPARESIS)"
 W !,"  ICD CODE (eg 536.3)"
 W !,"  ITEM NUMBER on the left side of the list of the DIAGNOSES (eg. 7)"
 W !
 W !,"To move the PRIMARY designation from one diagnosis to another do the following:"
 W !,"  select the current primary diagnosis"
 W !,"  answer NO to the primary diagnosis prompt"
 W !,"  select the new primary diagnosis"
 W !,"  answer YES to the primary diagnosis prompt"
 Q
D ;;3
 W !,"To ",IOINHI,"DELETE",IOINLOW," a DIAGNOSIS enter one of the following:"
 W !,"  an '@' followed by the ITEM NUMBER (eg. @1 or @3)"
 W !,"  Multiple ITEM NUMBERS can be selected (eg. @1,3,5 or @1-3,6,9)"
 Q
PROMPT ;---Prompt for the help prompt
 N DIR,OK,POSS
 D WIN17^PXBCC(PXBCNT)
 W !!,"Enter '^' to leave HELP CENTER"
 W !,"Enter a letter or number for additional help: "
 R Y:DTIME
 S POSS="aAdDeE1234^" I POSS[Y,$L(Y)=1!(Y="") S TAG=Y
 S TAG=$TR(TAG,"aed","AED")
 I POSS'[Y!($L(Y)>1) S TAG="BODY"
 ;
 ;
 Q
ROUTINE ;---routine executed when selection lists are selected
 ;W !,"ROUTINES FOR SELECTION LISTS"
1 ;;10
 S (Y,DATA,EDATA,UDATA)=$$DOUBLE^PXBGPOV2(WHAT)
 Q
2 ;;10
 S (FPL,PXBSPL)="" S (Y,DATA,EDATA,UDATA)=$P($P($$DOUBLE1^PXBGPL2(WHAT),"^",2)," ",1)
 Q
3 ;;10
 S (Y,DATA,EDATA,UDATA)=$$DOUBLE1^PXBGPOV3(WHAT)
 Q
4 ;;10
 S (Y,DATA,EDATA,UDATA)=$$DOUBLE1^PXBGPOV4(WHAT)
 Q
