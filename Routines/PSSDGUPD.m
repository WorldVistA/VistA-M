PSSDGUPD ;BIR/PWC - builds HL7 V.2.4 drug update message ;12/22/2003
 ;;1.0;PHARMACY DATA MANAGEMENT;**57,66,70,82**;9/30/97
 ;IA: 10054 - ^LAB(60
 ;IA: 10055 - ^LAB(61
 ;IA: 2079 -  ^PSNDF
 ;IA: 2221 -  ^PS(50.607
 ;IA: 872 -   ^ORD(101
 ;IA: 10106 - $$HLDATE^HLFNC
 ;IA: 2161  - INIT^HLFNC2
 ;IA: 2164  - GENERATE^HLMA
 Q
DRG(DRG,NEW,DNSNAM,DNSPORT) ;entry point
 N CNT,DOSF,DRG0,DRG2,DRG3,DRG6,DRG60,DRGN,DRGSYN,DRGZ,DRGZ1,MEDRT,PSSRESLT,PSSOPTNS,PROT,HL,HLA,ZPA,RXD,OBR,DOS1,DOS2,CLOZ2,LTMON,XX,WARN,LNF,VNF,SYIN,SYNINT,SYUN,VSN,TYPE,UNIT,WNS,WW,ORDITEM,CMOP,OPEXT,LABTST,SPEC,ZPANF,ZPACMOP
 ;
 K HLA("HLS") S PROT=$O(^ORD(101,"B","PSS EXT MFU SERVER",0))
 I 'PROT D EN^DDIOL("Drug Update Protocol NOT Installed ","","$C(7),!!") Q
 D INIT^HLFNC2(PROT,.HL) I $G(HL) Q
 S HL("ECH")="~^\&",CNT=0
 S DRG0=$G(^PSDRUG(DRG,0)),DRG2=$G(^(2)),DRG3=$G(^(3)),DRG6=$G(^(6)),DRGN=$G(^("ND")),DRGZ=$G(^("CLOZ")),DRGZ1=$G(^("CLOZ1")),DRG60=$G(^(660))
 S WARN=$P(DRG0,"^",8),LNF=$P(DRG0,"^",9),VNF=$P(DRG0,"^",11)
 S WNS="" I $G(WARN) F I=1:1 S WW=$P(WARN,",",I) Q:WW=""  S WNS=WNS_WW_"^"_$G(^PS(54,WW,0))_"~"
 S ORDITEM=+$P(DRG2,"^"),CMOP=+$P(DRG3,"^"),OPEXT=+$P(DRG6,"^")
 S LABTST=+$P(DRGZ,"^"),SPEC=+$P(DRGZ,"^",3)
 ;msh segment
 ;S CNT=CNT+1,HLA("HLS",CNT)="MSH|~^\&|PSS VISTA|STATION #~STATION DNS~DNS|PSS DISPENSE|~DISPENSE DNS NAME:PORT~DNS|"_$H_"||MFN^M01|10001||P|2.4|||AL|AL|||||"
 ;mfi segment
 S CNT=CNT+1,HLA("HLS",CNT)="MFI|50^DRUG^99PSD||UPD|||NE"
 ;the MFE and ZPA segments are multiples and a separate one will be sent
 ;for each Drug and the matching synonyms.
 ;mfe segment - DRUG
 S CNT=CNT+1,HLA("HLS",CNT)="MFE|"_$S($G(NEW):"MAD",1:"MUP")_"|||"_$P(DRG0,"^")
 ;zpa segment - DRUG
 S CNT=CNT+1,ZPA=""
 S $P(ZPA,"^",1)=$P(DRG0,"^")_"|N|"    ;main drug
 I LNF&VNF S ZPANF="LFN^Local Non-Formulary^Pharm Formulary Listing~VFN^VISN Non-Formulary^Pharm Formulary Listing"
 I LNF&'VNF S ZPANF="LFN^Local Non-Formulary^Pharm Formulary Listing"
 I 'LNF&VNF S ZPANF="VFN^VISN Non-Formulary^Pharm Formulary Listing"
 S $P(ZPA,"|",3)=$G(ZPANF)
 S $P(ZPA,"|",4)=$$HLDATE^HLFNC($G(^PSDRUG(DRG,"I")),"TS")
 S $P(ZPA,"|",5)=$P(DRG0,"^",10)
 S $P(ZPA,"|",6)=$P(DRG0,"^",2)
 S $P(ZPA,"|",7)=$E($P(DRG0,"^",3),1)
 S $P(ZPA,"|",8)=$E($P(DRG0,"^",3),2)
 S $P(ZPA,"|",9)=$S($P(DRG0,"^",6)]"":"50^"_$P(DRG0,"^",6)_"^LPS50",1:"")
 S $P(ZPA,"|",10)=WNS
 S $P(ZPA,"|",11)=$S(ORDITEM&($D(^PS(50.7,ORDITEM,0))):ORDITEM_"^"_$P($G(^PS(50.7,ORDITEM,0)),"^")_"^LPSD50.7",1:"")
 S DOSF=$S(ORDITEM&($P($G(^PS(50.7,ORDITEM,0)),"^",2)):$P(^PS(50.7,ORDITEM,0),"^",2)_"^"_$P($G(^PS(50.606,+$P($G(^PS(50.7,ORDITEM,0)),"^",2),0)),"^")_"^"_"LPSD50.606",1:"")
 S MEDRT=$S(ORDITEM&($P($G(^PS(50.7,ORDITEM,0)),"^",6)):$P(^PS(50.7,ORDITEM,0),"^",6)_"^"_$P($G(^PS(51.2,+$P($G(^PS(50.7,ORDITEM,0)),"^",6),0)),"^")_"^"_"LPSD51.2",1:"")
 S $P(ZPA,"|",12)=DOSF
 S $P(ZPA,"|",13)=MEDRT
 S $P(ZPA,"|",14)=$S($P(DRGN,"^",3)&($P($G(^PSNDF(50.68,+$P(DRGN,"^",3),0)),"^")]""):$P(DRGN,"^",3)_"^"_$P($G(^PSNDF(50.68,$P(DRGN,"^",3),0)),"^")_"^LPSD50.68",1:"")
 I CMOP&OPEXT S ZPACMOP="OP^OP Dispense^Pharm dispense flag~CMOP^CMOP Dispense^Pharm dispense flag"
 I 'CMOP&OPEXT S ZPACMOP="OP^OP Dispense^Pharm dispense flag"
 I CMOP&'OPEXT S ZPACMOP="CMOP^CMOP Dispense^Pharm dispense flag"
 S $P(ZPA,"|",15)=$G(ZPACMOP)
 S $P(ZPA,"|",16)=$$HLDATE^HLFNC($P(DRG60,"^",9),"TS")
 S $P(ZPA,"|",17)=$S(LABTST&($P($G(^LAB(60,LABTST,0)),"^")]""):LABTST_"^"_$P($G(^LAB(60,LABTST,0)),"^")_"^LLAB60",1:"")
 S $P(ZPA,"|",18)=$S(SPEC&($P($G(^LAB(61,SPEC,0)),"^")]""):SPEC_"^"_$P(^LAB(61,SPEC,0),"^")_"^LLAB61",1:"")
 S $P(ZPA,"|",19)=$P(DRGZ1,"^")
 S $P(ZPA,"|",20)=$P(DRGZ,"^",2)
 S $P(ZPA,"|",21)=$P($G(^PSDRUG(DRG,"DOS")),"^")
 S UNIT=$P($G(^PSDRUG(DRG,"DOS")),"^",2)
 ;order unit
 S $P(ZPA,"|",22)=$S(UNIT&($P($G(^PS(50.607,+UNIT,0)),"^")]""):UNIT_"^"_$P(^PS(50.607,+UNIT,0),"^")_"^LPSD50.607",1:"")
 ;price per order unit and price per dispense unit
 S $P(ZPA,"|",23)=$S($P(DRG60,"^",3)]"":$P(DRG60,"^",3)_"&USD^UP",1:"")
 S $P(ZPA,"|",24)=$S($P(DRG60,"^",6)]"":$P(DRG60,"^",6)_"&USD^UP",1:"")
 ;dispense unit, dispense unit/order unit
 S $P(ZPA,"|",25)=$P(DRG60,"^",8)
 S $P(ZPA,"|",26)=$P(DRG60,"^",5)
 S $P(ZPA,"|",29)=$P(DRG2,"^",4)
 S HLA("HLS",CNT)="ZPA|"_ZPA
 ;
 ;rxd segment
 ; a separate RXD segment will be sent for each multiple of possible dosages
 F XX=0:0 S XX=$O(^PSDRUG(DRG,"DOS1",XX)) Q:'XX  S DOS1=$G(^(XX,0)) D 
 .K RXD S CNT=CNT+1,RXD=""
 .S $P(RXD,"|",4)=$P(DOS1,"^",4)
 .S $P(RXD,"|",9)=$P(DOS1,"^")
 .S $P(RXD,"|",12)="^P&"_$P(DOS1,"^",2)_"&LPSD50.0903"
 .S $P(RXD,"|",24)=$P(DOS1,"^",3)
 .S HLA("HLS",CNT)="RXD|"_RXD
 ;a separate RXD segment will be sent for each local possible dosages
 F XX=0:0 S XX=$O(^PSDRUG(DRG,"DOS2",XX)) Q:'XX  S DOS2=$G(^(XX,0)) D
 .K RXD S CNT=CNT+1,RXD=""
 .S $P(RXD,"|",4)=$P(DOS2,"^",3)
 .S $P(RXD,"|",12)=$S($P(DOS2,"^")]"":"^LP&"_$P(DOS2,"^")_"&LPSD50.0904",1:"")
 .S $P(RXD,"|",24)=$P(DOS2,"^",2)
 .S HLA("HLS",CNT)="RXD|"_RXD
 ;
 ;obr segments - clozapine lab tests
 ;a separate OBR segment will be sent for each clozapine multiple
 ;
 F XX=0:0 S XX=$O(^PSDRUG(DRG,"CLOZ2",XX)) Q:'XX  S CLOZ2=$G(^(XX,0)) D
 .S LTMON=$P(CLOZ2,"^"),SPEC=$P(CLOZ2,"^",3),TYPE=$P(CLOZ2,"^",4)
 .K OBR S CNT=CNT+1,OBR=""
 .S $P(OBR,"|",4)=$S(LTMON]"":LTMON_"^"_$P(^LAB(60,LTMON,0),"^")_"^LLAB60",1:"")
 .S $P(OBR,"|",15)=$S(SPEC]"":SPEC_"^"_$P(^LAB(61,SPEC,0),"^")_"^LLAB61",1:"")
 .S $P(OBR,"|",24)=$S(TYPE=1:"WBC",TYPE=2:"ANC",1:"")
 .S $P(OBR,"|",27)=$P(CLOZ2,"^",2)
 .S HLA("HLS",CNT)="OBR|"_OBR
 ;
 ; now send SYNONYMS for DRUG in multiple ZPA segments
 ;
 F XX=0:0 S XX=$O(^PSDRUG(DRG,1,XX)) Q:'XX  S DRGSYN=$G(^(XX,0)) D
 .S SYIN=$P(DRGSYN,"^",3),VSN=$P(DRGSYN,"^",4),SYUN=+$P(DRGSYN,"^",5)
 .S SYNINT=$S(SYIN=0:"TRADE NAME",SYIN=1:"QUICK CODE",SYIN="D":"DRUG ACCOUNTABILITY",SYIN="C":"CONTROLLED SUBSTANCE",1:"")
 .K ZPA S CNT=CNT+1,ZPA=""
 .S $P(ZPA,"|",1)=$P(DRGSYN,"^")_"|Y"
 .S $P(ZPA,"|",9)=$S(VSN]"":"50.1^"_VSN_"^LPS50.1",1:"")
 .S $P(ZPA,"|",22)=$S(SYUN&($P($G(^DIC(51.5,SYUN,0)),"^")]""):SYUN_"^"_$P(^(0),"^",2)_"^LPSD51.5",1:"")
 .S $P(ZPA,"|",23)=$S($P(DRGSYN,"^",6)]"":$P(DRGSYN,"^",6)_"&USD^UP",1:"")
 .S $P(ZPA,"|",24)=$S($P(DRGSYN,"^",8)]"":$P(DRGSYN,"^",8)_"&USD^UP",1:"")
 .S $P(ZPA,"|",26)=$P(DRGSYN,"^",7)
 .S $P(ZPA,"|",28)=$P(DRGSYN,"^",9)
 .S $P(ZPA,"|",29)=$P(DRGSYN,"^",2)
 .S $P(ZPA,"|",30)=SYNINT
 .S HLA("HLS",CNT)="ZPA|"_ZPA
 S PSSOPTNS("SUBSCRIBER")="^^^^~"_DNSNAM_":"_DNSPORT_"~DNS"
 D GENERATE^HLMA("PSS EXT MFU SERVER","LM",1,.PSSRESLT,"",.PSSOPTNS)
 K HLA("HLS")
 Q
 ;
PSN ;entry point from NDF data updates
 S PROT=$O(^ORD(101,"B","PSS EXT MFU SERVER",0)) I 'PROT G PSNX
 D INIT^HLFNC2(PROT,.HL) I $G(HL) G PSNX
 N PSN
 F  S PSN=$O(^TMP($J,"^",PSN)) Q:'PSN  D DRG(PSN)
PSNX K PSN,^TMP($J),PROT,HL S ZTREQ="@"
 Q
