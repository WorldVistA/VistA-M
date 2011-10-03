FHWOR7 ; HISC/NCA - OE/RR Procedure Call ;2/17/95  10:28
 ;;5.5;DIETETICS;;Jan 28, 2005
EN1 ; OE/RR passes the Patient DFN and the information is stored in ^TMP
 K ^TMP($J,"FHTF"),^TMP($J,"FHSF"),^TMP($J,"FHPF")
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 S FHWRD=$G(^DPT(DFN,.1)) G:FHWRD="" KIL
 S FHADM=$G(^DPT("CN",FHWRD,DFN)) G:FHADM<1 KIL
 I '$D(^FHPT(FHDFN,"A",FHADM,0)) G KIL
SF ; Get Current Supplemental Feeding order and store in ^TMP($J,"FHSF",1).
 ; The information is stored in the following:
 ;
 ; ^TMP($J,"FHSF",1)=DATE ORDERED_"^"_10am fdg_"^"_2pm fdg_"^"_8pm fdg
 ; Under each feeding it is stored as Quantity_" "_fdg name 1_";"_
 ; Quantity_" "_fdg name 2... up to 4.
 S FHNO=$P($G(^FHPT(FHDFN,"A",FHADM,0)),"^",7) G:'FHNO TF
 S FHX=$G(^FHPT(FHDFN,"A",FHADM,"SF",FHNO,0)),FHX1=$P(FHX,"^",2)
 S FHL=4 F FHK1=1:1:3 S FHN(FHK1)="" F FHK2=1:1:4 S FHX2=$P(FHX,"^",FHL+1),FHX3=$P(FHX,"^",FHL+2),FHL=FHL+2 I FHX2 S:FHN(FHK1)'="" FHN(FHK1)=FHN(FHK1)_";" S FHN(FHK1)=FHN(FHK1)_$S(FHX3:FHX3,1:1)_" "_$P($G(^FH(118,FHX2,0)),"^",1)
 S FHX=FHX1_"^"_FHN(1)_"^"_FHN(2)_"^"_FHN(3)
 S ^TMP($J,"FHSF",1)=FHX
TF ; Get Tubefeeding total Kcal/Day and store in ^TMP($J,"FHTF",1).
 S FHNO=$P($G(^FHPT(FHDFN,"A",FHADM,0)),"^",4) G:'FHNO FP
 S FHX=$G(^FHPT(FHDFN,"A",FHADM,"TF",FHNO,0)) S FHX=$P(FHX,"^",7)
 S ^TMP($J,"FHTF",1)=FHX
FP ; Get Food Preferences and store all Likes in ^TMP($J,"FHFP","L")
 ; and all Dislikes in ^TMP($J,"FHFP","D").  The information is store
 ; in the following:
 ;
 ; ^TMP($J,"FHFP","L",1)=Quantity_" "_Food Preference name_"^"_Meal
 ; ^TMP($J,"FHFP","D",1)=Food Preference name_"^"_Meals.
 S (FHD,FHL)=0 F FHNO=0:0 S FHNO=$O(^FHPT(FHDFN,"P",FHNO)) Q:FHNO<1  S FHX=$G(^(FHNO,0)) D SP
 G KIL
SP S FHZ=$G(^FH(115.2,+FHX,0))
 I $P(FHZ,"^",2)="L" S FHL=FHL+1,^TMP($J,"FHFP","L",FHL)=$S($P(FHX,"^",3):$P(FHX,"^",3),1:1)_" "_$P(FHZ,"^",1)_"^"_$P(FHX,"^",2) Q
 E  S FHD=FHD+1,^TMP($J,"FHFP","D",FHD)=$P(FHZ,"^",1)_"^"_$P(FHX,"^",2)
 Q
KIL K FHADM,FHD,FHK1,FHK2,FHL,FHN,FHNO,FHX,FHX1,FHX2,FHX3,FHWRD,FHZ Q
