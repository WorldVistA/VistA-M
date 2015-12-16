ECXBCM1 ;ALB/JAP-Bar Code Medical Administration Extract Cont. ;6/5/15  14:34
 ;;3.0;DSS EXTRACTS;**154**;Dec 22, 1997 ;Build 13
 ;
FILE ;file the extract record
 ;node0
 ;Sequence Number,Year Month, Extract Number (EC23)^facility (ECXFAC)^
 ;dfn (ECXDFN)^ssn (ECXSSN)^name (ECXPNM)^
 ;in/out (ECXA)^Day (ECXADT)^
 ;date of birth (ECDOB)^Gender (ECXSEX)^State (ECXSTATE)^County (ECXCNTY)^
 ;zip code (ECXZIP)^country (ECXCNTRY)^ward (ECXW)^treating speciality (ECXTSC)^
 ;provider (ECPRO)^provider person class (ECPROPC)^provider npi (ECPRONPI)^
 ;primary care provider(ECPTPR)^pc provider person class (ECCLAS)^
 ;primary care provider NPI (ECPTNPI)^primary care team (ECPTTM)^ordering stop code (ECXOSC)^
 ;NODE(1)
 ;place order number (RIEN)^order reference number (ECXORN)^route (ECXORT)^
 ;^action time (ECXATM)^component code (CCIEN)^
 ;component dose ordered (CCDORD)^component dose given(CCDGVN)^
 ;component units (CCUNIT)^component type (CCTYPE)^Action Status (ECXASTA)^
 ;Administration Medication (ECXAMED)^Scheduled Administration Date (ECXSCADT)^
 ;NODE(2)
 ;Scheduled Administration Time (ECXSCATM)^
 ;Order Schedule (ECXOS)^IV Unique ID (ECXIVID)^
 ;Infusion Rate (ECXIR)^Production Division Code (ECXDIV)^Drug IEN (ECXVAP)^NDC (ECVNDC)^ ;;143, changed Drug IEN var from DRG to ECXVAP
 ;Investigational (DEA Special Handling) (ECINV)^VA Drug Classification (ECVACL)^
 ;Master Patient Index (ECXMPI)^DOM, PRRTP and SAARTP Indicator (ECXDOM)^
 ;Observation Patient Indicator (ECXOBS)^Encounter Number (ECXENC)^Means Test (ECXMTST)^
 ;Eligibility (ECXELIG)^Enrollment Location (ECXENRL)^Enrollment Category (ECXCAT)^
 ;Enrollment Status (ECXSTAT)^Enrollment Priority (ECXPRIOR)_(ECXSBGRP)^
 ;User Enrollee (ECXUESTA)^
 ;Ethnicity(ECXETH)^Race 1(ECXRC1)^Veteran(ECXVET)^Period of Service(ECXPOS)^POW Status(ECXPST)^
 ;POW Location(ECXPLOC)^Radiation Status(ECXRST)^Agent Orange Status(ECXAST)^Agent Orange Location(ECXAOL)
 ;^Purple Heart Indicator(ECXPHI)^MST Status(ECXMST)^CNH/SH Status(ECXCNHU)^
 ;Head & Neck Cancer Indicator(ECXHNCI)^SHAD Status(ECXSHADI)
 ;NODE(3)
 ;Patient Type(ECXPTYPE)^
 ;CV Status Eligibility(ECXCVE)^CV Eligibility End Date(ECXCVEDT)^Encounter CV(ECXCVENC)^
 ;National Patient Record Flag(ECXNPRFI)^ERI(ECXERI)^SW Asia Conditions(ECXEST)^
 ;OEF/OIF(ECXOEF)^OEF/OIF Return Date(ECXOEFDT)^PATCAT(ECXPATCAT)
 ;Encounter SC (ECXESC)^IV Additives Cost ECXIVAC^IV Solutions Cost ECXIVSC^Drug cost ECXDRGC^Camp Lejeune Status (ECXCLST)^Encounter Camp Lejeune (ECXECL)
 ;Combat Service Indicator (ECXSVCI) ^ Combat Service Location (ECXSVCL)
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA,ECXTSC
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTSC=$G(ECXDATA(7))
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE(0)=EC7_U_EC23_U_ECXFAC_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U_ECXADT
 S ECODE(0)=ECODE(0)_U_ECXDOB_U_ECXSEX_U_ECXSTATE_U_ECXCNTY_U_ECXZIP_U_ECXCNTRY
 S ECODE(0)=ECODE(0)_U_ECXW_U_ECXTSC_U_2_ECPRO_U_ECPROPC_U_ECPRONPI_U_ECPTPR_U_ECCLAS
 S ECODE(0)=ECODE(0)_U_ECPTNPI_U_ECPTTM_U_ECXOSC_U
 S ECODE(1)=RIEN_U_ECXORN_U_ECXORT_U_ECXATM_U_CCIEN_U_CCDORD_U_CCDGVN
 S ECODE(1)=ECODE(1)_U_CCUNIT_U_CCTYPE_U_ECXASTA_U_ECXAMED_U_ECXSCADT_U
 S ECODE(2)=ECXSCATM_U_ECXOS_U_ECXIVID_U_ECXIR_U_ECXDIV_U_ECXVAP_U_ECVNDC_U_ECINV_U_ECVACL_U_ECXMPI_U_ECXDOM ;143 Changed DRUG IEN field from DRG to ECXVAP
 S ECODE(2)=ECODE(2)_U_$E(ECXOBS,1)_U_ECXENC_U_ECXMTST_U_ECXELIG_U_ECXENRL_U_ECXCAT_U_ECXSTAT_U_ECXPRIOR_ECXSBGRP
 S ECODE(2)=ECODE(2)_U_ECXUESTA_U_ECXETH_U_ECXRC1_U_ECXVET_U_ECXPOS_U_ECXPST_U_ECXPLOC
 S ECODE(2)=ECODE(2)_U_ECXRST_U_ECXAST_U_ECXAOL_U_ECXPHI_U_ECXMST_U_ECXCNHU_U_ECXHNCI_U_ECXSHADI_U
 S ECODE(3)=ECXPTYPE_U_ECXCVE_U_ECXCVEDT_U_ECXCVENC_U_ECXNPRFI_U_ECXERI_U_ECXEST_U_ECXOEF_U_ECXOEFDT
 S ECODE(3)=ECODE(3)_U_ECXPATCAT
 I ECXLOGIC>2013 S ECODE(3)=ECODE(3)_U_ECXESC_U_ECXIVAC_U_ECXIVSC_U_ECXDRGC_U_ECXCLST_U_ECXECL ;144
 I ECXLOGIC>2014 S ECODE(3)=ECODE(3)_U_ECXSVCI_U_ECXSVCL ;149
 ;
 N DA,DIK,X S X=""
 F X=0:1:3 S ^ECX(ECFILE,EC7,X)=ECODE(X)
 S ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 Q
 ;
