XQ62 ;SEA/MJM - Generalized file look-up utility ;8/2/89  09:53;5/13/93  11:53 AM
 ;;8.0;KERNEL;;Jul 10, 1995
 S U="^" K ^TMP($J)
MENU W !!,?5,"Please choose the information you would like to examine by number",!!,?10,$S($D(XQ6):"1.  The key file",1:"1.  Help Frame File"),!!,?10,"2.  Current ",$S($D(XQ6):"holders of a key",1:"editors of a help frame")
 W !!,?10,"3.  The User File",!!,?10,"4.  A mail group"
 ;
ASK ;Get user's response, check it, and branch to subroutine
 R !!,?5,"Enter a number or '^' to quit: ",X:DTIME S:'$T X=U G:'$L(X)!(X=U) OUT I X<1!(X>4)!(X'?1N) W " ??",*7,!!,"Please enter the number corresponding to the information you seek or '^' to quit." G ASK
 W !!
 I X=3 G USER
 I X=4 G MAILG
 I $D(XQ6)&(X=1) S DIC="^DIC(19.1,",DIC(0)="AEMNQ",DIC("A")="     What key would you like to see? " D ^DIC G:Y<0 OUT S DA=+Y D EN^DIQ G OUT
 I X=1 S DIC="^DIC(9.2,",DIC(0)="AEMNQ",DIC("A")="     What help frame would you like to see? " D ^DIC G:Y<0 OUT S DA=+Y D EN^DIQ G OUT
 I $D(XQ6)&(X=2) S DIC="^DIC(19.1,",DIC(0)="AEMNQZ",DIC("A")="     Holders of what key? " D ^DIC G:Y<0 OUT S I=0 F XQL=0:1 S I=$O(^DIC(19.1,+Y,2,I)) G:I="" PRINT S XQU=+^(I,0) S:$D(^VA(200,+XQU,0)) X=$P(^(0),U),^TMP($J,X)=""
 I X=2 S DIC="^DIC(9.2,",DIC(0)="AEMNQZ",DIC("A")="     Editors of which help frame? " D ^DIC G:Y<0 OUT S I=0 F XQL=0:1 S I=$O(^DIC(9.2,+Y,4,"AB",I)) G:I="" PRINT S:$D(^VA(200,+I,0)) X=$P(^(0),U,1),^TMP($J,X)=""
 W !!,"Something's wrong...what was it you wanted again? " G ASK
 Q
USER ;Look at the User File
 S DIC=200,X="?",DIC(0)="AEMNQ",DIC("S")="I $L($P(^(0),U,3))",DIC("A")="     Which user would you like to examine? " D ^DIC G:Y<0 OUT S DA=+Y D EN^DIQ G OUT
 Q
MAILG ;Examine a mail group
 S XMDUZ=DUZ,DIC="^XMB(3.8,",DIC(0)="AEQMZ",DIC("A")="     Which mail group? " D ^DIC G:Y<0 OUT W !!," Members are: " S I=0 W !
 F XQL=0:1 S I=$O(^XMB(3.8,+Y,1,I)) Q:'I  S XQU=+^(I,0) S:$D(^VA(200,+XQU,0)) X=$P(^VA(200,+XQU,0),U),^TMP($J,X)=""
PRINT S XQLL=XQL,I=""
 I $O(^TMP($J,I))="" W !!,?5," There is no one listed in the file.",!! G OUT
 F XQL=0:XQLL S I=$O(^TMP($J,I)) Q:I=""  W !,?5,I
 ;
OUT ;Clean up and return
 K DA,DIC,I,X,Y,XQL,XQLL,XQU
 Q
