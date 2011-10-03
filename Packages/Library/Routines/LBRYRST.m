LBRYRST ;ISC2/DJM-REMOVE SERIALS TITLE ;[ 05/23/97  12:13 PM ]
 ;;2.5;Library;**2**;Mar 11, 1996
 I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" Q
 . D ^LBRYASK
START W @IOF,?5,"VA Library Serials Remove a Title for "_LBRYNAM
 D NOW^%DTC S Y=X X ^DD("DD") W ?60,Y,! S YDT=Y,DIC="^LBRY(680.5,"
 S DIC(0)="AEMQZ",DIC("A")="Please select TITLE to remove: "
 D ^DIC
 K DIC("A") G:Y<0 EXIT1 S LBRYCLS=+Y,LBRTDA=""
 F  S LBRTDA=$O(^LBRY(680,"B",LBRYCLS,LBRTDA)) Q:LBRTDA=""  D
 . I $P(^LBRY(680,LBRTDA,0),U,4)=LBRYPTR S LBRYLOC=LBRTDA Q
 I $G(LBRYLOC)="",$O(^LBRY(680,"B",LBRYCLS,0))'="" D  G EXIT
 . W !!,"** You do not have any holdings on file, but another site does **",!!
 . R !,"Press return to continue: ",LBRC:DTIME
 I $O(^LBRY(680,"B",LBRYCLS,0))="" W ! G DIE2
 S LA0="TITLE: "_$P(^LBRY(680.5,LBRYCLS,0),U,1)
 W @IOF,?5,"VA Library Serials Remove a Title",?60,YDT,!!,LA0
WARN W !!,"Removing this journal deletes it completely from the LOCAL SERIALS file."
 I $G(LBRYLOC)="" Q
 S LBRYDA=$O(^LBRY(681,"AC",LBRYLOC,0))
 W:LBRYDA]"" !,"This will include data in the LBRY DISPOSITION file."
 S LBRYDAT1=$O(^LBRY(682,"AC",LBRYLOC,0))
 W:LBRYDAT1]"" !,"This will include data in the LBRY ISSUE file."
DIE W !!,"Do you want to remove this journal"
 S %=2 D YN^DICN G:%=2 LBRYRST G:%=1 DIE1 G:%=-1 EXIT
 W !!,"Answer YES to remove this journal from the data base."
 W !,"Answer NO or <CR> to exit."
 G DIE
DIE1 W !! F I=1:1:79 W "*"
 W !,?9,"***WARNING***",?33,"***WARNING***",?57,"***WARNING***",!!
 W "All data about this title, i.e., holdings, check-in and copy information will"
 W !,"be REMOVED from the system upon title deletion.  You may wish to set this"
 W !,"title INACTIVE in Library Title Setup (LTS) instead.",!!
DIE2 W $C(7),$C(7),$C(7),$C(7),$C(7),!,"DO YOU REALLY WANT TO REMOVE THIS JOURNAL "
 S %=2 D YN^DICN G:%=2 LBRYRST G:%=1 DOIT G:%=-1 EXIT
 W !,"Enter <CR> to do nothing or enter Y(es) if you are certain you wish to"
 W !,"REMOVE all data about this title from the module."
 G DIE2
DOIT W !!,"Please be patient, this may take a few moments."
 I $G(LBRYDAT1)="" G DOIT1
 S DIK="^LBRY(682,",RMV=0
 F  S RMV=$O(^LBRY(682,"AC",LBRYLOC,RMV)) Q:RMV=""  D
 . S DA=$O(^LBRY(682,"AC",LBRYLOC,RMV,0)) D ^DIK
DOIT1 I $G(LBRYLOC)="" G DOIT2
 S DIK="^LBRY(681,",DA=0
 F  S DA=$O(^LBRY(681,"C",LBRYLOC,DA)) Q:DA=""  D:DA'="" ^DIK
 S DIK="^LBRY(680,",DA=LBRYLOC D ^DIK
DOIT2 I $G(LA0)="" S LA0=$P(^LBRY(680.5,LBRYCLS,0),U)
 S LA0=$E(LA0,1,70) W !!,LA0," Removed.",!
 I $O(^LBRY(680,"B",LBRYCLS,""))="" D DEL
 S XZ="EXIT//" D PAUSE^LBRYUTL K XZ
EXIT K LA0,LBRYCLS,LBRTDA,LBRC
 G START
EXIT1 K Y,YDT,DIC,I,LA0,LBRYDA,LBRYDAT1,%,DIK,RMV,LBRTDA,LBRYCLS,LBRYLOC
 Q
DEL S DA=LBRYCLS,DIK="^LBRY(680.5," D ^DIK
 N ZTSK,ZTDTH,ZTUCI,ZTSAVE,ZTIO,ZTDESC,ZTRTN
 S (ZTSAVE("LA0"),ZTSAVE("LBRYCLS"))="",ZTRTN="REM^LBRYRST"
 S ZTDTH=$H,ZTIO="",ZTDESC="LIBRARY REMOVE TITLE" D ^%ZTLOAD
 Q
REM S N=0
REM1 S N=$O(^LBRY(680.5,N)) Q:N'>0
 I $P($G(^LBRY(680.5,N,3)),U,6)=LBRYCLS S $P(^(3),U,6)=LA0_"*"
 I $P($G(^LBRY(680.5,N,3)),U,7)=LBRYCLS S $P(^(3),U,7)=LA0_"*"
 G REM1
