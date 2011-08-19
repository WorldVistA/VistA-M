FHWDIS ; HISC/REL - Close out on discharge ;10/10/00  14:55
 ;;5.5;DIETETICS;;Jan 28, 2005
 ; Updated for outpatient meals FHDFN/DFN
 S FHZ115="P"_DFN D CHECK^FHOMDPA I FHDFN="" Q
 D NOW^%DTC S FHNOW=%,FHA0=$G(^FHPT(FHDFN,"A",ADM,0)),FHWF=$S($D(^ORD(101)):1,1:0) Q:FHA0=""  Q:$P(FHA0,"^",14)
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",14)=FHNOW
 S FHWRD=$P(FHA0,"^",8),FHRMB=$P(FHA0,"^",9) I FHWRD K ^FHPT("AW",FHWRD,FHDFN) S $P(^FHPT(FHDFN,"A",ADM,0),"^",8,9)="^"
 S EVT="L^D^^"_FHWRD_"~"_FHRMB D ^FHORX
 ; Close out Additional Orders
 F FHDR=0:0 S FHDR=$O(^FHPT("AOO",FHDFN,ADM,FHDR)) Q:FHDR<1  D AOO
 ; Close out Consults
 F FHDR=0:0 S FHDR=$O(^FHPT(FHDFN,"A",ADM,"DR",FHDR)) Q:FHDR<1  S Y=^(FHDR,0) D CON
 ; Close out standing orders
 F FHDR=0:0 S FHDR=$O(^FHPT(FHDFN,"A",ADM,"SP",FHDR)) Q:FHDR<1  S Y=^(FHDR,0) D SP
 ; Cancel tubefeeding
 S K=$P(FHA0,"^",4) I K D TF
 ; Cancel future early/late trays
 F FHDR=FHNOW:0 S FHDR=$O(^FHPT(FHDFN,"A",ADM,"EL",FHDR)) Q:FHDR<1  D EL
 ; Cancel supplemental feeding
 S K=$P(FHA0,"^",7) I K D SF
 ; Cancel isolation/precaution
 S K=$P(FHA0,"^",10) I K D IS
 ; Cancel diet/ place on no order
 D DO
 I $D(^DPT(DFN,.1)) D WRD^FHWADM
 ; Delete Diet related Food Restrictions
 F FHFP=0:0 S FHFP=$O(^FHPT(FHDFN,"P",FHFP)) Q:FHFP<1  S FHFP1=$G(^(FHFP,0)) I $P(FHFP1,"^",4)="Y" D FP
KIL K %,%H,%I,%Y,EDT,A1,FHDR,K,FILL,FHNOW,FHO,FHA0,FHFP,FHFP1,FHORD,FHORN,FHPV,FHRMB,FHWRD,FHX,VAL,WKD,X,Y Q
AOO Q:$P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",5)="X"
 S $P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",5,7)="X^"_FHNOW_"^"_DUZ
 K ^FHPT("AOO",FHDFN,ADM,FHDR)
 S FHORN=$P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",8) Q:'FHORN
 Q:'$D(^OR(100,+FHORN))
 S FILL="A"_";"_ADM-";"_FHDR_$P(^FHPT(FHDFN,"A",ADM,"OO",FHDR,0),"^",3)
 D SEND
 Q
CON Q:$P(Y,"^",8)'="A"  S $P(^FHPT(FHDFN,"A",ADM,"DR",FHDR,0),"^",8,11)="X^"_FHNOW_"^"_DUZ_"^"
 S K=$P(Y,"^",5)
 K:K ^FHPT("ADRU",K,FHDFN,ADM,FHDR) Q
SP Q:$P(Y,"^",6)  S $P(^FHPT(FHDFN,"A",ADM,"SP",FHDR,0),"^",6,7)=FHNOW_"^"_DUZ
 K ^FHPT("ASP",FHDFN,ADM,FHDR) Q
TF S $P(^FHPT(FHDFN,"A",ADM,0),"^",4)="" K ^FHPT("ADTF",FHDFN,ADM)
 S $P(^FHPT(FHDFN,"A",ADM,"TF",K,0),"^",11,12)=FHNOW_"^"_DUZ
 S FHX=$G(^FHPT(FHDFN,"A",ADM,"TF",K,0))
 S FHORN=$P(FHX,"^",14) Q:'FHORN
 Q:'$D(^OR(100,+FHORN))
 S FILL="T"_";"_ADM_";"_K_";"_$P(FHX,"^",6)_";"_$P(FHX,"^",7)_";"_$P(FHX,"^",5)_";"
 D SEND
 Q
EL S FHORN=$P(^FHPT(FHDFN,"A",ADM,"EL",FHDR,0),"^",7)
 I FHORN D EL1
 K ^FHPT(FHDFN,"A",ADM,"EL",FHDR),^FHPT("ADLT",FHDR,FHDFN,ADM)
 S %=$P($G(^FHPT(FHDFN,"A",ADM,"EL",0)),"^",4)-1 S:%'<0 $P(^(0),"^",4)=% Q
EL1 S EDT=FHDR,WKD="" D WKD^FHWOR31
 S FHX=$G(^FHPT(FHDFN,"A",ADM,"EL",FHDR,0))
 Q:'$D(^OR(100,+FHORN))
 S FILL="E"_";"_ADM_";;"_FHDR_";"_FHDR_";"_WKD_";"_$P(FHX,"^",2)_";"_$P(FHX,"^",3)_";"_$P(FHX,"^",4)
 D SEND Q
SF S $P(^FHPT(FHDFN,"A",ADM,0),"^",7)=""
 S $P(^FHPT(FHDFN,"A",ADM,"SF",K,0),"^",32,33)=FHNOW_"^"_DUZ Q
IS S $P(^FHPT(FHDFN,"A",ADM,0),"^",10)="" K ^FHPT("AIS",FHDFN,ADM)
 S FHORN=$P(FHA0,"^",13) Q:'FHORN
 Q:'$D(^OR(100,+FHORN))
 S FILL="I"_";"_ADM_";"_K D SEND
 Q
DO F A1=FHNOW:0 S A1=$O(^FHPT(FHDFN,"A",ADM,"AC",A1)) Q:A1=""  K ^FHPT(FHDFN,"A",ADM,"AC",A1)
 F FHDR=0:0 S FHDR=$O(^FHPT(FHDFN,"A",ADM,"DI",FHDR)) Q:FHDR<1  D D1
 S FHA0=$P(FHA0,"^",2) Q:'FHA0  S FHA0=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHA0,0)),"^",7) Q:FHA0="X"
 D ORD^FHORD7 S ^FHPT(FHDFN,"A",ADM,"DI",FHORD,0)=FHORD_"^^^^^^X^^"_FHNOW_"^^"_DUZ_"^"_FHNOW
 S ^FHPT(FHDFN,"A",ADM,"AC",FHNOW,0)=FHNOW_"^"_FHORD
 S $P(^FHPT(FHDFN,"A",ADM,0),"^",2,3)=FHORD_"^" Q
D1 ; Get all filler fields for Diet
 S FHORN=$P($G(^FHPT(FHDFN,"A",ADM,"DI",FHDR,0)),"^",14,15)
 I +FHORN>0,$P(FHORN,"^",2)>2 S FHORN=+FHORN,$P(^FHPT(FHDFN,"A",ADM,"DI",FHDR,0),"^",15)=1 D D2
 Q
D2 S FHX=$G(^FHPT(FHDFN,"A",ADM,"DI",FHDR,0))
 Q:$P(FHX,"^",7)="P"!($P(FHX,"^",7)="X")
 S FHO=$P(FHX,"^",2,6),VAL="" D VAL^FHWORP(FHO,.VAL) Q:VAL=""
 Q:'$D(^OR(100,+FHORN))
 S FILL=$S($P(FHX,"^",7)="N":"N",1:"D")_";"_ADM_";"_FHDR_";"_$P(FHX,"^",9)_";"_$P(FHX,"^",10)_";"_$P(FHX,"^",7)_";"_$G(^FHPT(FHDFN,"A",ADM,"DI",FHDR,1))_";"_$P(FHX,"^",8)_";;"_VAL
 D SEND Q
FP K ^FHPT(FHDFN,"P",FHFP,0),^FHPT(FHDFN,"P","B",+FHFP1,FHFP)
 S %=$P($G(^FHPT(FHDFN,"P",0)),"^",4)-1 S:%'<0 $P(^(0),"^",4)=% Q
SEND ; Send MSG to OE/RR
 D CODE D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) Q
CODE ; Code Cancel For Discharge
 K MSG S ACT="OC" D SITE^FH
 ; code MSH
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||ORM"
 ; code PID
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 ; code ORC
 S DATE=$$FMTHL7^XLFDT(FHNOW),FHPV=DUZ
 S MSG(3)="ORC|"_ACT_"|"_FHORN_"^OR|"_FILL_"^FH|||||||||"_FHPV_"|||"_DATE_"|Dietetics Canceled Order."
 K %,ACT,DATE,FILL,SITE Q
