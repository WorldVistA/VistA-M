FBAAVR ;AISC/GRR,SAB - FINALIZE BATCH ;4/16/2012
 ;;3.5;FEE BASIS;**132**;JAN 30, 1995;Build 17
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S Q="",$P(Q,"=",80)="=",IOP=$S($D(ION):ION,1:"HOME") D ^%ZIS
 D DT^DICRW
 I '$D(^XUSEC("FBAAREJECT",DUZ)),'$D(^XUSEC("FBAAFINANCE")) W !!,*7,"Sorry, you must hold security key FBAAREJECT or FBAAFINANCE!" G Q
 ;
BT ; select batch
 S FBINTOT=0 K QQ W !!
 K DIC S DIC="^FBAA(161.7,",DIC(0)="AEQ",DIC("S")="I $G(^(""ST""))=""F"""
 D ^DIC K DIC("S") G Q:X="^"!(X=""),BT:Y<0
 L +^FBAA(161.7,+Y):$G(DILOCKTM,3)
 I '$T W !,"Another user is editing this batch.  Try again later." G Q
 S FBN=+Y
 I $G(^FBAA(161.7,FBN,"ST"))'="F" W !,$C(7),"Batch status must be CENTRAL FEE ACCEPTED!" G DONE
 S FZ=^FBAA(161.7,FBN,0),FBTYPE=$P(FZ,"^",3)
 S FBAAB=$P(FZ,"^"),FBAAON=$P(FZ,"^",2),FBAAOB=$P(FZ,"^",8)_"-"_FBAAON
 I FBTYPE="B9",$P(FZ,"^",15)="" S FBCNH=1
 S (FBRFLAG,FBAARA)=0
 ;
 ; display batch
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 ;
 ; check for split invoice
 I FBTYPE="B3" D CHKSPLT^FBAAVR3
 ;
BTL S B=FBN S DIR(0)="Y",DIR("A")="Want line items listed",DIR("B")="NO" D ^DIR K DIR G Q:$D(DIRUT) W:Y @IOF D:Y LIST^FBAACCB:FBTYPE="B3",LISTP^FBAACCB:FBTYPE="B5",LISTT^FBAACCB0:FBTYPE="B2",LISTC^FBAACCB1:FBTYPE="B9"
 ;
RD0 ; local reject functionality
 I '$D(^XUSEC("FBAAREJECT",DUZ)) W !,"Skipping reject function because key not held." G RDD
 ;
 S DIR(0)="Y",DIR("A")="Want to reject the entire Batch",DIR("B")="NO",DIR("?")="'Yes' will flag all payment items in batch as rejected, 'No' will prompt for rejection of specific line items." D ^DIR K DIR G Q:$D(DIRUT),^FBAADD:Y
 ;
 I FBTYPE="B3",$D(FBLNLST) D  G Q:$D(DIRUT),SPLIT^FBAAVR2:Y
 . S DIR(0)="Y"
 . S DIR("A")="Want to reject all line items on split invoices"
 . S DIR("B")="NO"
 . S DIR("?")="'Yes' will flag all payment items on split invoices as rejected, 'No' will prompt for rejection of specific line items."
 . D ^DIR K DIR
 ;
RD1 S DIR(0)="Y",DIR("A")="Want to reject any line items",DIR("B")="NO" D ^DIR K DIR G Q:$D(DIRUT)
 I 'Y G RDD
 ; answered yes to reject line items
 I $P(FZ,U,11)'>0 G NOLINE^FBAADD
 D CK1358^FBAAUTL1 G Q:$D(FBERR)
 D DELC^FBAAVR0:FBTYPE="B9"
 D DELT^FBAAVR1:FBTYPE="B2"
 D DELP^FBAAVR1:FBTYPE="B5"
 D DELM^FBAAVR2:FBTYPE="B3"
 ;
RD2 ; update obligation for rejected lines that are posted by batch
 I FBRFLAG D
 . N FBX
 . S FBRFLAG=0
 . Q:FBAARA'>0
 . S FBX=$$POSTBAT^FB1358(FBN,FBAARA,"R")
 . I 'FBX D
 . . W !,"Error posting $"_$FN(FBAARA,",",2)_" to 1358 for batch "_FBAAB
 . . W !,"  "_$P(FBX,"^",2)
 ;
 ; display batch
 S DIC="^FBAA(161.7,",DA=FBN,DR="0:1;ST" W !! D EN^DIQ
 ;
RDD ; finalize batch functionality
 I '$D(^XUSEC("FBAAFINANCE",DUZ)) W !,"Skipping finalize function because key not held." G DONE
 ;
 ; enforce segregation of duties
 I $P(FZ,U,7)=DUZ W $C(7),!,"You released this batch. Per segregation of duties you cannot finalize it." G DONE
 ;
RDD1 ; ask if batch should be finalized
 S DIR(0)="Y",DIR("A")="Do you want to Finalize Batch as Correct"
 S DIR("B")="NO"
 D ^DIR K DIR G Q:$D(DIRUT)
 I 'Y W !!,"Batch has NOT been Finalized!",$C(7) G DONE
 ;
 ; generate voucher batch message
 S FBX=$$VBMSG^FBAAVR5(FBN)
 I FBX W !,"Voucher Batch message # "_FBX_" sent to Central Fee."
 I 'FBX D  G DONE
 . W !,"Error occurred during creation of voucher batch message."
 . W !,"  ",$P(FBX,U,2)
 . W !!,"Batch has NOT been Finalized!",$C(7)
 ;
 ; finalize batch
 ; update line items
 D MEDV:FBTYPE="B3",VCHNH^FBAAVR0:FBTYPE="B9"
 ; update batch file
 S DA=FBN,DIE="^FBAA(161.7,"
 S DR="13////^S X=DT;14////^S X=DUZ;11////^S X=""V"";20////^S X=1"
 D ^DIE K DIE,DA
 W !!," Batch has been Finalized!"
 ;
DONE ;
 D Q
 G FBAAVR
 ;
Q ; clean-up
 I $G(FBN) L -^FBAA(161.7,FBN)
 K B,J,K,L,M,X,Y,Z,DIC,ERR,FBN,FBAAOUT,FBAC,FBAP,FBFD,FBPDT,FBSC,FBTD,FBVP,POP,FBRFLAG,Q,QQ,A,A1,A2,DO,DA,DL,DR,DRX,DX,FBAAAP,FBAACB,FBAACPT,FBAAON,FBAARA,FBINTOT,FBIN,FBRR,FBTYPE,FZ,HX,I,P3,P4,S,V,VAL,VID,XY,ZS,FBAAB,FBAAOB,DIRUT
 K FBAAON,FBCOMM,FBERR,FBI,FBLIST,PRCS("TYPE"),FBLISTC,FBINOLD,FBDX,FBK,FBL,FBPROC,FBCNH,FBAAMT,FBII78,FBLNLST
 Q
 ;
MEDV ; set DATE FINALIZED for line items in batch type B3
 F J=0:0 S J=$O(^FBAAC("AC",B,J)) Q:J'>0  F K=0:0 S K=$O(^FBAAC("AC",B,J,K)) Q:K'>0  F L=0:0 S L=$O(^FBAAC("AC",B,J,K,L)) Q:L'>0  F M=0:0 S M=$O(^FBAAC("AC",B,J,K,L,M)) Q:M'>0  D SETXFR
 Q
SETXFR I '$D(^FBAAC(J,1,K,1,L,1,M,"FBREJ")),$D(^FBAAC(J,1,K,1,L,1,M,0)) S DA(3)=J,DA(2)=K,DA(1)=L,DA=M,DIE="^FBAAC(DA(3),1,DA(2),1,DA(1),1,",DR="5///^S X=DT" D ^DIE K DIE,DA,DR
 Q
 ;
 ;FBAAVR
