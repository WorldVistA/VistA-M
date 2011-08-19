FHWOR2 ; HISC/NCA - HL7 Diet Order ;11/22/00  11:05
 ;;5.5;DIETETICS;;Jan 28, 2005
 S (DATE,D1)=SDT I DATE="" S TXT="No Start Date." D ERR^FHWOR Q
 D NOW^%DTC D CVT^FHWOR S D1=DATE
 S (DATE,D2)=EDT
 I DATE D CVT^FHWOR S D2=DATE
 I D2,D1>D2 S TXT="Wrong Stop Date." D ERR^FHWOR Q
 S DATE=NOW D CVT^FHWOR S NOW=DATE
 S FHRDER=+FHORN
 I D1<% S D1=%
 K DI S N1=0 F K=5:1 S X=$G(FHMSG(K)) Q:X=""  D
 .I $E(X,1,3)'="ODS" S TXT="Msg Error." Q
 .S TYP=$E($P(X,"|",2),2) I TYP="" S TXT="No Type of Service." Q
 .I "TCD"'[TYP S TXT="Wrong Type of Tray." Q
 .S DIET=$P(X,"|",4),Y=$P(DIET,"^",4),FILE=$P(DIET,"^",6),COM=$E($P(X,"|",5),1,80)
 .I $E(FILE,1,5)'="99FHD" S TXT="Msg Error." Q
 .S PREC=$P($G(^FH(111,+Y,0)),"^",4) I $D(DI(PREC)) S TXT="Msg Error." Q
 .S N1=N1+1,DI(PREC)=Y_"^"_$G(^FH(111,+Y,0)) Q
 I TXT'="" D ERR^FHWOR Q
 I N1>1 D  I CHK S TXT="Can not order REGULAR with another Diet." D ERR^FHWOR Q
 .S CHK=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0=""  I +DI(D0)=1 S CHK=1 Q
 I N1>5 S TXT="Can not order more than 5 Diets." D ERR^FHWOR Q
 S D4=0,FHOR="^^^^",FHEVTX="",N1=0 F D0=0:0 S D0=$O(DI(D0)) Q:D0<1  S N1=N1+1,$P(FHOR,"^",N1)=+DI(D0),FHEVTX=FHEVTX_", "_$P(DI(D0),"^",8) S:$P(DI(D0),"^",7)="Y" D4=1
 S FHLD=""
 I '$O(^FH(111.1,"AB",FHOR,0)),$P($G(^FH(119.9,1,4)),"^",2)="Y" S EVT="M^O^^No Diet Pattern ("_$E(FHEVTX,3,999)_")" D ^FHORX
 ; Process PROC
 D PROC^FHORD1
 S CAN=$$CANCEL^ORCDFH(FHRDER)
 I CAN S FHTF=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",4) D:FHTF ORCAN^FHWOR5 K FHRDER
 K FHRDER G KIL
CAN ; Process Cancel or Discontinue
 S FHORD=$P(FILL,";",3) I 'FHORD D CSEND^FHWOR Q
 D GADM^FHWORR
 S FHREA=$P(DATA,"|",17),FHREA=$P(FHREA,"^",5) I FHREA="Discharge" D DIS^FHWOR4,CSEND^FHWOR K FHREA Q
 D NC
 D CSEND^FHWOR
 D KIL^FHORD3 Q
NC ; Cancel Diet Order
 D NOW^%DTC S NOW=% S OLD=""
 I '$D(^FHPT(FHDFN,"A",+ADM,"DI",+FHORD,0)) Q
 I $P($G(^FHPT(FHDFN,"A",ADM,"DI",+FHORD,0)),"^",19)'="" Q
 S NSTR=0 F KK=0:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1!(KK'<NOW)  S NSTR=KK
 F KK=NSTR-.000001:0 S KK=$O(^FHPT(FHDFN,"A",ADM,"AC",KK)) Q:KK<1  I $P(^(KK,0),"^",2)=FHORD G F1
 Q
F1 D T0^FHORD3
 Q
DO ; Code Diet Orders
 K MSG S FILL=$G(FHNEW)
 S SDT=D1,DATE1="" D SET
 ; Code MSH, PID, and PV1
 D MSH^FHWOR
 ; code ORC
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_SDT_"^"_DATE1_"|||"_DUZ_"||"_DUZ_"|||"_DATE
 ; Code ODS
 F A1=5:1 S A2=$P(FHOR,"^",A1-4) Q:'A2  D
 .;S MSG(A1)="ODS|ZT||^^^"_A2_"^"_$P($G(^FH(111,+A2,0)),"^",1)_"^99FHD" Q
 .I $G(TYP)="" S TYP="T"
 .S MSG(A1)="ODS|Z"_TYP_"||^^^"_A2_"^"_$P($G(^FH(111,+A2,0)),"^",1)_"^99FHD" Q
 K DATE,DATE1,FILL,FHWRD,HOSP,RM,SITE,SDT,VAL
 Q
SET ; Set Date/Time in HL7 format
 S:SDT SDT=$$FMTHL7^XLFDT(SDT)
 S:NOW DATE=$$FMTHL7^XLFDT(NOW)
 S:D2 DATE1=$$FMTHL7^XLFDT(D2) S:'DATE1 DATE1=""
 Q
KIL ; Kill
 G KIL^FHORD1
CODE ; Code Cancel/Discontinue Diet Order Status Change
 K MSG N ACT,FILL S FILL=$G(FHMSG1) S ACT=$S(FHSTS=6:"IP",FHSTS=8:"SC",FHSTS=1:"DC",1:"") Q:ACT=""  D SITE^FH
 ; code MSH
 S MSG(1)="MSH|^~\&|DIETETICS|"_SITE(1)_"|||||"_$S($D(FHORR):"ORR",1:"ORM")
 ; code PID
 S MSG(2)="PID|||"_DFN_"||"_$P($G(^DPT(DFN,0)),"^",1)
 ; code ORC
 S DATE=$S(FHDAT'="":$P(FHDAT,"^",1),1:"")
 I DATE S DATE=$$FMTHL7^XLFDT(DATE) S $P(FHDAT,"^",1)=DATE
 S DATE=$S(FHDAT'="":$P(FHDAT,"^",2),1:"")
 I DATE S DATE=$$FMTHL7^XLFDT(DATE) S $P(FHDAT,"^",2)=DATE
 S MSG(3)="ORC|"_$S($D(FHORR):"SR",1:"SC")_"|"_FHORN_"^OR|"_FILL_"^FH||"_ACT
 I FHDAT'="" S MSG(3)=MSG(3)_"||^^^"_FHDAT
 I ACT="DC" S MSG(3)=MSG(3)_"|||"_$S($D(FHPV):FHPV,1:"")_"||"_$S($D(FHPV):FHPV,1:"")
 K ACT,DATE,FHORR,FILL,SITE,WKDAYS Q
NA ; OE/RR Number Assign
 S FHORD=+$P(FILL,";",3) S:ADM'=$P(FILL,";",2) ADM=$P(FILL,";",2)
 S $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD,0),"^",14)=+FHORN Q
EL ; Late Trays HL7 to OE/RR
 K MSG S WKDAYS="",(EDT,SDT)=DTE
 S ITVL="ONCE",WKD="",SERV="L"
 S FILL="E"_";"_ADM_";;"_SDT_";"_EDT_";"_WKD_";"_MEAL_";"_TIM_";"_BAG
 D SET^FHWOR3
 ; Code MSH, PID, and PV1
 D MSH^FHWOR
 ; code ORC
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^"_ITVL_"^^"_SDT_"^"_EDT_"|||"_DUZ_"||"_DUZ_"|||"_NOW
 ; code ODT
 S MSG(5)="ODT|"_$S(SERV="E":"EARLY",1:"LATE")_"|^^^"_MEAL_SERV_NUM_"^^99FHS|"_$S(BAG="Y":"bagged",1:"")
 K FHWARD,FILL,HOSP,ITVL,FHORN,RM,SITE,WARD,WKDAYS,Z
 Q
