ONCOSINP ;WASH ISC/SRR,MLH-INPUT SUBROUTINES FOR ONCOS ;11/1/93  12:16
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;These entry points perform miscellaneous input functions:
 ;GETFILE  get a FileMan file
 ;GETYES   get a yes/no response
 ;GETTEMPL get a search template
 ;
GETFILE ;lookup file, get file number & global reference
 ;in:  ONCOS("F")=file name
 ;out: ONCOS("FI")=file number^file name^global reference OR Y=-1
 N DIC
 S X=$S($D(ONCOS("F")):ONCOS("F"),1:""),DIC="^DIC(",DIC(0)=$S(X="":"AEQ",1:"EQ") D ^DIC Q:Y<0  S GBL=^DIC(+Y,0,"GL"),FNUM=+Y,ONCOS("FI")=Y_GBL W !,"FILE: ",X Q
 Q
 ;
GETTEMPL ;get a search template
 ;in:  FNUM,ONCOS,^DIBT
 ;out: Y
 N D,DIC,DIR
 I $D(ONCOS("T")) S Y=ONCOS("T") Q:Y="ALL"  I $D(^DIBT("F"_FNUM,Y)) S X=$O(^(Y,"")) I X]"" W !,"SEARCH TEMPLATE: ",Y S Y=X_U_Y Q
 ;S Y="Use a SEARCH TEMPLATE? Yes// ",Z="Use a SEARCH TEMPLATE to restrict cases"
ASK W ! S DIR("A")="     Restrict cases with a SEARCH TEMPLATE",DIR("B")="Yes",DIR(0)="Y",DIR("??")="^D HP1^ONCOSINP" D ^DIR G GT2:$G(Y)=0 S Y=$S(Y["^":-1,Y="":0,1:1) Q:Y'>0  G GT2:Y=2
Z S D="F"_FNUM,DIC="^DIBT(",DIC(0)="AEQ",DIC("A")="     Select SEARCH TEMPLATE: " D ^DIC S Y=$S(Y="^":0,Y="":0,Y=-1:0,1:Y) Q:'Y  S N=+Y
X ;D GETYES E  Q:Y=-1  G GT2
 I '$D(^DIBT(N,"DIS")) W !,"Sorry, ",$P(Y,U,2)," must be a SEARCH template" G GT1
 I '$D(^DIBT(N,1)) W !!,?10,$P(Y,U,2)_" does not have stored entries",!?10,"you must run FM Search Option for this template.",!! G GT1
 W !!?10,"REMINDER: Run Define Search Criteria Option"
 W !,?10,"to be sure selected entries are up-to-date!!",!
 ;S DIR("A")="Continue",DIR(0)="Y",DIR("B")="Yes" D ^DIR W ! S Y=$S(Y=1:1,1:0)
 ;Line above caused program to quit with NO DEATHS
 Q
 Q
GT2 W ! S Y="Really use ALL cases (this may take some time)? No// ",Z=""
 D GETYES I  S Y="ALL"
 E  G:Y'=-1 ASK
 Q
HP1 W !!?10,"Using a Search Template will restrict cases.",!
 W ?10,"It will act as a filter using only those cases",!
 W ?10,"that fit the criteria you have selected."
W W !!,?10,"YOU MUST have FIRST GENERATED the Search Template using the",!?10,"DS Option to create the necessary 'TRUE' entries!",!!
 Q
GT1 S D="F"_FNUM D IX^DIC G GT2:$P(Y,U,2)="ALL" Q:Y=-1  Q:$O(^DIBT(+Y,1,""))]""
 Q
 ;
GETYES ;get a yes/no response
 ;in:  Y = prompt (including default e.g. Yes//)
 ;     Z = undefined if specific help handled by calling module
 ;       '="" for single line help
 ;out: X = actual entry
 ;     $T = true if yes
 ;     Y = -1 for ^
 W !,Y R X:DTIME E  S X="^"
 I X'[U
 E  S Y=-1 Q
 I X="" S X=$F(Y,"//"),X=$S(X>3:$E(Y,X-5,X-3),1:"?")
 I '(X["Y"!(X["y")!(X["N")!(X["n")) W *7 S X="?"
 I X["?" W !,"Enter 'y' or 'n' or '^' to abort." Q:'$D(Z)  W:Z'="" !,Z G GETYES
 I X["Y"!(X["y") W "  (Yes)"
 E  W "  (No)"
 Q
