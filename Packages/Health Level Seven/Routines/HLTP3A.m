HLTP3A ;SFIRMFO/RSD - Transaction Processor for TCP- INIT ;10/31/2008  11:01
 ;;1.6;HEALTH LEVEL SEVEN;**109,142**;Oct 13, 1995;Build 17
 ;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ;split from hltp3
 Q
INIT ;initialize variables, get MSA & header, returns HLRESLT if error
 N HLJ
 ;
 K HLRESLT,HL
 S HLMTIENS=+X,HLMTIEN=+$P(X,U,2),HLMSA=$$MSA^HLTP3(HLMTIEN)
 ;
 ;get header and validate
 ; patch HL*1.6*142: locking code for MPI-client/server
 F  L +^HLMA(HLMTIENS,"MSH"):10 Q:$T  H 1
 F COUNT=1:1:15 Q:$G(^HLMA(HLMTIENS,"MSH",1,0))]""  H COUNT
 M HLHDRO=^HLMA(HLMTIENS,"MSH")
 L -^HLMA(HLMTIENS,"MSH")
 ;HLMSA is by ref., for a batch msg HLMSA will be setup in HLTPCK2
 D CHK^HLTPCK2(.HLHDRO,.HL,.HLMSA)
 ;Update Message Administration file #773, for incoming message
 ;3=trans type, 20=status
 K HLJ
 S X="HLJ(773,"""_HLMTIENS_","")",@X@(3)="I",@X@(20)=9
 ;HL=error #^error text, 21=date process, 22=error msg, 23=error type
 S:$G(HL) @X@(20)=4,@X@(21)=$$NOW^XLFDT,@X@(22)=$P(HL,U,2),@X@(23)=+HL
 ;8=protocol, 13=sending app
 S:$G(HL("EIDS")) @X@(8)=HL("EIDS") S:$G(HL("SAP")) @X@(13)=HL("SAP")
 ;14=receiving app, 12=acknowledgement to
 S:$G(HL("RAP")) @X@(14)=HL("RAP") S:$G(HL("MTIENS")) @X@(12)=HL("MTIENS")
 ;6=initial message, 7=logical link
 S:$G(HLTCPI) @X@(6)=HLTCPI S @X@(7)=HLDP
 ;
 ;15=message type, 16=event type
 S:$G(HL("MTP")) @X@(15)=HL("MTP") S:$G(HL("ETP")) @X@(16)=HL("ETP")
 ;HL*1.6*109 S:$G(HL("MTP_ETP")) @X@(17)=HL("MTP_ETP")
 D FILE^HLDIE("","HLJ","","INIT-1","HLTP3A") ;HL*1.6*109
 ;Update Message Text file #772
 ;4=trans type
 K HLJ S X="HLJ(772,"""_HLMTIEN_","")",@X@(4)="I"
 ;10=event protocol
 S:$G(HL("EID")) @X@(10)=HL("EID")
 D FILE^HLDIE("","HLJ","","INIT-2","HLTP3A") ; HL*1.6*109
 ;set HLRESLT to error
 S:HL'="" HLRESLT=HL
 Q
