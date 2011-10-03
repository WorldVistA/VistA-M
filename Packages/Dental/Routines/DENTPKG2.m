DENTPKG2 ;ISC2/SAW-INITIALIZE DENTAL PACKAGE CONTINUATION; 4/12/88  9:12 AM ; 10/7/88  4:05 PM ;
V ;;VERSION 1.2
226 I $P(X,"^")<2851001 D ^DIK Q
 S Z=$P(X,"^"),Z1=$P(Z,".") S X0=$S('$D(^DENT(226,DA,.1)):"",$P(^(.1),"^")="":"",1:^(.1))
 I Z<2871001,X0="" S X0=".5^2000101"
 S IEN=9999999-(Z1_"."_(9999-$E($P(Z,".",2)_"000",1,4))) K ^DENT(226,DA,0),^(.1)
 S ^DENT(226,IEN,0)=X S:X0'="" ^(.1)=X0 S ^DENT(226,"B",Z1,IEN)="",^DENT(226,"B1",Z,IEN)=""
 S X1=$P(X,"^",2),X2=$P(X,"^",3) S:X2'="" ^DENT(226,"C",X2,IEN)="" I X1 S ^DENT(226,"A1",X1,Z1,IEN)="" I X2'="" S ^DENT(226,"AC",X1,Z1,X2,IEN)=""
 I X1,X0="" S ^DENT(226,"A",X1,Z1,IEN)=""
 I Z>DATE S Y=X X ^DD("DD") S F=226 D N
 Q
N W !,"NOTE: You have an erroneous entry dated "_Y_" in file "_F_".",!,"Please correct it after the initialization is complete.",! Q
