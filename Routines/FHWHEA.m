FHWHEA ; HISC/REL - Health Summary ;7/16/96  15:47
 ;;5.5;DIETETICS;**1,8**;Jan 28, 2005;Build 28
 ;patch #8 - adding Nutrition Assessment (follow-up date and comment) in the "NA" node.
 S FH9=9999999,FHS1=$S(GMTS2<1:1,1:FH9-GMTS2),FHS2=$S(GMTS1<1:FH9,1:FH9-GMTS1)
 K ^UTILITY($J) S (FHN1,FHN2,FHN3,FHN4)=0
 ; Nutrition Status in inverse order
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 S FHL=0 F FHX1=GMTS1:0 S FHX1=$O(^FHPT(FHDFN,"S",FHX1)) Q:FHX1'>0!(FHX1>GMTS2)  I $D(^(FHX1,0)) S FHX2=^(0) D NS S ^UTILITY($J,"NS",FHX1,0)=$P(FHX2,"^",1)_"^"_FHY,FHL=FHL+1 I GMTSNDM=FHL Q
 ; Dietetic Encounters
 F FHX1=FHS1:0 S FHX1=$O(^FHEN("AP",DFN,FHX1)) Q:FHX1=""!(FHX1>FHS2)  F FHI=0:0 S FHI=$O(^FHEN("AP",DFN,FHX1,FHI)) Q:FHI<1  D EN
 F FHADM=0:0 S FHADM=$O(^FHPT(FHDFN,"A",FHADM)) Q:FHADM'>0  D CHK
 ;add nutrition assessment (Follow-up date & comments.
 ; where ^utility($j,"NA",date,1)=follow-up date
 ;                        date,2)=pt's allergy
 ;                        date,3)=1nd line comment
 ;                        date,4)=2rd line comment and so on... 
 F FHI=0:0 S FHI=$O(^FHPT(FHDFN,"N",FHI)) Q:FHI'>0  I $D(^(FHI,"DI")) D NAD
 I GMTSNDM'>0 G KIL
 I FHN1>GMTSNDM S FHL=0 F FHI=0:0 S FHI=$O(^UTILITY($J,"DI",FHI)) Q:FHI=""  S FHL=FHL+1 I FHL>GMTSNDM K ^UTILITY($J,"DI",FHI)
 I FHN2>GMTSNDM S FHL=0 F FHI=0:0 S FHI=$O(^UTILITY($J,"TF",FHI)) Q:FHI=""  S FHL=FHL+1 I FHL>GMTSNDM K ^UTILITY($J,"TF",FHI)
 I FHN3>GMTSNDM S FHL=0 F FHI=0:0 S FHI=$O(^UTILITY($J,"SF",FHI)) Q:FHI=""  S FHL=FHL+1 I FHL>GMTSNDM K ^UTILITY($J,"SF",FHI)
 I FHN4>GMTSNDM S FHL=0 F FHI=0:0 S FHI=$O(^UTILITY($J,"EN",FHI)) Q:FHI=""  S FHL=FHL+1 I FHL>GMTSNDM K ^UTILITY($J,"EN",FHI)
 G KIL
CHK ;
 S FHY=$P($G(^DGPM(FHADM,0)),"^",17) S:FHY>0 FHY=$P($G(^DGPM(+FHY,0)),"^",1)
 I FHY,FHY<FHS1 Q
 ; Diet Order in inverse order
 S FHP="" F FHI=FHS1:0 S FHI=$O(^FHPT(FHDFN,"A",FHADM,"AC",FHI)) Q:FHI=""!(FHI>FHS2)  I $D(^(FHI,0)) S FHX=^(0) D DI S ^UTILITY($J,"DI",(FH9-FHI),0)=FHX,FHN1=FHN1+1 S:FHP $P(^UTILITY($J,"DI",FHP,0),"^",2)=FHI S FHP=FH9-FHI
 ; Tubefeeding in inverse order
 F FHI=0:0 S FHI=$O(^FHPT(FHDFN,"A",FHADM,"TF",FHI)) Q:FHI=""  I $D(^(FHI,0)) S FHX=^(0) D TF I FHX S ^UTILITY($J,"TF",(FH9-FHX1),0)=FHX,FHN2=FHN2+1
 ; Supplemental feeding in inverse order
 F FHI=0:0 S FHI=$O(^FHPT(FHDFN,"A",FHADM,"SF",FHI)) Q:FHI=""  I $D(^(FHI,0)) S FHX=^(0) D SF I FHX S ^UTILITY($J,"SF",FH9-FHX1,0)=FHX,FHN3=FHN3+1
 Q
DI ; Decode Diet Order
 S FHX=^FHPT(FHDFN,"A",FHADM,"DI",$P(FHX,"^",2),0),FHX2=$G(^(1)),FHX3=""
 S FHOR=$P(FHX,"^",2,6),FHLD=$P(FHX,"^",7),FHY=""
 I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") S:%>0 FHY=$P($E(FHDU,%,999),";",1) K % G D1
 S FHY="" F FHK1=1:1:5 S FHL=$P(FHOR,"^",FHK1) I FHL S:FHY'="" FHY=FHY_", " S FHY=FHY_$P($G(^FH(111,FHL,0)),"^",7)
 S FHX3=$P(FHX,"^",8) S:FHX3'="" FHX3=$S(FHX3="T":"Tray",FHX3="D":"Dining Room",1:"Cafeteria")
D1 S FHX=FHI_"^"_$P(FHX,"^",10)_"^"_FHY_"^"_FHX2_"^"_FHX3 Q
SF ; Decode Supp. Fdg.
 S FHX1=$P(FHX,"^",2) I FHX1<FHS1!(FHX1>FHS2) S FHX="" Q
 S FHL=4 F FHK1=1:1:3 S FHN(FHK1)="" F FHK2=1:1:4 S FHX2=$P(FHX,"^",FHL+1),FHX3=$P(FHX,"^",FHL+2),FHL=FHL+2 I FHX2 S:FHN(FHK1)'="" FHN(FHK1)=FHN(FHK1)_"; " S FHN(FHK1)=FHN(FHK1)_$S(FHX3:FHX3,1:1)_" "_$P($G(^FH(118,FHX2,0)),"^",1)
 I $L(FHX1_"^"_$P(FHX,"^",32)_"^"_FHN(1)_"^"_FHN(2)_"^"_FHN(3))>240 D BRK
 S FHX=(FHX1\1)_"^"_$P(FHX,"^",32)_"^"_FHN(1)_"^"_FHN(2)_"^"_FHN(3)
 Q
NS ; Decode Nut Status
 S FHY=$P($G(^FH(115.4,+$P(FHX2,"^",2),0)),"^",2) Q
TF ; Decode Tubefeeding
 S FHX1=$P(FHX,"^",1) I FHX1<FHS1!(FHX1>FHS2) S FHX="" Q
 S %=$O(^FHPT(FHDFN,"A",FHADM,"TF",FHI,"P",0)) S:% %=^(%,0)
 S FHX2=$P(%,"^",1),FHX3=$P(%,"^",2),FHX4=$P(%,"^",3)
 I FHX4["CC" S QUAFI=$P(FHX4,"CC",1),QUASE=$P(FHX4,"CC",2),FHX4=QUAFI_"ML"_QUASE
 S:FHX2 FHX2=$S($D(^FH(118.2,FHX2,0)):$P(^(0),"^",1),1:" ")
 S:FHX3 FHX3=$S(FHX3=4:"Full",FHX3=1:"1/4",FHX3=2:"1/2",1:"3/4")
 S FHX=FHX1_"^"_$P(FHX,"^",11)_"^"_FHX2_"^"_FHX3_"^"_FHX4_"^"_$P(FHX,"^",6)_"^"_$P(FHX,"^",7)_"^"_$P(FHX,"^",5) Q
EN ; Decode Dietetic Encounter
 S FHX2=$G(^FHEN(FHI,0)),FHX3=$P(FHX2,"^",4) Q:'FHX3  S FHX3=$P($G(^FH(115.6,+FHX3,0)),"^",1)
 S FHX=FHX1_"^"_FHX3_"^"_$P(FHX2,"^",11)_"^"_$P($G(^FHEN(FHI,"P",DFN,0)),"^",4)
 S ^UTILITY($J,"EN",(FH9-FHX1),0)=FHX,FHN4=FHN4+1 Q
 Q
 ;
NAD ;Nutrition Assessment.
 S FHX=$G(^FHPT(FHDFN,"N",FHI,0))
 S FHDI=$G(^FHPT(FHDFN,"N",FHI,"DI"))
 S FHX1=$P(FHX,U,1)
 S FHFUD=$P(FHDI,U,5),FHNAST=$P(FHDI,U,6)
 S DTP=FHFUD D DTP^FH S FHFUD=$E(DTP,1,9)
 I (FHNAST="")!(FHNAST="W") Q
 I (FHX1<FHS1)!(FHX1>FHS2) Q
 S FHNA=1
 S ^UTILITY($J,"NA",(FH9-FHX1),FHNA)="Follow-up Date: "_FHFUD
 D ALG^FHCLN
 S FHNA=FHNA+1 S ^UTILITY($J,"NA",(FH9-FHX1),FHNA)="Patient's Allergy: "_ALG
 I $D(^FHPT(FHDFN,"N",FHI,"X")) S FHNA=FHNA+1 S ^UTILITY($J,"NA",(FH9-FHX1),FHNA)="Comment: "
 F FHI1=0:0 S FHI1=$O(^FHPT(FHDFN,"N",FHI,"X",FHI1)) Q:FHI1'>0  D
 .S FHNA=FHNA+1
 .S ^UTILITY($J,"NA",(FH9-FHX1),FHNA)=$G(^FHPT(FHDFN,"N",FHI,"X",FHI1,0))
 Q
BRK ; Break Supplemental Feeding
 S FHVAL=""
 D STP(FHN(1),.FHVAL) S FHN(1)=FHVAL
 D STP(FHN(2),.FHVAL) S FHN(2)=FHVAL
 D STP(FHN(3),.FHVAL) S FHN(3)=FHVAL
 Q
STP(FHVAL1,FHVAL2) ; Strip Excess Spaces and truncate SF from 20 to 16 char
 S FHVAL2=""
 F FHK2=1:1:4 S FHP1=$P(FHVAL1,";",FHK2) I FHP1'="" S:$E(FHP1,1)=" " FHP1=$E(FHP1,2,$L(FHP1)) S:FHVAL2'="" FHVAL2=FHVAL2_";" S FHVAL2=FHVAL2_$E(FHP1,1,16)
 Q
KIL K %,FHADM,FHDU,FHI,FHK1,FHK2,FHL,FHLD,FHN,FHN1,FHN2,FHN3,FHN4,FHOR,FHP,FHP1,FHX,FHX1,FHX2,FHX3,FHX4,FHS1,FHS2,FH9,FHFHY,FHVAL,FHVAL1,FHVAL2
 K FHI1,FHNA,FHFUD,FHNAST,FHDI,FHDFN,FHY,FHZ115,FLAG
 Q
