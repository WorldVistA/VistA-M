PSDTRV1 ;BIR/JPW-Transfer CS Drugs between Vaults (cont'd) ; 17 Nov 93
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
UPDATE ;update vault balances
 D CHK G:PSDLES END
 W !!,"Updating vault on-hand balances now..." F CNT=1:1:2 D CALC
 W "done!",!! D:ADD MSG
 S (ADD,PSDOUT)=0
END K %,%H,%I,BAL,CNT,DA,DD,DIC,DIE,DINUM,DIR,DIROUT,DIRUT,DLAYGO,DO,DR,DTOUT,DUOUT,EXP,JJ,LOT,MFG,NBKU,NPKG,PSDT,PSDLES,PSDR,PSDREC,PSDRN
 K QTY,RDT,TEMP,TQTY,VAULT,VAULTN,X,XMDUZ,XMSUB,XMTEXT,XMY,Y
 Q
CALC ;sub/add qty from dsp sites
 W $S(CNT=2:VAULTN,1:PSDSN)_"..."
 S TEMP=$S(CNT=2:VAULT,1:PSDS),TQTY=-TQTY
 F  L +^PSD(58.8,TEMP,1,PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDT=+%
 S BAL(CNT)=$P(^PSD(58.8,TEMP,1,PSDR,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)+TQTY,$P(BAL(CNT),"^",2)=+BAL(CNT)+TQTY
 L -^PSD(58.8,TEMP,1,PSDR,0)
ADD ;find entry number
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDREC=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDREC)) S $P(^PSD(58.81,0),"^",3)=PSDREC G FIND
 K DIC,DLAYGO S DIC(0)="L",(DIC,DLAYGO)=58.81,(X,DINUM)=PSDREC D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
DIE ;update transaction data
 K DA,DIE,DR S DA=PSDREC,DIE=58.81
 S DR="1////16;2////"_+TEMP_";4////"_PSDR_";3////"_PSDT_";Q;5////"_TQTY_";6////"_PSDUZ_";9////"_$P(BAL(CNT),"^")_";100////1"
 D ^DIE K DA,DIE,DR W !,"Still updating..."
 ;update vault drug info
 I CNT=2 K DA,DIE,DR S DIE="^PSD(58.8,"_+TEMP_",1,",DA(1)=+TEMP,DA=+PSDR,DR="I 'ADD S Y=9;7////"_NBKU_";8////"_NPKG_";9////"_MFG_";10////"_LOT_";11////"_EXP D ^DIE K DA,DIE,DR
 S:'$D(^PSD(58.8,+TEMP,1,+PSDR,4,0)) ^PSD(58.8,+TEMP,1,+PSDR,4,0)="^58.800119PA^^"
 I '$D(^PSD(58.8,+TEMP,1,+PSDR,4,PSDREC,0)) K DA,DIC,DD,DO S DIC(0)="L",DIC="^PSD(58.8,"_+TEMP_",1,"_+PSDR_",4,",DA(2)=+TEMP,DA(1)=+PSDR,(X,DINUM)=PSDREC D FILE^DICN K DA,DIC
 Q
CHK ;check for valid bal
 S PSDLES=0 D:TQTY>$P(^PSD(58.8,PSDS,1,PSDR,0),"^",4)
 .W $C(7),!!,"=>   The drug balance is "_+$P(^PSD(58.8,PSDS,1,PSDR,0),"^",4)_".  You cannot transfer "_TQTY_" for this drug.",! S PSDLES=1
 .W "No action taken.",!
 Q
MSG ;send mailman message with transfer info
 K XMY,^TMP("PSDTRV",$J) D NOW^%DTC S Y=X X ^DD("DD") S RDT=Y S ^TMP("PSDTRV",$J,1,0)="Controlled Substances have been transferred between Dispensing Sites."
 S ^TMP("PSDTRV",$J,2,0)="Run Date: "_RDT,^TMP("PSDTRV",$J,3,0)=""
 S ^TMP("PSDTRV",$J,4,0)="Drug: "_PSDRN
 S ^TMP("PSDTRV",$J,5,0)="Transferred from: "_PSDSN,^TMP("PSDTRV",$J,6,0)="Transferred and Added to: "_VAULTN
 S ^TMP("PSDTRV",$J,7,0)="Quantity ("_NBKU_"): "_TQTY,^TMP("PSDTRV",$J,8,0)="Pharmacist: "_PSDUZN
 S XMSUB="CS DRUG TRANSFER BETWEEN VAULTS",XMTEXT="^TMP(""PSDTRV"",$J,",XMDUZ="CONTROLLED SUBSTANCES PHARMACY" F JJ=0:0 S JJ=$O(^XUSEC("PSDMGR",JJ)) Q:'JJ  S XMY(JJ)=""
 S:'$D(XMY) XMY(.5)="" D ^XMD K XMY,^TMP("PSDTRV",$J)
 Q
