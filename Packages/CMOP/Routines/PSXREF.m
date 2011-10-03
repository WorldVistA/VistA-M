PSXREF ;BIR/BAB-Cross Reference Utility ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
ACT ;Entry point to create xref for CMOP Dispense field edit
 Q:$G(^PSDRUG(DA,3))=""
 S:'$D(^PSDRUG(DA,4,0)) ^PSDRUG(DA,4,0)="^50.0214DA^^"
 S (PSX,Z)=0 F  S Z=$O(^PSDRUG(DA,4,Z)) Q:'Z  S PSX=Z
 S PSX=PSX+1 D NOW^%DTC S ^PSDRUG(DA,4,PSX,0)=%_"^E^"_DUZ_"^CMOP Dispense^"_$S($G(^PSDRUG(DA,3))=1:"YES",$G(^PSDRUG(DA,3))=0:"NO",1:"")
 S $P(^PSDRUG(DA,4,0),"^",3)=PSX,$P(^(0),"^",4)=$P(^(0),"^",4)+1
 K PSX,Z,% Q
DEL ;  Called by ^DD(52.1,.01,"DEL",550,0)- PREVENTS DELETING REFILL DATE
 I $G(PSX(DA))]"",($G(PSX(DA))="L"!(+$G(PSX(DA))'=3)) D
 .W !!,"You cannot delete a refill date for a fill that is"_$S(+$G(PSX(DA))=1:" released by",+$G(PSX(DA))=0:" in transmission to",1:" being retransmitted to")_" the CMOP",!!
 Q
AR ; Sets the "AR" xref if CMOP status in 52 =1      
 ; ^PSRX("AR",RELEASE D/T,INTERNAL ENTRY # RX in 52,fill #
 I X=1 D
 .I $P(^PSRX(DA(1),4,DA,0),U,3)=0,($P($G(^PSRX(DA(1),2)),U,13)) S ^PSRX("AR",$P(^PSRX(DA(1),2),U,13),DA(1),$P(^PSRX(DA(1),4,DA,0),U,3))=""
 .I $P(^PSRX(DA(1),4,DA,0),U,3)>0,($D(^PSRX(DA(1),1,$P(^PSRX(DA(1),4,DA,0),U,3),0))),($P($G(^PSRX(DA(1),1,$P(^PSRX(DA(1),4,DA,0),U,3),0)),U,18)]"") D
 ..S ^PSRX("AR",$P(^PSRX(DA(1),1,$P(^PSRX(DA(1),4,DA,0),U,3),0),U,18),DA(1),$P(^PSRX(DA(1),4,DA,0),U,3))=""
 Q
AS ; Transmission D/T xref
 ; ^PSRX("AS",TRANS D/T,INTERNAL ENTRY # RX in 52, fill #
 S ^PSRX("AS",$P(^PSX(550.2,$P(^PSRX(DA(1),4,DA,0),U),0),U,6),DA(1),$P(^PSRX(DA(1),4,DA,0),U,3))=""
 Q
ASKILL ;
 ;K ^PSRX("AS",$P(^PSX(550.2,$P(^PSRX(DA(1),4,DA,0),U),0),U,6),DA(1),$P(^PSRX(DA(1),4,DA,0),U,3))
 Q
DISPUNIT ;Called by ^DD(50,14.5,"DEL",0) to prevent deleting CMOP disp units. 
 I $D(^PSDRUG("AQ",DA)) W !,"The Dispense Unit of a CMOP drug cannot be deleted!",!
 Q
