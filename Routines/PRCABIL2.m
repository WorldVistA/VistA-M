PRCABIL2 ;SF-ISC/YJK-ENTER BILL INFO ;5/11/94  9:41 AM
 ;;4.5;Accounts Receivable;**158**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN8 ;Amend the bill returned from Fiscal.
 N PRCABILN,PRCAKSTA,RCAMEND
EN80 D SVC^PRCABIL Q:'$D(PRCAP("S"))  S DIC("S")="S Z0=$S($D(^PRCA(430.3,+$P(^(0),U,8),0)):$P(^(0),U,3),1:0) I (Z0=230)!(Z0=220),$D(^PRCA(430,Y,100)),+^(100),+$P(^(100),U,2)="_PRCAP("S")
 D BILLN^PRCAUTL G Q:'$D(PRCABN) S PRCABILN=PRCABN,PRCAKSTA=PRCA("STATUS")
 I $P(^PRCA(430.3,+PRCAKSTA,0),U,3)=230 S RCAMEND=""
 D EN^PRCABIL1
 S PRCABN=PRCABILN K PRCABILN D:",220,230,"[(","_$P(^PRCA(430.3,+PRCAKSTA,0),U,3)_",") EN81 K PRCAKSTA
 G EN80
EN81 W !!,"Now amending bill...",!
 S PRCA("STATUS")=$O(^PRCA(430.3,"AC",205,0))
 S DIE="^PRCA(430,",DA=PRCABN,DR="33//^S X=DT;35;37;8////"_PRCA("STATUS")_";95////"_+PRCAKSTA D ^DIE K DIE,DR
 S $P(^PRCA(430,PRCABN,3),U,4)=DUZ Q
EN ;ENTER NEW BILL IN FILE 430
 K PRCAP,PRCABN,DA,DIC,DLAYGO Q:'$D(PRCA("SITE"))!('$D(DUZ))  D SVC Q:'$D(PRCAP("S"))
ENPO ;S DIC="^PRCA(430.4,",DIC(0)="QEMZ",DIC("S")="I +$P(^(0),U,1)=PRCA(""SITE""),+$P(^(0),U,5)=PRCAP(""S"")"
 R !!,"BILL NO. : ",X:DTIME Q:('$T)!(X="")  I X["^" S X="" Q
 I "Nn"[$E(X) D  I $P(X,"^")=-1 W *7,!!,$P(X,"^",2),! G ENPO
 . S X=$$BNUM^RCMSNUM
 . I $P(X,"^")'=-1 S X=$P(X,"-",2)
 I (X'?1U1N5UN) W *7,!!,"Please enter 7 character bill number.",!,"It must be in the following format: K400001, K481234 or '(N)ew' to get",!,"the next available number.  (Enter ""^"" to exit)",! G ENPO
 I ($D(^PRCA(430,"D",X)))!($D(^PRCA(430,"B",PRCA("SITE")_"-"_X))) W *7,!!,"SORRY ! THIS NUMBER HAS BEEN ALREADY ASSIGNED TO A BILL. USE EDIT OPTION",! G ENPO
 ;W !!,"ENTER YOUR BILL COMMON NUMBERING SERIES: " R X:DTIME G:X=""!(X=U) ENPOQ I $E(X,1)="?"!($L(X)'<4) S D="C" D IX^DIC G ENPO
EN2 ;I $L(X)<4 S D="C" D IX^DIC G ENPO:Y<0,NUM
 S X=PRCA("SITE")_"-"_X,DIC(0)="L"
ENPO1 K DIC("S") S PRCAP("NEW")="",DIC="^PRCA(430,",DIC("DR")="97////^S X=DUZ;101////^S X="_PRCAP("S"),DLAYGO=430 D ^DIC
 G ENPO:Y<0,W3:'+$P(Y,U,3)
 S (DA,PRCABN)=+Y,$P(^PRCA(430,DA,100),U,2)=PRCAP("S")
 W " ... Bill Number '",$P(^PRCA(430,PRCABN,0),"^"),"' assigned"
 G ENPOQ
NUM ;L +^PRCA(430.4,+Y,0):1 G:'$T W1 S X=$P(Y,U,2),Z=$S(+$P(Y(0),U,4)<$P(Y(0),U,2):+$P(Y(0),U,2),1:+$P(Y(0),U,4)),L=$L(X)#2-3
Z ;G:Z>$P(Y(0),U,3) W2 S Z="000"_Z,Z=$E(Z,$L(Z)+L,$L(Z)),X=X_Z I $D(^PRCA(430,"B",X)) S Z=Z+1,X=$P(Y,U,2) G Z
 ;W !?3,"Are you adding '",X,"' as a new Bill number ",*7 S %=0 D YN^DICN I %'=1 L -^PRCA(430.4,+$G(Y),0) G ENPO
 ;S $P(^PRCA(430.4,+Y,0),U,4)=Z,DIC(0)="L" L -^PRCA(430.4,+Y,0) G ENPO1
W1 ;L -^PRCA(430.4,+Y,0) W !?3,"Bill Number series is being edited by another user, try later",*7 G ENPO
W2 ;L -^PRCA(430.4,+Y,0) W !?3,"UPPER BOUND NOT DEFINED FOR BILL NUMBER SERIES ",$P(Y,U,2),*7 G ENPO
W3 W "   Bill Number already exists, please try again ",*7 G ENPO
SVC K PRCAP("S") I $D(^VA(200,DUZ,5)),$D(^DIC(49,+^(5),0)) S PRCAP("S")=+^VA(200,DUZ,5) Q
 W !,"You must have a SERVICE/SECTION assigned to you in the NEW PERSON file.",!?3,"See your Site Manager."
ENPOQ K DIC,DLAYGO,%DT,L,PRCAP,Z Q
Q K %,A,B,C,D0,DA,DIC,DIE,DIK,DR,I,PRCA,PRCABC,PRCABN,PRCABT,PRCADFM,PRCAI,PRCAMT,PRCANM,PRCAMT1,PRCAMT2,PRCAQ,PRCAP,PRCAT,PRCATY,PRCAX,X,Y,Z0,ZRTN,ZTSK Q
