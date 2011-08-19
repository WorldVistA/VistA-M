PSAAOP ;BIR/DB - Price Conversion Routine;4/3/00
 ;;3.0; DRUG ACCOUNTABILITY/INVENTORY INTERFACE;**21,64**; 10/24/97;Build 4
 ;PSA*3*21 : 14145837
 ;References to ^PSDRUG( are covered by IA #2095
Q K DA,DIE,DIR,DR,PSALOC,PSALOCN,PSAOP,PSAOSITN
 W !!,"PSA*3*21 corrects errors in the way pricing was done in the past. The new",!,"process correctly calculates the price per dispense unit by dividing"
 W !,"the Price per Order Unit by the Dispense Units per Order Unit.",!!,"It loops through each entry in the DRUG file (#50) and corrects any problems"
 W !,"found in the synonym data."
 W !!,"Please note - Because this process checks each NDC in the DRUG file (#50),"
 W !,"it is suggested that you queue the option to run during low usage times."
PRICE R !!,"Fix synonym entries? YES // ",AN:DTIME G NOQ:AN["^" I AN="" S AN="Y"
 S AN=$E(AN,1) I "yYNn"'[AN W !!,"Answer 'Y' for YES, or 'N' for NO." K AN G PRICE
 I "nN"[AN G NOQ
 S PSADUZ=DUZ,ZTSAVE("PSADUZ")=""
 S ZTIO=""
 S ZTRTN="PSANDC^PSAAOP",ZTDESC="Drug Accountability Price Correction" D ^%ZTLOAD,HOME^%ZIS G EXITQ
 ;
PSANDC ;Entry point for price correction
 ;
 K PSADRG,PSACNT,PSADRG1,PSASUB,PSADATA,DRGCNT,FIXCNT
PSADRG S PSADRG1=$S('$D(PSADRG1):$O(^PSDRUG("B",0)),1:$O(^PSDRUG("B",PSADRG1))) G QQ:PSADRG1="" K PSASUB S DRGCNT=$G(DRGCNT)+1,PSADRG=$O(^PSDRUG("B",PSADRG1,0)) I $G(^PSDRUG(PSADRG,0))="" G PSADRG
 S PSANDC=$P($G(^PSDRUG(PSADRG,2)),"^",4) G PSADRG:$G(PSANDC)=""
 ;
PSASUB S PSASUB=$S('$D(PSASUB):$O(^PSDRUG(PSADRG,1,0)),1:$O(^PSDRUG(PSADRG,1,PSASUB))) G PSADRG:PSASUB'>0 S PSADATA=$G(^PSDRUG(PSADRG,1,PSASUB,0)) I $P(PSADATA,"^",2)=PSANDC G DONESUB
 G PSASUB
DONESUB S PSAOU=$P($G(PSADATA),"^",6),PSADUOU=$P($G(PSADATA),"^",7),PSAPDUOU=$J($P($G(PSADATA),"^",8),0,3) I $G(PSAOU)=""!($G(PSADUOU)="") G PSADRG
 ;
 S XX=PSAOU/PSADUOU,NEWPRICE=$J(XX,0,3) I NEWPRICE'=PSAPDUOU D
 .S PSACNT=$S('$D(PSACNT):4,1:$G(PSACNT)+1),^TMP("PSAAOP",$J,PSACNT,0)="NDC       : "_PSANDC_"  Drug Name : "_$E($P($G(^PSDRUG(PSADRG,0)),"^"),1,35)
 .S PSACNT=$S('$D(PSACNT):4,1:$G(PSACNT)+1),^TMP("PSAAOP",$J,PSACNT,0)="Old Price : "_$J(PSAPDUOU,8,3)_"        New Price : "_$J(NEWPRICE,8,3),PSACNT=PSACNT+1,^TMP("PSAAOP",$J,PSACNT,0)=" "
 .S DIE="^PSDRUG(",DA=PSADRG,DR="16///^S X=NEWPRICE" D
 ..F  L +^PSDRUG(PSADRG,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 ..D ^DIE K DIE,DA,DR
 ..S DA(1)=PSADRG,DIE="^PSDRUG("_DA(1)_",1,",DA=PSASUB,DR="404////^S X=NEWPRICE" D ^DIE
 ..L -^PSDRUG(PSADRG,0)
 .S FIXCNT=$G(FIXCNT)+1
 G PSADRG
QQ S ^TMP("PSAAOP",$J,2,0)=$G(DRGCNT)_" items checked, and "_$S($G(FIXCNT)="":0,1:$G(FIXCNT))_" items corrected." K PSADRG,PSAOU,PSADUOU,NEWPRICE,PSAPDUOU,DATA,PSADATA
 S ^TMP("PSAAOP",$J,1,0)="Price correction process results"
 S XMDUZ="Patch: PSA*3*21 price Corrector",XMSUB="Drug Accountability Synonym Fix",XMTEXT="^TMP(""PSAAOP"",$J,"
 S XMY(PSADUZ)=""
 G:'$D(XMY) QQ D ^XMD
 K ^TMP("PSAAOP",$J)
 Q
NOQ W !,"Nothing corrected." Q
EXITQ Q
