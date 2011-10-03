SPNDODCK ;SD/CM- UPDATES REG STATUS BASED ON DEATH STATUS; 4-4-01
 ;;2.0;Spinal Cord Dysfunction;**15,19**;01/02/97
 ;
LOOP(SPNPD0) ;
 Q:'$D(^SPNL(154,SPNPD0,0))
 Q:$P(^SPNL(154,SPNPD0,0),U,3)=""
 S SPNOLD=$P(^SPNL(154,SPNPD0,0),U,3)
 ;I $P($G(^DPT(SPNPD0,.35)),U,1)'="" K ^SPNL(154,"AD",SPNOLD,SPNPD0) S $P(^SPNL(154,SPNPD0,0),U,3)="X" S DA=SPNPD0,DIK="^SPNL(154,",DIK(1)=".03" D EN^DIK
 I $P($G(^DPT(SPNPD0,.35)),U,1)'="" K ^SPNL(154,"AD",SPNOLD,SPNPD0) S DIE="^SPNL(154,",DA=SPNPD0,DR=".03///EXPIRED" D ^DIE
 K DA,DIE,DR,SPNOLD,SPNPD0
 Q
 ;
LOOP2(SPNPD0) ;
 N DIFROM
 Q:'$D(^SPNL(154,SPNPD0,0))
 Q:$P(^SPNL(154,SPNPD0,0),U,3)=""
 Q:$P(^SPNL(154,SPNPD0,0),U,3)'="X"
 I $P($G(^DPT(SPNPD0,.35)),U,1)="" D LOOP3
 K SPNARR,SPNPD0,XMDUZ,XMSUB,XMTEXT,XMY
 Q
LOOP3 ;
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
 S SPNARR(8)="Patient ----> "_$E($P($G(^DPT(SPNPD0,0)),U,1),1)_$E($P($G(^DPT(SPNPD0,0)),U,9),6,9)
 S XMSUB="PT DEATH: MAS RECORD vs. SCD RECORD"
 S XMDUZ="SCD REGISTRY"
MSG ;
 S XMTEXT="SPNARR("
 S XMY("G.SPNL SCD COORDINATOR")=""
SEND ;
 D ^XMD
 Q
