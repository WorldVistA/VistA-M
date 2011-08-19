SROPRIN ;B'HAM ISC/MAM - PRINCIPAL ANESTHESIA TECHNIQUE; 5 Jan 1989  8:31 AM
 ;;3.0; Surgery ;**22,26,32,38**;24 Jun 93
PRIN I $P(^SRF(SRTN,6,SRT,0),"^",3)="Y" S SRTECH=$P(^SRF(SRTN,6,SRT,0),"^"),SRZ=1 Q
 I SRT=$O(^SRF(SRTN,6,0)),'$O(^SRF(SRTN,6,SRT)) S SRTECH=$P(^SRF(SRTN,6,SRT,0),"^"),SRZ=1
 Q
CHECK ; check for already existing Principal Technique
 Q:$E(X)="N"
 S (SRPT,SRT)=0 F  S SRT=$O(^SRF(DA(1),6,SRT)) Q:'SRT!SRPT  I SRT'=DA,$P(^(SRT,0),"^",3)="Y" W *7,!!,"An anesthesia technique has already been selected as 'PRINCIPAL' technique.",! S SRPT=1 K X
 K SRPT,SRT
 Q
TECH ; entry from reports to get principal technique
 K SRTECH,SRZ S SRT=0 F  S SRT=$O(^SRF(SRTN,6,SRT)) Q:'SRT  D PRIN Q:$D(SRZ)
 I $D(SRTECH) D ANES
 I '$D(SRTECH) S SRTECH="NOT ENTERED"
 Q
ANES ; anesthesia technique
 N C
 S Y=SRTECH,C=$P(^DD(130.06,.01,0),"^",2) D Y^DIQ S SRTECH=Y
 Q
