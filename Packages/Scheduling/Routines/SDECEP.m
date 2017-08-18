SDECEP ;SPFO/DMR SCHEDULING ENHANCEMENTS VSE EP API
 ;;5.3;Scheduling;**669**;Aug 13 1993;Build 16
 ;
 ;The API provides Extended Profile Appt info the VS Gui.
 ;INPUT - DFN required
 ;        APP appointment date/time required
 Q
 ;
CLASS(RTT,DFN,APT) ;
 Q:'$G(DFN)
 Q:'$G(APT)
 S U="^"
 ;
 ; Each Clasification set to Not Applicable
 ; 1 Agent Orange Exposure: Not Applicable
 ; 2 Ionizing Radiation Exposure: Not Applicable
 ; 3 Treatment for SC Condition: Not Applicable
 ; 4 SW Asia Conditions: Not Applicable
 ; 5 Military Sexual Trauma: Not Applicable
 ; 6 Head and/or Neck Cancer: Not Applicable
 ; 7 Combat Vet (Combat Related): Not Applicable
 ;
 S NA="Not Applicable"
 S RTT=NA_U_NA_U_NA_U_NA_U_NA_U_NA_U_NA_U_NA
 ;
 S (ENCN,CC,CL)=""
 ;
 S ENCN=$P($G(^DPT(DFN,"S",APT,0)),"^",20)
 I ENCN'="" D CLOE^SDCO21(ENCN,.RR)
 F CC=1:1:8 S CL=$G(RR(CC)) D
 .I $P($G(CL),"^",2)=1 S $P(RTT,"^",CC)="YES"
 .I $P($G(CL),"^",2)=0 S $P(RTT,"^",CC)="NO"
 K ENCN,CC,CL
 Q
 ;
DIAGN(REN,DFN,APP) ;
 Q:'$G(DFN)
 Q:'$G(APP)
 ;
 S (ENUM,CNT,CNT1,CC,NAME,REN)=""
 S ENUM=$P($G(^DPT(DFN,"S",APP,0)),"^",20)
 I ENUM'="" D SET^SDCO4(ENUM)
 Q:SDCNT=""
 F CC=1:1:SDCNT S ICDN=$P($G(SDDXY(CC)),"^",2) D
 .Q:ICDN=""
 .S NAME="" S NAME=$$GET1^DIQ(80,ICDN,.01)
 .S CNT="" S CNT=$P($G(^ICD9(ICDN,67,0)),"^",3)
 .S CNT1="" S CNT1=$P(^ICD9(ICDN,67,CNT,0),"^",2)
 .S REN=REN_NAME_" "_CNT1_"^"
 .Q
 K ENUM,CNT,CNT1,CC,NAME
 Q
PROV(RET,DFN,APPT) ;
 Q:'$G(DFN)
 Q:'$G(APPT)
 ;
 S EN="" S EN=$P($G(^DPT(DFN,"S",APPT,0)),"^",20)
 Q:EN=""
 ;
 S (CC,NAME,NAM,RET)=""
 ;
 K PLIST
 D GETPRV^SDOE(EN,"PLIST")
 Q:PLIST=""
 F  S CC=$O(PLIST(CC)) Q:CC=""  D
 .S NAM="" S NAM=$P(PLIST(CC),"^",1)
 .S NAME="" S NAME=$$GET1^DIQ(200,NAM,.01)
 .I NAME'="" S RET=RET_NAME_"^"
 .Q
 K CC,NAME,NAM
 Q
 ;
CPT(REC,DFN,APP) ;
 Q:'$G(APP)
 Q:'$G(DFN)
 ;
 S ENN="" S ENN=$P($G(^DPT(DFN,"S",APP,0)),"^",20)
 Q:ENN=""
 S (CNT,CC,CCC,CPT,PNAR,PNARN,QTY,CPTM,REC)=""
 ;
 K CPTL
 D GETCPT^SDOE(ENN,"CPTL")
 S CC="" F  S CC=$O(CPTL(CC)) Q:CC=""  D
 .S CPT="" S CPT=$P($G(CPTL(CC,0)),"^",1)
 .S QTY="" S QTY=$P($G(CPTL(CC,0)),"^",16)
 .S PNARN="" S PNARN=$P($G(CPTL(CC,0)),"^",4)
 .I PNARN'="" S PNAR="" S PNAR=$$GET1^DIQ(9999999.27,PNARN,.01)
 .S REC=REC_"^"_CPT_" "_QTY_" "_PNAR
 .I $D(CPTL(CC,1,0)) D
 ..S (CNN,CMM,CCC)="" S CCC=$P($G(CPTL(CC,1,0)),"^",4)
 ..F CNT=1:1:CCC S CNN=$P($G(CPTL(CC,1,CNT,0)),"^",1) D
 ...I CNN>0 D
 ....S CPTMN="" S CPTMN=$$GET1^DIQ(81.3,CNN,.02)
 ....S CMM="" S CMM=$$GET1^DIQ(81.3,CNN,.01)
 ...S CPTM=CPTM_":"_CMM_":"_CPTMN
 ...S REC=REC_CPTM
 ...Q
 K ENN,CNT,CC,CCC,CPT,PNAR,PNARN,QTY,CPTM
 Q
 ;
SCODE(RTU,DFN,APP) ;
 Q:'$G(DFN)
 Q:'$G(APP)
 ;
 S ENU="" S ENU=$P($G(^DPT(DFN,"S",APP,0)),"^",20)
 Q:ENU=""
 S (SNAM,SNUM,SNAM1,SNUM1,LOC,LNUM,AMIS,AMIS1,RTU)=""
 ;
 S LNUM="" S LNUM=$P($G(^SCE(ENU,0)),"^",4)
 Q:LNUM=""
 S (SNAM,SNUM)="" S SNAM=$$GET1^DIQ(44,LNUM,8,"E") S SNUM=$$GET1^DIQ(44,LNUM,8,"I")
 I SNUM'="" S AMIS="" S AMIS=$$GET1^DIQ(40.7,SNUM,1)
 S (SNAM1,SNUM1)="" S SNAM1=$$GET1^DIQ(44,LNUM,2503,"E") S SNUM1=$$GET1^DIQ(44,LNUM,2503,"I")
 I SNUM1'="" S AMIS1="" S AMIS1=$$GET1^DIQ(40.7,SNUM1,1)
 S RTU=AMIS_" "_SNAM_"^"_AMIS1_" "_SNAM1_"^"
 K SNAM,SNUM,SNAM1,SNUM1,LOC,LNUM,AMIS,AMIS1
 Q
 ;
INP(REN,DFN) ;
 Q:'$G(DFN)
 ;
 S (ADMDT,DISDT,DNUM,LSTAT,SDST,SDSTA,REN)=""
 I '$D(^DGPM("C",DFN)) S LSTAT="NO INPT./LOD. ACT." Q
 ;
 S VAIP("D")="L",VAIP("L")="" D INP^DGPMV10
 S A=$S("^3^5^"[("^"_+DGPMVI(2)_"^"):0,1:+DGPMVI(2)),SDST=$S('A:"IN",1:"")_"ACTIVE ",SDSTA=$S("^4^5^"[("^"_+DGPMVI(2)_"^"):"LODGER",1:"INPATIENT")
 S LSTAT="" S LSTAT=SDST_" "_SDSTA
 S ADMDT="" S ADMDT=$P($G(DGPMVI(13,1)),"^",2)
 S DNUM="" S DNUM=$G(DGPMV1(17)) I DNUM'="" D
 .S DISDT="" S DISDT=$$GET1^DIQ(405,DNUM,.01)
 S REN=LSTAT_"^"_ADMDT_"^"_DISDT
 K ADMDT,DISDT,DNUM,LSTAT,SDST,SDSTA
 Q
APPT(RET,DFN1,APP1) ;
 Q:'$G(DFN1)
 Q:'$G(APP1)
 S RET=$P($G(^DPT(DFN1,"S",APP1,0)),"^",2)
 Q
