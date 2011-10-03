DIQQ ;SFISC/GFT-VARIOUS HELPS ;10:25 AM  21 Feb 2002
 ;;22.0;VA FileMan;**97**;Mar 30, 1999
 ;Per VHA Directive 10-93-142, this routine should not be modified.
DIP ;
 W !?9,"TYPE '-' IN FRONT OF NUMERIC-VALUED FIELD TO SORT FROM HI TO LO"
 D:$G(DDXP)'=4
 . W !?9,"TYPE '+' IN FRONT OF FIELD NAME TO GET SUBTOTALS BY THAT FIELD,"
 . W !?12,"'#' TO PAGE-FEED ON EACH FIELD VALUE,  '!' TO GET RANKING NUMBER,"
 . W !?12,"'@' TO SUPPRESS SUB-HEADER,   ']' TO FORCE SAVING SORT TEMPLATE"
 . W !?9,"TYPE ';TXT' AFTER FREE-TEXT FIELDS TO SORT NUMBERS AS TEXT" Q
 W:DJ=1 !?9,"TYPE [TEMPLATE NAME] IN BRACKETS TO SORT BY PREVIOUS SEARCH RESULTS"
 I DUZ(0)="@",DJ=1 W !?9,"TYPE 'BY(0)' TO DEFINE RECORD SELECTION AND SORT ORDER"
 Q
 ;
DIP3 W !,"SINCE YOU ARE CALLING FOR OUTPUT ON DEVICE '",IO,"', YOU MAY USE ",!,"THE TERMINAL YOU ARE NOW TYPING ON FOR SOMETHING ELSE, BY ANSWERING 'Y'",!!
 G FREE^DIP3
 ;
DIP1(FT) ;from DIR reader -- FROM or TO help
 N % G:X["??" 11
 W !,"TO ",DE,$P(" IN SEQUENCE, STARTING FROM^ ONLY UP TO",U,FT)
1 W " A CERTAIN ",R,", " S %="TYPE THAT "_R W:$L(%)+$X>77 !?5 W %
 I $P(DC,U)'["R"&$L(DC) S %="OR ENTER '@' TO INCLUDE NULL "_R_" VALUES" W !?5,%
 I $G(DIR("B"))]"" S %=$P("FIRST^LAST",U,FT) I %'=DIR("B") W !?5,"OR ENTER '",%,"' TO ",$P("START FROM THE FIRST^GO THRU THE LAST",U,FT)," VALUE"
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
 . W !!?5,"YOU CAN ALSO ENTER A COMPUTED EXPRESSION."
 . W:DE="" !?5,"ENTER '[TEMPLATE NAME]' TO USE AN EXISTING SELECTED EXPORT FIELDS TEMPLATE."
 . W !
 . Q
 W:$P(DU,U,4)>1 !?5,"TYPE 'ALL' TO PRINT EVERY ",$P(DU,U,1)
 W !?5,"TYPE '&' IN FRONT OF FIELD NAME TO GET TOTAL FOR THAT FIELD,",!?8,"'!' TO GET COUNT, '+' TO GET TOTAL & COUNT, '#' TO GET MAX & MIN,",!?8,"']' TO FORCE SAVING PRINT TEMPLATE"
 W:DE="" !?5,"TYPE '[TEMPLATE NAME]' IN BRACKETS TO USE AN EXISTING PRINT TEMPLATE"
 W !?5,"YOU CAN FOLLOW FIELD NAME WITH ';' AND FORMAT SPECIFICATION(S)"
 G F^DIP2
 ;
DICE2 ;
 W !!,"YOU MAY USE '@' TO INDICATE THAT '",DNEW,"' IS TO BE DELETED",!,"IF YOU SIMPLY WANT TO MOVE THE VALUE OF '",DOLD,"' OVER,",!,"   JUST ENTER '",DOLD,"'"
 G C^DICE2
DIARQ ;ARCHIVING ERROR MESSAGES
FER W !,$C(7),"Less than 'FROM SELECT CRITERIA VALUE'.",$P(DIARS,U,2) Q
FER1 W !,$C(7),"Less than 'FROM' value." Q
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
