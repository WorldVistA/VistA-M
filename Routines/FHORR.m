FHORR ; HISC/NCA/JH - Diet Order Utilities For OE/RR Interface ;10/10/00  14:54
 ;;5.5;DIETETICS;;Jan 28, 2005
OE ; File OE/RR Diet Order For Re-instated Diet Order
 Q:$P(FHNO1,"^",7)="X"!($P(FHNO1,"^",7)="P")
 S FHO=$P(FHNO1,"^",2,6),VAL="" D VAL^FHWORP(FHO,.VAL) Q:VAL=""
 S FHNEW=$S($P(FHNO1,"^",7)'="":"N",1:"D")_";"_ADM_";"_FHORD1_";"_D2_";"_$P(FHNO1,"^",10)_";"_$P(FHNO1,"^",7)_";"_FHNO2_";"_$P(FHNO1,"^",8)_";"_0_";"_VAL
 S (FHSTS,FHDU)=$S(D2>NOW:8,1:6) S FHDIE=FHORD
 I $P(FHNO1,"^",7)="N" D NPO D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG S FHORD=FHDIE K FHDIE G SAV
 I $P(FHNO1,"^",7)="" D DO D:$D(MSG) MSG^XQOR("FH EVSEND OR",.MSG) K MSG
 S FHORD=FHDIE K FHDIE
SAV S:FHDU $P(^FHPT(FHDFN,"A",ADM,"DI",FHORD1,0),"^",15)=FHDU Q
DO ; Code Re-instated Diet Orders
 K MSG S FILL=$G(FHNEW)
 S SDT=D2,DATE1="" D SET
 ; Code MSH, PID, and PV1
 D MSH^FHWOR
 ; code ORC
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_SDT_"^"_DATE1_"|||"_DUZ_"||"_FHPV_"|||"_DATE
 ; Code ODS
 F A7=5:1 S A8=$P(FHNO1,"^",A7-3) Q:'A8  D
 .S MSG(A7)="ODS|ZT||^^^"_A8_"^"_$P($G(^FH(111,+A8,0)),"^",1)_"^99FHD" Q
 K A7,A8,DATE,DATE1,FILL,FHWRD,HOSP,RM,SITE,SDT,VAL
 Q
NPO ; Code Re-instated NPO Order
 K MSG S FILL=$G(FHNEW) Q:FILL=""
 S SDT=D2,DATE1="" D SET
 ; Code MSH, PID, and PV1
 D MSH^FHWOR
 ; code ORC
 S MSG(4)="ORC|SN||"_FILL_"^FH||||^^^"_SDT_"^"_DATE1_"|||"_DUZ_"||"_FHPV_"|||"_DATE
 ; Code ODS
 S MSG(5)="ODS|D||^^^FH-5^NPO^99OTH|"_COM
 K DATE,DATE1,FILL,FHWRD,HOSP,RM,SITE,SDT
 Q
SET ; Set Date/Time in HL7 format
 S DATR=$S($P(FHNO1,"^",10):$P(FHNO1,"^",10),1:"")
 S:SDT SDT=$$FMTHL7^XLFDT(SDT)
 S:NOW DATE=$$FMTHL7^XLFDT(NOW)
 S:DATR DATE1=$$FMTHL7^XLFDT(DATR) S:'DATE1 DATE1="" K DATR
 Q
ORD ; Get next order # for re-instate diet order
 L +^FHPT(FHDFN,"A",ADM,"DI",0)
 I '$D(^FHPT(FHDFN,"A",ADM,"DI",0)) S ^FHPT(FHDFN,"A",ADM,"DI",0)="^115.02A^^"
 S X=^FHPT(FHDFN,"A",ADM,"DI",0),FHORD1=$P(X,"^",3)+1,^(0)=$P(X,"^",1,2)_"^"_FHORD1_"^"_($P(X,"^",4)+1)
 L -^FHPT(FHDFN,"A",ADM,"DI",0) Q:'$D(^FHPT(FHDFN,"A",ADM,"DI",FHORD1))  G ORD
