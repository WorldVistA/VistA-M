PSSHUIDG ;BIR/SAB - builds hl7 drug update message ;06/27/2002
 ;;1.0;PHARMACY DATA MANAGEMENT;**57,66,70**;9/30/97
 ;IA: 10054 - ^LAB(60
 ;IA: 10055 - ^LAB(61
 ;IA: 2079 -  ^PSNDF
 ;IA: 2221 -  ^PS(50.607
 ;IA: 872 -   ^ORD(101
 ;IA: 10106 - $$HLDATE^HLFNC
 ;IA: 2161  - INIT^HLFNC2
 ;IA: 2164  - GENERATE^HLMA
DRG(DRG,NEW) ;entry point
 N ACT,CNT,DOS,DOSF,DRG0,DRG2,DRG3,DRG6,DRG60,DRGN,DRGZ,DRGZ1,INT,MEDRT,PSSRESLT,PSSOPTNS,PKG,PROT,SYN,XX
 N HL,HLA
 S PROT=$O(^ORD(101,"B","PSS HUI DRUG UPDATE",0))
 I 'PROT D EN^DDIOL("Drug Update Protocol NOT Installed ","","$C(7),!!") Q
 D INIT^HLFNC2(PROT,.HL) I $G(HL) Q  ;D EN^DDIOL($P(HL,"^",2)_". Drug Update Message Not Sent.","","$C(7),!!") Q
 S HL("ECH")="^~\",CNT=0
 S DRG0=$G(^PSDRUG(DRG,0)),DRG2=$G(^(2)),DRG3=$G(^(3)),DRG6=$G(^(6)),DRGN=$G(^("ND")),DRGZ=$G(^("CLOZ")),DRGZ1=$G(^("CLOZ1")),DRG60=$G(^(660))
 ;msh segment
 ;S CNT=CNT+1,HLA("HLS",CNT)="MSH|^~\&|PHARMACY DATA MANAGEMENT"
 ;S $P(HLA("HLS",CNT),HL("FS"),9)="MFN"
 ;mfi segment
 S CNT=CNT+1,HLA("HLS",CNT)="MFI|50^DRUG^99PSD"
 S $P(HLA("HLS",CNT),HL("FS"),6)="NE"
 ;mfa segment
 S CNT=CNT+1,HLA("HLS",CNT)="MFA|"_$S($G(NEW):"MAD",1:"MUP")
 ;mfe segment
 S CNT=CNT+1,HLA("HLS",CNT)="MFE|"_$S($G(NEW):"MAD",1:"MUP"),$P(HLA("HLS",CNT),"|",5)=DRG_"^"_$P(DRG0,"^")_"^99PSD"
 ;zpa segment
 S CNT=CNT+1,HLA("HLS",CNT)="ZPA|"_$P(DRG2,"^",4)_"|"_$P(DRG0,"^",9)_"|"_$$HLDATE^HLFNC($G(^PSDRUG(DRG,"I")),"TS")_"|"
 S HLA("HLS",CNT)=HLA("HLS",CNT)_$P(DRG2,"^",3)_"|"_$P(DRG0,"^",10)_"|"_$P(DRG0,"^",2)_"|"_$P(DRG0,"^",3)_"|"_$P(DRG0,"^",6)_"|"_$P(DRG0,"^",8)_"|"_$P(DRG0,"^",11)
 ;zpb segment
 S CNT=CNT+1,HLA("HLS",CNT)="ZPB|"_$S($P(DRG2,"^")&($D(^PS(50.7,+$P(DRG2,"^"),0))):$P(DRG2,"^")_"^"_$P($G(^PS(50.7,$P(DRG2,"^"),0)),"^")_"^PSD50.7",1:"")_"|"
 S DOSF=$S($P(DRG2,"^")&($P($G(^PS(50.7,+$P(DRG2,"^"),0)),"^",2)):$P(^PS(50.7,+$P(DRG2,"^"),0),"^",2)_"^"_$P($G(^PS(50.606,+$P($G(^PS(50.7,+$P(DRG2,"^"),0)),"^",2),0)),"^")_"^"_"PSD50.606",1:"")
 S MEDRT=$S($P(DRG2,"^")&($P($G(^PS(50.7,+$P(DRG2,"^"),0)),"^",6)):$P(^PS(50.7,+$P(DRG2,"^"),0),"^",6)_"^"_$P($G(^PS(51.2,+$P($G(^PS(50.7,+$P(DRG2,"^"),0)),"^",6),0)),"^")_"^"_"PSD51.2",1:"")
 S HLA("HLS",CNT)=HLA("HLS",CNT)_DOSF_"|"_MEDRT_"|"
 S HLA("HLS",CNT)=HLA("HLS",CNT)_$S($P(DRGN,"^",3)&($P($G(^PSNDF(50.68,+$P(DRGN,"^",3),0)),"^")]""):$P(DRGN,"^",3)_"^"_$P($G(^PSNDF(50.68,$P(DRGN,"^",3),0)),"^")_"^PSD50.68",1:"")_"|"
 S HLA("HLS",CNT)=HLA("HLS",CNT)_$P($G(DRG60),"^",8)_"|"_+$P(DRG3,"^")_"|"_+$P(DRG6,"^")_"|"_$$HLDATE^HLFNC($P(DRG60,"^",9),"TS")_"|"
 S HLA("HLS",CNT)=HLA("HLS",CNT)_$S($P(DRGZ,"^")&($P($G(^LAB(60,+$P(DRGZ,"^"),0)),"^")]""):$P(DRGZ,"^")_"^"_$P($G(^LAB(60,$P(DRGZ,"^"),0)),"^")_"^LAB60",1:"")
 ;zpc segment
 S CNT=CNT+1,HLA("HLS",CNT)="ZPC|"_$S($P(DRGZ,"^",3)&($P($G(^LAB(61,+$P(DRGZ,"^",3),0)),"^")]""):$P(DRGZ,"^",3)_"^"_$P(^LAB(61,$P(DRGZ,"^",3),0),"^")_"^LAB61",1:"")_"|"
 S HLA("HLS",CNT)=HLA("HLS",CNT)_$P(DRGZ1,"^")_"|"_$P(DRGZ1,"^",2)_"|"_$P($G(^PSDRUG(DRG,"DOS")),"^")_"|",DOS=$P($G(^PSDRUG(DRG,"DOS")),"^",2)
 S HLA("HLS",CNT)=HLA("HLS",CNT)_$S(DOS&($P($G(^PS(50.607,+DOS,0)),"^")]""):DOS_"^"_$P(^PS(50.607,+DOS,0),"^")_"^PSD50.607",1:"")_"|"
 S HLA("HLS",CNT)=HLA("HLS",CNT)_$P(DRG60,"^",3)_"|"_$P(DRG60,"^",6)
 ;zpd segment
 K SYN F XX=0:0 S XX=$O(^PSDRUG(DRG,1,XX)) Q:'XX  D
 .S SYN=^PSDRUG(DRG,1,XX,0),CNT=CNT+1
 .S HLA("HLS",CNT)="ZPD|"_$P(SYN,"^")_"|"_$P(SYN,"^",2)_"|"
 .S HLA("HLS",CNT)=HLA("HLS",CNT)_$S($P(SYN,"^",3)]"":$P(SYN,"^",3)_"^"_$S($P(SYN,"^",3)=0:"TRADE NAME",$P(SYN,"^",3)=1:"QUICK CODE",$P(SYN,"^",3)="D":"DRUG ACCOUNTABILITY",$P(SYN,"^",3)="C":"CONTROLLED SUBSTANCE",1:""),1:"")_"|"
 .S HLA("HLS",CNT)=HLA("HLS",CNT)_$P(SYN,"^",4)_"|"_$S($P(SYN,"^",5)&($P($G(^DIC(51.5,+$P(SYN,"^",5),0)),"^")]""):$P(SYN,"^",5)_"^"_$P(^DIC(51.5,$P(SYN,"^",5),0),"^")_"^"_$P(^(0),"^",2)_"^PSD51.5",1:"")_"|"
 .S HLA("HLS",CNT)=HLA("HLS",CNT)_$P(SYN,"^",6)_"|"_$P(SYN,"^",7)_"|"_$P(SYN,"^",8)_"|"_$P(SYN,"^",9) K SYN
 ;zpe segment
 K ACT,INT F XX=0:0 S XX=$O(^PSDRUG(DRG,4,XX)) Q:'XX  S ACT=^PSDRUG(DRG,4,XX,0),CNT=CNT+1 D
 .S HLA("HLS",CNT)="ZPE|"_$$HLDATE^HLFNC($P(ACT,"^"),"TS")_"|"_$S($P(ACT,"^",2)]"":"E^EDIT",1:"")_"|"
 .S INT=$S($P(ACT,"^",3)&($P($G(^VA(200,$P(ACT,"^",3),0)),"^")]""):$P(ACT,"^",3)_"^"_$P(^VA(200,$P(ACT,"^",3),0),"^")_"^VA200",1:"")
 .S HLA("HLS",CNT)=HLA("HLS",CNT)_INT_"|"_$P(ACT,"^",4)_"|"_$P(ACT,"^",5)_"|"_$P(ACT,"^",6)
 K INT,ACT,XX
 ;zpf segment
 K ACT,INT F XX=0:0 S XX=$O(^PSDRUG(DRG,"DOS1",XX)) Q:'XX  S ACT=^PSDRUG(DRG,"DOS1",XX,0),CNT=CNT+1 D
 .S HLA("HLS",CNT)="ZPF|"_$P(ACT,"^")_"|"_$P(ACT,"^",2)_"|"_$S($P(ACT,"^",3)="I":"I^INPATIENT",$P(ACT,"^",3)="O":"O^OUTPATIENT",$P(ACT,"^",3)="IO"!($P(ACT,"^",3)="OI"):"IO^INPATIENT/OUTPATIENT",1:"")_"|"_$P(ACT,"^",4)
 K ACT,INT,XX
 ;zpg segment
 K ACT F XX=0:0 S XX=$O(^PSDRUG(DRG,"CLOZ2",XX)) Q:'XX  S ACT=^PSDRUG(DRG,"CLOZ2",XX,0),CNT=CNT+1 D
 .S HLA("HLS",CNT)="ZPG|"_$S($P(ACT,"^")&($P($G(^LAB(60,$P(ACT,"^"),0)),"^")]""):$P(ACT,"^")_"^"_$P(^LAB(60,$P(ACT,"^"),0),"^")_"^LAB60",1:"")_"|"_$P(ACT,"^",2)_"|"
 .S HLA("HLS",CNT)=HLA("HLS",CNT)_$S($P(ACT,"^",3)&($P($G(^LAB(61,$P(ACT,"^",3),0)),"^")]""):$P(ACT,"^",3)_"^"_$P(^LAB(61,$P(ACT,"^",3),0),"^")_"^LAB61",1:"")_"|"_$S($P(ACT,"^",4)=1:"1^WBC",$P(ACT,"^",4)=2:"2^ANC",1:"") K ACT
 ;zph segment
 K ACT,INT F XX=0:0 S XX=$O(^PSDRUG(DRG,"DOS2",XX)) Q:'XX  S ACT=^PSDRUG(DRG,"DOS2",XX,0),CNT=CNT+1 D
 .S HLA("HLS",CNT)="ZPH|"_$P(ACT,"^")_"|"
 .S PKG=$S($P(ACT,"^",2)="O":"O^OUTPATIENT",$P(ACT,"^",2)="I":"I^INPATIENT",$P(ACT,"^",2)="IO":"IO^INPATIENT/OUTPATIENT",$P(ACT,"^",2)="OI":"IO^INPATIENT/OUTPATIENT",1:"")
 .S HLA("HLS",CNT)=HLA("HLS",CNT)_PKG_"|"_$P(ACT,"^",3)
 K ACT,INT,XX,PKG
 ;builds hl7 message
 D GENERATE^HLMA("PSS HUI DRUG UPDATE","LM",1,.PSSRESLT,"",.PSSOPTNS)
 Q
 ;
PSN ;entry point from NDF data updates
 S PROT=$O(^ORD(101,"B","PSS HUI DRUG UPDATE",0)) I 'PROT G PSNX
 D INIT^HLFNC2(PROT,.HL) I $G(HL) G PSNX
 N PSN
 F  S PSN=$O(^TMP($J,"^",PSN)) Q:'PSN  D DRG(PSN)
PSNX K PSN,^TMP($J),PROT,HL S ZTREQ="@"
 Q
