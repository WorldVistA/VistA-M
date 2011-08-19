SROASITE ;BIR/SLM-Update Risk Assessment Transmission Status and Date [ 01/30/95  2:12 PM ]
 ;;3.0; Surgery ;**38,54,62**;24 Jun 93
 S TL=0 F I=1:1 X XMREC Q:XMER=-1  S SRAUD(I)=XMRG,TL=TL+1
 S TL=TL-2,X=$E(SRAUD(1),55,66) D ^%DT S SRD=Y
 F J=3:1:TL S SRC=$TR($E(SRAUD(J),13,19)," ","") D
 .I $P($G(^SRF(SRC,"RA")),"^")=""!($P($G(^SRF(SRC,"RA")),"^",2)="C") K DR S DIE=130,DA=SRC S DR="905///T" D ^DIE K DR,DIE,SRC Q
 .I $P($G(^SRF(SRC,"RA")),"^",2)="N" S SRRT=$P($G(^SRF(SRC,"RA")),"^",3) K DR S DIE=130,DA=SRC S DR="260.1///"_SRD_";235///T;905///T" D ^DIE K DR I SRRT'=1 S DR="260///"_SRD D ^DIE K DR,DIE,SRC Q
 K SRAUD,Y,SRD,SRC
 S XMSER="S."_XQSOP,XMZ=XQMSG D REMSBMSG^XMA1C
 Q
