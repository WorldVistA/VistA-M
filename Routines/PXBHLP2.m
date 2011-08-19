PXBHLP2 ;ISL/JVS - FIRST HELP ROUITINE FOR PROVIDERS ;6/17/03  10:29
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**124**;Aug 12, 1996
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
 W !,"Enter a PROVIDER associated with this patient ENCOUNTER."
 W !,"You can enter partial names to receive a short list."
 W !,"Above is a list of PROVIDERS already entered. If there are any"
 W !,"additional ones, they should be entered at this time."
 W !," * indicates that the entry has been visited during this session."
 I $G(WHAT)="INTV" W !,"a '^^' (double up arrow) will take you out of the interview"
 W !,"For more detailed ",IOINHI,"HELP",IOINLOW," and selection lists enter ",IOINHI,"??",IOINLOW,!
 Q
INTRO2 ;;6
 W !,"Enter an ORDERING PROVIDER associated with this PROCEDURE."
 W !,"You can enter partial names to receive a short list."
 W !,"Above is a list of PROVIDERS already entered. If there are any"
 W !,"additional ones, they should be entered at this time."
 W !," * indicates that the entry has been visited during this session."
 I $G(WHAT)="INTV" W !,"a '^^' (double up arrow) will take you out of the interview"
 W !,"For more detailed ",IOINHI,"HELP",IOINLOW," and selection lists enter ",IOINHI,"??",IOINLOW,!
 Q
BODY ;;11
 W !,"To receive detailed help for ",IOINHI,"ADD",IOINLOW," or ",IOINHI,"DELETE",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"A",IOINLOW,"   to get help on how to ADD providers."
 W !,"  ",IOINHI,"D",IOINLOW,"   to get help on how to DELETE providers."
 W !,"  ",IOINHI,"E",IOINLOW,"   to get help on how to EDIT providers."
 W !
 W !,"To receive more ",IOINHI,"SELECTION LISTS",IOINLOW," enter the following:"
 W !
 W !,"  ",IOINHI,"1",IOINLOW,"   to get a list of ALL active providers."
 W !,"  ",IOINHI,"2",IOINLOW,"   to get a list of CLINIC providers."
 W !,"  ",IOINHI,"3",IOINLOW,"   to get a list of ENCOUNTER FORM providers."
 Q
A ;;3
 W !,"To ",IOINHI,"ADD",IOINLOW," a PROVIDER enter one of the following:"
 W !,"  PROVIDER NAME (eg. SMITH,VAUGHN)"
 W !,"  PARTIAL LAST NAME of the PROVIDER (eg. SM or SMITH)"
 Q
E ;;9
 W !,"To ",IOINHI,"EDIT",IOINLOW," a PROVIDER enter one of the following:"
 W !,"  PROVIDER NAME (eg. SMITH,VAUGHN)"
 W !,"  ITEM NUMBER on the left side of the list of the PROVIDERS (eg. 7)"
 W !
 W !,"To move the PRIMARY designation from one provider to another do the following:"
 W !,"  select the current primary provider"
 W !,"  answer NO to the primary provider prompt"
 W !,"  select the new primary provider"
 W !,"  answer YES to the primary provider prompt"
 Q
D ;;3
 W !,"To ",IOINHI,"DELETE",IOINLOW," a PROVIDER enter one of the following:"
 W !,"  an '@' followed by the ITEM NUMBER (eg. @1 or @3)"
 W !,"  Multiple ITEM NUMBERS can be selected (eg. @1,3,5 or @1-3,6,9)"
 Q
PROMPT ;---Prompt for the help prompt
 N DIR,OK,POSS
 D WIN17^PXBCC(PXBCNT)
 W !!,"Enter '^' to leave HELP CENTER"
 W !,"Enter a letter or number for additional help: "
 R Y:DTIME
 S POSS="aAdDeE123^" I POSS[Y,$L(Y)=1!(Y="") S TAG=Y
 S TAG=$TR(TAG,"aed","AED")
 I POSS'[Y!($L(Y)>1) S TAG="BODY"
 ;
 ;
 Q
ROUTINE ;---routine excuted when SELECTION LISTS are selected
 ;W !,"ROUTINES FOR SELECTION LISTS"
1 ;;10
 S (Y,DATA,EDATA,UDATA)=$P($$DOUBLE^PXBGPRV2(WHAT),"^",2)
 Q
2 ;;10
 S (Y,DATA,EDATA,UDATA)=$P($$DOUBLE1^PXBGPRV3(WHAT),"^",2)
 Q
3 ;;10
 S (Y,DATA,EDATA,UDATA)=$P($$DOUBLE1^PXBGPRV4(WHAT),"^",2)
 Q
