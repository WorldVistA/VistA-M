ONCOSCF ;WASH ISC/SRR,MLH-COMPUTED FIELDS FOR STATISTICS FILE ;8/21/93  10:40
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 ;
FIL ;GET FILE # AND NAME
 S DIC(0)="AEQZ",DIC="^DIC(",DIC("A")="    Select File to Search: ",DIC("S")="I (Y\1=160)!((Y'<164)&(Y<170))" D ^DIC G EX:Y="^",EX:Y=-1 S $P(^ONCO(166,D0,0),U,2,3)=Y G EX ;,D="AC"
 Q
 D IX^DIC
ROW ;GET ROW
 S FIL=$P(^ONCO(166,D0,0),U,2),DIC="^DD("_FIL_",",DIC(0)="AEQ",DIC("A")="   Select ROW field: " D ^DIC G EX:Y="^" G EX:Y=-1 S $P(^ONCO(166,D0,0),U,4,5)=Y G EX
COL ;COLUMN NAME & NUMBER
 S FIL=$P(^ONCO(166,D0,0),U,2),DIC="^DD("_FIL_",",DIC(0)="AEQZ",DIC("A")="     Select Column field: " D ^DIC G EX:Y="^",EX:Y=-1 S $P(^ONCO(166,D0,0),U,6,7)=Y W ^(0),!
 ;
TEM ;TEMPLATE LOOKUP
 S DIC("A")="     Select Search Template: ",DIC(0)="AEQZ",DIC="^DIBT(",D="F"_$P($G(^ONCO(166,D0,0)),U,2) G EX:D="F" D IX^DIC G EX:Y="^",EX:Y=-1 S $P(^ONCO(166,D0,0),U,8,9)=Y G EX
EX ;EXIT
 K XX,XN,FIL,DIC
