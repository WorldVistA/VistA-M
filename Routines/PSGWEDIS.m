PSGWEDIS ;BHAM/CML-Input AOU 'INPATIENT SITE' field ; 07/19/90 10:27
 ;;2.3; Automatic Replenishment/Ward Stock ;;4 JAN 94
START ;
 W !!,"This option will loop thru the PHARMACY AOU STOCK FILE (#58.1) and",!,"locate all ""ACTIVE"" AOUs that do not have an INPATIENT SITE defined." S EDFLG=0
 S AOU="" F JJ=0:0 S AOU=$O(^PSI(58.1,"B",AOU)) Q:AOU=""  S LL=$O(^PSI(58.1,"B",AOU,0)) Q:'LL  I $S('$D(^PSI(58.1,LL,"SITE")):1,'^("SITE"):1,1:0) I $S('$D(^PSI(58.1,LL,"I")):1,'^("I"):1,^("I")>DT:1,1:0) D ED I EDFLG="^" D WARN G QUIT
 I 'EDFLG W *7,!!,"ALL ACTIVE AOUs HAVE INPATIENT SITE DEFINED!!" G QUIT
 W *7,!!,"LOOP COMPLETED!"
QUIT K AOU,EDFLG,LL,D,D0,DA,DI,DIC,DISYS,DQ,DR,JJ,X,Y Q
ED ;
 Q:'$D(^PSI(58.1,LL,0))  W !!,"=> ",AOU S DIE="^PSI(58.1,",DA=LL,DR=4 D ^DIE K DIE S EDFLG=1 I $D(Y) S EDFLG="^" Q
 Q
WARN ;
 W *7,!!,"LOOP INTERRUPTED!",!!,"      *** Please complete this editing soon, it is VERY IMPORTANT that ***",!,"      *** all your AOUs have the INPATIENT SITE field defined.         ***" Q
