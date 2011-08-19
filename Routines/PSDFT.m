PSDFT ;B'ham ISC/JPW,LTL - File NDES Info ; 26 June 95
 ;;3.0; CONTROLLED SUBSTANCES ;**66**;13 Feb 97;Build 3
LOOP ;loop thru data from DFT message
 N NAOU,PSD,PSDPID,PSDPV1,PSDFT1,PSDZPM,PSDM,PSDTYP,NUR1,NUR2,PAT
 S PSDPID=$G(^HL(772,HLDA,"IN",3,0)),PSDPV1=$G(^HL(772,HLDA,"IN",4,0))
 S PSDFT1=$G(^HL(772,HLDA,"IN",5,0)),PSDZPM=$G(^HL(772,HLDA,"IN",6,0))
 S NAOU=$P($P(PSDPV1,HLFS,4),$E(HLECH))
 S NAOU(1)=0 F  S NAOU(1)=$O(^PSD(58.8,"AB",+NAOU,NAOU(1)))  Q:$P($G(^PSD(58.8,+NAOU(1),0)),U,2)="N"!('NAOU(1))
 S:'NAOU(1) PSDM(1)="* "_$S(NAOU']"":"No Ward Location",'$D(^DIC(42,+NAOU)):NAOU_" is not a valid Ward Location (IEN).",1:$P($G(^DIC(42,+NAOU,0)),U)_" is not linked to an NAOU.")
 S PSDTYP=$E($P(PSDFT1,HLFS,7)),PSDTYP(1)=$S(PSDTYP="D":17,PSDTYP="W":18,PSDTYP="R":3,PSDTYP="V":17,1:"")
 S:'PSDTYP(1) PSDM(2)="* "_$S(PSDTYP']"":"No type",1:PSDTYP_" is not a valid action,")_" must be (D)ispensed, (W)asted, or (R)eturned."
 S NUR1=$P(PSDFT1,HLFS,21),NUR1(1)=+NUR1
 S:'$D(^VA(200,NUR1(1),0)) PSDM(3)="* "_$S(NUR1(1):NUR1(1)_" is invalid ID",1:"No Nurse ID")_" for "_$S($P(NUR1,$E(HLECH),2)]"":$P(NUR1,$E(HLECH),2),1:"Unknown Nurse")
 S NUR2=$P(PSDZPM,HLFS,15),NUR2(1)=+NUR2
 S:PSDTYP="W"&('$D(^VA(200,NUR2(1),0))) PSDM(3.5)="* "_$S(NUR2(1):NUR2(1)_" is invalid witness ID",1:"No witness ID")_" for "_$S($P(NUR2,$E(HLECH),2)]"":$P(NUR2,$E(HLECH),2),1:"Unknown Witness")
 S PAT=+$P(PSDPID,HLFS,4)
 S:'$D(^DPT(PAT)) PSDM(4)="* "_$S(PAT:PAT_" is an invalid ID",1:"NO ID")_" for "_$S($P(PSDPID,HLFS,6)]"":$$FMNAME^HLFNC($P(PSDPID,HLFS,6)),1:"UNKNOWN PATIENT")
 S PSDR=$P(PSDFT1,HLFS,8)
 S:'$D(^PSD(58.8,+NAOU(1),1,+PSDR)) PSDM(5)="* Drug #"_$S($P(PSDR,$E(HLECH))]"":$P(PSDR,$E(HLECH))_" is not stocked,",1:"No drug ID")_" drug:  "_$S($P(PSDR,$E(HLECH),2)]"":$P(PSDR,$E(HLECH),2),1:"UNKNOWN DRUG")
 S QTY=+$P(PSDFT1,HLFS,11),NUR2="" S:PSDTYP(1)="R" QTY=-QTY
 S PSDT=$$FMDATE^HLFNC($P($G(^HL(772,HLDA,"IN",1,0)),HLFS,7))
 S Y=PSDT X ^DD("DD") S %DT="RX",(X,PSDT(1))=Y D ^%DT
 S:Y<1 PSDM(6)="* "_PSDT(1)_" is an not a valid date, exact date/time are required."
 D:$O(PSDM(0))
 .N PSD D KILL^XM
 .S XMSUB="Narcotic Dispensing Equipment System Error"
 .S XMDUZ="Interface Monitor"
 .D XMZ^XMA2 I XMZ<1 D KILL^XM Q
 .S XMY(DUZ)="",PSD=0
 .F  S PSD=$O(^XUSEC("PSD ERROR",PSD)) Q:'PSD  S XMY(PSD)=""
 .S PSDM(.1)="The following transmission did NOT update the Controlled Substances package:",PSDM(.2)=""
 .S:NAOU(1) PSDM(.3)="NAOU:  "_$P($G(^PSD(58.8,+NAOU(1),0)),U)
 .S:PSDTYP(1) PSDM(.4)="Transaction type:  "_$S("DV"[PSDTYP:"Dispensed",PSDTYP="R":"Returned",1:"Wasted")
 .S:'$D(PSDM(3)) PSDM(.5)="Nurse:  "_$P($G(^VA(200,+NUR1,0)),U)
 .S:PSDTYP="W"&('$D(PSDM(3.5))) PSDM(.51)="Witness:  "_$P($G(^VA(200,+NUR2,0)),U)
 .S:'$D(PSDM(4)) PSDM(.6)="Patient:  "_$P($G(^DPT(PAT,0)),U)
 .S:'$D(PSDM(5)) PSDM(.7)="Drug:  "_$P($G(^PSDRUG(+PSDR,0)),U)_"  QTY:  "_QTY
 .S:'$D(PSDM(6)) PSDM(.8)="Date/Time:  "_PSDT(1)
 .S PSDM(.9)="",PSDM(.91)="No update occurred to Controlled Substances",PSDM(.92)="because of the following discrepancy:",PSDM(.93)=""
 .S XMTEXT="PSDM(" D ^XMD,KILL^XM
 S QTY=-QTY
 D:QTY&('$D(PSDM)) UPDATE
 ;Send ack back
 S HLSDATA(2)="MSA"_HLFS_"AA"_HLFS_$P(HLSDATA(1),HLFS,10)_HLFS_"MESSAGE PROCESSED",HLEVN=1 D EN1^HLTRANS
END K %,%DT,%H,%I,BAL,CQTY,DA,DIC,DIE,DIK,DINUM,DLAYGO,DR,JJ,LQTY,NAOUN,NODE,OK,OQTY,ORD
 K PAT,PATL,PSD,PSDER,PSDPN,PSDR,PSDREC,PSDRN,PSDT,PSDTN,QTY,WQTY,X,Y
OP Q
UPDATE ;update 58.8 and 58.81
 ;updating drug balance in 58.8
 F  L +^PSD(58.8,+NAOU(1),1,+PSDR,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
 D NOW^%DTC S PSDTN=+%
 S BAL=$P(^PSD(58.8,+NAOU(1),1,+PSDR,0),"^",4),$P(^(0),"^",4)=$P(^(0),"^",4)+QTY
 L -^PSD(58.8,+NAOU(1),1,+PSDR,0)
ADD ;find entry number in 58.81
 F  L +^PSD(58.81,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND S PSDREC=$P(^PSD(58.81,0),"^",3)+1 I $D(^PSD(58.81,PSDREC)) S $P(^PSD(58.81,0),"^",3)=PSDREC G FIND
 K DIC,DLAYGO S DIC(0)="L",(DIC,DLAYGO)=58.81,(X,DINUM)=PSDREC D ^DIC K DIC,DLAYGO
 L -^PSD(58.81,0)
EDIT ;edit new transaction in 58.81
 S ^PSD(58.81,PSDREC,0)=PSDREC_"^"_PSDTYP(1)_"^"_+NAOU(1)_"^"_PSDT_"^"_+PSDR_"^"_QTY_"^^^^"_BAL_"^^^^^^^^"_+NAOU(1)_"^^"
 ;get specialty for patient
 S DFN=PAT,VAROOT="PSD" D INP^VADPT
 S ^PSD(58.81,PSDREC,9)=PAT_"^"_+NUR1_"^^"_$S(PSDTYP(1)=18:-QTY,1:"")_"^^"_NUR2_"^^^^^^^"_$P($G(^DIC(45.7,+PSD(3),0)),U,2)
 S ^PSD(58.81,PSDREC,"CS")=1
 K DA,DIK,PSD,VAERR S DA=PSDREC,DIK="^PSD(58.81," D IX^DIK K DA,DIK
 W "."
 Q
ERR ;err log update
 F  L +^PSD(58.89,0):$S($G(DILOCKTM)>0:DILOCKTM,1:3) I  Q
FIND9 S PSDER=$P(^PSD(58.89,0),"^",3)+1 I $D(^PSD(58.89,PSDER)) S $P(^PSD(58.89,0),"^",3)=PSDER G FIND9
 K DIC,DLAYGO S DIC(0)="L",(DIC,DLAYGO)=58.89,(X,DINUM)=PSDER D ^DIC K DIC,DLAYGO
 L -^PSD(58.89,0)
EDIT9 ;edit error log
 K DA,DIE,DR S DA=PSDER,DIE=58.89,DR="1////"_PSDREC_";2////"_PSDT_";6////"_NAOU D ^DIE K DA,DIE,DR
 D ^PSDFILM
 Q
