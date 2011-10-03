FBNHDLTR ;AISC/GRR-DELETE TRANSFER FOR NURSING HOME ;29AUG88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q
RD2 S DIC("S")="I $P(^(0),U,3)=""T""&($P(^(0),U,2)=DFN)",DIC="^FBAACNH(",DIE=DIC,DIC(0)="AEQMZ",DLAYGO=162.3,DIC("A")="Select Transfer Date/Time: " D ^DIC K DIC,DLAYGO G RD1:X="^"!(X=""),RD2:Y<0 S DA=+Y
 S FBDA(0)=Y(0),FBDA=$P(FBDA(0),U,5) D  G Q:$D(FBERR)
 .I $O(^FBAACNH("AC",FBDA,DA)) W !,*7,"There are movements following this transfer that must be deleted first.",!! S FBERR=1
 S DIR("A")="Are you sure you want to delete this transfer",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G H^XUS:$D(DTOUT),RD1:$D(DUOUT)!(Y=0)
 S DIK="^FBAACNH(" D ^DIK K FBDA G RD1
Q K DIC,DIE,DR,DA,DFN,DIR,FBTYPE,FTP,Y,X,FBPROG,FBDA,FBERR
 Q
