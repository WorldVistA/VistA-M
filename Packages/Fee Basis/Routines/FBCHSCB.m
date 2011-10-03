FBCHSCB ;AISC/GRR - SUPERVISOR RELEASE ;11/2/2010
 ;;3.5;FEE BASIS;**117**;JAN 30, 1995;Build 9
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 D DT^DICRW
 I '$D(^FBAA(161.7,"AC","C")) W !!,*7,"There are no batches Pending Release!" Q
BT W !! S DIC="^FBAA(161.7,",DIC(0)="AEQZ",DIC("S")="I $P(^(0),U,15)=""Y"",$G(^(""ST""))=""C""" D ^DIC K DIC("S") G Q:X="^"!(X=""),BT:Y<0 S FBN=+Y,FZ=Y(0),FBTYPE=$P(FZ,"^",3),FBAAON=$P(FZ,"^",2),FBAAB=$P(FZ,"^")
 I $P(FZ,"^",18)["Y" W !!,*7,"This Batch is exempt from the Pricer!!!",!,"Please use the 'Release a Batch' option to forward this batch for payment." G Q
 S DA=FBN,DR="0;ST" W !! D EN^DIQ
RD S B=FBN S DIR(0)="Y",DIR("A")="Want line items listed",DIR("B")="NO" D ^DIR K DIR G BT:$D(DIRUT) D:Y LISTC
RDD S DIR(0)="Y",DIR("A")="Do you want to Release Batch as Correct",DIR("B")="NO" D ^DIR K DIR G BT:$D(DIRUT) I 'Y W !!,"Batch has NOT been Released!",*7 G BT
 ; use FileMan to update fields 5 and 6 (PRC*3.5*117)
 S DA=FBN,DIE="^FBAA(161.7,",DR="11////^S X=""S"";6////^S X=DUZ;5////^S X=DT" D ^DIE
 S DA=FBN,DR="0;ST",DIC="^FBAA(161.7," W !! D EN^DIQ W !!," Batch has been Released!" G BT
Q K B,J,K,L,M,X,Y,Z,DIC,FBN,A,A1,A2,BE,CPTDESC,D0,DA,DL,DR,DRX,DX,FBAACB,FBAACPT,FBAAON,FBAAOUT,FBVP,FBIN,DK,N,XY,FBINOLD,FBINTOT,FBTYPE,FZ,P3,P4,Q,S,T,V,VID,ZS,FBAAB,FBAAMT,FBAAOB,FBCOMM,FBAUT,FBSITE,I,X,Y,Z,FBERR,DIRUT,DUOUT,DTOUT
 K FBK,FBL,FBPDT,FBTD,DIE
 K DLAYGO,FBLISTC D END^FBCHDI Q
 ;
LISTC D HOME^%ZIS W @IOF
 D LISTC^FBAACCB1 Q
