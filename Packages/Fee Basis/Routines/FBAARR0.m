FBAARR0 ;AISC/GRR-REINITIATE BATCH CONTINUED ;26MAY88
 ;;3.5;FEE BASIS;;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
HELP W !!,"Enter the batch number to which the rejected items you re-initiate will",!,"be assigned to. It must be an open batch and assigned to you." G BTN^FBAARR
CHKOB W !!,*7,"The obligation number from the batch with rejects",!,"is not the same as the new batch selected !"
 S DIR(0)="Y",DIR("A")="Do you want to continue",DIR("B")="NO" D ^DIR K DIR G BT^FBAARR:$D(DIRUT)!'Y,ASKLL^FBAARR:Y
 Q
DELC S (QQ,FBAAOUT)=0 W @IOF D HEDC^FBAACCB1
 F I=0:0 S I=$O(^FBAAI("AH",B,I)) Q:I'>0!(FBAAOUT)  I $D(^FBAAI(I,0)) S Z(0)=^(0) D WRITC
RL S ERR=0 S DIR(0)="N^1:"_QQ,DIR("A")="Re-Initiate which line item" D ^DIR K DIR G:$D(DIRUT) END^FBAARR S HX=X
 I '$D(QQ(HX)) W !,*7,"You already did that one !!" G RL
ASKSU S DIR(0)="Y",DIR("A")="Are you sure you want to re-initiate line item number:  "_HX,DIR("B")="NO" D ^DIR K DIR G:$D(DIRUT)!'Y RL
 S I=QQ(HX) I $P(^FBAAI(I,0),"^",14)="VP" S FBIN=I D VOID^FBAARR1 Q
 S $P(^FBAAI(I,0),"^",17)=FBNB,FBAAAP=+$P(^(0),"^",9),^FBAAI("AC",FBNB,I)="",^FBAAI("AE",FBNB,$P(^FBAAI(I,0),"^",4),I)="" K ^FBAAI("AH",B,I)
 S FZ(0)=^FBAA(161.7,FBNB,0),$P(FZ(0),"^",9)=$P(FZ(0),"^",9)+FBAAAP,$P(FZ(0),"^",10)=$P(FZ(0),"^",10)+1,$P(FZ(0),"^",11)=$P(FZ(0),"^",11)+1,^FBAA(161.7,FBNB,0)=FZ(0) K ^FBAAI(I,"FBREJ")
ASKRI S DIR(0)="Y",DIR("A")=$S($G(FBERR):"",1:"Item Re-initiated.  ")_"Want to re-initiate another",DIR("B")="YES" D ^DIR K DIR G ASKRI:$D(DIRUT),DELC:Y
FIN I '$D(^FBAAI("AH",FBN)) S $P(^FBAA(161.7,FBN,0),"^",17)=""
 Q
WRITC S QQ=QQ+1,QQ(QQ)=I D CMORE^FBAACCB1 Q
 ;
NEWBT S FBSTN=$P(FZ,"^",8),FBDCB=$P(FZ,"^",13)
 W ! D GETNXB^FBAAUTL W !!,*7,"New Batch for Rejects is: ",FBBN
 S DLAYGO=161.7,X=FBBN,DIC(0)="LQ",DIC("DR")="1////^S X=FBOB;2////^S X=""B9"";3////^S X=DT;4////^S X=DUZ;4.5////^S X=FBDCB;11////^S X=$S(FBEXMPT[""Y"":""O"",1:""A"");16////^S X=FBSTN;17////^S X=""Y"";18////^S X=FBEXMPT"
 K DD,DO D FILE^DICN K DIC S FBNB=+Y
 S FBNUM=$P(FZ,"^",1),FBVD=$P(FZ,"^",12),FBVDUZ=$P(FZ,"^",16),FBNOB=FBOB
 Q
