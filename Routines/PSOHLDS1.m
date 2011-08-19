PSOHLDS1 ;BIR/LC,PWC-Build HL7 Segments for Automated Interface ; 7/25/08 1:28pm
 ;;7.0;OUTPATIENT PHARMACY;**156,232,255,200,305,336**;DEC 1997;Build 1
 ;HLFNC       supp. by DBIA 10106
 ;PSNAPIS     supp. by DBIA 2531
 ;VASITE      supp. by DBIA 10112
 ;VADPT       supp. by DBIA 10061
 ;EN^DIQ1     supp. by DBIA 100
 ;EN^VAFHLZTA supp. by DBIA 758
 ;PSDRUG      supp. by DBIA 221
 ;PS(50.607   supp. by DBIA 2221
 ;PS(55       supp. by DBIA 2228
 ;DPT         supp. by DBIA 3097
 ;SC          supp. by DBIA 10040
 ;VA(200      supp. by DBIA 10060
 ;SCMSVUT5    supp. by DBIA 4347
 ;BLDPID^VAFCQRY supp. by DBIA 3630
 ;MAKEIT^VAFHLU  supp. by DBIA 4346
 ;
 ;*232 allow for Do Not Mail
 ;*255 move NTEPMI to PSOHLDS4.  fix "MP" node test to '=""
 ;*305 send  Notice of Privacy Practices in NTE9 - Modified to NTE9 as NTE8 already exist
 ;
START ;
 D GETDATA
 D PID(.PSI),PV1(.PSI),PV2(.PSI),IAM^PSOHLDS4(.PSI),ORC^PSOHLDS4(.PSI)
 D NTE^PSOHLDS2,RXE^PSOHLDS2(.PSI),RXD^PSOHLDS2(.PSI)
 D NTEPMI^PSOHLDS4(.PSI),NTE9^PSOHLDS2(.PSI),RXR^PSOHLDS2(.PSI)                ;*255
 ; clean up data set by GETDATA
 K EBY,EBY1,EFDT,EXDT,FDT,PVDR,PVDR1,CSINER,CSINER1,SITE,SITADD,SITPHN
 K VPHARMID,VPHARM,DEAID,MW,QTY,DASPLY,OLAN,OTHLAN,PRIORDT,RFRM,NFLD,WARN
 K PSOXN,PSOXN2,PSND1,PSND2,PRODUCT,PSOPROD,UNIT,VANAME,DISPDT,PSONDC
 K DRUG
 Q
GETDATA ; this is the place to set all data needed for several segments
 I $G(FP)="F"&('$G(FPN)) D    ;original
 . S FDT=$P(^PSRX(IRXN,2),"^",2),VPHARMID=$P(^(2),"^",10),DISPDT=$P(^(2),"^",5),EXDT=$P(^(2),"^",6),PSONDC=$P(^(2),"^",7)
 . S PVDR=$P(^PSRX(IRXN,0),"^",4),QTY=$P(^(0),"^",7),DASPLY=$P(^(0),"^",8),MW=$P(^(0),"^",11),EBY=$P(^(0),"^",16)
 I $G(FP)="F"&($G(FPN)) D    ;refill
 . S FDT=$P(^PSRX(IRXN,1,FPN,0),"^"),MW=$P(^(0),"^",2),QTY=$P(^(0),"^",4),DASPLY=$P(^(0),"^",10),DISPDT=$P(^(0),"^",19),EXDT=$S($P(^(0),"^",15):$P(^(0),"^",15),1:$P(^PSRX(IRXN,2),"^",6))
 . S VPHARMID=$S($P(^PSRX(IRXN,1,FPN,0),"^",5)'="":$P(^(0),"^",5),1:$P(^PSRX(IRXN,2),"^",10))
 . S EBY=$S($P(^PSRX(IRXN,1,FPN,0),"^",5):$P(^(0),"^",5),1:$P(^(0),"^",7)),PVDR=$P(^(0),"^",17),PSONDC=$S($P($G(^PSRX(IRXN,1,FPN,1)),"^",3):$P(^(1),"^",3),1:$P(^PSRX(IRXN,2),"^",7))
 I $G(FP)="P"&($G(FPN)) D  ;partial
 . S FDT=$P(^PSRX(IRXN,"P",FPN,0),"^"),MW=$P(^(0),"^",2),QTY=$P(^(0),"^",4),DASPLY=$P(^(0),"^",10),DISPDT=$P(^(0),"^",13),PVDR=$P(^(0),"^",17),EXDT=$P(^PSRX(IRXN,2),"^",6)
 . S EBY=$S($P(^PSRX(IRXN,"P",FPN,0),"^",5):$P(^(0),"^",5),1:$P(^(0),"^",7)),VPHARMID=$S($P(^(0),"^",5)'="":$P(^(0),"^",5),1:$P(^PSRX(IRXN,2),"^",10)),PVDR=$P(^PSRX(IRXN,"P",FPN,0),"^",17)
 . S PSONDC=$S($P(^PSRX(IRXN,"P",FPN,0),"^",12):$P(^(0),"^",12),1:$P(^PSRX(IRXN,2),"^",7))
 S EFDT=$P(^PSRX(IRXN,2),"^",2) S:$G(EFDT) EFDT=$$HLDATE^HLFNC(EFDT,"DT")
 S ISDT=$P(^PSRX(IRXN,0),"^",13) S:$G(ISDT) ISDT=$$HLDATE^HLFNC(ISDT,"DT")
 S DEAID=$$GET1^DIQ(200,PVDR_",",53.2)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=VPHARMID D ^DIC
 S VPHARM=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)),1:"""""") K DIC,X,Y
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=EBY D ^DIC
 S EBY1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)),1:"""""") K DIC,X,Y
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=PVDR D ^DIC
 S PVDR1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)),1:"""""") K DIC,X,Y
 S PRIORDT=$P(^PSRX(IRXN,3),"^",4),PRIORDT=$$HLDATE^HLFNC(PRIORDT,"DT")
 S FDT=$$HLDATE^HLFNC(FDT,"DT")
 S:$G(DISPDT) DISPDT=$$HLDATE^HLFNC(DISPDT,"DT")
 S:$G(EXDT) EXDT=$$HLDATE^HLFNC(EXDT,"DT")
 S FIN=$P(^PSRX(IRXN,"OR1"),"^",5)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=FIN D ^DIC
 S FIN1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)),1:"""""") K DIC,X,Y
 S SITE=$S($D(^PS(59,PSOSITE,0)):^(0),1:"")
 S PSZIP=$P(SITE,"^",5) S PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 S CLN=+$P(^PSRX(IRXN,0),"^",5),CLN1=$S($D(^SC(CLN,0)):$P(^(0),"^",1),1:"UNKNOWN")
 S CSINER=$P(^PSRX(IRXN,3),"^",3)
 K DIC,X,Y S DIC="^VA(200,",DIC(0)="N,Z",X=CSINER D ^DIC
 S CSINER1=$S(+Y:$$HLNAME^HLFNC($P(Y,"^",2)),1:"""""") K DIC,X,Y
 D 6^VADPT
 S X=$S($D(^PS(55,DFN,0)):^(0),1:""),CAP=$P(X,"^",2)
 D MW(X,.MW,.MP)                                              ;PSO*232
 I (($P(^PSRX(IRXN,"STA"),"^")>0)&($P(^("STA"),"^")'=2)&('$G(PSODBQ)))!'$G(^PSRX(IRXN,"IB")) S COPAY="NO COPAY"
 E  S COPAY="COPAY"
 S NURSE=$S($P($G(^DPT(DFN,"NHC")),"^")="Y":1,$P($G(^PS(55,DFN,40)),"^"):1,1:0)
 S DATE=$$HLDATE^HLFNC(FDT) D NOW^%DTC S NOW=$$HLDATE^HLFNC(%,"TS")
 S OLAN=$P($G(^PS(55,DFN,"LAN")),"^",2),OTLAN="N" I OLAN=2 S OTLAN="Y"
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
 D:'$$CHKTEMP^PSOBAI(DFN)
 . N BADA S BADA=$$CHKRX^PSOBAI(IRXN)
 . I $P(BADA,"^"),'$P(BADA,"^",2),ADDSEQ(1,7)'["VAB" S BADA=$$GET1^DIQ(2,DFN_",",.121,"I") S:BADA ADDSEQ(1,7)="VAB"_BADA
 D:$$CHKTEMP^PSOBAI(DFN)
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
 ; rebuild PID segment
 K PRSEPID(11) M PRSEPID(11)=ADDSEQ
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
 Q:'$D(DFN)!$D(PAS1)
 N PV1  ;hardcoded to letter O for Outpatient (Patient class)
 S PV1="PV1"_FS_FS_"O"_FS
 S ^TMP("PSO",$J,PSI)=PV1
 S PSI=PSI+1,PAS1=1
 Q
PV2(PSI) ;patient visit segment (additional information)
 ;PATIENT STATUS AND COPAY
 Q:'$D(DFN)!$D(PAS2)
 N PV2 S PV2=""
 S $P(PV2,"|",24)=$P($G(^PS(53,+$P($G(^PSRX(IRXN,0)),"^",3),0)),"^",2)_"~"_COPAY_FS
 S ^TMP("PSO",$J,PSI)="PV2|"_PV2
 S PSI=PSI+1,PAS2=1
 Q
 ;
MW(PS55,MW,MP) ;Return Mail/Window and MP expanded text               ;PSO*232
 I MW="W"!(MW="") D                   ;*255
 . S MP=$S($P($G(^PSRX(IRXN,"MP")),"^")'="":$P(^("MP"),"^"),1:"""""")
 . S MW="WINDOW"
 I MW="M" D
 . S MP=""""""
 . S PS55=$P(PS55,"^",3)
 . S MW=$S(PS55=1:"CERTIFIED MAIL",PS55=2:"DO NOT MAIL",1:"REGULAR MAIL")
 Q
