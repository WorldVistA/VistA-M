ECXQSR1 ;ALB/JAP,BIR/PTD-DSS QUASAR Extract ;10/14/10  18:04
 ;;3.0;DSS EXTRACTS;**105,120,127,132,136**;Dec 22, 1997;Build 28
FILE ;file record in #727.825
 ;node0
 ;inst^dfn ECXDFN^ssn ECXSSN^name ECXPNM^i/o status ECXA^day ECDAY^
 ;DSS unit ECDU^^category ECPTTM^procedure ECP^volume ECV^cost center^
 ;ordering sec ^section^provider ECXPRV1^ECXPPC1^ECXPRV2^ECXPPC2^ECXPRV3^
 ;ECXPPC3^mov # ECXMN^treat spec ECXTS^time ECTIME^primary care team 
 ;ECPTTM^primary care provider ECPTPR^pce cpt code & modifers ECXCPT^
 ;primary icd-9 code ECDIA^secondary icd-9 #1 ECXICD91^secondary icd-9 
 ;#2 ECXICD92^secondary icd-9 #3 ECXICD93^secondary icd-9 #4 ECXICD94^
 ;agent orange ECXAST^radiation exposure ECRST^environmental
 ;contaminants ECEST^service connected ECSC^sent to pce^^dss identifier
 ;ECDSS^placeholder
 ;node1
 ;mpi ECXNPI^dss dept ECXDSSD^^^^placeholder 
 ;^assoc pc provider ECASPR^assoc pc prov person class 
 ;ECCLAS2^placeholder^divison ECXDIV^dom ECXDOM^
 ;enrollment category ECXCAT^enrollment status ECXSTAT^enrollment prior 
 ;ECXPRIOR^period of service ECXPOS^purple heart ECXPHI^observ pat ind 
 ;ECXOBS^encounter num ECXENC^ao loc ECXAOL^ord div ECXODIV^contr st dt 
 ;ECXCSDT^contr end dt ECXCEDT^contr typ ECXCTYP^CNH stat ECXCNH^
 ;production division ECXPDIV^eligibility ECXELIG^ethnicity ECXETH^
 ;race1 ECXRC1^enrollment location ECXENRL^^enrollment priority 
 ;ECXPRIOR_enrollment subgroup ECXSBGRP^user enrollee ECXUESTA^patient 
 ;type ECXPTYPE^combat vet elig ECXCVE^combat vet elig end date ECXCVEDT^
 ;enc cv eligible ECXCVENC^national patient record flag ECXNPRFI^
 ;emergency response indicator(FEMA) ECXERI^agent orange indicator 
 ;ECXAO^environ contam ECXECE^head/neck ECXHNC^military sexual trauma 
 ;ECXMIL^radiation encoun ECXIR^nutrition dx(currently null)^OEF/OIF ECXOEF^
 ;OEF/OIF return date ECXOEFDT^assoc pc provider npi ECASNPI^
 ;primary care provider npi ECPTNPI^provider npi ECPR1NPI^
 ;provider #2 npi ECPR2NPI^provider #3 npi ECPR3NPI^shad status ECXSHADI^
 ;shad encouter ECXSHAD^pat cat ECXPATCAT^provider #4 ECXPRV4^
 ;provider #4 pc ECXPPC4^provider #4 npi ECPR4NPI^provider #5 ECXPRV5^
 ;provider #5 pc ECXPPC5^provider #5 npi ECPR5NPI^
 ;primary ICD-10 code (currently null) ECXICD10P^Secondary ICD-10 Code #1 (currently null) ECXICD101^
 ;Secondary ICD-10 Code #2 (currently null) ECXICD102^Secondary ICD-10 Code #3 (currently null) ECXICD103^
 ;Secondary ICD-10 Code #4 (currently null) ECXICD104 
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA,ECXTSC
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTSC=$G(ECXDATA(7))
 ;done
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U
 S ECODE=ECODE_ECL_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U_ECDAY_U_ECDU_U_U
 S ECODE=ECODE_ECP_U_ECV_U_ECCS_U_ECO_U_ECM_U_ECXPRV1_U_ECXPPC1_U
 S ECODE=ECODE_ECXPRV2_U_ECXPPC2_U_ECXPRV3_U_ECXPPC3_U_U
 S ECODE=ECODE_ECXMN_U_ECXTSC_U_ECTIME_U_ECPTTM_U
 S ECODE=ECODE_ECPTPR_U_ECXCPT_U_ECDIA_U_ECXICD91_U_ECXICD92_U
 S ECODE=ECODE_ECXICD93_U_ECXICD94_U_ECXAST_U_ECXRST_U_ECXEST_U
 S ECODE=ECODE_ECSC_U_"N"_U_U_ECDSS_U_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_U_U_U_ECCLAS_U_U_ECASPR_U
 S ECODE1=ECODE1_ECCLAS2_U_U_ECXDIV_U_ECXMST_U_ECXDOM_U
 S ECODE1=ECODE1_ECXDOB_U_ECXCAT_U_ECXSTAT_U_$S(ECXLOGIC<2005:ECXPRIOR,1:"")_U_ECXPOS_U_ECXPHI_U
 S ECODE1=ECODE1_ECXOBS_U_ECXENC_U_ECXAOL_U_ECXODIV_U_ECXCSDT_U_ECXCEDT_U
 S ECODE1=ECODE1_ECXCTYP_U_ECXCNH_U_ECXPDIV_U_ECXELIG_U_ECXHNCI_U_ECXETH_U
 S ECODE1=ECODE1_ECXRC1
 I ECXLOGIC>2003 S ECODE1=ECODE1_U_ECXENRL
 I ECXLOGIC>2004 S ECODE1=ECODE1_U_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U_ECXPTYPE_U_ECXCVE_U
 I ECXLOGIC>2004 S ECODE2=ECXCVEDT_U_ECXCVENC_U_ECXNPRFI
 I ECXLOGIC>2006 S ECODE2=ECODE2_U_ECXERI_U_ECXAO_U_ECXECE_U_ECXHNC_U_ECXMIL_U_ECXIR_U
 I ECXLOGIC>2007 S ECODE2=ECODE2_U_$G(ECXOEF)_U_$G(ECXOEFDT)_U_$G(ECASNPI)_U_$G(ECPTNPI)_U_$G(ECPR1NPI)_U_$G(ECPR2NPI)_U_$G(ECPR3NPI)
 I ECXLOGIC>2010 S ECODE2=ECODE2_U_$G(ECXSHADI)_U_$G(ECXSHAD)_U_ECXPATCAT
 I ECXLOGIC>2011 S ECODE2=ECODE2_U_$G(ECXPRV4)_U_$G(ECXPPC4)_U_$G(ECPR4NPI)_U_$G(ECXPRV5)_U_$G(ECXPPC5)_U_$G(ECPR5NPI)
 I ECXLOGIC>2012 S ECODE2=ECODE2_U_ECXICD10P_U_ECXICD101_U_ECXICD102_U_ECXICD103_U
 I ECXLOGIC>2012 S ECODE3=ECXICD104
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,^ECX(ECFILE,EC7,2)=$G(ECODE2),^ECX(ECFILE,EC7,3)=$G(ECODE3),ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD
 Q
SETUP ;Set required input for ECXTRAC
 S ECHEAD="ECQ"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
QUE ;Entry point for the background requeuing handled by ECXTAUTO.
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
