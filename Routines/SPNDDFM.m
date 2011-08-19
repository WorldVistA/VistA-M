SPNDDFM ;SD/CM- UPDATES REG STATUS USING FIELD MONITOR; 7-9-01
 ;;2.0;Spinal Cord Dysfunction;**18**;01/02/97
 ;
EDIT ;
 Q:'$D(^SPNL(154,DGDA))
 Q:$P(^SPNL(154,DGDA,0),U,3)=""
 S SPNOLD=$P(^SPNL(154,DGDA,0),U,3)
 I $P($G(^DPT(DGDA,.35)),U,1)'="" K ^SPNL(154,"AD",SPNOLD,DGDA) S DIE="^SPNL(154,",DA=DGDA,DR=".03///EXPIRED" D ^DIE
 D CHK^SPNHL7(DGDA)
 K DA,DIE,DR,SPNOLD
 Q
DEL ;
 Q:'$D(^SPNL(154,DGDA))
 Q:$P(^SPNL(154,DGDA,0),U,3)=""
 Q:$P(^SPNL(154,DGDA,0),U,3)'="X"
 I $P($G(^DPT(DGDA,.35)),U,1)="" D DEL2
 K SPNARR,XMDUZ,XMSUB,XMTEXT,XMY
 Q
DEL2 ;
 S SPNARR(1)="     ******** Patient NOT Expired ********"
 S SPNARR(2)=" "
 S SPNARR(3)="This is to alert you that a patient marked as 'Expired'"
 S SPNARR(4)="in the SCD Registry is alive according to MAS records."
 S SPNARR(4.2)="Notify your hospital's MAS personnel -- it is possible"
 S SPNARR(4.4)="that the patient is indeed deceased, but Date of Death"
 S SPNARR(4.6)="was not entered into pt's VA record."
 S SPNARR(5)="However, if this patient is truely alive, please update"
 S SPNARR(6)="his Registration Status field in the SCD Registry."
 S SPNARR(7)=" "
 S SPNARR(8)="Patient ----> "_$E($P($G(^DPT(DGDA,0)),U,1),1)_$E($P($G(^DPT(DGDA,0)),U,9),6,9)
 S XMSUB="PT DEATH: MAS RECORD vs. SCD RECORD"
 S XMDUZ="SCD REGISTRY"
MSG ;
 S XMTEXT="SPNARR("
 S XMY("G.SPNL SCD COORDINATOR")=""
SEND ;
 D ^XMD
 Q
