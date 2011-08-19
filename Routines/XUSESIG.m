XUSESIG ;SF/RWF - ROUTINE TO ENTER OR CHANGE ELECTRONIC SIGNATURE CODE ;10/16/2006
 ;;8.0;KERNEL;**14,55,437**;Jul 10, 1995;Build 2
A ;Called by others from the top. See DBIC #936
 I $D(DUZ)[0 W "NO ACTION CAN BE TAKEN ON YOUR REQUEST     " Q
 N DA,DIE,DR,X1,K
 S DA=+DUZ S:$D(^VA(200,DA,0))[0 DA=0
 I DA'>0 W !,"You don't have an entry in the NEW PERSON file, See your site manager" G OUT
 W !,"This option is designed to permit you to enter or change your Initials,"
 W !,"Signature Block Information, Office Phone number, and Voice and",!,"Digital Pagers numbers."
 W !,"In addition, you are permitted to enter a new Electronic Signature Code"
 W !,"or to change an existing code."
 W !! S DIE="^VA(200,",DR="1;20.2;20.3;.132;.137;.138" D ^DIE
 I $P($G(^VA(200,DA,20)),U,2)="" W !,"You must have a SIGNATURE BLOCK PRINTED NAME before you can have",!,"an ELECTRONIC SIGNATURE CODE." G OUT1
 S X1=$P($G(^VA(200,DA,20)),"^",4) I X1]"" S K=0 D S2 G:X1="" OUT1
 S X1=$$NEW() W !,$S(X1:"DONE",1:"  OPTION ABORTED."_$C(7))
 G OUT1
 ;
NEW() ;Enter a NEW E-Sig code, return 0 for fail, 1 if done, 2 skip.
 N K,X,X1 S K=0
 W !!,"Your typing will not show."
N2 W !,"ENTER NEW SIGNATURE CODE: " D R Q:X=""!(X="^") 2
 I X'?.UNP!($L(X)>20)!($L(X)<6) W *7,!,"Signature code must be 6 to 20 characters in length",!," With no control or lowercase characters.",! G N2
 S X1=X W !,"RE-ENTER SIGNATURE CODE FOR VERIFICATION: " D R G:X=""!(X="^") N5
 I X'=X1 W "  CODE NOT VERIFIED, TRY AGAIN.",*7,! S K=K+1 G N5:K>3 G N2
 D HASH^XUSHSHP
 I X=$P(^VA(200,DA,20),U,4) W *7,!,"You can't use the same one.",! G N2
 S $P(^VA(200,DA,20),"^",4)=X
 F XUS=0:0 S XUS=$O(^DD(200,20.4,1,XUS)) Q:XUS'>0  X ^(XUS,1)
N4 Q 1 ;OK
N5 Q 0 ;FAIL
 ;
R X ^%ZOSF("EOFF") R X:60 X ^%ZOSF("EON") S:'$T X="^" Q
 ;
OUT W !,"  OPTION ABORTED.",*7
OUT1 K %,D,D0,DA,DIC,DIE,DQ,DR,X,X1,A,K,I,Z Q
 ;
SIG ;Call with DUZ; Return X1="" if fail else hashed ESC.
 N X2,K
 S X2=$G(^VA(200,+$G(DUZ),20)),X1=$P(X2,U,4) I X1="" W !,"No Electronic Signature code to check." Q
 S K=0 D S2 Q:X1=""
 Q  ;Following code was to force code change
 N LIFE S LIFE=$$KSP^XUPARAM("LIFETIME")
 S X2=+X2 I X2>0,(X2+LIFE)'>(+$H) D  I X1="" W !,*7,"Verification with held untill new code entered.",!
 . W !!,"Your Electronic Signature Code has expired, you need to create a new one."
 . N DA S DA=DUZ S:$$NEW()'=1 X1=""
 . Q
 Q
 ;
S2 W !!,"Enter your Current Signature Code: " D R G:X=""!(X="^") S9
 I X?1.2"?" W !,"Enter your current Electronic Signature Code so it can be verified.",! G S2
 S K=K+1 D HASH^XUSHSHP I X1'=X W "  ??",*7 S X="" G S2:K<3,S9
 W "   SIGNATURE VERIFIED"
S9 S:X=""!(X="^") X1=""
 Q
TEXT ;;
CLEAR ;Clear (delete) a users ESC to allow entering a new one.
 S DIC=200,DIC(0)="AEMQ" D ^DIC G OUT:Y'>0 S DA=+Y,DIR(0)="Y"
 W !,"Clear SIGNATURE CODE from user ",$P(Y,U,2) D ^DIR G OUT1:Y'=1
 S DIE=DIC,DR="20.4///@" D ^DIE G OUT1
 Q
 ;;
