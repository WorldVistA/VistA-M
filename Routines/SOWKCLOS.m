SOWKCLOS ;B'HAM ISC/SAB-Routine to close and then possible discharge of case ; 01 Mar 94 / 1:42 PM
 ;;3.0; Social Work ;**2,9,20,21**;27 Apr 93
 S OUT=0 S TY="I $D(^SOWK(650,""W"",DUZ,+Y)),'$P(^SOWK(650,+Y,0),""^"",18)",TY1="I (12378[$E($P($G(^VA(200,DUZ,654)),""^"",5))!($D(^SOWK(650,""W"",DUZ,+Y))))&'$P(^SOWK(650,+Y,0),""^"",18)"
BEG S PRI=$P(^SOWK(650.1,1,0),"^",19),DIC("S")=$S(PRI:TY1,1:TY)
 S DIC("A")="SELECT PATIENT: ",DR="[SOWKCLOT]",(DIC,DIE)="^SOWK(650,",DIC(0)="AEQM"
 D ^DIC G:"^"[$E(X) K G:Y'>0 BEG S (DA,CN)=+Y,P=$P(^SOWK(650,DA,0),"^",8),SWSW=$P(^(0),"^",3),SWSITE=$P(^(0),"^",5) W !! D ^DIE I $D(Y) W !!,*7,"INCOMPLETE CLOSING INFORMATION!!  INFORMATION DELETED." G DC
 K ^SOWK(650,"AC",P,SWSW,SWSITE)
 I $P(^SOWK(651,$P(^SOWK(650,CN,0),"^",13),0),"^",6)="R" F A=0:0 S A=$O(^SOWK(655,P,4,A)) Q:'A!(OUT)  I $P(^SOWK(655,P,4,A,0),"^",5)=CN,'$P(^(0),"^",6) G ED
CL F Q=0:0 W !!,"DO YOU WANT TO CLOSE ANOTHER CASE" S %=2 D YN^DICN Q:%  I %Y["?" D YN^SOWKHELP
 G:%=2 K G:%=-1 K
 G BEG
K K TY,TY1,PRI,A,CN,Q,%,%Y,CS,DIC,DA,DIE,DR,DB,X,Y,P,SWSW,SWSITE Q
DE S $P(^SOWK(655,P,4,A,0),"^",3)="",$P(^(0),"^",4)="",$P(^SOWK(655,P,0),"^",3)="",$P(^(0),"^",4)="",$P(^SOWK(650,CN,0),"^",18,22)="^^^^" K ^SOWK(650,CN,1) K:'$P(^SOWK(650.1,1,0),"^",23) ^SOWK(650,CN,2) S ^SOWK(650,"AC",P,SWSW,SWSITE,CN)=""
 G CL
 Q
ED D DISP Q:OUT  S DA=A,DA(1)=P,DIE="^SOWK(655,"_DA(1)_",4,",DR="3;I 'X S Y=""@4"";4;@4" D ^DIE I $D(Y) W !!,*7,"INCOMPLETE CLOSING DATA!!  DATA DELETED.",! G DE
 S DA=P,DIE="^SOWK(655,",DR="3;I 'X S Y=""@4"";2;@4" D ^DIE I $D(Y) W !!,*7,"INCOMPLETE CLOSING DATA!! DATA DELETED." G DE
 G CL
 Q
DC K ^SOWK(650,"ACD",$S($P($G(^SOWK(650,CN,0)),"^",18):$P(^(0),U,18),1:0),CN)
 S $P(^SOWK(650,CN,0),"^",18,22)="^^^^" K ^SOWK(650,CN,1) K:'$P(^SOWK(650.1,1,0),"^",23) ^SOWK(650,CN,2) K:'$P(^SOWK(650.1,1,0),"^",24) ^SOWK(650,CN,5) S ^SOWK(650,"AC",P,SWSW,SWSITE,CN)="" G CL
 Q
 G CL
 Q
DB W *7,!!,"The Closing Note Summary in the Data Base Assessment file",!,"must be complete before attempting to close case !!",! G CL
DISP ;disposition from RCH
 S DIE=650,DR="20",DA=CN D ^DIE K DIE I $D(Y) W !!,*7,"INCOMPLETE CLOSING INFORMATION!!  INFORMATION DELETED." S OUT=1 D DC
 Q
