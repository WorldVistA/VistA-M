ECXOPRX1 ;ALB/JAP,BIR/DMA,CML,PTD-Prescription Extract for DSS ;4/21/15  14:16
 ;;3.0;DSS EXTRACTS;**92,107,105,120,127,144,149,154**;Dec 22, 1997;Build 13
 ;
FILE ;file record
 ;node0
 ;inst^dfn^ssn^name^in/out ECXA^day^division^provider^drug category^mail^
 ;placeholder1^new^shad indicator^qty^cost^encounter shad^mov #^treat spec^placeholder4^unit of issue^dob^elig^vet^copay^
 ;feeder key^investigational^days supply^primary care team^primary care provider^time^race
 ;node1
 ;mpi^dss dept ECXDSSD^sex^zip+4^placeholder^placeholder^state^county^pc prov person class^pow status^pow location^
 ;ir status^ao status^sharing agree. payor^sharing agree. ins.^mst status^enroll loc^assoc pc provider^assoc pc prov person class^
 ;placeholder^dom ECXDOM^purple heart ECXPHI^enrollment category ECXCAT^enrollment status ECXSTST^
 ;enrollment priority ECXPRIOR^cnhu status ECXCNHU^period of service ECXPOS^observ pat ind ECXOBS^encounter num ECXENC^
 ;ao loc ECXAOL^ord physician ECXORDPH^ord stop code ECXORDST^ord date ECXORDDT^CNH status ECXCNH^national division ECXPDIV^
 ;MT Stat ECXMTST^head & neck cancer ind. ECXHNCI^ethnicity ECXETH^race ECXRC1^^enrollment priority ECXPRIOR_
 ;enrollment subgroup ECXSBGRP^user enrollee ECXUESTA
 ;NODE 2
 ;patient type ECXPTYPE^combat vet elig ECXCVE^combat vet elig end date ECXCVEDT^
 ;enc cv eligible ECXCVENC^national patient record flag ECXNPRFI^rx patient status ECRXPTST^non-va prescriber ECNONVAP^rx # ECRXNUM
 ;^emergency response indicator(FEMA) ECXERI^agent orange enc ECXAO^environ cont PGE ECXECE^head/neck ECXHNC^enc mst ECXMIL^environ contamin ECXEST^ion radiat ECXIR
 ;^OEF/OIF data ECXOEF^OEFOIF return date ECXOEFDT^associate pc provider npi ECASNPI^primary care provider npi ECPTNPI^provider npi ECPRVNPI
 ;^country ECXCNTRY^PATCAT^Encounter SC ECXESC^Vietnam ECXVNS^Camp Lejeune Status ECXCLST^Encounter Camp Lejeune ECXECL ^Combat Service Ind ECXSVCI ^Combat Service Loc ECXSVCL^Choice RX ECXCHOCE
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_ECINST_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECXDATE,ECXYM)_U_ECXDIV_U
 S ECODE=ECODE_ECXPROV_U_ECCAT_U_ECMW_U_ECXPROVP_U_ECXNEW_U_$S(ECXLOGIC>2010:ECXSHADI,1:"")_U_ECQTY_U
 ;convert specialty to PTF Code for transmission
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTS=$G(ECXDATA(7))
 ;done
 S ECODE=ECODE_ECXCOST_U_$S(ECXLOGIC>2010:ECXSHAD,1:"")_U_ECXMN_U_ECXTS_U_U_ECUI_U_ECXDOB_U
 S ECODE=ECODE_ECXELIG_U_ECXVET_U_ECOPAY_U_ECNFC_U_ECINV_U_ECDS_U
 S ECODE=ECODE_ECPTTM_U_ECPTPR_U_$$ECXTIME^ECXUTL(ECXDATE)_U_ECXRACE_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_ECXSEX_U_ECXZIP_U_ECXPROVN_U_U
 S ECODE1=ECODE1_ECXSTATE_U_ECXCNTY_U_ECCLAS_U_ECXPST_U_ECXPLOC_U
 S ECODE1=ECODE1_ECXRST_U_ECXAST_U_U_U_ECXMST_U_ECXENRL_U
 S ECODE1=ECODE1_ECASPR_U_ECCLAS2_U_U_ECXDOM_U_ECXPHI_U_ECXCAT_U
 S ECODE1=ECODE1_ECXSTAT_U_$S(ECXLOGIC<2005:ECXPRIOR,1:"")_U_ECXCNHU_U_ECXPOS_U_ECXOBS_U
 S ECODE1=ECODE1_ECXENC_U_ECXAOL_U_ECXORDPH_U_ECXORDST_U_ECXORDDT_U
 S ECODE1=ECODE1_ECXCNH_U_ECXPDIV_U_ECXMTST_U_ECXHNCI_U_ECXETH_U
 S ECODE1=ECODE1_ECXRC1_U
 I ECXLOGIC>2004 S ECODE1=ECODE1_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U
 I ECXLOGIC>2004 S ECODE2=ECXPTYPE_U_ECXCVE_U_ECXCVEDT_U_ECXCVENC_U_ECXNPRFI_U_ECRXPTST_U_ECNONVAP
 I ECXLOGIC>2005 S ECODE2=ECODE2_U_ECRXNUM
 I ECXLOGIC>2006 S ECODE2=ECODE2_U_ECXERI_U_ECXAO_U_ECXECE_U_ECXHNC_U_ECXMIL_U_ECXEST_U_ECXIR_U_ECXSCRX
 I ECXLOGIC>2007 S ECODE2=ECODE2_U_ECXOEF_U_ECXOEFDT_U_ECASNPI_U_ECPTNPI_U_ECPRVNPI
 I ECXLOGIC>2009 S ECODE2=ECODE2_U_ECXCNTRY
 I ECXLOGIC>2010 S ECODE2=ECODE2_U_ECXPATCAT
 I ECXLOGIC>2013 S ECODE2=ECODE2_U_ECXESC_U_ECXVNS_U_ECXCLST_U_ECXECL ;144
 I ECXLOGIC>2014 S ECODE2=ECODE2_U_ECXSVCI_U_ECXSVCL ;149
 I ECXLOGIC>2015 S ECODE2=ECODE2_U_ECXCHOCE ;154
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,^ECX(ECFILE,EC7,2)=$G(ECODE2),ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
