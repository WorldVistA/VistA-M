LRBLDLG ;AVAMC/REG/CYM - BB DONOR LOG-IN ;1/29/97  12:48 ;
 ;;5.2;LAB SERVICE;**90,247,408**;Sep 27, 1994;Build 8
 ;Per VHA Directive 97-033 this routine should not be modified.  Medical Device # BK970021
 Q  D V^LRU S LR("SSN")=$P($G(^LAB(69.9,1,8,1,0)),U,5),LR("LRBLDLG")="",X="BLOOD BANK" D ^LRUTL G:Y=-1 END D EN1^LRBLY,D^LRBLU G:'$D(X) END
 W @IOF,?30,"Log-in donor visits",! I LRCAPA D Z^LRBLWD G:$D(LRX) END
 S %DT="AEX",%DT(0)="-N",%DT("A")="Enter DONATION DATE: TODAY// " D ^%DT K %DT I X="" S Y=DT W LRH(0)
 G:Y<1 END S (LRAD,X)=Y,LRI=9999999-Y D DW^%DTC W " ",X S:'$D(^LRO(69.2,LRAA,5,0)) ^(0)="^69.24A^0^0"
 W !!,"For a group of donors COLLECTION SITE & DONATION GROUP need be entered once.",!,"If not desired just press 'RETURN' key after the following two prompts.",!!
 S DIC=65.4,DIC("S")="I $P(^(0),U,2)[""C""",DIC("A")="Enter COLLECTION SITE: ",DIC(0)="AEQM" D ^DIC K DIC G:X[U END S LR=$S(Y=-1:"",1:+Y)
 S DIC=65.4,DIC(0)="AEQM",DIC("A")="Enter DONATION GROUP: ",DIC("S")="I $P(^(0),U,2)[""G""" D ^DIC K DIC G:X[U END S LR(1)=$S(Y=-1:"",1:+Y)
DNR K LRC,DIC,DIE,DR,DA,LR("CK")
 W !! S (DIC,DIE)="^LRE(",DIC(0)="AEQLMZ",DLAYGO=65,D="B^C^"_$S("NAFARMY"[DUZ("AG")&(DUZ("AG")]""):"G4^G",1:"D") D MIX^DIC1 K DIC,DLAYGO G:Y<1 END
 S (LRQ,DA)=+Y,(LRP,LRP(0))=$P(Y,U,2) I $P(Y,U,3) D ^LRBLD G:'$D(DA) DNR D ADD G OK
 S B=0 I $D(^LRE(DA,9)) S DIWR=IOM-5,DIWL=5,DIWF="W" S A=0 F B=0:1 S A=$O(^LRE(DA,9,A)) Q:'A  W:'B ! S X=^(A,0) D ^DIWP
 D:B ^DIWW W !,"Is this the Donor " S %=1 D YN^LRU G:%'=1 DNR
OK G:'$D(^LRE(LRQ,0)) DNR S X=^(0),X1=DT,(X2,LRD)=$P(X,"^",3),LRB=$E(X2,4,5)_"-"_$E(X2,6,7)_"-"_$E(X2,2,3),LRS(2)=$P(X,"^",13) D ^%DTC S X=X\365.25
 I X<18 W $C(7),!!,"Age:",X,"  Does donor have permission to donate " S %=1 D YN^LRU G:%'=1 DNR
 I X>64 W $C(7),"  Age: ",X,!?7,"Does donor have physician permission to donate " S %=1 D YN^LRU G:%'=1 DNR
 W @IOF S (DIE,DIC)="^LRE(",DA=LRQ,DR="0;1;2;4" D EN^DIQ
 I $P(^LRE(LRQ,0),U,10) W $C(7),!!,$P(^(0),U)," permanently deferred except for autologous",!,"or therapeutic donation.  If any questions see physician in charge.",!!,"Do you want autologous/therapeutic donation " S %=2 D YN^LRU G:%'=1 DNR
 I LR("SSN"),$P(^LRE(LRQ,0),U,13)="" S DA=LRQ,DR=.13,DIE="^LRE(" D ^DIE
 W !,"EDIT above information: " S %=2 D YN^LRU G:%<1 DNR I %=1 K DR D CK^LRU G:$D(LR("CK")) DNR S DR="[LRBLDEMO]" D ^DIE D FRE^LRU G OK
 S X=$O(^LRE(LRQ,5,0)) I X S Y=+^(X,0) D D^LRU W "  Last visit: ",Y
 S:'$D(^LRE(LRQ,5,0)) ^(0)="^65.54DA^^" I '$D(^(LRI,0)) L +^LRE(LRQ,5) S X=$P(^LRE(LRQ,5,0),"^",4),^(0)="^65.54DA^"_LRI_"^"_(X+1),^(LRI,0)=LRAD_"^^^^^"_LR_"^"_LR(1),^LRE("AD",$P(LRAD,"."),LRQ)="" L -^LRE(LRQ,5)
 S (LR(65.54,1),LR(65.54,1.1),LRA)="",DA=LRI,DA(1)=LRQ,DIE="^LRE(LRQ,5,"
A S DR=".02;.03;.13//^S X=""NOW"";1//^S X=""WHOLE BLOOD"";S LR(65.54,1)=X;S:X=""N"" Y=2;1.1//^S X=""HOMOLOGOUS"";S LR(65.54,1.1)=X;S:X=""A"" LRA=LRP;S LRT=X;S:""AD""'[X Y=0;W !!;1.2//^S X=LRA;S Y=0;2"
 D ^DIE I $D(Y) G:$P(^LRE(LRQ,5,LRI,0),U,4)]"" DNR W $C(7),!!,"Delete all data from this donation " S %=2 D YN^LRU G:%'=1 A S DA=LRI,DIK="^LRE(LRQ,5," D ^DIK K DIK G DNR
 I LR(65.54,1.1)="A",'$P(^LRE(LRQ,5,LRI,0),U,12) W $C(7),!!,"Autologous donation and RESTRICTED FOR: field not entered.",!,"Delete all data from this donation " S %=2 D YN^LRU G:%'=1 A S DA=LRI,DIK="^LRE(LRQ,5," D ^DIK K DIK G DNR
 I LR(65.54,1)="N" D EN^LRBLY D:LRCAPA N^LRBLWD G DNR
 S LR(65.54)=LR(65.54,1.1)_LR(65.54,1),X1=9999999-LRI,X2=-55 D C^%DTC S Z(1)=9999999-X
 F X=LRI:0 S X=$O(^LRE(LRQ,5,X)) Q:'X!(X>Z(1))  S Y=$P(^(X,0),"^",2) I LR(65.54,1)="W",LR(65.54,1.1)="H",Y="W" W !!,"LAST WHOLE BLOOD DONATION " S LRC=1,(Y,Z)=+^(0) D D^LRU W Y Q
 I $D(LRC) S X1=LRAD,X2=Z D ^%DTC I X<56 W $C(7),!!,"SORRY NOT 8 WEEKS SINCE LAST DONATION OF WHOLE BLOOD" S X1=Z,X2=56 D C^%DTC S Y=X D D^LRU W !,"COME BACK ON OR AFTER ",Y D RES D:LRCAPA N^LRBLWD G DNR
 I LRCAPA D @(LR(65.54)_"^LRBLWD")
 D EN^LRBLY W !,"Enter donor in list for printing registration form " S %=2 D YN^LRU G:%'=1 MORE
 S ^LRO(69.2,LRAA,5,LRQ,0)=LRQ_"^65.5^"_LRP,^LRO(69.2,LRAA,5,"C",LRP,LRQ)="" G DNR
MORE W !!,"Continue to enter collection information " S %=1 D YN^LRU G:%'=1 DNR
 K DA,DR,DIE,DIC,DR,DQ S (DIC,DIE)="^LRE(",DA=LRQ,DR="[LRBLDCPN]" D ^DIE G DNR
ADD S DR=$S(LRH(2):"[LRBLDNEWM]",1:"[LRBLDNEW]") D ^DIE Q
RES S X=^LRE(LRQ,5,LRI,0),^(0)=$P(X,"^")_"^"_"N"_"^"_$P(X,"^",3,99) Q
END D V^LRU Q
