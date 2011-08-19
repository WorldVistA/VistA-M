FHSEL1 ; HISC/REL/NCA/JH/RTK/FAI - Patient Preferences ;10/20/04  10:19
 ;;5.5;DIETETICS;**8**;Jan 28, 2005;Build 28
EN1 ; Enter/Edit Preference File entries
 I $G(FHALGMZ)=1 QUIT
 W ! S (DIC,DIE)="^FH(115.2,",DIC(0)="AEQLM",DIC("DR")=".01;1",DLAYGO=115.2 W ! D ^DIC K DIC,DLAYGO G KIL:U[X!$D(DTOUT),EN1:Y<1
 S (FHDA,DA)=+Y,DR=".01;26;1;S:X=""D"" Y=0;3;20;S:'X Y=99;21;27;99" D ^DIE K DA,DIE,DR
 I $P($G(^FH(115.2,FHDA,0)),"^",2)'="D"!($D(Y)) G EN1
TRAN R !!,"Do you want to import Recipes from another Food Preference? N // ",X:DTIME
 G:'$T!(X["^") EN1
 S:X="" X="N" D TR^FH I $P("YES",X,1)'="",$P("NO",X,1)'="" W *7,!,"  Answer YES or NO" G TRAN
 S ANS=X?1"Y".E G:'ANS DIS
T1 W ! K DIC S DIC="^FH(115.2,",DIC(0)="AEMQ",DIC("S")="I $P(^(0),U,2)=""D""" D ^DIC K DIC
 G KIL:"^"[X!($D(DTOUT)),T1:Y<1 S FHD=+Y
 S:'$D(^FH(115.2,FHDA,"X",0)) ^(0)="^115.21P^^"
 F DIS=0:0 S DIS=$O(^FH(115.2,FHD,"X",DIS)) Q:DIS<1  S L1=$G(^(DIS,0)) D ADD
DIS S DA=FHDA,DIE="^FH(115.2,",DR="10;27;99" D ^DIE K DA,DIE,DR G EN1
ADD ; Add dislikes recipes from another food preference
 I $D(^FH(115.2,FHDA,"X","B",+L1)) Q
A L +^FH(115.2,FHDA,"X",0)
 S FHX1=$G(^FH(115.2,FHDA,"X",0)),FHX2=$P(FHX1,"^",3)+1
 S $P(^FH(115.2,FHDA,"X",0),"^",3)=FHX2
 L -^FH(115.2,FHDA,"X",0) I $D(^FH(115.2,FHDA,"X",FHX2,0)) G A
 S $P(^FH(115.2,FHDA,"X",0),"^",4)=($P(FHX1,"^",4)+1)
 S ^FH(115.2,FHDA,"X",FHX2,0)=+L1
 S ^FH(115.2,FHDA,"X","B",+L1,FHX2)=""
 Q
EN2 ; List Preference File
 W ! K DIR S DIR("A")="Do you want to print recipes?: "
 S DIR(0)="YA",DIR("B")="Y" D ^DIR
 I $D(DIRUT) K %ZIS S IOP="" D ^%ZIS G KIL
 S FHALRC=Y I FHALRC=1 D EN2OLD Q
 I FHALRC=0 D EN2NEW Q
 Q
EN2OLD W ! S L=0,DIC="^FH(115.2,",FLDS="[FHSELIST]",BY="LIKE OR DISLIKE,NAME"
 S FR="@",TO="",DHD="PATIENT PREFERENCES" D EN1^DIP
 K %ZIS S IOP="" D ^%ZIS G KIL
EN2NEW W ! S L=0,DIC="^FH(115.2,",FLDS="[FHSELST2]",BY="LIKE OR DISLIKE,NAME"
 S FR="@",TO="",DHD="PATIENT PREFERENCES" D EN1^DIP
 K %ZIS S IOP="" D ^%ZIS G KIL
EN3 ; Enter/Edit Patient Preferences
 S FHALL=1 D ^FHOMDPA G:'FHDFN KIL D DISP S DA=FHDFN W !
 K PP F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0),PP(+X)=$P(X,"^",2,3)
 S DIE="^FHPT(",DR="[FHSEL]",DIE("NO^")="" D ^DIE K DIE S FLG=0
 S:$D(Y) FLG=1
 S STR="" F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0) S:$P(X,"^",2)="" STR=STR_K_"," S:$P(X,"^",2)'="" $P(PP(+X),"^",3,4)=$P(X,"^",2)_"^"_$P(X,"^",3)
 D N31 K PP
 I FLG,STR'="" D
 .S DA(1)=FHDFN F K=1:1 Q:'$P(STR,",",K)  S DA=$P(STR,",",K) D
 ..S DIK="^FHPT("_DA(1)_",""P""," D ^DIK
 ..Q
 .W *7,!,"<Preference deleted>" K DIK,DA Q
 G EN3
N31 F K=0:0 S K=$O(PP(K)) Q:K<1  D N33
 S KK=0,COM=""
N32 S KK=$O(PP(KK)) I KK<1 Q:COM=""  S EVT="P^O^^"_$E(COM,2,999) D ^FHORX Q
 I $L(COM)+$L(PP(KK))>120 S EVT="P^O^^"_$E(COM,2,999) D ^FHORX S COM=""
 S COM=COM_" "_PP(KK) G N32
N33 S X1=$P(PP(K),"^",1,2),X2=$P(PP(K),"^",3,4) I X1=X2 K PP(K) Q
 S X1=$S(X1="^":"Add",X2="":"Del",1:"Mod"),Q=$P(X2,"^",2)
 I X1["Mod" D
 .S NOD=$O(^FHPT(FHDFN,"P","B",K,0)) Q:NOD<1
 .S:$P($G(^FHPT(FHDFN,"P",NOD,0)),"^",4)="Y" $P(^FHPT(FHDFN,"P",NOD,0),"^",4)=""
 .Q
 S PP(K)=X1_" "_$S(X2="":"",Q:Q_" ",1:"1 ")_$P(^FH(115.2,K,0),"^",1) S:X2'="" PP(K)=PP(K)_" ("_$P(X2,"^",1)_")" Q
EN4 ; Display Patient Preferences
 S FHALL=1 D ^FHOMDPA G:'DFN KIL G:'FHDFN KIL D E41 G EN4
E41 ; Display Patient Header and Food Preferences
 D NOW^%DTC S NOW=%,DT=NOW\1
 S Y(0)=^DPT(DFN,0),SEX=$P(Y(0),"^",2),DOB=$P(Y(0),"^",3) D PID^FHDPA
 S AGE=$E(NOW,1,3)-$E(DOB,1,3)-($E(NOW,4,7)<$E(DOB,4,7))
 W @IOF,!,PID,?17,$P(Y(0),"^",1),?49,$S(SEX="M":"Male",SEX="F":"Female",1:""),?55,"Age ",AGE
DISP ; Display Food Preferences
 W !!?21,"Likes",?54,"DisLikes",!
 K P S P1=1 F K=0:0 S K=$O(^FHPT(FHDFN,"P",K)) Q:K<1  S X=^(K,0) D SP
 W ! S (M,MM)="" F  S M=$O(P(M)) Q:M=""  I $D(P(M)) W $P(M,"~",2) D  S MM=M
 .  S (P1,P2)=0 F  S:P1'="" P1=$O(P(M,"L",P1)) S X1=$S(P1>0:P(M,"L",P1),1:"") S:P2'="" P2=$O(P(M,"D",P2)) S X2=$S(P2>0:P(M,"D",P2),1:"") Q:P1=""&(P2="")  D P0  W:MM'=M !
 .  Q
 I $O(P(""))="" W !,"No Food Preferences on file",!
 Q
P0 I X1'="" W ?12 S X=X1 D P1 S X1=X
 I X2'="" W ?46 S X=X2 D P1 S X2=X
 Q:X1=""&(X2="")  W ! G P0
P1 I $L(X)<34 W X S X="" Q
 F KK=35:-1:1 Q:$E(X,KK-1,KK)=", "
 W $E(X,1,KK-2) S X=$E(X,KK+1,999) Q
SP Q:+X<1  S M1=$P(X,"^",2) Q:M1=""  S:M1="A" M1="BNE" S Z=$G(^FH(115.2,+X,0)) Q:$P(Z,U)=""!$P(Z,U,2)=""  S L1=$P(Z,"^",1),KK=$P(Z,"^",2),M="",DAS=$P(X,"^",4)
 I KK="L" S Q=$P(X,"^",3),L1=$S(Q:Q,1:1)_" "_L1
 I M1="BNE" S M="1~All Meals" G SP1
 S Z1=$E(M1,1) I Z1'="" S M=$S(Z1="B":"2~Break",Z1="N":"3~Noon",1:"4~Even")
 S Z1=$E(M1,2) I Z1'="" S M=M_","_$S(Z1="B":"Break",Z1="N":"Noon",1:"Even")
SP1 S:'$D(P(M,KK,P1)) P(M,KK,P1)="" I $L(P(M,KK,P1))+$L(L1)<255 S P(M,KK,P1)=P(M,KK,P1)_$S(P(M,KK,P1)="":"",1:", ")_L1_$S(DAS="Y":" (D)",1:"")
 E  S:'$D(P(M,KK,K)) P(M,KK,K)="" S P(M,KK,K)=L1_$S(DAS="Y":" (D)",1:"") S P1=K
 Q
KIL G KILL^XUSCLEAN
