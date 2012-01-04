ECXBCM ;ALB/JAP-Bar Code Medical Administration Extract ;11/19/10  17:00
 ;;3.0;DSS EXTRACTS;**107,127,132**;Dec 22, 1997 ;Build 18
 ;
BEG ;entry point from option
 ;ECFILE=^ECX(727.833,
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 ; 
 S ECED=ECED+.3,ECD=ECSD1
 S PIEN=0
 I $G(ECSD)="" S ECSD=DT
 ; loop thru and get each new patient, reset the start date to ECSD - begin date from ECXTRAC
 F  S PIEN=$O(^PSB(53.79,"AADT",PIEN)) Q:('PIEN)  S IDAT=ECSD D
 .F  S IDAT=$O(^PSB(53.79,"AADT",PIEN,IDAT)) Q:'IDAT!(IDAT>ECED)  S RIEN="" D
 ..F  S RIEN=$O(^PSB(53.79,"AADT",PIEN,IDAT,RIEN)) Q:'RIEN  D
 ...S ECXNOD=^PSB(53.79,RIEN,0) Q:'ECXNOD  S ECXDFN=$P($G(ECXNOD),U) D GET
 Q
 ;
GET ;get extract data
 S (ACTDT,ECXADT,ECXAMED,ECXASTA,ECXATM,ECXORN,ECXORT,ECXOSC,ECPRO,PLACEHLD,ECXFAC,DRG)=""
 ; get needed YYYYDD variable
 I $G(ECXYM)="" S ECXYM=$$ECXYM^ECXUTL(DT)
 ;Get Facility
 I $G(ECXFAC)="" D
 .S ECXFAC=+$P(^ECX(728,1,0),U) K ECXDIC S DA=ECXFAC,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 .D EN^DIQ1 S ECXFAC=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 ;get patient demographics
 S ECXERR=0 D PAT(ECXDFN,IDAT,.ECXERR) Q:ECXERR
 ;
 S ECXORN=$$GET1^DIQ(53.79,RIEN,.11)
 ; Ordering Stop Code - based on Unit dose or IV
 I ECXA="O" D
 .I ECXORN["U" S ECXOSC=$$DOUDO^ECXUTL5(ECXDFN,+ECXORN)
 .I ECXORN["V" S ECXOSC=$$DOIVPO^ECXUTL5(ECXDFN,+ECXORN)
 S ECPRO=$$ORDPROV^ECXUTL(ECXDFN,ECXORN,"")
 S ACTDT=$$GET1^DIQ(53.79,RIEN,.06,"I")
 I ACTDT'=IDAT Q
 S ECXADT=$$ECXDATE^ECXUTL(ACTDT,ECXYM)
 S ECXATM=$$ECXTIME^ECXUTL(ACTDT)
 S ECXORT=$P($G(^TMP("PSJ",$J,1)),U,3) K ^TMP("PSJ",$J)
 S ECPROPC=$P($$GET^XUA4A72(ECPRO,$P(ACTDT,".")),U,7)
 N ECXUSRTN
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECPRO,$P(ACTDT,"."))
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECPRONPI=$P(ECXUSRTN,U)
 S ECXASTA=$$GET1^DIQ(53.79,RIEN,.09,"I")
 I "^G^S^C^"'[("^"_ECXASTA_"^") Q  ;process 'G'iven,'S'topped,'C'ompleted
 S ECXAMED=$$GET1^DIQ(53.79,RIEN,.08,"I")
 ;Component code data
 D CCODE(RIEN)
 Q
 ;
CMPT ; during component/sequence processing, retrieve rest of data record the file it. 
 S (ECXSCADT,ECPROPC,ECXOS,ECXIVID,ECXIR,SCADT,ECXSCADT,ECXSCATM,DRUG,ECVNDC,ECINV,ECVACL)=""
 I $G(DRG) D
 .S DRUG=$$PHAAPI^ECXUTL5(DRG)
 .S ECVNDC=$P(DRUG,U,3)
 .S ECINV=$P(DRUG,U,4) S ECINV=$S(ECINV["I":"I",1:"")
 .S ECVACL=$P(DRUG,U,2)
 S SCADT=$$GET1^DIQ(53.79,RIEN,.13,"I")
 S ECXSCADT=$$ECXDATE^ECXUTL(SCADT,ECXYM)
 S ECXSCATM=$$ECXTIME^ECXUTL(SCADT)
 S ECXOS=$$GET1^DIQ(53.79,RIEN,.12,"I")
 S ECXIVID=$$GET1^DIQ(53.79,RIEN,.26)
 S ECXIR=$$GET1^DIQ(53.79,RIEN,.35)
 S ECXDIV=$$RADDIV^ECXDEPT($$GET1^DIQ(53.79,RIEN,.03,"I"))
 S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADM,ACTDT,ECXTS,ECXOBS,ECHEAD,,)
 D:ECXENC'="" FILE
 Q
 ;
PAT(ECXDFN,ECXDATE,ECXERR)  ;get patient demographics, primary care, and inpatient data
 N X
 S (ECXCAT,ECXSTAT,ECXPRIOR,ECXSBGRP,ECXOEF,ECXOEFDT)=""
 ;get patient data
 K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,$P(ECXDATE,"."),"1;2;3;5",.ECXPAT)
 I 'OK K ECXPAT S ECXERR=1 Q
 S ECXPNM=ECXPAT("NAME")
 S ECXSSN=ECXPAT("SSN")
 S ECXMPI=ECXPAT("MPI")
 S ECXDOB=ECXPAT("DOB")
 S ECXELIG=ECXPAT("ELIG")
 S ECXSEX=ECXPAT("SEX")
 S ECXSTATE=ECXPAT("STATE")
 S ECXCNTY=ECXPAT("COUNTY")
 S ECXZIP=ECXPAT("ZIP")
 S ECXVET=ECXPAT("VET")
 S ECXCNTRY=ECXPAT("COUNTRY")
 S ECXPOS=ECXPAT("POS")
 S ECXPST=ECXPAT("POW STAT")
 S ECXPLOC=ECXPAT("POW LOC")
 S ECXRST=ECXPAT("IR STAT")
 S ECXAST=ECXPAT("AO STAT")
 S ECXAOL=ECXPAT("AOL")
 S ECXPHI=ECXPAT("PHI")
 S ECXMST=ECXPAT("MST STAT")
 S ECXENRL=ECXPAT("ENROLL LOC")
 S ECXMTST=ECXPAT("MEANS")
 S ECXEST=ECXPAT("EC STAT")
 S ECXCNHU=$$CNHSTAT^ECXUTL4(ECXDFN) S ECXCNHU=$S(ECXCNHU'="":$E(ECXCNHU,1),1:"") ;get CNHU status
 ;get enrollment data (category, status and priority)
 I $$ENROLLM^ECXUTL2(ECXDFN)
 S ECXHNCI=$$HNCI^ECXUTL4(ECXDFN)                  ; Head and Neck Cancer Indicator
 S ECXSHADI=$$SHAD^ECXUTL4(ECXDFN)                 ; PROJ 112/SHAD Indicator
 I ECXSHADI="U" S ECXSHADI=""                      ; If Shad comes back as "U" force to null
 S ECXETH=ECXPAT("ETHNIC"),ECXRC1=ECXPAT("RACE1")  ; Race and Ethnicity
 S ECXERI=ECXPAT("ERI")                            ; emergency response indicator (FEMA)
 S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)               ; PATCAT code / patch 127  
 S ECXOEF=ECXPAT("ECXOEF")
 S ECXOEFDT=ECXPAT("ECXOEFDT")
 ;
 ;get primary care data
 S X=$$PRIMARY^ECXUTL2(ECXDFN,$P(ECXDATE,"."))
 S ECPTTM=$P(X,U),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4)
 ;get inpatient data
 S (ECXA,ECXMN,ECXADM,ECXTS,ECXW)=""
 S X=$$INP^ECXUTL2(ECXDFN,ECXDATE)
 S ECXA=$P(X,U),ECXMN=$P(X,U,2),ECXTS=$P(X,U,3),ECXADM=$P(X,U,4)
 S W=$P(X,U,9),ECXDOM=$P(X,U,10),ECXW=$P(W,";")
 ;get national patient record flag, if it exists
 D NPRF^ECXUTL5     ; sets ECXNPRFI
 Q
 ;
CCODE(RIEN) ; get component information
 ;  input - IEN of the BCMA MEDICATION LOG File
 ; 
 ; output - CCIEN: pointer to a variable pointer field to file #50, #52.6, or #52.7
 ;          CCDORD: .02 field of file #50, #52.6, or #52.7
 ;          CCDGVN: .03 FIELD of file #50, #52.6, or #52.7
 ;          CCUNIT: .04 field of file #50, #52.6, or #52.7
 ;          CCTYPE: derived field, "D", "A", or "S"
 ;
 S (CCIEN,CCDORD,CCDGVN,CCUNIT,CCTYPE)=""
 F I=.5,.6,.7 D
 .I '$O(^PSB(53.79,RIEN,I,0)) Q
 .S J=0 F  S J=$O(^PSB(53.79,RIEN,I,J)) Q:'J  D
 ..S DATA=^PSB(53.79,RIEN,I,J,0)
 ..S CCIEN=$P(DATA,U),CCDORD=$P(DATA,U,2),CCDGVN=$P(DATA,U,3),CCUNIT=$P(DATA,U,4)
 ..I I=.5 S DRG=CCIEN
 ..I I=.6 S DRG=$$GET1^DIQ(52.6,CCIEN,1,"I")
 ..I I=.7 S DRG=$$GET1^DIQ(52.7,CCIEN,1,"I")
 ..S CCTYPE=$S(I=.5:"D",I=.6:"A",I=.7:"S",1:"")
 ..S CCIEN=$S(I=.5:CCIEN_";PSDRUG(",I=.6:CCIEN_";PS(52.6,",I=.7:CCIEN_";PS(52.7,",1:"")
 ..D CMPT
 Q
 ;
FILE ;file the extract record
 ;node0
 ;Sequence Number,Year Month, Extract Number (EC23)^facility (ECXFAC)^
 ;dfn (ECXDFN)^ssn (ECXSSN)^name (ECXPNM)^
 ;in/out (ECXA)^Day (ECXADT)^
 ;date of birth (ECDOB)^Gender (ECXSEX)^State (ECXSTATE)^County (ECXCNTY)^
 ;zip code (ECXZIP)^country (ECXCNTRY)^ward (ECXW)^treating speciality (ECXTS)^
 ;provider (ECPRO)^provider person class (ECPROPC)^provider npi (ECPRONPI)^
 ;primary care provider(ECPTPR)^pc provider person class (ECCLAS)^
 ;primary care provider NPI (ECPTNPI)^primary care team (ECPTTM)^ordering stop code (ECXOSC)^
 ;NODE(1)
 ;place order number (RIEN)^order reference number (ECXORN)^route (ECXORT)^
 ;^action time (ECXATM)^component code (CCIEN)^
 ;component dose ordered (CCDORD)^component dose given(CCDGVN)^
 ;component units (CCUNIT)^component type (CCTYPE)^Action Status (ECXASTA)^
 ;Administration Medication (ECXAMED)^Scheduled Administration Date (ECXSCADT)^
 ;Scheduled Administration Time (ECXSCATM)^
 ;NODE(2)
 ;Order Schedule (ECXOS)^IV Unique ID (ECXIVID)^
 ;Infusion Rate (ECXIR)^Production Division Code (ECXDIV)^Drug IEN (DRG)^NDC (ECVNDC)^
 ;Investigational (DEA Special Handling) (ECINV)^VA Drug Classification (ECVACL)^
 ;Master Patient Index (ECXMPI)^DOM, PRRTP and SAARTP Indicator (ECXDOM)^
 ;Observation Patient Indicator (ECXOBS)^Encounter Number (ECXENC)^Means Test (ECXMTST)^
 ;Eligibility (ECXELIG)^Enrollment Location (ECXENRL)^Enrollment Category (ECXCAT)^
 ;Enrollment Status (ECXSTAT)^Enrollment Priority (ECXPRIOR)_(ECXSBGRP)^
 ;NODE(3)
 ;User Enrollee (ECXUESTA)^
 ;NODE(4)
 ;Ethnicity(ECXETH)^Race 1(ECXRC1)^Veteran(ECXVET)^Period of Service(ECXPOS)^POW Status(ECXPST)^
 ;POW Location(ECXPLOC)^Radiation Status(ECXRST)^Agent Orange Status(ECXAST)^Agent Orange Location(ECXAOL)
 ;^Purple Heart Indicator(ECXPHI)^MST Status(ECXMST)^CNH/SH Status(ECXCNHU)^
 ;Head & Neck Cancer Indicator(ECXHNCI)^SHAD Status(ECXSHADI)^Patient Type(ECXPTYPE)^
 ;CV Status Eligibility(ECXCVE)^CV Eligibility End Date(ECXCVEDT)^Encounter CV(ECXCVENC)^
 ;National Patient Record Flag(ECXNPRFI)^ERI(ECXERI)^SW Asia Conditions(ECXEST)^
 ;OEF/OIF(ECXOEF)^OEF/OIF Return Date(ECXOEFDT)^PATCAT(ECXPATCAT)
 ;
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE(0)=EC7_U_EC23_U_ECXFAC_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U_ECXADT
 S ECODE(0)=ECODE(0)_U_ECXDOB_U_ECXSEX_U_ECXSTATE_U_ECXCNTY_U_ECXZIP_U_ECXCNTRY
 S ECODE(0)=ECODE(0)_U_ECXW_U_ECXTS_U_ECPRO_U_ECPROPC_U_ECPRONPI_U_ECPTPR_U_ECCLAS
 S ECODE(0)=ECODE(0)_U_ECPTNPI_U_ECPTTM_U_ECXOSC_U
 S ECODE(1)=RIEN_U_ECXORN_U_ECXORT_U_U_ECXATM_U_CCIEN_U_CCDORD_U_CCDGVN
 S ECODE(1)=ECODE(1)_U_CCUNIT_U_CCTYPE_U_ECXASTA_U_ECXAMED_U_ECXSCADT_U_ECXSCATM_U
 S ECODE(2)=ECXOS_U_ECXIVID_U_ECXIR_U_ECXDIV_U_DRG_U_ECVNDC_U_ECINV_U_ECVACL_U_ECXMPI_U_ECXDOM
 S ECODE(2)=ECODE(2)_U_$E(ECXOBS,1)_U_ECXENC_U_ECXMTST_U_ECXELIG_U_ECXENRL_U_ECXCAT_U_ECXSTAT_U_ECXPRIOR_ECXSBGRP_U
 S ECODE(3)=ECXUESTA_U
 S ECODE(4)=ECXETH_U_ECXRC1_U_ECXVET_U_ECXPOS_U_ECXPST_U_ECXPLOC_U_ECXRST_U_ECXAST_U_ECXAOL
 S ECODE(4)=ECODE(4)_U_ECXPHI_U_ECXMST_U_ECXCNHU_U_ECXHNCI_U_ECXSHADI_U_ECXPTYPE_U_ECXCVE
 S ECODE(4)=ECODE(4)_U_ECXCVEDT_U_ECXCVENC_U_ECXNPRFI_U_ECXERI_U_ECXEST_U_ECXOEF_U_ECXOEFDT_U_ECXPATCAT
 ;
 N DA,DIK,X S X=""
 F X=0:1:4 S ^ECX(ECFILE,EC7,X)=ECODE(X)
 S ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 Q
 ;
SETUP ;Set required input for ECXTRAC.
 S ECHEAD="BCM"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
