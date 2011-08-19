GMTSFHWZ ; SLC/JER - Dietetics extract for export ;12/16/92  09:38
 ;;2.5;Health Summary;;Dec 16, 1992
FHWHEA ;; GLRISC/REL - Health Summary ;1/11/91  09:11
 ;;4.6;;
 S FH9=9999999,FHS1=$S(GMTS2<1:1,1:FH9-GMTS2),FHS2=$S(GMTS1<1:FHP,1:FH9-GMTS1)
 K ^UTILITY($J) S (FHN1,FHN2,FHN3)=0
 ; Nutrition Status in inverse order
 S FHL=0 F FHX1=GMTS1:0 S FHX1=$O(^FHPT(DFN,"S",FHX1)) Q:FHX1'>0!(FHX1>GMTS2)  I $D(^(FHX1,0)) S FHX2=^(0) D NS S ^UTILITY($J,"NS",FHX1,0)=$P(FHX2,"^",1)_"^"_FHY,FHL=FHL+1 I GMTSNDM=FHL Q
 S FHNOD="A" I ^DG(43,1,"VERSION")'>4.8 S FHNOD="DA"
 F FHADM=0:0 S FHADM=$O(^FHPT(DFN,FHNOD,FHADM)) Q:FHADM'>0  D CHK
 I GMTSNDM'>0 G KIL
 I FHN1>GMTSNDM S FHL=0 F FHI=0:0 S FHI=$O(^UTILITY($J,"DI",FHI)) Q:FHI=""  S FHL=FHL+1 I FHL>GMTSNDM K ^UTILITY($J,"DI",FHI)
 I FHN2>GMTSNDM S FHL=0 F FHI=0:0 S FHI=$O(^UTILITY($J,"TF",FHI)) Q:FHI=""  S FHL=FHL+1 I FHL>GMTSNDM K ^UTILITY($J,"TF",FHI)
 I FHN3>GMTSNDM S FHL=0 F FHI=0:0 S FHI=$O(^UTILITY($J,"SF",FHI)) Q:FHI=""  S FHL=FHL+1 I FHL>GMTSNDM K ^UTILITY($J,"SF",FHI)
 G KIL
CHK ;
 I FHNOD="A" S FHY=$S($D(^DGPM(FHADM,0)):$P(^(0),"^",17),1:"") S:FHY>0 FHY=$S($D(^DGPM(+FHY,0)):$P(^(0),"^",1),1:"")
 I FHNOD="DA" S FHY=$S($D(^DPT(DFN,FHNOD,FHADM,1)):$P(^(1),"^",1),1:"")
 I FHY,FHY<FHS1 Q
 ; Diet Order in inverse order
 S FHP="" F FHI=FHS1:0 S FHI=$O(^FHPT(DFN,FHNOD,FHADM,"AC",FHI)) Q:FHI=""!(FHI>FHS2)  I $D(^(FHI,0)) S FHX=^(0) D DI S ^UTILITY($J,"DI",(FH9-FHI),0)=FHX,FHN1=FHN1+1 S:FHP $P(^UTILITY($J,"DI",FHP,0),"^",2)=FHI S FHP=FH9-FHI
 ; Tubefeeding in inverse order
 F FHI=0:0 S FHI=$O(^FHPT(DFN,FHNOD,FHADM,"TF",FHI)) Q:FHI=""  I $D(^(FHI,0)) S FHX=^(0) D TF I FHX S ^UTILITY($J,"TF",(FH9-FHX1),0)=FHX,FHN2=FHN2+1
 ; Supplemental feeding in inverse order
 F FHI=0:0 S FHI=$O(^FHPT(DFN,FHNOD,FHADM,"SF",FHI)) Q:FHI=""  I $D(^(FHI,0)) S FHX=^(0) D SF I FHX S ^UTILITY($J,"SF",FH9-FHX1,0)=FHX,FHN3=FHN3+1
 Q
DI ; Decode Diet Order
 S FHX=^FHPT(DFN,FHNOD,FHADM,"DI",$P(FHX,"^",2),0),FHX2=$S($D(^(1)):^(1),1:""),FHX3=""
 S FHOR=$P(FHX,"^",2,6),FHLD=$P(FHX,"^",7),FHY=""
 I FHLD'="" S FHDU=";"_$P(^DD(115.02,6,0),"^",3),%=$F(FHDU,";"_FHLD_":") S:%>0 FHY=$P($E(FHDU,%,999),";",1) K % G D1
 S FHY="" F FHK1=1:1:5 S FHL=$P(FHOR,"^",FHK1) I FHL S:FHY'="" FHY=FHY_", " S FHY=FHY_$S($D(^FH(111,FHL,0)):$P(^(0),"^",7),1:"")
 S FHX3=$P(FHX,"^",8) S:FHX3'="" FHX3=$S(FHX3="T":"Tray",FHX3="D":"Dining Room",1:"Cafeteria")
D1 S FHX=FHI_"^"_$P(FHX,"^",10)_"^"_FHY_"^"_FHX2_"^"_FHX3 Q
SF ; Decode Supp. Fdg.
 S FHX1=$P(FHX,"^",2) I FHX1<FHS1!(FHX1>FHS2) S FHX="" Q
 S FHL=4 F FHK1=1:1:3 S FHN(FHK1)="" F FHK2=1:1:4 S FHX2=$P(FHX,"^",FHL+1),FHX3=$P(FHX,"^",FHL+2),FHL=FHL+2 I FHX2 S:FHN(FHK1)'="" FHN(FHK1)=FHN(FHK1)_"; " S FHN(FHK1)=FHN(FHK1)_$S(FHX3:FHX3,1:1)_" "_$S($D(^FH(118,FHX2,0)):$P(^(0),"^",1),1:"")
 S FHX=FHX1_"^"_$P(FHX,"^",32)_"^"_FHN(1)_"^"_FHN(2)_"^"_FHN(3) Q
NS ; Decode Nut Status
 S FHY=$S($D(^FH(115.4,+$P(FHX2,"^",2),0)):$P(^(0),"^",2),1:"") Q
TF ; Decode Tubefeeding
 S FHX1=$P(FHX,"^",1) I FHX1<FHS1!(FHX1>FHS2) S FHX="" Q
 S FHX2=$P(FHX,"^",2),FHX3=$P(FHX,"^",3)
 S:FHX2 FHX2=$S($D(^FH(118.2,FHX2,0)):$P(^(0),"^",1),1:" ")
 S:FHX3 FHX3=$S(FHX3=4:"Full",FHX3=1:"1/4",FHX3=2:"1/2",1:"3/4")
 S FHX=FHX1_"^"_$P(FHX,"^",11)_"^"_FHX2_"^"_FHX3_"^"_$P(FHX,"^",4)_"^"_$P(FHX,"^",6)_"^"_$P(FHX,"^",7)_"^"_$P(FHX,"^",5) Q
KIL K %,FHADM,FHDU,FHI,FHK1,FHK2,FHL,FHLD,FHN,FHN1,FHN2,FHN3,FHNOD,FHOR,FHP,FHX,FHX1,FHX2,FHX3,FHS1,FHS2,FH9,FHFHY Q
