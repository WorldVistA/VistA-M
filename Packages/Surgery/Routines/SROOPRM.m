SROOPRM ;B'HAM ISC/KKA - UPDATE NORMAL O.R. HOURS ; [ 07/27/98   2:33 PM ]
 ;;3.0; Surgery ;**11,50**;24 Jun 93
BEGIN ;
 S SRLINE="" F C=1:1:80 S SRLINE=SRLINE_"="
LKUPRM ;*****get internal entry number of o.r.***** 
 S (SRSOUT,SRCHNG,SRSTOP,SRWRONG)=0,SRSAVE=""
 W @IOF,!,SRLINE,!,?15,"Normal Daily Schedules for Operating Rooms",!,SRLINE,!
 K DIC S DIC=131.7,DIC(0)="QEAMZ",DIC("S")="I $$ORDIV^SROUTL0(+Y,$G(SRSITE(""DIV""))),$P(^SRS(+Y,0),U)",DIC("A")="Enter the name of the operating room: " D ^DIC S SRENT=+Y K DIC G:SRENT<0 END S SRREC=Y(0) W !
FDAY ;*****start with sunday and follow w/ consec days until user changes
 D SETUP F SRD=0:1:6 Q:SRSOUT!(SRCHNG)!(SRSTOP)  S X=SRD D DAY
 I SRCHNG F  Q:SRSOUT!(SRSTOP)  S SRCHNG=0 D CHNG
RPTRM G LKUPRM
END W @IOF D ^SRSKILL Q
DAY ;*****get internal entry number of day to be edited*****
 K DIC S DIC="^SRS("_SRENT_",4,",DIC(0)="MZ" D ^DIC S SRDAY=+Y K DIC S:SRDAY<0 SRWRONG=1 S:'SRWRONG SREXT=Y(0,0),SRSAVE=$P(Y(0),"^"),SRNEW=SRSAVE+1
 I SRWRONG S SRWRONG=0,X=SRSAVE W !!,"Day entered not valid.",!,"Press RETURN to continue: " R SRANS:DTIME G DAY
EDIT ;*****dispay heading and choices*****
 Q:SRSOUT  W @IOF,!,?10,"Editing the ",SREXT," Schedule for the ",$P(^SC($P(SRREC,"^",1),0),"^",1)," Operating Room",!,SRLINE,!
 S SRNDE=^SRS(SRENT,4,SRDAY,0),SRNST=$P(SRNDE,"^",2),SRNET=$P(SRNDE,"^",3),SRIN=$P(SRNDE,"^",4)
 S:SRNST'="" SRNST=$E(SRNST,1,2)_":"_$E(SRNST,3,4) S:SRNET'="" SRNET=$E(SRNET,1,2)_":"_$E(SRNET,3,4) S:SRIN'="" SRIN=$S(SRIN=0:"NO",SRIN=1:"YES")
 W !,"1. Normal Start Time: ",?24,SRNST,!,"2. Normal End Time: ",?24,SRNET,!,"3. Inactive (Y/N):",?24,SRIN,!!,SRLINE,!
CHOICE ;*****find out user's choice*****
 S SRGOOD=1
 W !!,"Select information to edit: " R SRCH:DTIME I '$T!(SRCH="^") S SRSOUT=1 Q
 I SRCH["^" S X=$P(SRCH,"^",2),SRCHNG=1 D:$L(X)=1&($E(X)="T") T^SROOPRM1 D:$L(X)=1&($E(X)="S") S^SROOPRM1 S SRCH="^"_X
JUMP I SRCH["^" S X=$P(SRCH,"^",2) K DIC S DIC="^SRS("_SRENT_",4,",DIC(0)="MZ" D ^DIC K DIC S X=$P(Y,"^",2) D:X="" SETUP G:X="" JUMP G DAY
 S:X=6 SRSTOP=1 S:($E(X,1,2))="SA" SRSTOP=1
 Q:SRCH=""  I SRCH="A"!(SRCH="ALL") S SRCH="1:3"
 I SRCH'[":",(SRCH'?1N) D HELP^SROOPRM1 Q:SRSOUT  G EDIT
 I SRCH?1N S SRCKNM=SRCH I SRCKNM<1!(SRCKNM>3)!($E(SRCKNM)'=SRCKNM) D HELP^SROOPRM1 Q:SRSOUT  G EDIT
 I SRCH[":" S SR1=$P(SRCH,":"),SR2=$P(SRCH,":",2) I SR1<1!(SR2>3)!(SR1>SR2) D HELP^SROOPRM1 Q:SRSOUT  G EDIT
 I SRCH[":" W !! D PL G EDIT
 S SRNUM=SRCH W !! D UPDATE G EDIT
 G LKUPRM
 Q
PL ;*****update more than one characteristic*****
 F SRC=SR1:1:SR2 S SRNUM=SRC D UPDATE Q:SRSOUT
 Q
UPDATE ;*****update one characteristic*****
 K DA,DIE,DR S DIE="^SRS("_SRENT_",4,",DA(1)=SRENT,DA=SRDAY,DR=SRNUM_"T" D ^DIE K DA,DIE,DR
 I SRNUM=1,$P(^SRS(SRENT,4,SRDAY,0),"^",2)'="",$P(^(0),"^",3)'="",$P(^(0),"^",2)'<$P(^(0),"^",3) W !!,"Normal Starting Time must be earlier than Normal Ending Time.",! D DEL G UPDATE
 I SRNUM=2,$P(^SRS(SRENT,4,SRDAY,0),"^",3)'="",$P(^(0),"^",2)'="",$P(^(0),"^",3)'>$P(^(0),"^",2) W !!,"Normal Ending Time must be later than Normal Starting Time.",! D DEL G UPDATE
 Q
CHNG ;*****loop through days of week starting with user's day of choice***
 F SRNEWC=SRNEW:1:6 Q:SRCHNG!(SRSOUT)!(SRSTOP)  S X=SRNEWC D DAY
 Q
DEL ; delete absurd times
 S DIE="^SRS("_SRENT_",4,",DA(1)=SRENT,DA=SRDAY,DR=SRNUM_"///@" D ^DIE
 Q
SETUP ; add the days of the week if they do not exist
 F SRDAY=0:1:6 I '$D(^SRS(SRENT,4,"B",SRDAY)) K DA,DD,DO,DIC S DIC="^SRS("_SRENT_",4,",DIC(0)="LMZ",DIC("P")=$P(^DD(131.7,11,0),"^",2),DA(1)=SRENT,X=SRDAY D FILE^DICN
 K DA,DIC,DD,DO
 Q
