SCMCHLP ;ALB/JDS PCMM WORKLOAD MESSAGE ; 28 Feb 2003  7:54 AM  ; Compiled July 8, 2008 16:29:48
 ;;5.3;Scheduling;**272,297,534**;AUG 13, 1993;Build 8
 ;this version reverts BUILD & SUM to pre 297 - swo/largo 3.31.2006
 ;Ftee message
EVN(DATE,ASSDT) ;create evn segment
 I '$G(DATE) D NOW^%DTC S DATE=$E(%,1,12)
 S MSG=$$EN^VAFHLEVN("B02",DATE,,"^","^")
 S $P(MSG,"^",7)=$$HLDATE^HLFNC(ASSDT,"TS")
 S @XMITARRY@(1,1,2)=MSG
 Q
STF(PH) ;staff segment
 N I,ZERO
 ;ph pointer to position assignment file
 ;S ZERO=$G(^SCTM(404.52,+$G(PH),0)) Q:'$P(ZERO,U,3)
 ;S DOC=$P(ZERO,U,3),INST=$P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+ZERO,0)),U,2),0)),U,7),SSN=$$GET1^DIQ(200,(+DOC)_",",9),INSTNM=$$GET1^DIQ(4,(+INST)_",",.01),INST=$$GET1^DIQ(4,(+INST)_",",99)
 N A S A("FILE")=200,A("FIELD")=.01,A("IENS")=DOC
 S MSG="STF^^"_DOC_"~~~USVHA~LR~"_INST_"|"_SSN_"~~~USSA~SS"_"^"_$$HLNAME^XLFNAME(.A,"","~")
 S $P(MSG,U,13)=$$HLDATE^HLFNC($P($G(PZERO),U,5),"TS")
 S $P(MSG,U,14)=$$HLDATE^HLFNC($P($G(ZERO),U,6),"TS")
 S @XMITARRY@(1,1,3)=MSG
 Q
ORG(PH) ;ORG SEGMENT
 ;PH pointer to position assignment filePC
 S @XMITARRY@(1,1,4)="ORG^1^"_INST_"~"_INSTNM_"^^^^^^"_PC
 Q
MSH(PH) ;
 N I,ZERO,PZERO,VARDOC
 S DOC=0
 S SCMSGCNT=$G(SCMSGCNT)+1
 ;ph pointer to position assignment file
 S ZERO=$G(^SCTM(404.52,+$G(PH),0)) Q:'$P(ZERO,U,3)
 S (VARDOC,DOC)=$P(ZERO,U,3),FTEE=+$P(ZERO,U,9),INSTI=$P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+ZERO,0)),U,2),0)),U,7)
MSH1 ;Know DOC nad INSTI
 S INSTNM=$$GET1^DIQ(4,(+INSTI)_",",.01),INST=$$GET1^DIQ(4,(+INSTI)_",",99)
 ;S MAX=+$P($G(^SCTM(404.57,+ZERO,0)),U,8)
 S SSN=$$GET1^DIQ(200,(+DOC)_",",9)
 S (MAX,FTEE)=0 D SUM(DOC,INSTI)
 S PC=U
 S (PZERO,ZERO)=$$GET^XUA4A72(+DOC)
 I ZERO'>0 N I,FTOK S I="" D
 .F  S I=$O(^SCTM(404.52,"C",+DOC,I),-1) Q:I=""  S:'$G(FTOK) FTOK=$P($G(^SCTM(404.52,+I,0)),U,9) S (PZERO,ZERO)=$$GET^XUA4A72(+DOC,+$P($G(^SCTM(404.52,I,0)),U,8)) Q:ZERO>0
 I ZERO'>0,'$G(FTOK) S DOC=0 Q
 S PC=$P(ZERO,U,7)_"~"_$P(ZERO,U,2)
 S HL("SAF")=INST Q
 D CREATE^HLTF(.ID)
 ;D HL
 D MSH^HLFNC2(.HL,ID_"-"_SCMSGCNT,.MSG)
 D NOW^%DTC S $P(MSG,"^",7)=$$HLDATE^HLFNC(%,"TS")
 S @XMITARRY@(1,1,1)=MSG
 Q
ZFT S @XMITARRY@(1,1,5)="ZFT^1^"_FTEE_"^"_MAX
 Q
HL S HL("ACAT")="NE"
 S HL("APAT")="AL"
 S HL("ECH")="~|\&"
 S HL("ETN")="B02"
 S HL("FS")="^"
 S HL("MTN")="PMU"
 S HL("Q")=""""""
 S HL("SAF")=$G(^DD("SITE",1))
 S HL("SAN")="PCMM"
 S HL("VER")=2.4
 S HL("PID")="P"
 Q
BUILD(VAPTR,HL,XMITARRY,HLIEN) ;Build array given pointer.
 ;check which file and build based on that
 ;If team file check if active and PC send message with new max panel
 ;if possition assignment history check status
 ;if active send FTEE
 ;if inactive check if PC and send zero in FTEE
 ;if from Team position file check if pc and send zero in FTEE.
 N %,DOC,EVNDATE,FTEE,ID,INSTI,INSTNM,MAX,MSG,PC,SCFUT,SSN,TP,TEAM,Z1
 S EVNDATE=$G(^SCPT(404.48,+$G(HLIEN),0)) I 'EVNDATE D NOW^%DTC S EVNDATE=%
 N HL D HL
 S ZERO=$G(@(U_$P(VAPTR,";",2)_(+VAPTR)_",0)")) I '$L(ZERO) D  Q 1   ;Record has vanished
 .N IEN S IEN=$O(^SCPT(404.471,"AWRK",VAPTR,""),-1) Q:'IEN   ;not transmitted
 .S TP=$P($G(^SCPT(404.48,+$G(HLIEN),0)),U,4) Q:'TP
 .S ACTIVE=$$DATES^SCAPMCU1(404.52,+TP)
 .I ((ACTIVE)!(VAPTR'[404.52)) D MSH(+$P(ACTIVE,U,4)) Q:'DOC  D EVN(EVNDATE,$P(ACTIVE,U,2)),STF($P(ACTIVE,U,4)),ORG($P(ACTIVE,U,4)),ZFT Q
 .S DOC=$P($G(^SCPT(404.471,+IEN,0)),U,8) Q:'DOC
 .S INSTI=$P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+TP,0)),U,2),0)),U,7)
 .D MSH1,EVN(EVNDATE,$P(ACTIVE,U,2)),STF(),ORG(),ZFT
 I VAPTR[404.57 D  Q 1  ;Team Position
 .S ACTIVE=$$DATES^SCAPMCU1(404.52,+VAPTR)
 .D MSH(+$P(ACTIVE,U,4)) Q:'DOC  D EVN(EVNDATE,$P(ACTIVE,U,2)),STF($P(ACTIVE,U,4)),ORG($P(ACTIVE,U,4)),ZFT
 I VAPTR[404.52 D  Q 1  ;Position Assignment History
 .I $P(ZERO,U,2)>DT S SCFUT=1 Q  ;future date wait till then
 .I $P(ZERO,U,2) S EVNDATE=$E($P(ZERO,U,2),1,7)_$E(EVNDATE,8,99)
 .D MSH(+VAPTR) Q:'DOC  D EVN(EVNDATE,$P(ZERO,U,2)),STF(+VAPTR),ORG(+VAPTR)
 .D ZFT
 I VAPTR[404.59 D  Q 1  ;Team Position History
 .I $P(ZERO,U,2)>DT S SCFUT=1 Q  ;Future do it then
 .I $P(ZERO,U,2) S EVNDATE=$E($P(ZERO,U,2),1,7)_$E(EVNDATE,8,99)
 .;check if active assignment on inactive team
 .S ACTIVE=$$DATES^SCAPMCU1(404.52,$P(ZERO,U,1))
 .D MSH(+$P(ACTIVE,U,4)) Q:'DOC  D EVN(EVNDATE,$P(ACTIVE,U,2)),STF(+$P(ACTIVE,U,4)),ORG(+$P(ACTIVE,U,4))
 .D ZFT
 Q 1
PROV(VAPTR) ;Get internal provider given varible pointer
 N ZERO,ACTIVE
 S ZERO=$G(@(U_$P(VAPTR,";",2)_(+VAPTR)_",0)"))
 I VAPTR[404.57 D  Q $$PH($P(ACTIVE,U,4))  ;Team Position
 .S ACTIVE=$$DATES^SCAPMCU1(404.52,+VAPTR) Q:'ACTIVE
 I VAPTR[404.52 Q $$PH(+VAPTR)
 I VAPTR[404.59 D  I ACTIVE Q $$PH(+VAPTR)  ;Team Position History
 .;check if active assignment on inactive team
 .S ACTIVE=$$DATES^SCAPMCU1(404.52,$P(ZERO,U,1))
 Q 0
PH(PH) ;Return provider from position history
 Q $P($G(^SCTM(404.52,+$G(PH),0)),U,3)
SUM(PR,INST) ; get all the  positions for this provider
 N I,INS,ZERO,SCA,TEAM
 S I=""
 F  S I=$O(^SCTM(404.52,"C",PR,I),-1) Q:'I  D
 .S ZERO=$G(^SCTM(404.52,I,0)) Q:$D(SCA(+ZERO))  S SCA(+ZERO)=""
 .S INS=$P($G(^SCTM(404.51,+$P($G(^SCTM(404.57,+ZERO,0)),U,2),0)),U,7)
 .Q:(INS'=INST)
 .S ACTIVE=$$DATES^SCAPMCU1(404.52,+ZERO,DT+.5) Q:'ACTIVE
 .S (Z1,ZERO)=$G(^SCTM(404.52,+$P(ACTIVE,U,4),0)) Q:$P(Z1,U,3)'=PR
 .S ACTIVE=$$DATES^SCAPMCU1(404.59,+Z1,DT+.5) Q:'ACTIVE
 .S Z1=$G(^SCTM(404.57,+Z1,0))
 .Q:'$P(Z1,U,4)  ;Cannot be primary
 .S TEAM=$G(^SCTM(404.51,+$P(Z1,U,2),0))
 .Q:'$P(TEAM,U,5)
 .S FTEE=FTEE+$P(ZERO,U,9)
 .S MAX=MAX+$P(Z1,U,8)
