FBNHDLTR ;AISC/GRR - DELETE TRANSFER FOR NURSING HOME ;1/22/15  14:13
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q
RD2 S DIC("S")="I $P(^(0),U,3)=""T""&($P(^(0),U,2)=DFN)",DIC="^FBAACNH(",DIE=DIC,DIC(0)="AEQMZ",DLAYGO=162.3,DIC("A")="Select Transfer Date/Time: " D ^DIC K DIC,DLAYGO G RD1:X="^"!(X=""),RD2:Y<0 S DA=+Y
 S FBDA(0)=Y(0),FBDA=$P(FBDA(0),U,5) D  G Q:$D(FBERR)
 .I $O(^FBAACNH("AC",FBDA,DA)) W !,*7,"There are movements following this transfer that must be deleted first.",!! S FBERR=1
 S DIR("A")="Are you sure you want to delete this transfer",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G Q:$D(DTOUT),RD1:$D(DUOUT)!(Y=0)
 S DIK="^FBAACNH(" D ^DIK
 I DFN D
 . N FB,FBX
 . S FB(161)=$S(FBDA:$P($G(^FBAACNH(FBDA,0)),"^",10),1:"")
 . Q:'FB(161)
 . I $D(^FBAAA(DFN,1,FB(161),0)) S FB(78)=+$P(^(0),"^",9)
 . Q:'$G(FB(78))
 . S FBX=$$ADDUA^FBUTL9(162.4,FB(78)_",","Delete CNH transfer.")
 . I 'FBX W !,"Error adding record in User Audit. Please contact IRM."
 K FBDA G RD1
Q K DIC,DIE,DR,DA,DFN,DIR,FBTYPE,FTP,Y,X,FBPROG,FBDA,FBERR
 Q
