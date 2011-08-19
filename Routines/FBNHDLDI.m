FBNHDLDI ;AISC/GRR-DELETE DISCHARGE FOR NURSING HOME ;29AUG88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q
 I $D(^FBAACNH("AD",DFN)) W !!,*7,"Veteran presently has an active admission.",!,"You cannot delete a discharge when there is an active admission!",! G CKVEIW
RD2 S DIC("S")="I $P(^(0),U,3)=""D""&($P(^(0),U,2)=DFN)",DIC="^FBAACNH(",DIE=DIC,DIC(0)="AEQMZ",DLAYGO=162.3,DIC("A")="Select Discharge Date/Time: " D ^DIC K DIC,DLAYGO G RD1:X="^"!(X=""),RD2:Y<0 S DA=+Y
 S FBCKDT=+Y(0) I $O(^FBAACNH("AF",DFN,0))<(9999999.9999-FBCKDT) W !!,*7,"There is activity following this discharge date.",!,"You must delete all subsequent activity before deleting this discharge." G RD1
 S FBDA=$P(^FBAACNH(DA,0),"^",5)
 S DIR("A")="Are you sure you want to delete this discharge",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G H^XUS:$D(DTOUT),RD1:$D(DUOUT)!(Y=0)
 S DIK="^FBAACNH(" D ^DIK S DIE="^FBAACNH(",DR="3////^S X=""Y""",DA=FBDA D ^DIE W !?5,"... deleted" D ALERT G RD1
Q K DIC,DIE,DR,DA,DFN,FBTYPE,FTP,Y,X,FBPROG,FBDA,FBCKDT
 Q
CKVEIW S DIR("A")="Want data related to active admission displayed",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G H^XUS:$D(DTOUT),RD1:$D(DUOUT)!(Y=0) S IFN=$O(^FBAACNH("AD",DFN,0)) D ^FBNHDEC
 G RD1
ALERT W !!,*7,"It will be necessary to adjust the 'TO DATE' of this patient's authorization",!,"using the 'EDIT CNH AUTHORIZATION' option."
