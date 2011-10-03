XMA2B ;(WASH ISC)/CAP/THM-Send BLOB ;06/22/99  14:44
 ;;8.0;MailMan;;Jun 28, 2002
 ; Entry points used by MailMan options (not covered by DBIA):
 ; BLOB     XMBLOBSEND - Send Imaging Package message
BLOB ;Send BLOBs [Other Body Parts] in a message.
 ;Do not allow option to be used if Imaging is not set up.
 I '$O(^MAG(2005,0)) W !!,"Imaging is not installed here.  You can not send multimedia messages.",$C(7) Q
 ;
 ;First message is created with text.
 K XMA2BT
 D BLOB^XMJMS
 Q
ADD ;Then this entry point is called
 ;Called from ^XMJMS for adding BLOBS to message as other body parts
 ;
 W !,"Do you want to attach "_$S('$D(XMA2BT):"a",1:"another")_" patient's image to this message?  N// " R X:DTIME
 I X="Y"!(X="y") S MAGBLOB=1 G SEL
 I $D(MAGBLOB) I X="N"!(X="n")!(X="^")!(X="") S X="" G ADDCHK
SEL D SELIM^MAGAPI G ADDBLOB
ADDCHK G CHK:X=""
 I X["?" D HLP G ADD
 ;
 ;Remove a BLOB
 S XMN=$E(X)="-"
 I XMN S X=$E(X,2,99) D LK G ER:+Y<1 S %=$O(^XMB(3.9,XMZ,2005,"B",+Y,0)) I % K ^(%) S I=^XMB(3.9,XMZ,2005,0),%0=$P(I,U,4)-1,$P(I,U,3,4)=%0_U_%0,^(0)=I K ^(%) G ADD
 ;
 ;Add a BLOB
K S Y=-1 D LK
ADDBLOB G:$S(X["^":1,X="":1,+Y<1:1,1:0) CHK
 S %=$S($D(^XMB(3.9,XMZ,2005,0)):^(0),1:"^3.92005P"),I=$P(%,U,3)+1,$P(%,U,3)=I,$P(%,U,4)=$P(%,U,4)+1,^(0)=%,^(I,0)=+Y
 S ^XMB(3.9,XMZ,2005,"B",+Y,I)="",XMA2BT=1
 G ADD
CHK K XMA2BT Q:$S($O(^XMB(3.9,XMZ,2005,0)):1,'$O(^XMB(3.9,XMZ,2,0)):1,1:0)
 W !!,"You did not add any 'Other Body Parts' (files) to this message."
 R !!,"Do you wish to deliver just the text ? N// ",Y:DTIME
 K XMOUT
 S Y=$TR(Y,"yesno","YESNO")
 I $L(Y) Q:$E("YES",1,$L(Y))=Y
 I $E("NO",1,$L(Y))=Y G ADD
 W $C(7),"  <<< Please answer 'YES' or 'NO'"
 G CHK
 ;
LK S DIC=2005,DIC(0)="NOQFEM",DIC("S")="N % S %=^(0) I $P(%,U,6)'=9,$P(%,U,3)" D ^DIC K DIC Q
ER W " ??",$C(7) G ADD
 ;
HLP ;Help for adding/removing BLOBS
 W !!,"You may add or remove a BLOB from the message.  To add a BLOB"
 W !,"enter the name of the BLOB you wish to add to the message.  This"
 W !,"BLOB must already be in the * file.  To remove on, preceed the"
 W !,"name of the BLOB with a '-'.  Example:  To add the BLOB named"
 W !,"ZZTEMP, enter 'ZZTEMP'.  To remove it enter '-ZZTEMP'."
 Q:'$O(^XMB(3.9,XMZ,2005,0))
 W !!,"The following BLOBs have already been added to this message:",!!
 ;
 ;List BLOBS in a message
L S I=0 F  S I=$O(^XMB(3.9,XMZ,2005,I)) Q:+I'=I  S %=+^(I,0),X=$P(^MAG(2005,%,0),U) W:$L(X)+$X>79 ! W X,?$X\10*10+10
 Q
 ;
 ;Entry point to list non-textual body parts for Query.
LIST N I,X W !,"This message has non-textual body-parts: "
 G L
