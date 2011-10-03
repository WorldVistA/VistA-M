FBNHEDTR ;AISC/GRR-EDIT TRANSFER TYPE FOR NURSING HOME ;29AUG88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q
 ;
RD2 S DIC("S")="I $P(^(0),U,3)=""T""&($P(^(0),U,2)=DFN)",DIC="^FBAACNH(",DIE=DIC,DIC(0)="AEQMZ",DLAYGO=162.3,DIC("A")="Select Transfer Date/Time: " D ^DIC K DIC,DLAYGO G RD1:X="^"!(X=""),RD2:Y<0 S (DA,IFN)=+Y,FBAADT=$P(Y,U,2)
 S FBDA=$P(Y(0),U,5) D  I $G(FBERR) D Q G RD1
 .  I $O(^FBAACNH("AC",FBDA,DA)) W !,*7,"There are movements following this transfer that must be deleted first.",!! S FBERR=1
 ;
 S FBTR=$P(Y(0),U,7),FBLTTYP=""
 S FBJ=9999999.999999-FBAADT F  S FBJ=$O(^FBAACNH("AF",DFN,FBJ)) Q:'FBJ  S FBK=$O(^FBAACNH("AF",DFN,FBJ,0)) I $P($G(^FBAACNH(FBK,0)),"^",5)=$P(^FBAACNH(DA,0),"^",5) D  Q
 . S FBLTTYP=$P(^FBAACNH(FBK,0),U,7)
 S DR="@1;6;S FBNTR=X;D CHKTR^FBNHEDTR;6////^S X=FBTR;S Y=""@1"""
 D ^DIE K DIE G Q:$D(DTOUT)
 D Q G RD1
 ;
Q K DIC,DIE,DR,DA,DFN,FBTYPE,FTP,Y,X,FBPROG,FBTR,FBNTR,IFN,FBAADT,FBJ,FBK,FBASIH,FBDA,FBERR,FBLTTYP
 Q
CHKTR ;called from dr string to make sure that the transfer type is
 ;consistant, that is if the old transfer type (FBTR) is a loss
 ;then the new transfer type (FBNTR) is also a loss.
 ;
 I '$G(FBLTTYP),(FBTR>3&(FBNTR'>3)) D ERROR1 Q
 I '$G(FBLTTYP),(FBTR<4&(FBNTR'<4)) D ERROR Q
 S Y=""
 Q
 ;
ERROR ;write inconsistant movement type which will reset the movement type
 ;to original and allow user to re-edit.
 ;
 W !?5,*7,"Movement Type must be consistant. A transfer that is a loss",!?5,"may only be editted to another 'loss' type.",!
 Q
ERROR1 ;write inconsistant movement type 'gain', reset transfer type and re-edit
 ;
 W !?5,*7,"Movement Type must be consistant.  A transfer that is a gain",!?5,"may only be editted to another 'gain' type.",!
 Q
