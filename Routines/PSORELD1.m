PSORELD1 ;BIR/PWC-HL7 V.2.4 EXTERNAL INTERFACE RELEASE DATE/TIME CONT. ;03/22/04
 ;;7.0;OUTPATIENT PHARMACY;**156**;DEC 1997
 ;HLFNC supp. by DBIA 10106
 ;PSNAPIS supp. by DBIA 2531
 ;VASITE supp. by DBIA 10112
 ;VADPT supp. by DBIA 10061
 ;EN^DIQ1 supp. by DBIA 100
 ;EN^VAFHLPID supp. by DBIA 263
 ;EN^VAFHLZTA supp. by DBIA 758
 ;BLDPID^VAFCQRY supp. by DBIA 3630
 ;MAKEIT^VAFHLU supp. by DBIA 4346
 ;PSDRUG supp. by DBIA 221
 ;PS(50.7 supp. by DBIA 2223
 ;PS(50.606 supp. by DBIA 2174
 ;PS(50.607 supp. by DBIA 2221
 ;PS(55 supp. by DBIA 2228
 ;PSNDF(50.6 supp. by DBIA 2195
 ;DIC(5 supp. by DBIA 10056
 ;DPT supp. by DBIA 3097
 ;SC supp. by DBIA 10040
 ;SEGPRSE^SCMSVUT5 supp. by DBIA 4347
 ;SEQPRSE^SCMSVUT5 supp. by DBIA 4347
 ;
INIT D GETDATA
 D PID(.PSI),PV1(.PSI),PV2(.PSI),ORC(.PSI),RXE(.PSI),RXD(.PSI)
 ; clean up data set by GETDATA
 K BINGO,RELDT,SITE,SITADD,SITPHN,PSOXN,PSOXN2,PSND1,PSND2,PSND3,PRODUCT,PSOPROD,VANAME,UNIT,PSDOSE,PODOSENM,POIPTR,NRFL,DISPDT,COPAY,ERR,PSONDC,NFDL,NFLD,PSZIP,PSOHZIP,TRADENM,X,Y,UU
 Q
GETDATA ; this is the place to set all data needed for several segments
 I $G(FP)="F"&('$G(FPN)) D    ;original
 . S FDT=$P(^PSRX(IRXN,2),"^",2),VPHARMID=$P(^(2),"^",10),DISPDT=$P(^(2),"^",5),EXDT=$P(^(2),"^",6),PSONDC=$P(^(2),"^",7)
 . S PVDR=$P(^PSRX(IRXN,0),"^",4),QTY=$P(^(0),"^",7),DASPLY=$P(^(0),"^",8),MW=$P(^(0),"^",11),EBY=$P(^(0),"^",16)
 I $G(FP)="F"&($G(FPN)) D    ;refill
 . S FDT=$P(^PSRX(IRXN,1,FPN,0),"^"),MW=$P(^(0),"^",2),QTY=$P(^(0),"^",4),DASPLY=$P(^(0),"^",10),DISPDT=$P(^(0),"^",19),EXDT=$S($P(^(0),"^",15):$P(^(0),"^",15),1:$P(^PSRX(IRXN,2),"^",6))
 . S VPHARMID=$S($P(^PSRX(IRXN,1,FPN,0),"^",5)'="":$P(^(0),"^",5),1:$P(^PSRX(IRXN,2),"^",10))
 . S EBY=$S($P(^PSRX(IRXN,1,FPN,0),"^",5):$P(^(0),"^",5),1:$P(^(0),"^",7)),PVDR=$P(^(0),"^",17),PSONDC=$S($P($G(^PSRX(IRXN,1,FPN,1)),"^",3):$P(^(1),"^",3),1:$P(^PSRX(IRXN,2),"^",7))
 I $G(FP)="P" D  ;partial
 . S FDT=$P(^PSRX(IRXN,"P",FPN,0),"^"),MW=$P(^(0),"^",2),QTY=$P(^(0),"^",4),DASPLY=$P(^(0),"^",10),DISPDT=$P(^(0),"^",13),PVDR=$P(^(0),"^",17),EXDT=$P(^PSRX(IRXN,2),"^",6)
 . S EBY=$S($P(^PSRX(IRXN,"P",FPN,0),"^",5):$P(^(0),"^",5),1:$P(^(0),"^",7)),VPHARMID=$S($P(^(0),"^",5)'="":$P(^(0),"^",5),1:$P(^PSRX(IRXN,2),"^",10)),PVDR=$P(^PSRX(IRXN,"P",FPN,0),"^",17)
 . S PSONDC=$S($P(^PSRX(IRXN,"P",FPN,0),"^",12):$P(^(0),"^",12),1:$P(^PSRX(IRXN,2),"^",7))
 S EFDT=$P(^PSRX(IRXN,2),"^",2) S:$G(EFDT) EFDT=$$HLDATE^HLFNC(EFDT,"DT")
 S ISDT=$P(^PSRX(IRXN,0),"^",13) S:$G(ISDT) ISDT=$$HLDATE^HLFNC(ISDT,"DT")
 S DEAID=$$GET1^DIQ(200,PVDR_",",53.2)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=VPHARMID D ^DIC
 S VPHARM=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)):1,"""""") K DIC,X,Y
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=EBY D ^DIC
 S EBY1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)):1,"""""") K DIC,X,Y
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=PVDR D ^DIC
 S PVDR1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)):1,"""""") K DIC,X,Y
 S PRIORDT=$P(^PSRX(IRXN,3),"^",4),PRIORDT=$$HLDATE^HLFNC(PRIORDT,"DT")
 S FDT=$$HLDATE^HLFNC(FDT,"DT")
 S:$G(DISPDT) DISPDT=$$HLDATE^HLFNC(DISPDT,"DT")
 S:$G(EXDT) EXDT=$$HLDATE^HLFNC(EXDT,"DT")
 S EBY1=$$HLNAME^HLFNC(EBY1,HLECH),PVDR1=$$HLNAME^HLFNC(PVDR1,HLECH)
 S FIN=$P(^PSRX(IRXN,"OR1"),"^",5)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=FIN D ^DIC
 S FIN1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)):1,"""""") K DIC,X,Y
 S SITE=$S($D(^PS(59,PSOSITE,0)):^(0),1:"")
 S PSZIP=$P(SITE,"^",5) S PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 S CLN=+$P(^PSRX(IRXN,0),"^",5),CLN1=$S($D(^SC(CLN,0)):$P(^(0),"^",1),1:"UNKNOWN")
 S CSINER=$P(^PSRX(IRXN,3),"^",3)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=CSINER D ^DIC
 S CSINER1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)):1,"""""") K DIC,X,Y
 D 6^VADPT
 I MW="W" S MP=$S($P($G(^PSRX(IRXN,"MP")),"^"):$P(^("MP"),"^"),1:"""""")
 S X=$S($D(^PS(55,DFN,0)):^(0),1:""),CAP=$P(X,"^",2)
 S:MW="M" MP="""""",MW=$S($P(X,"^",3):"R",1:MW) S MW=$S(MW="M":"REGULAR MAIL",MW="R":"CERTIFIED MAIL",MW="W":"WINDOW",1:"""""")
 I (($P(^PSRX(IRXN,"STA"),"^")>0)&($P(^("STA"),"^")'=2)&('$G(PSODBQ)))!'$G(^PSRX(IRXN,"IB")) S COPAY="NO COPAY"
 E  S COPAY="COPAY"
 S NURSE=$S($P($G(^DPT(DFN,"NHC")),"^")="Y":1,$P($G(^PS(55,DFN,40)),"^"):1,1:0)
 S DATE=$$HLDATE^HLFNC(FDT) D NOW^%DTC S NOW=$$HLDATE^HLFNC(%,"TS")
 S OLAN=$$GET1^DIQ(55,IDGN_",",106.1,"I"),OTLAN="N" I OLAN=1 S OTLAN="Y"
 S CSUB1=$$GET1^DIQ(50,IDGN_",",3),CSUB="N" I $E(CSUB1,1)>1&($E(CSUB1,1)<6) S CSUB="Y"
 S SCTALK=+$G(^PS(55,"ASTALK",$P(^PSRX(IRXN,0),"^",2)))
 K DIC,DR,DIQ S DA=$P($$SITE^VASITE(),"^") I DA D
 .K PSOINST S DIC=4,DIQ(0)="I",DR=99,DIQ="PSOINST" D EN^DIQ1
 .S PSOINST=PSOINST(4,DA,99,"I") K DIC,DA,DR,DIQ,PSOINST(4)
 S DRUG=$$ZZ^PSOSUTL(IRXN),DEA=$P(^PSDRUG(IDGN,0),"^",3),WARN=$P($G(^(0)),"^",8)
 S PSND1=$P($G(^PSDRUG(IDGN,"ND")),"^"),PSND2=$P($G(^("ND")),"^",2),PSND3=$P($G(^("ND")),"^",3)
 K PSOXN,PSOXN2,PSOPROD
 I PSND1,PSND3 D
 .S PSOPROD=$$PROD2^PSNAPIS(PSND1,PSND3),VANAME=$P($G(PSOPROD),"^",1)
 .I $T(^PSNAPIS)]"" S PSOXN=$$DFSU^PSNAPIS(PSND1,PSND3),UNIT=$P($G(PSOXN),"^",6) S PSOXN=$P($G(PSOXN),"^",5) S PSOXN2=$$PROD2^PSNAPIS(PSND1,PSND3) Q
 .S PSOXN2=$G(^PSNDF(PSND1,5,PSND3,2))
 .S PRODUCT=$G(^PSNDF(PSND1,5,PSND3,0))
 .I $G(PRODUCT)'="" S PSOXN=+$P($G(^PSNDF(PSND1,2,+$P(PRODUCT,"^",2),3,+$P(PRODUCT,"^",3),4,+$P(PRODUCT,"^",4),0)),"^"),UNIT=$P($G(^PS(50.607,PSOXN,0)),"^")
 S NFLD=0,UU="" F  S UU=$O(^PSRX(IRXN,1,UU)) Q:UU=""  S:$D(^PSRX(IRXN,1,UU,0)) NFLD=NFLD+1
 S NRFL=$P(^PSRX(IRXN,0),"^",9),RFRM=(NRFL-NFLD)
 Q
PID(PSI) ;patient ID segment
 Q:'$D(DFN)!$D(PAS)
 S HLFS=HL1("FS"),HLECH=HL1("ECH"),HLQ=HL1("Q"),HLVER=HL1("VER")
 K PSPID,PSPID1
 D BLDPID^VAFCQRY(DFN,"","3,5,7,8,11,13",.PSPID,.HL1,.ERR)
 ; put PID in format needed for segment parser
 S PSPID=PSPID(1) K PSPID(1)
 S (X,Y)=1 F  S X=+$O(PSPID(X)) Q:'X  S PSPID(Y)=PSPID(X),Y=Y+1 K PSPID(X)
 ;parse PID into individual fields
 K PRSEPID D SEGPRSE^SCMSVUT5("PSPID","PRSEPID",HL1("FS"))
 ; parse address into individual components
 K ADDSEQ D SEQPRSE^SCMSVUT5($NA(PRSEPID(11)),"ADDSEQ",HL1("ECH"))
 ; build ZTA (Temporary Address)
 K X2 S X2=$$EN^VAFHLZTA(DFN,"1,2,3,4,5,6,7,",1)
 ; parse X2 (ZTA) into individual fields if temp add. exists
 I $P(X2,HLFS,3) D
 . K PRSEZTA D SEGPRSE^SCMSVUT5("X2","PRSEZTA",HL1("FS"))
 . ; parse temporary address into individual components
 . K TMPADD D SEQPRSE^SCMSVUT5($NA(PRSEZTA(5)),"TMPADD",HL1("ECH"))
 . ; add temporary address as next repitition in PID segment
 . S SPOT=1+$O(ADDSEQ(""),-1)
 . M ADDSEQ(SPOT)=TMPADD(1)
 . S ADDSEQ(SPOT,7)="C"
 . S ADDSEQ(SPOT,9)=PRSEZTA(6)
 . S ADDSEQ(SPOT,12,1)=PRSEZTA(3)
 . S ADDSEQ(SPOT,12,2)=PRSEZTA(4)
 . ;move address sequence back into parse PID segment
 . K PRSEPID(11) M PRSEPID(11)=ADDSEQ
 ; rebuild PID segment
 K PSPID1 D MAKEIT^VAFHLU("PID",.PRSEPID,.PSPID1,.PSPID1)
 ;put rebuilt PID into format used by $$EN^VAFCQRY
 K PSPID S PSPID(1)=PSPID1
 S X=0,Y=2 F  S X=+$O(PSPID1(X)) Q:'X  S PSPID(Y)=PSPID1(X) S Y=Y+1
 S CNT=0 F I=1:1 Q:'$D(PSPID(I))  D
 . I I=1 S ^TMP("PSO",$J,PSI)=PSPID(I) Q
 . S CNT=CNT+1 S ^TMP("PSO",$J,PSI,CNT)=PSPID(I)
 S PSI=PSI+1
 S PAS=1
 K PSPID,PSPID1,PRSEPID,PRSEZTA,SPOT,TMPADD,ADDSEQ
 Q
PV1(PSI) ;patient visit segment
 N PV1  ;hardcoded to letter O for Outpatient (Patient class)
 S PV1="PV1"_FS_FS_"O"_FS
 S ^TMP("PSO",$J,PSI)=PV1
 S PSI=PSI+1
 Q
PV2(PSI) ;patient visit segment (additional information)
 ;PATIENT STATUS AND COPAY
 N PV2 S PV1=""
 S $P(PV2,"|",24)=$P($G(^PS(53,+$P($G(^PSRX(IRXN,0)),"^",3),0)),"^",2)_"~"_COPAY_FS
 S ^TMP("PSO",$J,PSI)="PV2|"_PV2
 S PSI=PSI+1
 Q
ORC(PSI) ;common order segment
 Q:'$D(DFN)
 N ORC S ORC=""
 S $P(ORC,"|",1)="OE"
 S $P(ORC,"|",2)=IRXN_CS_"OP7.0"
 S $P(ORC,"|",9)=ISDT
 S $P(ORC,"|",10)=EBY_CS_EBY1
 S $P(ORC,"|",12)=PVDR_CS_PVDR1
 S $P(ORC,"|",13)=$G(PSOLAP)
 S $P(ORC,"|",15)=EFDT
 S $P(ORC,"|",16)=$S($G(RXPR(IRXN)):"PARTIAL",$G(RXFL(IRXN)):"REFILL",$G(RXRP(IRXN)):"REPRINT",1:"NEW")
 S $P(ORC,"|",17)=CLN_CS_CLN1_CS_"99PSC"
 S $P(ORC,"|",19)=$S(CSINER'="":CSINER_CS_CSINER1,1:"")
 S $P(ORC,"|",21)=$P(SITE,"^",1)_CS_CS_$P(SITE,"^",6)_
 S PSZIP=$P(SITE,"^",5) S PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 S $P(ORC,"|",22)=$P(SITE,"^",2)_CS_CS_$P(SITE,"^",7)_CS_$S($D(^DIC(5,+$P(SITE,"^",8),0)):$P(^(0),"^",2),1:"UKN")_CS_PSOHZIP
 S $P(ORC,"|",23)="("_$P(SITE,"^",3)_")"_$P(SITE,"^",4)
 S ^TMP("PSO",$J,PSI)="ORC|"_ORC,PSI=PSI+1
 Q
RXE(PSI) ;Pharmacy/treatment Encoded Order segment
 Q:'$D(DFN)
 N RXE S RXE=""
 S $P(RXE,"|",1)=""""""
 S $P(RXE,"|",2)=$S($P($G(^PSDRUG(IDGN,"ND")),"^",10)'="":$P(^("ND"),"^",10),($G(PSND1)&$G(PSND3)):$P($G(PSOXN2),"^",2),1:"""""")_CS_$G(PSND2)_CS_"99PSNDF"_CS_PSND1_"."_PSND3_"."_$G(IDGN)_CS_$P($G(^PSDRUG(IDGN,0)),"^")_CS_"99PSD"
 S $P(RXE,"|",3)=""
 I $G(PSOXN)="" S PSOXN=""""""
 S $P(RXE,"|",5)=PSOXN_CS_$S($G(UNIT)'="":$G(UNIT),1:"""""")_CS_"99PSU"
 S POIPTR=$P($G(^PSRX(IRXN,"OR1")),"^") I POIPTR S PODOSE=$P($G(^PS(50.7,POIPTR,0)),"^",2),PODOSENM=$G(^PS(50.606,PODOSE,0))
 I '$G(POIPTR) S PODOSE=$P($G(^PS(50.7,$P($G(^PSDRUG(IDGN,2)),"^"),0)),"^",2),PODOSENM=$G(^PS(50.606,PODOSE,0))
 S TRADENM=$G(^PSRX(IRXN,"TN"))
 S $P(RXE,"|",6)=PODOSE_CS_PODOSENM_CS_"99PSF"
 S $P(RXE,"|",8)=MP
 S $P(RXE,"|",9)=TRADENM_
 S $P(RXE,"|",15)=$P(^PSRX(IRXN,0),"^")
 S ^TMP("PSO",$J,PSI)="RXE|"_RXE,PSI=PSI+1
 Q
RXD(PSI) ;pharmacy dispense segment
 Q:'$D(DFN)
 N RXD S RXD=""
 S $P(RXD,"|",1)=$S($G(NFLD):NFLD,1:0)
 S $P(RXD,"|",2)=CS_$G(VANAME)
 S $P(RXD,"|",3)=DISPDT
 S $P(RXD,"|",7)=$P(^PSRX(IRXN,0),"^")
 S $P(RXD,"|",9)=RELDT_RS_BINGO_RS_PSONDC
 Q
