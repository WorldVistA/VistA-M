XMUT1 ;(WASH ISC)/CAP-Recover msgs for a user ;04/17/2002  11:49
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; A   XMUT-REC-FIND
 ; G   XMUT-REC-DELIVER
 Q
A ;
 W !!,"WE WILL FIND THE MESSAGES AND STORE THEM IN ^TMP('XMUT1'..."
 W !,"LATER WE WILL LOAD THEM INTO PERSON'S MAILBOX.",!!
 W !!,"This routine recovers 'ALL' messages that the user has not been"
 W !,"terminated from.  It will not recover some messages that were"
 W !,"sent after reinstatement if the user previously lost Mail-Baskets."
 S DIR(0)="Y",DIR("B")="N",DIR("A")="THIS MAY TAKE A LONG TIME.... DO YOU WISH TO CONTINUE" D ^DIR K DIR,DIRUT G EXIT:"yY"'[$E(X)!(X="")
 S XMA0=^DD("DD")
B S DIC("A")="Enter the USER for whom you wish to recover messages: "
 S DIC="^VA(200,",DIC(0)="AEQZM" D ^DIC
 K DIC I "^"[$E(X) G EXIT
 I Y<1 W !,"Enter '^' to abort or a Valid User who has a Mailbox." G B
 I '$D(^XMB(3.7,+Y,2,1,0)) W $C(7),"You cannot recover messages for this user (no Mailbox)." G B
 S XMC0=+Y,XMB0=Y(0) K Y
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="DO YOU MEAN '"_$P(XMB0,"^")_"' "
 D ^DIR K DIR,DIRUT I "Yy"'[$E(X)!(X="") G B
 S (F,A,G)=0,D=XMC0 K XMC0
 W !!,"*=100 MESSAGES PROCESSED",!!
L S A=$O(^XMB(3.7,"M",A)) G Q:'A,L:$D(^(A,D)) S G=G+1 W:G#100=0 "*" S E=$O(^XMB(3.9,A,1,"C",D,0)) G L:'E,L:$D(^XMB(3.9,A,1,E,"D"))
 S F=F+1,X=^XMB(3.9,A,0),^TMP("XMUT1",D,A)=X W !,$P(X,"^"),!
 G L
Q W !!,G," MESSAGES PROCESSED, ",F," MESSAGES FOUND"
 K %1,A,D,E,F,G,X,XMA0,XMB0,Y,Z,%,%H,%DT
 Q
QQ S (A,G,F)=0,C=1,XMA0=^DD("DD") H 3600 D L G H^XUS
 ;
G ;LOAD DOCUMENTS FOUND INTO USER'S 'IN' BOX
 S (J,C,F)="" W !!,"CHOOSE FROM:",!
 F I=0:0 S I=$O(^TMP("XMUT1",I)) Q:'I  I $D(^VA(200,I,0)) W !,$J(I,8),"   ",$$NAME^XMXUTIL(I) I 'J S J=I
 I 'J W !!!,"NONE RECOVERED FOR ANYBODY !!!" K C,F,I,J,X Q
F W !!,"WHICH ONE: ",J,"// " R X:DTIME I X="" S X=J
 G E:"^"[$E(X) I X="?" D H1^XMUT1A G F
 I X="??" G G
 S D=X I '$D(^TMP("XMUT1",D)) W "   << NOT ON LIST !!!",$C(7) G G
 W !!,"RECOVERING MESSAGES ('+'=RECOVERED, '.'=MESSAGE PROCESSED)",!!
 S D=X,(C,F)=0
P S A=$O(^TMP("XMUT1",D,0)) G QQQ:'A W "." I $X>77 W !
 S C=C+1 W "+" G T:$D(^XMB(3.7,"M",A,D)),T:'$D(^XMB(3.9,A))
 S F=F+1
 L +^XMB(3.7,D)
 D PUTMSG^XMXMSGS2(D,1,"IN",A)
 L -^XMB(3.7,D)
T K ^TMP("XMUT1",D,A) G P
QQQ W !!,C," POTENTIAL ENTRIES PROCESSED.  ",F," MESSAGES RECOVERED.",!!
E K %,%1,A,C,D,F,I,J,Y,Z,%H
 Q
EXIT K X1,X2
 Q
 ;
 ;LIST MESSAGES IN MAILBOXES OF DUZ
M G MBOX^XMJBL
 Q
