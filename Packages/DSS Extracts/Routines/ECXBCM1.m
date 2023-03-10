ECXBCM1 ;ALB/JAP-Bar Code Medical Administration Extract Cont. ;2/14/20  08:49
 ;;3.0;DSS EXTRACTS;**154,170,174,178,181,184**;Dec 22, 1997 ;Build 124
 ;
 ; Reference to ^XMD in ICR #10113
 ; Reference to ^XMB("NETNAME") in ICR #1131
 ; Reference to ^TMP($J) in SACC 2.3.2.5.1
 ; 
FILE ;file the extract record
 ;node0
 ;Sequence Number,Year Month, Extract Number (EC23)^facility (ECXFAC)^
 ;dfn (ECXDFN)^ssn (ECXSSN)^name (ECXPNM)^
 ;in/out (ECXA)^Day (ECXADT)^
 ;date of birth (ECDOB)^Gender (ECXSEX)^State (ECXSTATE)^County (ECXCNTY)^
 ;zip code (ECXZIP)^country (ECXCNTRY)^ward (ECXW)^treating specialty (ECXTSC)^
 ;provider (ECPRO)^provider person class (ECPROPC)^provider npi (ECPRONPI)^
 ;Placehold primary care provider(ECPTPR)^Placehold pc provider person class (ECCLAS)^
 ;Placehold primary care provider NPI (ECPTNPI)^Placehold primary care team (ECPTTM)^ordering stop code (ECXOSC)^
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
 ;Placehold Ethnicity(ECXETH)^Placehold Race 1(ECXRC1)^Veteran(ECXVET)^Period of Service(ECXPOS)^POW Status(ECXPST)^
 ;POW Location(ECXPLOC)^Radiation Status(ECXRST)^Agent Orange Status(ECXAST)^Agent Orange Location(ECXAOL)
 ;^Purple Heart Indicator(ECXPHI)^MST Status(ECXMST)^CNH/SH Status(ECXCNHU)^
 ;Head & Neck Cancer Indicator(ECXHNCI)^SHAD Status(ECXSHADI)
 ;NODE(3)
 ;Patient Type(ECXPTYPE)^
 ;CV Status Eligibility(ECXCVE)^CV Eligibility End Date(ECXCVEDT)^Encounter CV(ECXCVENC)^
 ;National Patient Record Flag(ECXNPRFI)^ERI(ECXERI)^SW Asia Conditions(ECXEST)^
 ;OEF/OIF(ECXOEF)^OEF/OIF Return Date(ECXOEFDT)^PATCAT(ECXPATCAT)
 ;Encounter SC (ECXESC)^IV Additives Cost ECXIVAC^IV Solutions Cost ECXIVSC^Drug cost ECXDRGC^Camp Lejeune Status (ECXCLST)^Encounter Camp Lejeune (ECXECL)
 ;Combat Service Indicator (ECXSVCI) ^ Combat Service Location (ECXSVCL)^ Vista DEA special hdlg (ECXDEA)^New MPI (ECXNMPI)^Feeder Key (ECXFDK)^Price Per Dispense Unit (ECXPPDU)^
 ;NODE(3) -Cont'd
 ;Self Identified Gender (ECXSIGI)
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA,ECXTSC
 ;N ECXNMPI ;184 new field
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTSC=$G(ECXDATA(7))
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 I ECXLOGIC>2018 S (ECXETH,ECXRC1,ECPTPR,ECCLAS,ECPTNPI,ECPTTM)="" ;170 Fields will now be null
 I ECXLOGIC>2020 S ECXMTST="" ;178 Means Test field will now be null
 ;I ECXLOGIC>2022 S ECXNMPI=ECXMPI,ECXMPI="" ;184 - field retired.
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
 I ECXLOGIC>2019 S ECODE(3)=ECODE(3)_U_ECXDEA ;174
 I ECXLOGIC>2022 S ECODE(3)=ECODE(3)_U_ECXNMPI_U_ECXFDK_U_ECXPPDU_U_ECXSIGI ;184
 ;
 N DA,DIK,X S X=""
 F X=0:1:3 S ^ECX(ECFILE,EC7,X)=ECODE(X)
 S ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 Q
 ;
SENDMSG ;181 - Called from ECXBCM
 N ECMSG,ECX,XMSUB,XMDUZ,XMY,XMTEXT
 ;Send missing stop  code message
 S ECX=$O(^TMP($J,"ECXBCMM","ECXNOSC",0))
 I ECX D
 .S XMSUB="CLINICS WITH MISSING STOP CODE in File #44",XMDUZ="DSS SYSTEM"
 .K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 .S ECMSG(1,0)="The DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN_" through"
 .S ECMSG(2,0)=ECEDN_" contains the following clinics which have not been assigned a stop"
 .S ECMSG(3,0)="code in the HOSPITAL LOCATION file (#44).  The DSS-"_ECPACK
 .S ECMSG(4,0)="extract records associated with these clinics have been given a default"
 .S ECMSG(5,0)="Stop Code of ""PHA""."
 .S ECMSG(6,0)=""
 .S ECMSG(7,0)="CLIN IEN  CLINIC NAME"
 .S ECMSG(8,0)="-----------------------------------------"
 .S ECMSG(9,0)=""
 .S ECX=0
 .F  S ECX=$O(^TMP($J,"ECXBCMM","ECXNOSC",ECX)) Q:ECX=""  S ECMSG(9+ECX,0)=^TMP($J,"ECXBCMM","ECXNOSC",ECX,0)
 .S XMTEXT="ECMSG(" D ^XMD
 ;Send Inactive Stop Code message
 S ECX=$O(^TMP($J,"ECXBCMM","ECXINVSC",0))
 I ECX D
 .S XMSUB="CLINICS WITH INACTIVE STOP CODE",XMDUZ="DSS SYSTEM"
 .K XMY S XMY("G.DSS-"_ECGRP_"@"_^XMB("NETNAME"))=""
 .S ECMSG(1,0)="The DSS-"_ECPACK_" extract (#"_$P(EC23,U,2)_") for "_ECSDN_" through"
 .S ECMSG(2,0)=ECEDN_" contains the following clinics which have been assigned an"
 .S ECMSG(3,0)="inactive stop code in the HOSPITAL LOCATION file (#44).  The DSS-"
 .S ECMSG(4,0)=ECPACK_" extract records associated with these clinics have been"
 .S ECMSG(5,0)="given a default Stop Code of ""PHA""."
 .S ECMSG(6,0)=""
 .S ECMSG(7,0)="CLINIC IEN/NAME                         STOP CODE NUMBER/NAME "
 .S ECMSG(8,0)="--------------------------------------------------------------------"
 .S ECMSG(9,0)=""
 .S ECX=0
 .F  S ECX=$O(^TMP($J,"ECXBCMM","ECXINVSC",ECX)) Q:ECX=""  S ECMSG(9+ECX,0)=^TMP($J,"ECXBCMM","ECXINVSC",ECX,0)
 .S XMTEXT="ECMSG(" D ^XMD
 K ^TMP($J,"ECXBCMM")
 Q
