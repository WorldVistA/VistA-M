XQALMAKE ;ISC-SF.SEA/JLI- HIGH LEVEL SETUP ALERT ;4/9/07  14:03
 ;;8.0;KERNEL;**443**;Jul 10, 1995;Build 4
 ;;
ENTRY ;
 W !!,"ALERT GENERATOR"
TEXT K XQA,XQAMSG,XQAOPT,XQAROU,DIC,DIR
 R !!,"ON THE NEXT LINE ENTER THE TEXT TO BE DISPLAYED FOR THE ALERT ___",!,X:DTIME G:'$T!(X[U)!(X="") EXIT W !!,X S XQALX=X,DIR(0)="Y",DIR("A")="Is this text OK? ",DIR("B")="YES" D ^DIR K DIR G:'Y TEXT S XQAMSG=XQALX
 D LOOP1 G:'$D(XQA) EXIT
ASKOPT S DIR(0)="Y",DIR("A")="Do you want to transfer control to an option when the alert is selected" D ^DIR K DIR I Y D GETOPT G:Y'="" SETIT G ASKOPT
ASKROU S DIR(0)="Y",DIR("A")="Do you want to transfer control to a routine when the alert is selected" D ^DIR K DIR G:'Y SETIT
 R !,"Enter ROUTINE name or ENTRY^ROUTINE name: ",X:DTIME S:'$T X=U G:X=U EXIT G:X="" ASKROU S XQAROU=X S X=$S(X'[U:X,1:$P(X,U,2)) G:X="" ASKROU X ^%ZOSF("TEST") I 'Y W !,"Routine '",X,"' not present" G ASKROU
SETIT ;
 I '$D(XQAROU),'$D(XQAOPT) S DIR(0)="Y",DIR("A")="Do you want to make a long text info only alert" D ^DIR K DIR I Y D LONGTEXT
 W !!,"As currently entered, this alert will display the following text:",!!,XQAMSG
 W !!,"The alert is currently to be delivered to:" S XQAX="" F I=1:1 S XQAX=$O(XQA(XQAX)) Q:XQAX=""  S X=$S(XQAX>0:$P(^VA(200,XQAX,0),U),1:XQAX) W:(I#2) ! W:'(I#2) ?40 W X
 W:$D(XQAROU) !!,"On selection of the alert, the user will run the routine ",XQAROU W:$D(XQAOPT) !!,"On selection of the alert, the user will be taken to the",!,"the option ",XQAOPT W !!
 S DIR(0)="Y",DIR("A")="Is this alert what was intended",DIR("B")="YES" D ^DIR K DIR I 'Y G ENTRY
 D SETUP^XQALERT
 W !!?20,"ALERT IS NOW SET",!!
 G ENTRY
 ;
GETOPT ;
 S DIC=19,DIC(0)="AEQM",DIC("A")="Indicate the desired OPTION: " D ^DIC K DIC S:Y'>0 Y="" S XQAOPT=$P(Y,U,2)
 Q
 ;
EXIT ;
 K XQALDIC,XQALX,XQA,XQAMSG,XQAOPT,XQAROU,DIC,DIR,X,Y
 Q
LOOP1 K XQA R !,"Enter a User name or G.mailgroup",!,"as recipient of the Alert: ",X:DTIME S:'$T!(X="") X=U I X'[U D SETONE G:Y'>0 LOOP1
 I X'[U F  R !,"Enter another user or G.mailgroup: ",X:DTIME  S:'$T X=U Q:X[U!(X="")  D SETONE
 K:X[U XQA Q
SETONE ;
 S XQALDIC=$S("g.G."[$E(X,1,2):3.8,1:200),X=$S(XQALDIC=3.8:$E(X,3,$L(X)),1:X),DIC=XQALDIC,DIC(0)="EMQ" D ^DIC Q:Y'>0  S X=$S(XQALDIC=3.8:"G."_$P(Y,U,2),1:+Y),XQA(X)=""
 Q
 ;
LONGTEXT ;
 W !,"Enter .EXIT  to terminate input",!
 S COUNT="" F  R X:DTIME Q:X=".EXIT"  S COUNT=COUNT+1,XQATEXT(COUNT)=X W !
 Q
