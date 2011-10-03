KMPDUT4C ;OAK/RAK; Multi-Lookup cont. ;2/17/04  10:48
 ;;2.0;CAPACITY MANAGEMENT TOOLS;;Mar 22, 2002
 ;
HELP ;--help text
 N OUT
 W !!?7,"Enter '?D' to display entries selected so far."
 I $G(OPTION)'["S" W !!?7,"Select '*' for all entries or"
 W !
 G:$G(OPTION)'["W" HELPM
 W !?7,"Select entries by typing one or more characters and then the '*'"
 W !
 W !?7,"    Example:  'A*'     - will select all entries begging with"
 W !?7,"                         the letter 'A'"
 W !?7,"              'SMITH*' - will select all entries begging with"
 W !?7,"                         'SMITH'"
 W !!!
 D FTR^KMPDUTL4("Press <RET> to continue, '^' to exit Help",.OUT)
 I 'OUT W !!! Q
 W !!!
HELPM ;help text for minus sign
 W !?7,"You may remove entries that have been selected so far by"
 W !?7,"entering a minus sign (-) before the entry to be removed"
 W !
 W !?7,"    Example:  '-JONES,JANE' - will remove the entry 'JONES,JANE'"
 W !?7,"                              from the array"
 W !?7,"              '-SMITH*' - will remove all entries beginning with"
 W !?7,"                          'SMITH' from the array"
 W !
 W !?7,"     ************************************************"
 W !?7,"     *** It is important to note that using the   ***"
 W !?7,"     *** minus sign (-) only removes entries from ***"
 W !?7,"     *** the array storing the selected entries,  ***"
 W !?7,"     *** it DOES NOT remove any entries from the  ***"
 W !?7,"     *** look-up file                             ***"
 W !?7,"     ************************************************"
 W !!!
 D FTR^KMPDUTL4("Press <RET> to continue: ")
 W !!!
 Q
MINUS(X) ;de-select entries
 ;--------------------------------------------------------------------
 ;--------------------------------------------------------------------
 Q:'$D(@ARRAY)  S X=$G(X) Q:$E(X)'="-"  S X=$E(X,2,$L(X))
 I X="*" K @ARRAY Q
 I X["*" S STR=$E(X,1,($F(X,"*")-2))
 E  S STR=X
 Q:STR']""  S STR1=STR
 ;--------------------------------------------------------------------
 ;  if exact match on STR1
 ;--------------------------------------------------------------------
 I SORT=1,($D(@ARRAY@(STR1))) D  Q
 .K @ARRAY@(STR1) S @ARRAY@(0)=$G(@ARRAY@(0))-1 W:$X>73 !?7 W "."
 ;--------------------------------------------------------------------
 ;  if wildcard
 ;--------------------------------------------------------------------
 I SORT=1,(X["*") D  Q
 .F  S STR1=$O(@ARRAY@(STR1)) Q:$E(STR1,1,$L(STR))'=STR  D 
 ..K @ARRAY@(STR1) S @ARRAY@(0)=$G(@ARRAY@(0))-1 W:$X>73 !?7 W "."
 Q:SORT
 I X'["*" S ASKI=0 D  Q
 .F  S ASKI=$O(@ARRAY@(ASKI)) Q:'ASKI  I @ARRAY@(ASKI)=STR1 D 
 ..K @ARRAY@(ASKI) S @ARRAY@(0)=$G(@ARRAY@(0))-1 W:$X>73 !?7 W "."
 I X["*" S ASKI=0 D  Q
 .F  S ASKI=$O(@ARRAY@(ASKI)) Q:'ASKI  I $E(@ARRAY@(ASKI),1,$L(STR))=STR D 
 ..K @ARRAY@(ASKI) S @ARRAY@(0)=$G(@ARRAY@(0))-1 W:$X>73 !?7 W "."
 Q
