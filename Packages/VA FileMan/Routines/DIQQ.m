DIQQ ;SFISC/GFT-VARIOUS HELPS ;11:05 AM  9 Aug 2002
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;;GFT;**97,999**
 ;
DIP ;**CCO/NI  EVERYTHING THRU TAG '11' CHANGED
 D BLD^DIALOG(9070),MSG^DIALOG("WH") ;*CCO/NI TYPE '-' ...
 I $G(DDXP)'=4 D BLD^DIALOG(9071),MSG^DIALOG("WH") ;*CCO/NI '=', '#', ETC
 I DJ=1 D BLD^DIALOG(9072),MSG^DIALOG("WH") ;**CCO/NI '[TEMPLATE NAME]'
 I DUZ(0)="@",DJ=1 D BLD^DIALOG(9073),MSG^DIALOG("WH") ;**CCO/NI 'BY(0)'
 Q
 ;
DIP3 ;
 D BLD^DIALOG(9085,IO),MSG^DIALOG("WH") ;**CCO/NI 'YOU CAN FREE THIS TERMINAL'
 G FREE^DIP3
 ;
DIP1(FT) ;from DIR reader -- FROM or TO help
 I X'["??" D
 .N DIP S DIP(1)=DE,DIP(2)=DIPR
 .D BLD^DIALOG(9080+FT,.DIP),MSG^DIALOG("WH") ;**CCO/NI
 .I $G(DIR("B"))]"" S %=$P("FIRST^LAST",U,FT) I %'=DIR("B") W !?5,"OR ENTER '",%,"' TO ",$P("START FROM THE FIRST^GO THRU THE LAST",U,FT)," VALUE"
11 I $P(DPP(DJ),U) S %=$P(DPP(DJ),U,2)+$P($P(DPP(DJ),U,4),"""",2) I % W ! D EN^DIQQ1($P(DPP(DJ),U),%,$S(X["??":"??",1:"?"))
 Q
 ;
DICATT3 W "TYPE FIELD NAMES, OPERATORS(+-\/*), DIGITS, OR FUNCTIONS",!,"FOR FUNCTIONS,"
 S D="B",DZ="??",DIC("W")="W:$D(^(9)) ""  ("",^(9),"")""",DIC="^DD(""FUNC"",",DIC(0)="" D DQ^DICQ G 6^DICATT3
 ;
DICATT31 W !,"ENTER THE NUMBER OF DIGITS THAT SHOULD NORMALLY APPEAR TO THE"
 W !,"RIGHT OF THE DECIMAL POINT WHEN '",F,"' IS DISPLAYED" G DEC^DICATT3
 ;
DIP2 ;
 I $G(DDXP)=2 D  G F^DIP2
 .W !!?5,"YOU CAN ALSO ENTER A COMPUTED EXPRESSION."
 .W:DE="" !?5,"ENTER '[TEMPLATE NAME]' TO USE AN EXISTING SELECTED EXPORT FIELDS TEMPLATE."
 .W !
 I $P(DU,U,4)>1 D BLD^DIALOG(9076,$P(DU,U)),MSG^DIALOG("WH") ;**CCO/NI  'TYPE 'ALL''
 D BLD^DIALOG(9077),MSG^DIALOG("WH") ;**CCO/NI 'TYPE '&' ETC'
 I DE="" D BLD^DIALOG(9078),MSG^DIALOG("WH") ;**CCO/NI 'TYPE [TEMPLATE NAME]'
 G F^DIP2
 ;
DICE2 ;
 W !!,"YOU MAY USE '@' TO INDICATE THAT '",DNEW,"' IS TO BE DELETED",!,"IF YOU SIMPLY WANT TO MOVE THE VALUE OF '",DOLD,"' OVER,",!,"   JUST ENTER '",DOLD,"'"
 G C^DICE2
DIARQ ;ARCHIVING ERROR MESSAGES
FER W !,$C(7),"Less than 'FROM SELECT CRITERIA VALUE'.",$P(DIARS,U,2) Q
FER1 W !,$C(7),$$EZBLD^DIALOG(1511) Q  ;**CCO/NI 'START WITH' > 'GO TO'
TER W !,$C(7),"Less than 'TO SELECT CRITERIA VALUE'.",$P(DIARE,U,2) Q
TER1 W !,$C(7),"Less than 'TO' value." Q
 ;
ENTT W !!,"_____________________________________________________________________________",!!,$C(7),"A field in the 'SELECT CRITERIA TEMPLATE being used does NOT MATCH."
 W !,"the field at the SAME LEVEL in the BASE SELECT CRITERIA SORT TEMPLATE"
 W !,"specified for this file.  There must be a one to one correspondence"
 W !,"between the fields in the template you want to use and the"
 W !,"BASIC SELECT CRITERIA SORT TEMPLATE, until all the fields in the"
 W !,"BASIC SELECT CRITERIA SORT TEMPLATE have been satisfied.  More"
 W !,"CRITERIA may exist after that.  See the development staff of the Package"
 W !,"or the ARCHIVING DOCUMENTATION where this process is explained further"
 W !,"for more information."
 W !,"_____________________________________________________________________________"
 Q
