XQ6 ;SEA/AMF,SLC/CJS- BULK KEY DISTRIBUTION ;2/14/95  12:47
 ;;8.0;KERNEL;;Jul 10, 1995
EN1 S XQAL=1,XQDA=0 G INIT ; ENTRY POINT TO ACTIVATE KEY (XUKEYALL)
EN2 S XQAL=0,XQDA=0 G INIT ; DE-ALLOCATE ACTIVE KEY (XUKEYDEALL)
EN3 S XQAL=1,XQDA=1 G INIT ; DELEGATE KEYS (XQKEYDEL)
EN4 S XQAL=0,XQDA=1 ;REMOVE DELEGATED KEYS (XQKEYRDEL)
INIT ;
 K XQKEY,XQHOLD S (XQKEY(0),XQHOLD(0),XQBOSS)=0
KEY ;
 S:'$D(XQDA) XQDA=0 S XQBOSS=0 S:(DUZ(0)="@"!($D(^XUSEC("XUMGR",DUZ)))) XQBOSS=1
 I 'XQBOSS,$O(^VA(200,DUZ,52,0))'>0 W !,"You've nothing to allocate.  See your package coordinator or site manager." G OUT
 W !!,$S($O(XQKEY(0))>0:"Another",XQAL&XQDA:"Delegate",XQAL:"Allocate",'XQAL&XQDA:"Remove delegated",1:"De-allocate")," key: " R X:DTIME S:'$T X=U G:X[U OUT
 I '$L(X) G:($O(XQKEY(0))'>0) OUT G HOLDER
 I X["?" S XQH="XQKEYALLOCATE-KEY" D:X="?" EN^XQH D:X="??" LSTKEY^XQ6A D:X="???" KEYFIL^XQ6A G KEY
 S XQM=0 S:"-"[$E(X,1) X=$E(X,2,999),XQM=1
 S DIC=19.1,DIC(0)="EZM" S:'XQBOSS DIC("S")="I $D(^VA(200,DUZ,52,+Y,0))" D ^DIC K DIC I Y<0 W " ??",*7 G KEY
 I XQM W $S($D(XQKEY(+Y)):"  Deleted from current list",1:$C(7)_" ??  Key not on list") K XQKEY(+Y) G KEY
 S XQKEY(+Y)="" I $D(^DIC(19.1,+Y,3,0)),$P(^(0),U,4)>0 D MORE
 G KEY
 ;
MORE ;Handles subordinate or exploding keys
 W !!,"There are subordinate keys, do you wish to add them" S %=2 D YN^DICN I %=-1!(%=2) Q
 I %=0 W !!,"If you answer 'YES', the subordinate keys will be listed and added." G MORE
 F XQI=0:0 S XQI=$O(^DIC(19.1,+Y,3,XQI)) Q:XQI'>0  S XQJ=+^(XQI,0),XQKEY(XQJ)="" W !,$P(^DIC(19.1,XQJ,0),"^"),"  ",$P(^(0),U,2)
 Q
HOLDER ;Continue in next routine
 G HOLDER^XQ6A
 ;
OUT K %,DA,DIC,DIE,DR,XMDUZ,XQBOSS,XQKEY,XQAL,XQHOLD,XQI,XQJ,XQK,XQDA,XQSBNFDT,XQH,XQM,XQNM,X,Y
 Q
SHOW ;Show the users of a particular key
 K ^TMP($J) S XQL=1,DIC="^DIC(19.1,",DIC(0)="AEQMZ",DIC("A")="   Which key? " W ! D ^DIC I Y'>0 K DIC,XQL Q
 S XQKEY=$P(Y,U,2) I '$D(^XUSEC(XQKEY)) W !!,"There are no holders of this key." K DIC,XQKEY Q
 W @IOF,?15,"Current holders of the key ",XQKEY,!!
 S %=0 F XQI=0:0 S %=$O(^XUSEC(XQKEY,%)) Q:%=""  I $D(^VA(200,+%,0)) S ^TMP($J,$P(^VA(200,+%,0),U))=""
 S %="" F XQI=1:1 S %=$O(^TMP($J,%)) Q:%=""  W !,% D:'(XQI#16) PAUSE Q:X[U
 K ^TMP($J),%,DIC,XQI,XQL,XQKEY
 Q
PAUSE ;Hold the screen
 W !!?5,"Hit RETURN to continue or '^' to stop: " R X:DTIME S:'$T X=U
 I X'[U,XQL W @IOF,?15,"Current holders of the key ",XQKEY,!!
 Q
LIST ;List all the keys of a given user
 K ^TMP($J) S XQL=0,DIC="^VA(200,",DIC(0)="AEQMZ",DIC("A")="   User's name: " W ! D ^DIC I Y'>0 K DIC Q
 S %=$P(Y,U,2),XQUSER=$P(%,",",2)_" "_$P(%,","),XQU=+Y
 I $D(^VA(200,XQU,52,0)),$P(^(0),U,2)["200.051" S $P(^(0),U,2)="200.052PA" D MESS ;This corrects a Kv7 problem can be removed after Kv8
 S %=0 F XQI=0:1 S %=$O(^VA(200,XQU,51,"B",%)) Q:%=""  S:$D(^DIC(19.1,%,0)) ^TMP($J,$P(^DIC(19.1,%,0),U))=""
 W @IOF S XQK=5 I XQI=0 W !!,XQUSER," does not currently hold any keys."
 I XQI>0 W !!,XQUSER," currently holds:",! S %="" F XQI=0:1 S %=$O(^TMP($J,%)) Q:%=""  W:'(XQI#XQK) ! W ?(XQI#XQK*16),%
 K ^TMP($J) S %=0 F XQI=0:1 S %=$O(^VA(200,XQU,52,"B",%)) Q:%=""  S:$D(^DIC(19.1,%,0)) ^TMP($J,$P(^DIC(19.1,%,0),U))=""
 I XQI>0 W !!!,XQUSER," may delegate the following keys:",! S %="" F XQI=0:1 S %=$O(^TMP($J,%)) Q:%=""  W:'(XQI#XQK) ! W ?(XQI#XQK*16),%
 K ^TMP($J),%,DIC,XQI,XQK,XQL,XQU,XQUSER
 Q
 ;
ATOD ;Convert all of a users allocated keys to delegated keys
 S DIC="^VA(200,",DIC(0)="AEQMZ",DIC("A")="  User's name: " W ! D ^DIC I Y'>0 K DIC Q
 S %=$P(Y,U,2),XQUSER=$P(%,",",2)_" "_$P(%,","),XQU=+Y
 S %=$P($G(^VA(200,XQU,51,0)),U,4) I %'>0 W !!,XQUSER," does not hold any keys to transfer." K XQUSER,XQU,Y G ATOD
 I $D(^VA(200,XQU,52,0)),$P(^(0),U,4)>0 W !!,XQUSER," already has some delegated keys." S DIR(0)="YA",DIR("A")=" Shall I merge the two sets? Y/N ",DIR("B")="N" D ^DIR I Y=0!$D(DIRUT) K DIR,DIRUT,XQUSER,XQU,Y G ATOD
 S %X="^VA(200,"_XQU_",51,",%Y="^VA(200,"_XQU_",52," D %XY^%RCR
 S $P(^VA(200,XQU,52,0),U,2)="200.052PA"
 S DIK="^VA(200,"_XQU_",52,",DIK(1)=".01^B",DA=52,DA(1)=XQU D ENALL^DIK
 K %,%X,%Y,DA,DIC,DIK,DIR,XQU,XQUSER,X,Y
 Q
 ;
MESS ;Correct problems with key cross-references from 7.0 %RCR above.
 S DA(1)=XQU F XQFIL=51,52 D
 .K ^VA(200,DA(1),XQFIL,"B")
 .S DA=0,DIK="^VA(200,"_DA(1)_","_XQFIL_","
 .F  S DA=$O(^VA(200,DA(1),XQFIL,DA)) Q:DA'=+DA  D IX^DIK
 .Q
 K DA,DIC,DIK,XQDUZ,XQFIL
 Q
