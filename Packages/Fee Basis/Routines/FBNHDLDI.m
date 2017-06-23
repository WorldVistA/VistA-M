FBNHDLDI ;AISC/GRR - DELETE DISCHARGE FOR NURSING HOME ;1/22/15  13:39
 ;;3.5;FEE BASIS;**154**;JAN 30, 1995;Build 12
 ;;Per VA Directive 6402, this routine should not be modified.
RD1 D GETVET^FBAAUTL1 G:DFN']"" Q
 I $D(^FBAACNH("AD",DFN)) W !!,*7,"Veteran presently has an active admission.",!,"You cannot delete a discharge when there is an active admission!",! G CKVEIW
RD2 S DIC("S")="I $P(^(0),U,3)=""D""&($P(^(0),U,2)=DFN)",DIC="^FBAACNH(",DIE=DIC,DIC(0)="AEQMZ",DLAYGO=162.3,DIC("A")="Select Discharge Date/Time: " D ^DIC K DIC,DLAYGO G RD1:X="^"!(X=""),RD2:Y<0 S DA=+Y
 S FBCKDT=+Y(0) I $O(^FBAACNH("AF",DFN,0))<(9999999.9999-FBCKDT) W !!,*7,"There is activity following this discharge date.",!,"You must delete all subsequent activity before deleting this discharge." G RD1
 S FBDA=$P(^FBAACNH(DA,0),"^",5)
 S DIR("A")="Are you sure you want to delete this discharge",DIR(0)="Y",DIR("B")="No" D ^DIR K DIR G Q:$D(DTOUT),RD1:$D(DUOUT)!(Y=0)
 S DIK="^FBAACNH(" D ^DIK S DIE="^FBAACNH(",DR="3////^S X=""Y""",DA=FBDA D ^DIE W !?5,"... deleted" D ALERT
 I DFN D
 . N FB,FBX
 . S FB(161)=$S(FBDA:$P($G(^FBAACNH(FBDA,0)),"^",10),1:"")
 . Q:'FB(161)
 . I $D(^FBAAA(DFN,1,FB(161),0)) S FB(78)=+$P(^(0),"^",9)
 . Q:'$G(FB(78))
 . S FBX=$$ADDUA^FBUTL9(162.4,FB(78)_",","Delete CNH discharge.")
 . I 'FBX W !,"Error adding record in User Audit. Please contact IRM."
 G RD1
Q K DIC,DIE,DR,DA,DFN,FBTYPE,FTP,Y,X,FBPROG,FBDA,FBCKDT
 Q
CKVEIW S DIR("A")="Want data related to active admission displayed",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G RD1:$D(DTOUT)!$D(DUOUT)!(Y=0) S IFN=$O(^FBAACNH("AD",DFN,0)) D ^FBNHDEC
 G RD1
ALERT W !!,*7,"It will be necessary to adjust the 'TO DATE' of this patient's authorization",!,"using the 'EDIT CNH AUTHORIZATION' option."
