DENTPKG ;ISC2/SAW-INITIALIZE DENTAL PACKAGE ; 11/2/88  5:18 PM ;
 ;VERSION 1.2
 S:'$D(^DENT("VERSION")) ^("VERSION")=0
 I ^DENT("VERSION")[1.2 W *7,!!,"You have already initialized version 1.2.  You cannot initialize it twice." W:^DENT("VERSION")="I1.2" *7,!!,"Your initialization was never completed.  Contact your local ISC for help." Q
 W !,"This routine will perform the following functions:",!!,?4,"1.  Initialize the new file structures for the Dental Package.",!,?4,"2.  Purge (delete) all old data prior to October 1985."
 W !,?4,"3.  Ensure that all data prior to October 1988 is marked as released.",!,?4,"4.  Convert the data in the Treatment Data and Non Clinical Time files to",!,?8,"appear in reverse date/time order whenever it is displayed."
ASK S U="^" W !!,"Are you sure you want to initialize the Dental Package" S %=2 D YN^DICN Q:%=2!(%<0)  I %=0 W !,"Answer 'YES' if you want to proceed with this initialization/conversion." G ASK
 ;INITIALIZE DENTAL PACKAGE FILES
 K ^DIC(220.2),^DIC(220.3) W !!,"First let me initialize the files used in the Dental Package",!! D ^DENTINIT
 S ^DENT("VERSION")="I1.2" W !!,"Next I need to run a database conversion." S X=$P(^DENT(221,0),"^",4),X=X+$P(^DENT(226,0),"^",4)
 W !,"This conversion takes approximately 1 minute per 366 entries to be converted.",!,"You have ",X," entries in files 221 and 226 that need to be converted, so"
 W !,"your conversion should take approximately ",$J(X/366,0,1)," minutes.",!!,"Begin file 221 conversion."
 D NOW^%DTC S DATE=X K %,%H,%I F I=222,223,224 S DA=0,DIK="^DENT("_I_"," F J=1:1 S DA=$O(^DENT(I,DA)) Q:DA'>0  D CHK
 K ^DENT(221,"A"),^DENT(221,"A1"),^DENT(221,"AC"),^DENT(221,"AC1"),^DENT(221,"B"),^DENT(221,"B1"),^DENT(221,"C"),^DENT(221,"D"),^DENT(221,"E"),^DENT(221,"AG")
 W ! S DA=0,DIK="^DENT(221," F I=0:1 S DA=$O(^DENT(221,DA)) Q:DA>1000000!(DA'>0)  S X=^(DA,0) D 221 W:I#100=0 "." W:I#1000=0 " "_I_" entries converted in file 221.",!
 W !,"File 221 conversion finished. "_I_" entries converted.",!!,"Begin file 226 conversion.",!
 I I S $P(^DENT(221,0),"^",3)=IEN
 K ^DENT(226,"A"),^DENT(226,"A1"),^DENT(226,"AC"),^DENT(226,"B"),^DENT(226,"B1"),^DENT(226,"C")
 W ! S DA=0,DIK="^DENT(226," F I=0:1 S DA=$O(^DENT(226,DA)) Q:DA>1000000!(DA'>0)  S X=^(DA,0) D 226^DENTPKG2 W:I#100=0 "." W:I#1000=0 " "_I_" entries converted in file 226.",!
 W !,"File 226 conversion finished. "_I_" entries converted.",!
 I I S $P(^DENT(226,0),"^",3)=IEN
 S ^DENT("VERSION")=1.2 W *7,!!,"Initialization of the Dental Package is complete." K %,DA,DATE,DIK,F,I,IEN,J,N,X,X0,X1,X2,X3,X4,Y,Z,Z1 Q
CHK S X=$P(^DENT(I,DA,0),"^") I X<2851001 D ^DIK Q
 G CHK1:X'<2871001 I '$D(^DENT(I,DA,.1)) S ^(.1)=".5^2000101" Q
 I $P(^DENT(I,DA,.1),"^")="" S ^(.1)=".5^2000101" Q
CHK1 I X>DATE S Y=X X ^DD("DD") S F=I D N
 Q
221 I $P(X,"^")<2851001 D ^DIK Q
 S Z=$P(X,"^"),Z1=$P(Z,"."),X0=$S('$D(^DENT(221,DA,.1)):"",$P(^(.1),"^")="":"",1:^(.1))
 I Z<2871001,X0="" S X0=".5^2000101"
 S IEN=9999999-(Z1_"."_(9999-$E($P(Z,".",2)_"000",1,4))) K ^DENT(221,DA,0),^(.1)
 S ^DENT(221,IEN,0)=X S:X0'="" ^(.1)=X0 S ^DENT(221,"B",Z1,IEN)="",^DENT(221,"B1",Z,IEN)=""
 S X1=$P(X,"^",40),X2=$P(X,"^",10) S:X2'="" ^DENT(221,"C",X2,IEN)="" I X1 S ^DENT(221,"A1",X1,Z1,IEN)="" I X2'="" S ^DENT(221,"AC1",X1,Z1,X2,IEN)=""
 I X1,X0="" S ^DENT(221,"A",X1,Z1,IEN)="" I X2'="" S ^DENT(221,"AC",X1,Z1,X2,IEN)=""
 I $P(X,"^",2)'="" S ^DENT(221,"D",$P(X,"^",2),IEN)=""
 I $P(X,"^",4) S ^DENT(221,"E",$P(X,"^",4),IEN)=""
 I $P(X0,"^",2),X1 S ^DENT(221,"AG",X1,$P(X0,"^",2),IEN)=""
 I Z>DATE S Y=X X ^DD("DD") S F=221 D N
 Q
N W !,"NOTE: You have an erroneous entry dated "_Y_" in file "_F_".",!,"Please correct it after the initialization is complete.",! Q
