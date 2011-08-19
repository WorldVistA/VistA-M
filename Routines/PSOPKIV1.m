PSOPKIV1 ;BHAM ISC/MHA - validate PKI cert. ; 05/09/2002  8:15 am
 ;;7.0;OUTPATIENT PHARMACY;**131,146,223,148,249**;DEC 1997;Build 9
 ;Ref. to ^ORWOR1 supported by DBIA 3750
CER ;
 N P1,P2
 I $D(OR0) S P1=$P(OR0,"^"),P2=$P(OR0,"^",2)
 E  S P1=$P($G(^PSRX(DA,"OR1")),"^",2),P2=$P($G(^(0)),"^",2)
 I P1<1 S PKI=-1,VALMSG="Invalid CPRS Pointer - Unable to Process" Q
CT N PKIRT D VERIFY^ORWOR1(.PKIRT,P1,P2)
 S PKI=+PKIRT I PKI=1 S VALMSG="Digitally Signed Order",PKIE="Processing "_VALMSG Q
 I PKI<2 S VALMSG=$P(PKIRT,"^",2) Q
 S PKI1=$S(PKI>89802014&(PKI<89802019)!((PKI>89802020)&(PKI<89802023)):2,1:1)
 S PKIE="Digital Signature Failed: "_$P($T(@($E(PKI,7,8))),";;",2)
 S:'$G(PSOZVER) VALMSG="Signature Failed: "_$P($T(@($E(PKI,7,8))),";;",2)
 S:PKI1=2 PKIE=PKIE_" - Order Auto Discontinued" S:$L(PKIE)>75 PKIE=$E(PKIE,1,75)
 Q
L1 ;
 S PKID=1,IEN=IEN+1,^TMP($S($G(ST)=1:"PSOAO",1:"PSOPO"),$J,IEN,0)=PKIE Q
ERR(ER) ;
 Q:'ER
 N ERM S ERM=$P($T(@($E(ER,7,8))),";;",2) I ERM]"" Q "Signature Failed: "_ERM
 Q ""
REA ;
 D KV^PSOVER1
 W ! S DIR("A")="Enter Override Reason ",DIR(0)="F^5:70",DIR("?")="Free text reason must be entered, should be between 5 to 70 characters and must not contain embedded up-arrow, e.g. Spoke with the Provider."
 S:$G(PKIR)]"" DIR("B")=PKIR D ^DIR S:'$D(DIRUT) PKIR=Y
 I $D(DIRUT) K PKIR I $D(OR0) S:$P(OR0,"^",3)="RNW" PSONEW("QFLG")=1 S:$P(OR0,"^",3)="NW" PSORX("DFLG")=1
 D KV^PSOVER1 K Y Q
ACT(DA) ;
 Q:'DA
 N I,J D AR
 S ^PSRX(DA,"A",0)="^52.3DA^"_J_"^"_J,^PSRX(DA,"A",J,0)=%_"^K^"_DUZ_"^0^INVALID PKI CERT. "_PKI
 S ^PSRX(DA,"A",J,2,1,0)=PKIR,^PSRX(DA,"A",J,2,0)="^52.34A^1^1"
 K PKIR Q
 ;
AR ;
 S (I,J)=0 F  S I=$O(^PSRX(DA,"A",I)) Q:'I  S J=I
 S J=J+1 D NOW^%DTC Q
DCP ;
 Q:'$D(^PS(52.41,ORD,0))
 K ^PS(52.41,"AOR",$P(^PS(52.41,ORD,0),"^",2),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD),^PS(52.41,"AD",$P(^PS(52.41,ORD,0),"^",12),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD)
 S $P(^PS(52.41,ORD,0),"^",3)="DC"
 S PKIE=$P(PKIE," - ")_" - "_PKI,$P(^PS(52.41,ORD,4),"^")=PKIE
 D EN^PSOHLSN($P(^PS(52.41,ORD,0),"^"),"OD",PKIE,"A")
 Q
 ;
DCV ;
 W ! D KV^PSOVER1 K PKIR S DIR(0)="Y",DIR("B")="N",DIR("A",1)="Digitally signed Schedule II Rx cannot be deleted, it can only be D/Ced."
 S DIR("A")="Are you sure you want to D/C this Rx: " D ^DIR,KV^PSOVER1
 I 'Y S VALMSG="No Action Taken!",VALMBCK="R" Q
 S:'$D(INCOM) INCOM="DCed by Pharmacy for PKI" S DIR("B")=INCOM
 ;
 W ! S DIR("A")="Reason for D/Cing",DIR(0)="F^5:75",DIR("?")="Reason must be entered and should be 5 to 75 characters and must not contain embedded uparrow"
 D ^DIR I $D(DIRUT) D KV^PSOVER1 S VALMSG="No Action Taken!",VALMBCK="R" Q
 S PKIR=Y D KV^PSOVER1
DCV0 Q:'$D(^PS(52.4,DA,0))
 S $P(^PSRX(DA,"STA"),"^")=12,$P(^PSRX(DA,3),"^",5)=DT
 D REVERSE^PSOBPSU1(DA,,"DC",7),CAN^PSOTPCAN(DA) N I,J D AR
 S ^PSRX(DA,"A",J,0)=%_"^C^"_DUZ_"^0^Discontinued during verification"
 S J=J+1 D ADR
 N PKIX S PKIX=DA D EN^PSOHLSN1(DA,"OD","",PKIR,PSONOOR)
 S DA=PKIX S DIK="^PS(52.4," D ^DIK K DIK
 Q
 ;
DCV1 N PKIR,PSONOOR,DA S DA=PSONV,PKIR=$P($G(PKIE),"-")_" - "_PKI,PSONOOR="A" D DCV0
 Q
ADR ;
 S ^PSRX(DA,"A",0)="^52.3DA^"_J_"^"_J
 S ^PSRX(DA,"A",J,0)=%_"^K^"_DUZ_"^0^Digitally signed"
 S ^PSRX(DA,"A",J,2,1,0)=$S($G(PKIR)]"":PKIR,1:"Digitally signed order Discontinued"),^PSRX(DA,"A",J,2,0)="^52.34A^1^1"
 Q
RV ;
 N TY,T,T1,T2,MIG,SG
 S (T,T2)=0
 F  S T=$O(^PS(52.41,ORD,"OBX",T)) Q:'T  D
 .S T1=0,$P(TY(T2)," ",23)=" "
 .F  S T1=$O(^PS(52.41,ORD,"OBX",T,2,T1)) Q:'T1  D
 ..S MIG=^PS(52.41,ORD,"OBX",T,2,T1,0)
 ..F SG=1:1:$L(MIG," ") S:$L(TY(T2)_" "_$P(MIG," ",SG))>80 T2=T2+1,$P(TY(T2)," ",23)=" " S TY(T2)=$G(TY(T2))_" "_$P(MIG," ",SG)
 .S T2=T2+4
 S T2=T2+2 D CNTRL^VALM10(T2,1,$L(PKIE),IORVON,IORVOFF,0)
 Q
 ;
00 ;;Order Text is blank;;
01 ;;DEA # missing;;
02 ;;Drug Schedule missing;;
03 ;;DEA # not valid;;
04 ;;Valid Certificate not found;;
05 ;;Couldn't load CSP;;
06 ;;Smart card Reader not found;;
07 ;;Certificate with DEA # not found;;
08 ;;Certificate not valid for schedule;;
10 ;;Crypto Error (contact IRM);;
15 ;;Corrupted (Decode failure);;
16 ;;Corrupted (Hash mismatch);;
17 ;;Certificate revoked;;
18 ;;Verification failure;;
19 ;;Before Cert effective date;;
20 ;;Certificate expired;;
21 ;;No Cert with a valid date found;;
22 ;;Signature Check failed (Invalid Signature);;
