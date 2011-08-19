PSOCPTRH ;BHAM ISC/SAB,RTR - PUT IN CHAMPUS HOLD ; 4/29/93 10:55
 ;;7.0;OUTPATIENT PHARMACY;;DEC 1997
ACT ;adds activity info for rx removed or placed on hold
 D NOW^%DTC S NOW=%
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(DA,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 S ^PSRX(DA,"A",IR,0)=NOW_"^"_ACT_"^"_DUZ_"^"_$S(RXF'<0&(RXF<6):RXF,1:(RXF+1))_"^"_"RX "_"Rx placed in a HOLD status for CHAMPUS billing."
 K PSUS,RXF,I,FDA,DIC,DIE,DR,Y,X,%,%I,%H,RSDT
 Q
 ;
H ;hold function
 I $P($G(^PSRX(DA,"STA")),"^")=3 Q
 S RSDT="@",ACT="H",(PSUS,RXF,RFN,I)=0 F  S I=$O(^PSRX(DA,1,I)) Q:'I  D
 .S RXF=I,RFN=RFN+1 S:RFN=1 RSDT=$P(^PSRX(DA,2),"^",2) S:RFN>1 RSDT=$P(^(I-1,0),"^")
 I RXF S (PSDA,DA(1))=DA,DA=RXF S $P(^PSRX(DA(1),1,RXF,0),"^",3)="CHAMPUS billing",$P(^(0),"^",5)=$G(DUZ) S DA=PSDA K DA(1)
 S PSHORX=DA S DIE="^PSRX(",DR=$S('RXF:"22///@;",1:"")_"99///"_FLD(99)_";99.1///"_FLD(99.1)_";99.2///"_DT_";100///3;101///"_RSDT D ^DIE
 S DA=PSHORX D EN^PSOHLSN1(DA,"OH","","Rx placed in hold status (CHAMPUS billing)","A") S DA=PSHORX K PSHORX
 W !!,"RX# "_$P(^PSRX(DA,0),"^")_" Has been placed in a Hold status. (CHAMPUS BILLING)",!
 I $G(PSTRIVER) K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 I +$G(PSDA) S DA=$O(^PS(52.5,"B",PSDA,0)) I DA S DIK="^PS(52.5,",PSUS=1 D ^DIK K DA,DIK
 S:+$G(PSDA) DA=PSDA D ACT
 Q
