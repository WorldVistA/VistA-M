PSDNTTP1 ;BIR/BJW-Transfer Green Sheet - Receive this NAOU ; 7/9/07 10:02am
 ;;3.0; CONTROLLED SUBSTANCES ;**64**;13 Feb 97;Build 33
COM ;complete order and transaction
 S FLAG=0 D NOW^%DTC S PSDT=X,(RECD,Y)=+$E(%,1,12) X ^DD("DD") S RECDT=Y
 W !!,"Accessing ",PSDRGN," information...",!!
 I '$D(^PSD(58.8,+AOU,1,+PSDRG,0)) D DRUG
 W !!,"Updating your records now..."
DIE ;create the order request in 58.8
 S:'$D(^PSD(58.8,AOU,1,PSDRG,3,0)) ^(0)="^58.800118A^^"
 S PSDRN=$P(^PSD(58.8,AOU,1,PSDRG,3,0),"^",3)+1 I $D(^PSD(58.8,AOU,1,PSDRG,3,PSDRN)) S $P(^PSD(58.8,AOU,1,PSDRG,3,0),"^",3)=$P(^PSD(58.8,AOU,1,PSDRG,3,0),"^",3)+1 G DIE
 W "order..."
 K DA,DIC,DIE,DD,DR,DO S DIC(0)="L",(DIC,DIE)="^PSD(58.8,"_AOU_",1,"_PSDRG_",3,",DA(2)=AOU,DA(1)=PSDRG,(X,DINUM)=PSDRN D FILE^DICN K DIC
 S DA=PSDRN,DA(1)=PSDRG,DA(2)=AOU
 S STAT=$S(+$P($G(^PSD(58.8,AOU,2)),U,5):13,1:4)
 S DR="16////"_PSDPN_";14////"_PSDSP_";15////"_RECD_";2////"_+PSDS_";6////"_PSDUZ_";7////"_MFG_";8////"_LOT_";9////"_EXP_";10////"_STAT_";19////"_QTY_";20////"_RQTY_";22////"_RQTY
 D ^DIE K DIE,DR
 W "transaction..."
ADD ;find entry number in 58.81
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDREC=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDREC)) S $P(^PSD(58.81,0),"^",3)=PSDREC G FIND
 K DIC,DLAYGO S DIC(0)="L",(DIC,DLAYGO)=58.81,(X,DINUM)=PSDREC D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
EDIT ;edit new transaction in 58.81
 I $P($G(^PSD(58.81,PSDREC,0)),"^")
 S STAT=$S(+$P($G(^PSD(58.8,AOU,2)),U,5):13,1:4)
 S ^PSD(58.81,PSDREC,0)=PSDREC_"^5^"_PSDS_"^"_RECD_"^"_PSDRG_"^"_RQTY_"^^^^^"_STAT_"^^"_MFG_"^"_LOT_"^"_EXP_"^^"_PSDPN_"^"_AOU_"^^"_PSDRN
 S ^PSD(58.81,PSDREC,1)="^^"_PSDUZ_"^"_RECD_"^^^^"_RQTY
 S ^PSD(58.81,PSDREC,7)="^^^^^"_PSDA,^PSD(58.81,PSDREC,9)=PAT
 S ^PSD(58.81,PSDREC,"CS")=1,$P(^PSD(58.81,PSDREC,"CS"),"^",4)=1
 K DA,DIK S DA=PSDREC,DIK="^PSD(58.81," D IX^DIK K DA,DIK
 ;update new order and prev trans #
 S $P(^PSD(58.8,AOU,1,PSDRG,3,PSDRN,0),"^",17)=PSDREC
 S $P(^PSD(58.81,PSDA,7),"^",4)=RECD,$P(^(7),"^",5)=PSDUZ,$P(^(7),"^",3)=AOU
BAL ;update naou to balance  ; *64 - balance will not change
COMP ;completed msg
 W "done.",!!
 S STAT=$P($G(^PSD(58.81,PSDREC,0)),"^",11)
 W ?2,!,"*** The status of your Green Sheet #"_PSDPN_" is now",!,?2,$S($P($G(^PSD(58.82,STAT,0)),"^")]"":$P(^(0),"^"),1:"UNKNOWN")_" ***",!
 G:'FLAG END
MSG ;send mail message
 K XMY,^TMP("PSDNTMSG",$J) S ^TMP("PSDNTMSG",$J,1,0)="CS PHARM Transfer Green Sheet between NAOUs",^TMP("PSDNTMSG",$J,2,0)="Transfer In Date: "_RECDT
 S ^TMP("PSDNTMSG",$J,3,0)=""
 S ^TMP("PSDNTMSG",$J,4,0)="Drug: "_PSDRGN_"      Green Sheet #"_PSDPN
 S ^TMP("PSDNTMSG",$J,5,0)="Transfer to: "_AOUN
 S ^TMP("PSDNTMSG",$J,6,0)="",^TMP("PSDNTMSG",$J,7,0)="This drug has been inactivated."
 S XMSUB="CS PHARM TRANSFER GREEN SHEET INACTIVATE DRUG",XMTEXT="^TMP(""PSDNTMSG"",$J,",XMDUZ="CONTROLLED SUBSTANCES PHARMACY"
 F JJ=0:0 S JJ=$O(^XUSEC("PSDMGR",JJ)) Q:'JJ  S XMY(JJ)=""
 S:'$D(XMY) XMY(.5)="" D ^XMD K XMY,^TMP("PSDNTMSG",$J)
END Q
DRUG ;add drug and inactivate it
 S:'$D(^PSD(58.8,AOU,1,0)) ^(0)="^58.8001IP^^"
 K DA,DIC,DIE,DD,DO S (DIC,DIE)="^PSD(58.8,"_AOU_",1,",(X,DINUM)=+PSDRG,DA(1)=AOU,DIC(0)="L" D FILE^DICN K DIC I Y<0 S PSDOUT=1 Q
 K DA,DR S DA=PSDRG,DA(1)=AOU,DR="13////"_PSDT_";14////O;14.5////TRANSFER FROM ANOTHER NAOU" D ^DIE K DA,DIE,DR
 S FLAG=1
 Q
