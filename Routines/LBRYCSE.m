LBRYCSE ;ISC2/DJM-COPY SPECIFIC EDITING ;[ 11/26/97  4:35 PM ]
 ;;2.5;Library;**2,9**;Mar 11, 1996
 I $G(LBRYPTR)="" D  I $G(LBRYPTR)="" W !!,$C(7),"No Site has been selected" Q
 . D ^LBRYASK
START W @IOF,?5,"VA Library Copy Specific Edit for "_LBRYNAM
 S Y=DT X ^DD("DD") W ?60,Y,! S YDT=Y
 S DIC="^LBRY(680,",DIC(0)="AEQZ",DIC("S")="I $P(^(0),U,4)=LBRYPTR&($P(^(0),U,2)="""")"
 D ^DIC K DIC("S") G:Y<0 CHOICE
 S (DA,LBRYLOC)=$P(Y,U),LBRYCLS=$P(Y,U,2)
 S (E,E0,E1)=1 D CON
 S LBUDT=0,XXZ=$P(^LBRY(680,LBRYLOC,0),U,2) G:XXZ]"" INCOM
 I '$D(A(1)) G INCOM
CONT W @IOF,?5,"VA Library Copy Specific Edit",?60,YDT
 W !,"TITLE: ",$P(^LBRY(680.5,LBRYCLS,0),U),! K LA
 S LA(1)="ID",LA(2)="COPY",LA(3)="START",LA(4)="STOP",LA(5)="NUM",LA(6)="DATE"
 W !,LA(1),?10,LA(2),?30,LA(3),?55,LA(4)
 W !,LA(5),?10,LA(5),?30,LA(6),?55,LA(6)
 G:'$D(A(1)) INACT
 S E1=E0 D FWD1^LBRYCK0
 F I=E0:1:E1 S AA=^LBRY(681,A(I),1),CN=$P(AA,U),START=$P(AA,U,10),STOP=$P(AA,U,11) D FIXIT W !,?1,I,?11,CN,?27,START,?52,STOP
 G ^LBRYCSE0
REMOVE S E=0 G:$L(X)>0 KILL0
KILL W !,"Select a number from 'ID NUM' column to REMOVE that COPY from this title: "
 S DTOUT=0 R X:DTIME E  W $C(7) S DTOUT=1 G START
 I X="" Q
KILL0 I X="^" Q
 I X="?" W !,"Choose the 'ID NUM' of the COPY you want to REMOVE." G KILL
 I '$D(A(X)) W !,"There is no COPY by this number." G KILL
 S CN=$P(^LBRY(681,A(X),1),U),X1=0,L1=""
 F  S L1=$O(^LBRY(682,"C",LBRYLOC,L1)) G:L1="" KILL1 S L2=$O(^LBRY(682,L1,4,"B",CN,0)) I L2'="" W !,"This COPY # may not be REMOVED only EDITED." G KILL
KILL1 S DIK="^LBRY(681,",DA=A(X) D ^DIK K DIK
 Q
QUERY S E=0 G:$L(X)>0 EDIT0
EDIT W !,"Select a number from 'ID NUM' column to EDIT that COPY: "
 S DTOUT=0 R X:DTIME E  W $C(7) S DTOUT=1 G CONT
 I X="" Q
 I X="^" Q
EDIT0 I X="?" W !,"Choose the 'ID NUM' of the COPY you want to EDIT." G EDIT
 I '$D(A(X)) W !,"There is no COPY by this number." G EDIT
 S LBRYX0=$G(^LBRY(680,LBRYLOC,7)),DA=A(X),DIE="^LBRY(681,"
 S DR=$S($D(LBRYPTR)&($P($G(^LBRY(680.6,LBRYPTR,0)),U,10)):"[LBRY D4]",1:"[LBRY D2]"),DIC=DIE D LOCK^LBRYEDR G:LBRYL=0 EXIT
 D ^DIE L  I $D(Y)!($D(DTOUT)) Q
 Q
ENTER S LBRYX0=$G(^LBRY(680,LBRYLOC,7))
ENTER1 I $L(X)>0,X="?" W !,"Use INSERT to add a new COPY to this title." S XZ="CONTINUE// " D PAUSE^LBRYUTL K XZ
 S X=$P(LBRYX0,U) I X="" D  Q
 . W !!,"This title has no INITIAL COPIES ORDERED information."
 . W !,"Go to Library Title Setup to correct this."
 . S XZ="Exit// " D PAUSE^LBRYUTL K XZ
 L ^LBRY(681,0) S X=^LBRY(681,0),X=$P(X,U,3) F  S X=X+1 I '$D(^LBRY(681,X,0)) L  Q
 K DO S DIC="^LBRY(681,",DIC(0)="LZ" D FILE^DICN L
 S DIE=DIC,DA=+Y,DR=$S($D(LBRYPTR)&($P($G(^LBRY(680.6,LBRYPTR,0)),U,10)):"[LBRY D4]",1:"[LBRY D2]") D LOCK^LBRYEDR G:LBRYL=0 EXIT
 D ^DIE L  I $D(Y)!($D(DTOUT)) Q
 Q
INCOM W !,"This title is "_$S(XXZ="C":"cancelled",XXZ="D":"a dead title",XXZ="R":"a renamed title",1:"not completely set up")_"."
 W:XXZ="" !,"Go to Library Title Setup (LTS) to finish setting up this title."
 S XZ="Continue// " D PAUSE^LBRYUTL K XZ
 G START
CON K A S (LX,A)=0
 F  S LX=$O(^LBRY(681,"AC",LBRYLOC,LX)) Q:LX=""  S NC="" D
 . F  S NC=$O(^LBRY(681,"AC",LBRYLOC,LX,NC)) Q:NC=""  S A=A+1,A(A)=NC
 Q
FIXIT S:START="" START="-----------" I START=+START S Y=START X ^DD("DD") S START=Y
 S:STOP="" STOP="-----------" I STOP=+STOP S Y=STOP X ^DD("DD") S STOP=Y
 Q
CHOICE I $D(LBRYNEW) I LBRYNEW=1 D EXIT G ^LBRYLST
 G EXIT
INACT S $P(^LBRY(680,LBRYLOC,0),U,2)="C",$P(^LBRY(680.5,LBRYLOC,0),U,2)=2
 W !!!,"Since you just removed the last copy for this title I am making this",!,"a CANCELLED TITLE.",!
NOT1 S XZ="EXIT//" D PAUSE^LBRYUTL K XZ
EXIT K YDT,E,E0,E1,A,I,X,Z,LX,LS,LBUDT,XXZ,LA,AA,CN,START,STOP,X1,X2,L1,L2
 K LBRYX0,LBRYNEW,DR,LBRYL,XZ,DIC,DIE,DIK,LBRYLOC,LBRYCLS
 Q
