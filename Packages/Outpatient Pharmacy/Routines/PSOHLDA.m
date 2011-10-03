PSOHLDA ;BIR/MFR - HOLD/UNHOLD functionality (cont.) ;07/15/96
 ;;7.0;OUTPATIENT PHARMACY;**148,225**;DEC 1997;Build 29
 ;
HOLD ;hold function
 I $P($G(^PSRX(DA,"STA")),"^")=3 Q
 S RSDT=$S($P(^PSRX(DA,2),"^",13):$P(^PSRX(DA,3),"^"),1:"@"),(PSUS,ACT,RXF,RFN,I)=0 F  S I=$O(^PSRX(DA,1,I)) Q:'I  D
 .S RXF=I,RFN=RFN+1 S:RFN=1 RSDT=$S('$P(^PSRX(DA,1,I,0),"^",18):$P(^PSRX(DA,2),"^",2),1:$P(^PSRX(DA,1,I,0),"^"))
 .I RFN>1,'$P(^PSRX(DA,1,I,0),"^",18) S RSDT=$P(^PSRX(DA,1,RXF-1,0),"^") Q
 .S:RFN>1 RSDT=$P(^PSRX(DA,1,RXF,0),"^")
 I RXF D
 .S (PSDA,DA(1))=DA,DA=RXF,DIE="^PSRX("_DA(1)_",1,",DR="4" D ^DIE
 .S $P(^PSRX(DA(1),1,DA,0),"^",3)=$S($G(FLD(99.1))]"":$E(FLD(99.1),1,60),1:"")
 .S DA=PSDA K DA(1)
 S DIE="^PSRX(",DR=$S('RXF&('$P(^PSRX(DA,2),"^",13)):"22///@;",1:"")_"99///"_FLD(99)_";99.1///^S X=FLD(99.1);99.2///"_DT_";100///3;101///"_RSDT D ^DIE Q:$D(Y)
 S:$G(PSOHD) VALMSG="RX# "_$P(^PSRX(DA,0),"^")_" has been placed in a hold status."
 K RXRS(DA)
 I +$G(PSDA) S DA=$O(^PS(52.5,"B",PSDA,0)) I DA S:$P($G(^PS(52.5,DA,"P")),"^")=0 PSUS=1 S DIK="^PS(52.5," D ^DIK K DA,DIK
 S:+$G(PSDA) DA=PSDA D ACT
 S PSOHNX=+$P($G(^PSRX(+$G(DA),"H")),"^") D
 .I $G(PSOHNX),$P($G(^PSRX(DA,"H")),"^",2)'="" S COMM=$P($G(^("H")),"^",2) Q
 .S COMM="Medication placed on Hold "_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)
 D EN^PSOHLSN1(DA,"OH","",COMM,PSONOOR) K COMM,PSOHNX
 ;
 ; - Closes any OPEN/UNRESOLVED REJECTs and Reverses ECME Claim
 D REVERSE^PSOBPSU1(DA,+$G(RXF),"HLD",2)
 Q
 ;
ACT ;adds activity info for rx removed or placed on hold
 D NOW^%DTC S NOW=%
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(DA,"A",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(DA,"A",0)="^52.3DA^"_IR_"^"_IR
 S ^PSRX(DA,"A",IR,0)=NOW_"^"_$S(ACT:"U",1:"H")_"^"_DUZ_"^"_$S(RXF>5:RXF+1,1:RXF)_"^"_"RX "_$S('ACT:"placed in a",1:"removed from")_" HOLD status "_$S(+$G(PSUS):"and removed from SUSPENSE ",1:"")_"("_$E(DT,4,5)_"-"_$E(DT,6,7)_"-"_$E(DT,2,3)_")"
 K PSUS,RXF,I,FDA,DIC,DIE,DR,Y,X,%,%I,%H,RSDT
 Q
 ;
RMP ;remove Rx if found in array PSORX("PSOL")
 Q:'$G(DA)
 N I,J,K,PSOX2,PSOX3,PSOX9 S I=0
 F  S I=$O(PSORX("PSOL",I)) Q:'I  S PSOX2=PSORX("PSOL",I) D:PSOX2[(DA_",")
 .S PSOX9="",K=0 F J=1:1 S PSOX3=$P(PSOX2,",",J) Q:'PSOX3  D
 ..I PSOX3=DA,$P($G(^PSRX(DA,"STA")),"^")=3 S K=1 Q
 ..S PSOX9=PSOX9_$S('PSOX9:"",1:",")_PSOX3
 .I K S:PSOX9]"" PSORX("PSOL",I)=PSOX9_"," K:PSOX9="" PSORX("PSOL",I) D:$D(BBRX(I)) RMB
 Q
RMB ;remove Rx if found in array BBRX()
 S PSOX2=BBRX(I) D:PSOX2[(DA_",")
 .S PSOX9="" F J=1:1 S PSOX3=$P(PSOX2,",",J) Q:'PSOX3  S:PSOX3'=DA PSOX9=PSOX9_$S('PSOX9:"",1:",")_PSOX3
 .S:PSOX9]"" BBRX(I)=PSOX9_"," K:PSOX9="" BBRX(I)
 Q
