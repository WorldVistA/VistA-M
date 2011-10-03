XQABTMP ;ISC-SF.SEA/JLI - temporary routine for clean up ;04/16/96  10:49
 ;;8.0;KERNEL;**28**;Jul 10, 1995
 ;This routine can be used to remove Packages from Alpha/Beta testing
EN ;ask for Package name and remove A/B testing
 N DA,DIC,DIK,DIR,DIRUT,DIROUT,X,XQ1,XQ2,XQ3,XQ4,XQA,XQDA,XQID,Y
 S DIC="^XTV(8989.3,1,""ABPKG"",",DIC(0)="AEMQZ"
 ;don't allow if there is an address, this can be used to only show
 ;you local packages that you want to remove.
 ;S DIC("S")="I $P(^(0),U,3)="""""
 D ^DIC K DIC Q:Y<0
 S XQDA=+Y,DIR(0)="Y",DIR("A")="You want to remove "_Y(0,0)_" from Alpha/Beta Testing"
 D ^DIR Q:'Y!$D(DIRUT)
 D RMVTEST W !,"Done.",!
 Q
 ;
RMVTEST D GETDATA
 S DIK="^XTV(8989.3,1,""ABPKG"",",DA(1)=1,DA=XQDA
 D ^DIK
 I $O(^XTV(8989.3,1,"ABPKG",0))'>0 K ^XTV(8989.3,1,"ABOPT")
 Q
 ;
GETDATA ;
 F XQ1=0:0 S XQ1=$O(^XTV(8989.3,1,"ABPKG",XQDA,1,XQ1)) Q:XQ1'>0  S XQID=$P(^(XQ1,0),U),XQID(XQID)="" D CHECK
 Q
 ;
CHECK S XQA=$E(XQID,1,$L(XQID)-1)_$C($A($E(XQID,$L(XQID)))-1)_"z"
 F XQ2=0:0 S XQA=$O(^DIC(19,"B",XQA)) Q:XQA=""!($E(XQA,1,$L(XQID))'=XQID)  I $E(XQA,$L(XQID)+1)'="Z" D CHK2
 Q
 ;
CHK2 F XQ3=0:0 S XQ3=$O(^XTV(8989.3,1,"ABPKG",XQDA,1,XQ1,1,XQ3)) Q:XQ3'>0  S XQ4=$P(^(XQ3,0),U) Q:$E(XQA,1,$L(XQ4))=XQ4
 I XQ3'>0 F XQ4=0:0 S XQ4=$O(^DIC(19,"B",XQA,XQ4)) Q:XQ4'>0  K ^XTV(8989.3,1,"ABOPT",XQ4,0)
 Q
