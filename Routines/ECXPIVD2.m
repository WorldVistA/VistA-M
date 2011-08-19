ECXPIVD2 ;ALB/JAP,BIR/DMA,CML,PTD-Extract from IV EXTRACT DATA File (#728.113) ;9/8/10  15:48
 ;;3.0;DSS EXTRACTS;**105,120,127**;Dec 22, 1997;Build 36
FILE ;file record
 ;node0
 ;fac^dfn^ssn^name^i/o^day^va class^qty^ward^cost^movement #^treat spec^ndc^investigational^iv dispensing fee^new feeder key^total doses^
 ;primary care team^primary care provider^ivp time^adm date^adm time^dss identifier
 ;node1
 ;mpi^dss dept^pc provider npi^pc prov person class^assoc pc provider^assoc pc prov person class^assoc pc prov npi^dom^obs pat ind^enc num^
 ;ord pr^ordering stop code^ord dt^req phys^nat prod division^means tst^elig^dob^sex^state^county^zip+4^vet^period of svc^pow stat^pow loc^ir stat^ao stat^
 ;ao loc^purple heart ind.^mst stat^enrollment loc^enrollment cat^enrollment stat^enrollment prior^cnh/sh stat^ord pr npi
 ;node2
 ;head & neck cancer ind.^ethnicity^race1^bcma drug dispensed^bcma dose given^bcma unit of administration^bcma ICU flag^
 ;ordering provider person class^^user enrollee ECXUESTA^patient type ECXPTYPE^combat vet elig ECXCVE^
 ;combat vet elig end date ECXCVEDT^enc cv eligible ECXCVENC^national patient record flag ECXNPRFI^emerg resp indic(FEMA) ECXERI^
 ;environ contamin ECXEST
 ;^oef/oif ECXOEF^ oef/oif return date ECXOEFDT^assoc pc prov npi ECASNPI
 ;^ordering provider npi ECXOPNPI^primary care provider npi ECPTNPI
 ;^country ECXCNTRY
 N DA,DIK
 S ECPLACE=""
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_ECXDIV_U_DFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECD,ECXYM)_U_ECVACL_U_ECXCNT_U_ECXW_U
 ;convert specialty to PTF Code for transmission
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTS=$G(ECXDATA(7))
 ;done
 S ECODE=ECODE_ECXCOST_U_ECXMN_U_ECXTS_U_ECNDC_U_ECINV_U_ECTYP_U_ECNFC_U
 S ECODE=ECODE_ECST_U_ECPTTM_U_ECPTPR_U_ECDTTM_U_$$ECXDATE^ECXUTL(ECXADM,ECXYM)_U_$$ECXTIME^ECXUTL(ECXADM)_U_ECXDSSI_U
 ;if outpat and not observ patient, admit date="" and admit time="000000"
 I ECXA="O",(ECXOBS="NO") S $P(ECODE,U,24)="",$P(ECODE,U,25)="000000"
 S ECODE1=ECXMPI_U_ECXDSSD_U_ECPLACE_U_ECCLAS_U_ECASPR_U_ECCLAS2_U_ECPLACE_U_ECXDOM_U_ECXOBS_U_ECXENC_U_ECXORDPR_U
 S ECODE1=ECODE1_ECXORDST_U_$$ECXDATE^ECXUTL(ECXORDDT,ECXYM)_U_ECXRPHY_U_ECXPDIV_U_ECXMTST_U_ECXELIG_U_ECXDOB_U
 S ECODE1=ECODE1_ECXSEX_U_ECXSTATE_U_ECXCNTY_U_ECXZIP_U_ECXVET_U_ECXPOS_U_ECXPST_U_ECXPLOC_U_ECXRST_U_ECXAST_U
 S ECODE1=ECODE1_ECXAOL_U_ECXPHI_U_ECXMST_U_ECXENRL_U_ECXCAT_U
 S ECODE1=ECODE1_ECXSTAT_U_$S(ECXLOGIC<2005:ECXPRIOR,ECXLOGIC>2010:ECXSHADI,1:"")_U_ECXCNHU_U_U
 S ECODE2=ECXHNCI_U_ECXETH_U_ECXRC1
 I ECXLOGIC>2003 D
 .S ECODE2=ECODE2_U_ECXBCDD_U_ECXBCDG_U_ECXBCUA_U_ECXBCIF_U_ECXOPPC
 I ECXLOGIC>2004 S ECODE2=ECODE2_U_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U_ECXPTYPE_U_ECXCVE_U_ECXCVEDT_U_ECXCVENC_U_ECXNPRFI
 I ECXLOGIC>2006 S ECODE2=ECODE2_U_ECXERI_U_ECXEST
 I ECXLOGIC>2007 S ECODE2=ECODE2_U_ECXOEF_U_ECXOEFDT_U_ECASNPI_U_ECXOPNPI_U_ECPTNPI
 I ECXLOGIC>2009 S ECODE2=ECODE2_U_ECXCNTRY
 I ECXLOGIC>2010 S ECODE2=ECODE2_U_ECXPATCAT
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1
 S ^ECX(ECFILE,EC7,2)=ECODE2,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
