PSOPKIV1 ;BHAM ISC/MHA - validate PKI cert. ; 05/09/2002  8:15 am
 ;;7.0;OUTPATIENT PHARMACY;**131,146,223,148,249,391,426**;DEC 1997;Build 2
 ;Ref. to ^ORDEA is supported by DBIA 5709
 ;Ref. to ^ORB supported by DBIA 1362
 ;Ref. to ^XUSSPKI supported by DBIA 3539
CER ;
 N PKIRT
 D VERIFY(.PKIRT,ORD)
 S PKI=+PKIRT I PKI=1!(PKI=89802020) D  Q
 . S PKI1=1,VALMSG="Digitally Signed Order",PKIE="Processing "_VALMSG
 . I PKI=89802020 S PKIE=PKIE_": "_$P($T(@($E(PKI,7,8))),";;",2)
 I PKI<2 S VALMSG=$P(PKIRT,"^",2) Q
 S PKI1=$S(PKI>89802014&(PKI<89802020)!((PKI>89802020)&(PKI<89802031)):2,1:1)
 S PKIE="Digital Signature Failed: "_$P($T(@($E(PKI,7,8))),";;",2)
 I PKI1=2 D
 .S VALMSG="Signature Failed: "_$P($T(@($E(PKI,7,8))),";;",2)
 .S PKIE=PKIE_" - Order Auto Discontinued"
 S:$L(PKIE)>80 PKIE=$E(PKIE,1,80)
 Q
L1 ;
 S PKID=1,IEN=IEN+1,^TMP($S($G(ST)=1:"PSOAO",1:"PSOPO"),$J,IEN,0)=PKIE
 Q
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
 Q:'$D(^PS(52.41,ORD,0))  N PKIOR,PKIORM
 K ^PS(52.41,"AOR",$P(^PS(52.41,ORD,0),"^",2),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD),^PS(52.41,"AD",$P(^PS(52.41,ORD,0),"^",12),+$P($G(^PS(52.41,ORD,"INI")),"^"),ORD)
 S $P(^PS(52.41,ORD,0),"^",3)="DC"
 S PKIE=$P(PKIE," - ")_" - "_PKI,$P(^PS(52.41,ORD,4),"^")=PKIE
 S PKIOR=$E(PKI,7,8)
 S PKIORM=$S(PKIOR=16:"16:Order has been modified. Resubmit or contact Pharmacy.",PKIOR=17:"17:DEA Certificate revoked. Resubmit or contact Pharmacy.",1:PKIE)
 D EN^PSOHLSN($P(^PS(52.41,ORD,0),"^"),"OC",PKIORM,"A")
 D ^PSOPKIV2
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
 Q
 ;
VERIFY(RET,PSIEN)       ;Verify PKI Data
 ;PSIEN = IEN of file 52.41 ;ORIFN;ACTION - NOTE: if no ACTION then 1 (new order) is assumed
 ;Returned values: "1" if digital signature verifies
 ;                 "-1^error message" if DS fails during initial parameter checking
 ;                 "898020xx^message" if DS fails during verification
 ;
 N PSO0,DFN,PSIG,I,INFO,INF1,DEA,INST,HASH,DATE
 I $G(PSIEN)="" S RET="-1^Invalid order number" Q
 K ^TMP("PSOPKIDATA",$J)
 S PSO0=$G(^PS(52.41,PSIEN,0))
 S ^TMP("PSOPKIDATA",$J,"ISSUANCE DATE",1)=$$FMTE^XLFDT($P($P(PSO0,"^",6),"."))
 ;patient inf
 S DFN=$P(PSO0,"^",2) D DEM^VADPT,ADD^VADPT
 S ^TMP("PSOPKIDATA",$J,"PATIENT NAME",2)=VADM(1)
 S ^TMP("PSOPKIDATA",$J,"PATIENT ADDRESS",3)=VAPA(1)_"^"_VAPA(2)_"^"_VAPA(3)_"^"_VAPA(4)_"^"_$P(VAPA(5),"^")_"^"_$P(VAPA(5),"^",2)_"^"_VAPA(6)_"^"_VAPA(7)
 S ^TMP("PSOPKIDATA",$J,"QUANTITY",5)=$P(PSO0,"^",10)
 K ^TMP($J,"ORDEA")
 D ARCHIVE^ORDEA(+PSO0)
 ;POS DOSE
 N J,INF0,INF1,PSIG
 S J=0 F  S J=$O(^PS(52.41,PSIEN,1,J)) Q:'J  D
 .S INF0=$G(^PS(52.41,PSIEN,9,J,0)),INF1=$G(^PS(52.41,PSIEN,1,J,1))
 .S PSIG=INF0_"|"_$P(INF1,"^")_"|"_$S($E($P(INF1,"^",2))="L":"M"_$E($P(INF1,"^",2),2,99),1:$P(INF1,"^",2))_"|"_$P(INF1,"^",6)_"|"_$P(INF1,"^",8)
 .S ^TMP("PSOPKIDATA",$J,"DIRECTIONS",6,J)=PSIG
 I +$P(PSO0,"^",9),+$P(PSO0,"^",25) S ^TMP("PSOPKIDATA",$J,"DRUG NAME",4)=$$GET1^DIQ(50,$P(PSO0,"^",9),.01)
 S DEA=$P($G(^TMP($J,"ORDEA",+PSO0,2)),"^")
 ;S ^TMP("PSOPKIDATA",$J,"DETOX NUMBER",7)=$$DETOX^XUSER($P(PSO0,"^",5))
 S ^TMP("PSOPKIDATA",$J,"PROVIDER NAME",8)=$$GET1^DIQ(200,$P(PSO0,"^",5),.01)
 I $D(^TMP($J,"ORDEA",+PSO0,3)) S ^TMP("PSOPKIDATA",$J,"PROVIDER ADDRESS",9)=$P(^(3),"^",2,6)
 E  D INSTAD
 K ^TMP($J,"ORDEA")
 D KVA^VADPT
 S ^TMP("PSOPKIDATA",$J,"DEA NUMBER",10)=DEA
 S ^TMP("PSOPKIDATA",$J,"ORDER NUMBER",11)=$P(PSO0,"^")
 S HASH=$$HASHRTN^ORDEA($P(PSO0,"^"))
 I '$L(HASH) S RET="-1^Order has no PKI Hash" G VQT
 S DATE=$$FMTE^XLFDT($P($P(PSO0,"^",6),"."))
 I '$L(DATE) S RET="-1^No date associated with order" G VQT
 S RET=$$VERIFY^XUSSPKI(HASH,$NA(^TMP("PSOPKIDATA",$J)))
 I RET="OK"!(RET["No error found for this certificate or chain") S RET=1 G VQT
 N ECD S ECD=898020
 I RET[ECD S RET=$P(RET,"^",2) G VQT
 I RET["not time-valid" S RET=ECD_"20" G VQT
 I RET["has been revoked" S RET=ECD_"17" G VQT
 I RET["does not have a valid signature" S RET=ECD_"22" G VQT
 I RET["not properly time-nested" S RET=ECD_"23" G VQT
 I RET["not valid in its proposed usage" S RET=ECD_"24" G VQT
 I RET["based on an untrusted root" S RET=ECD_"25" G VQT
 I RET["certificates in the certificate chain is unknown" S RET=ECD_"26" G VQT
 I RET["authority that the original certificate had certified" S RET=ECD_"27" G VQT
 I RET["certificate chain is not complete" S RET=ECD_"28" G VQT
 I RET["this chain did not have a valid signature" S RET=ECD_"29" G VQT
 I RET["not valid for this usage" S RET=ECD_"30" G VQT
VQT ;
 K ^TMP("PSOPKIDATA",$J)
 Q
 ;
INSTAD ;
 S INST=$P($G(^PS(52.41,PSIEN,"INI")),"^")
 D GETS^DIQ(4,INST,".01;1.01;1.02;1.03;1.04;.02","E","VADR")
 S VADD(1)=$G(VADR(4,INST_",",.01,"E")),VADD(2)=$G(VADR(4,INST_",",1.01,"E")),VADD(3)=$G(VADR(4,INST_",",1.02,"E"))
 S VADD(4)=$G(VADR(4,INST_",",1.03,"E")),VADD(5)=$G(VADR(4,INST_",",.02,"E")),VADD(6)=$G(VADR(4,INST_",",1.04,"E"))
 S ^TMP("PSOPKIDATA",$J,"PROVIDER ADDRESS",9)=VADD(1)_"^"_VADD(2)_"^"_VADD(3)_"^"_VADD(4)_"^"_VADD(5)_"^"_VADD(6)
 Q
 ;
HSHCHK(ARET,PNP) ;Compares digitally signed archived data in file #101.52 against data in OP pending file #52.41
 ;PSO*7*391/JAM
 ;Input - PNP  - Pending file IEN
 ;     
 ;Output - returns 1 if the archived data matches the pending file
 ;                 0 if initial parameter checking fails
 ;                -1 if comparison fails; and return array with failed items
 ;
 N DFN,PND0,DRGNM,DEA,DETOX,DFN,J,I,INST,NAM,SIGFL,DOSE,DOSEP,DOSEX,DFRM,TMP,VADD,VADR,INF0,INF1,ASIG,PSIG,ORP,ND
 I $G(PNP)="" S ARET=0 Q ARET
 S PND0=$G(^PS(52.41,PNP,0)) I PND0="" S ARET=0 Q ARET
 S ORP=$P(PND0,"^") I ORP="" S ARET=0 Q ARET
 ;get archived data from CPRS
 K ^TMP($J,"ORDEA")
 D ARCHIVE^ORDEA(ORP)
 I '$D(^TMP($J,"ORDEA")) S ARET=0 Q ARET
 F I=1:1:5 S TMP(I)=$G(^TMP($J,"ORDEA",ORP,I))
 I $P($P(PND0,"^",6),".")'=$P(TMP(1),"^",2) S ARET=-1,ARET("ISSUANCE DATE")=$P(TMP(1),"^",2)_"^"_$P($P(PND0,"^",6),".")
 S DRGNM=$$GET1^DIQ(50,$P(PND0,"^",9),.01)
 I DRGNM'=$P(TMP(1),"^",3) S ARET=-1,ARET("DRUG NAME")=$P(TMP(1),"^",3)_"^"_DRGNM
 I $P(PND0,"^",10)'=$P(TMP(1),"^",6) S ARET=-1,ARET("QTY PRESCRIBED")=$P(TMP(1),"^",6)_"^"_$P(PND0,"^",10)
 ;I $P(PND0,"^",11)'=$P(TMP(1),"^",7) S ARET=-1,ARET("# OF REFILLS")=$P(TMP(1),"^",7)_"^"_$P(PND0,"^",11)
 ;provider info
 S INST=$P($G(^PS(52.41,PNP,"INI")),"^")
 S DEA=$$DEA^XUSER(0,$P(PND0,"^",5))
 I DEA'=$P(TMP(2),"^") S ARET=-1,ARET("DEA #")=$P(TMP(2),"^")_"^"_DEA
 ;S DETOX=$$DETOX^XUSER($P(PND0,"^",5)) I DETOX'=$P(TMP(2),"^",2) S ARET=-1,ARET("DETOX #")=$P(TMP(2),"^",2)_"^"_DETOX
 S NAM=$$GET1^DIQ(200,$P(PND0,"^",5),.01) I NAM'=$P(TMP(2),"^",3) S ARET=-1,ARET("PROVIDER NAME")=$P(TMP(2),"^",3)_"^"_NAM
 ;patient inf
 S DFN=$P(PND0,"^",2) D DEM^VADPT,ADD^VADPT
 I VADM(1)'=$P(TMP(4),"^") S ARET=-1,ARET("PATIENT NAME")=$P(TMP(4),"^")_"^"_VADM(1)
 I VAPA(1)'=$P(TMP(5),"^") S ARET=-1,ARET("PATIENT ADDRESS #1")=$P(TMP(5),"^")_"^"_VAPA(1)
 I VAPA(2)'=$P(TMP(5),"^",2) S ARET=-1,ARET("PATIENT ADDRESS #2")=$P(TMP(5),"^",2)_"^"_VAPA(2)
 I VAPA(3)'=$P(TMP(5),"^",3) S ARET=-1,ARET("PATIENT ADDRESS #3")=$P(TMP(5),"^",3)_"^"_VAPA(3)
 I VAPA(4)'=$P(TMP(5),"^",4) S ARET=-1,ARET("PATIENT CITY")=$P(TMP(5),"^",4)_"^"_VAPA(4)
 I $P(VAPA(5),"^",2)'=$P(TMP(5),"^",5) S ARET=-1,ARET("PATIENT STATE")=$P(TMP(5),"^",5)_"^"_$P(VAPA(5),"^",2)
 I VAPA(6)'=$P(TMP(5),"^",6) S ARET=-1,ARET("PATIENT ZIP+4")=$P(TMP(5),"^",6)_"^"_VAPA(6)
 ;sig
 M ASIG=^TMP($J,"ORDEA",ORP,6)
 S I=0 F  S I=$O(^PS(52.41,PNP,1,I)) Q:'I  D
 .S INF0=$G(^PS(52.41,PNP,9,I,0)),INF1=$G(^PS(52.41,PNP,1,I,1))
 .S PSIG(I)=INF0_"|"_$P(INF1,"^")_"|"_$P(INF1,"^",2)_"|"_$P(INF1,"^",6)_"|"_$P(INF1,"^",8)
 S I=0 F  S I=$O(ASIG(I)) Q:'I  I ASIG(I)'=$G(PSIG(I)) S ND="SIG #"_I,ARET=-1 S ARET(ND)=ASIG(I)_"^"_$G(PSIG(I))
 D KVA^VADPT
 K ^TMP($J,"ORDEA")
 Q $S($G(ARET):ARET,1:1)
 ;
ALERT ;
 ; ORN=76 - Notification ID (ifn from OE/RR Notifications file  #100.9) 
 ; ORBDFN=Patient DFN from Patient file #2 
 ; ORNUM=Order ifn from Order file #100
 ; ORBADUZ=Provider DUZ - Array of notification recipients requested by the calling package.  
 ; ORBPMSG=Message text 
 ; ORBPDATA=This is an identifier of the package entry which the notification is based on.  
 ;          For radiology: Rad/Nuc Med exam/case ifn's(format: exam_ifn;case_ifn)
 ;          For consults:  the IEN of the consult in file 123 
 N PSOX S PSOX=1
 S PSOX(+$P(OR0,"^",5))=""
 D EN^ORB3(76,PSODFN,$P(OR0,"^"),.PSOX,"DEA certificate expired. Renew your certificate.","")
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
23 ;;CERT_IS_NOT_TIME_NESTED;;
24 ;;CERT_IS_NOT_VALID_FOR_USAGE;;
25 ;;CERT_IS_UNTRUSTED_ROOT;;
26 ;;CERT_REVOCATION_STATUS_UNKNOWN;;
27 ;;CERT_IS_CYCLIC;;
28 ;;CERT_IS_PARTIAL_CHAIN;;
29 ;;CERT_CTL_IS_NOT_SIGNATURE_VALID;;
30 ;;CERT_CTL_IS_NOT_VALID_FOR_USAGE;;
