SPNDDXFR ;SD/CM- UPDATES REG STATUS BASED ON DEATH STATUS; 4-29-99
 ;;2.0;Spinal Cord Dysfunction;**11**;01/02/97
 ;
DOD ; Called by Mumps x-ref ASPN when editing Date of Death (file 2).
 S U="^"
SET Q:'$D(X)
 Q:'$D(^SPNL(154,DA))
 I $P($G(^DPT(DA,.35)),U,1)'="",(X'="") S $P(^SPNL(154,DA,0),U,3)="X" S DIK="^SPNL(154,",DIK(1)=".03" D EN^DIK
SENDMM ;
 I $P($G(^DPT(DA,.35)),U,1)="" D ALIVE
 G EXIT
ALIVE ;
 S SPNARR(1)="     ******** Patient NOT Deceased ********"
 S SPNARR(2)=" "
 S SPNARR(3)="This is to alert you that a patient marked as 'deceased'"
 S SPNARR(4)="in the PATIENT file has been corrected to 'NOT deceased'."
 S SPNARR(5)="Please check this patient's record in the SCD Registry to"
 S SPNARR(6)="ensure the Registration Status field is updated."
 S SPNARR(7)=" "
 S SPNARR(8)="Patient's name is ----> "_$P(^DPT(DA,0),U,1)
 S SPNARR(9)="Patient's SSN  is ----> "_$P(^DPT(DA,0),U,9)
 S XMSUB="UPDATE REGISTRATION STATUS - SCI PATIENT"
 S XMDUZ="SCD REGISTRY"
MSG ;
 S XMTEXT="SPNARR("
 S XMY("G.SPNL SCD COORDINATOR")=""
SEND ;
 D ^XMD
 Q
EXIT ;
 K SPNARR,DIK,XMDUZ,XMSUB,XMTEXT,XMY
 Q
