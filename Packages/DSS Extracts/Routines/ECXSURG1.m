ECXSURG1 ;ALB/JA,BIR/DMA,PTD-Surgery Extract for DSS ;4/24/18  15:36
 ;;3.0;DSS EXTRACTS;**105,112,120,127,132,144,149,161,166,170,184**;Dec 22, 1997;Build 124
 ;
FILE ;file record
 ;node0
 ;division^dfn^ssn^name^in/out (ECXA)^day^case #^
 ;surg specialty^or room #^
 ;surgeon^attending^anesthesia supervisor^anesthesia technique^
 ;primary/secondary/prostheses^placeholder^^pt time^op time^anes time^
 ;prostheses^qty^^
 ;movement number^treating specialty^cancel/abort (ECCAN)^time^or type^
 ;attending's service^non-or dss id^recovery room time^^
 ;Placehold primary care team^Placehold primary care provider^admission date
 ;node1
 ;mpi^placeholder ECXDSSD^surgeon npi^attending npi^anes supervisor npi^
 ;pc provider npi^Placehold pc prov person class^
 ;Placehold assoc pc provider^Placehold assoc pc prov person class^assoc pc prov npi^
 ;cpt&modifiers ECXCPT^dom ECXDOM^enrollment category ECXCAT^
 ;enrollment status ECXSTAT^enrollment priority ECXPRIOR^
 ;period of service ECXPOS^purple heart indicator ECXPHI^
 ;observ pat ind ECXOBS^encounter num ECXENC^ao loc ECXAOL^
 ;production division ECXPDIV^head & neck canc ind ECXHNCI^
 ;Placehold ethnicity ECXETH^Placehold race1 ECXRC1^new quantity ECXQ^
 ;^user enrollee ECXUESTA^patient type ECXPTYPE^combat vet elig
 ;ECXCVE^combat vet elig end date ECXCVEDT^enc cv eligible ECXCVENC
 ;or clean time ECXORCT^time pt in hold area ECXPTHA^national patient
 ;record flag ECXNPRFI^princ anesthetist ECXPA^surgeon per class ECSRPC
 ;node2
 ;atten surgeon per class ECATPC^anesthesia super person class ECSAPC^
 ;princ anesthetist PC ECXPAPC^emergency response indicator(FEMA) ECXERI^
 ;agent orange indic ECXAO^head/neck cancer ECXHNC
 ;OEF/OIF ECXOEF^OEF/OIF return date ECXOEFDT^clinic pointer ECXCLIN
 ;credit stop ECXCRST^stop code ECXSTCD^Placeholder ECXPODX^
 ;Placeholder ECXPODX1^Placeholder ECXPODX2^Placeholder ECXPODX3^
 ;Placeholder ECXPODX4^Placeholder ECXPODX5^
 ;anesthesia sup npi ECSANPI^Placehold assoc pc prov npi ECASNPI^
 ;attending surgeon npi ECATNPI^Placehold primary care provider npi ECPTNPI^
 ;principle anesthetist npi ECPANPI^surgeon npi ECSRNPI
 ;encounter ec ECENEC^radiation encounter indicator ECENRI^
 ;mst encounter indicator ECENMST^encounter sc ECENSC^
 ;agent orange status ECXAST^
 ;environmental contaminants ECXEST^radiation status ECXRST^
 ;mst status ECXMST^shad indicator ECXSHADI^encounter shad ECXSHAD^
 ;NODE3
 ;1st assist EC1A^1st assist pc EC1APC^1st assist npi EC1ANPI^
 ;2nd assist EC2A^2nd assist pc EC2APC^2nd assist npi EC2ANPI^
 ;perfusionist ECPQ^perfusionist pc ECPQPC^perfusionist npi ECQANPI^
 ;anesthesia severity ECASA^patcat PATCAT^date of birth ECXDOB
 ;Vietnam Status ECXVNS^Camp Lejeune Status ECXCLST^Encounter Camp Lejeune ECXECL^
 ;Concurrent Case ECXCONC^Principle post op icd-10 ECICD10^post op icd-10 code #1 ECICD101^post op icd-10 code #2 ECICD102^
 ;post op icd-10 code #3 ECICD103^post op icd-10 code #4 ECICD104^post op icd-10 code #5 ECICD105^
 ;Combat Service Indicator (ECXSVCI)^Combat Service Location (ECXSVCL)^
 ;NODE 4
 ;medical specialty of non-OR provider (ECXNONMS)^transplant organ 1 (ECXORG1)^trans org 2 (ECXORG2)^trans org 3 (ECXORG3)^
 ;Patient Division (ECXSTANO)  ;166
 ;convert specialty to PTF Code for transmission
 ;NODE 5 ;184
 ;Placehold CERNER (ECXCERN)^
 ;NODE 6 ;184
 ;New MPI (ECXNMPI)^Self Identified Gender (ECXSIG)
 ;
 N ECXDATA,ECXTSC
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTSC=$G(ECXDATA(7))
 ;done
 N DA,DIK,STR
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 I ECXLOGIC>2018 S (ECXETH,ECXRC1,ECPTTM,ECPTPR,ECCLAS,ECASPR,ECCLAS2,ECASNPI,ECPTNPI)="" ;170 Fields will now be null
 I ECXLOGIC>2022 S ECXMPI="" ;184 field retired
 S ECODE=EC7_U_EC23_U_ECXDIV_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECXDATE,ECXYM)_U_ECD0_U_ECSS_U_ECO_U
 S ECODE=ECODE_ECSR_U_ECAT_U_ECSA_U_ECANE_U_ECODE0_U
 S STR=ECXMN_U_ECXTSC_U_$S(ECCAN'="":ECCAN,1:"")_U_ECXTM_U_ECORTY_U
 S STR=STR_ECATSV_U_ECNL_U_ECRR_U_U_ECPTTM_U_ECPTPR_U_ECXADD_U
 S $P(ECODE,U,26,38)=STR
 S ECODE1=ECXMPI_U_ECXDSSD_U_U_U_U_U
 S ECODE1=ECODE1_ECCLAS_U_ECASPR_U_ECCLAS2_U_U_ECXCPT_U_ECXDOM_U
 S ECODE1=ECODE1_ECXCAT_U_ECXSTAT_U_$S(ECXLOGIC<2005:ECXPRIOR,1:"")_U_ECXPOS_U_ECXPHI_U
 S ECODE1=ECODE1_ECXOBS_U_ECXENC_U_ECXAOL_U_ECXPDIV_U_ECXHNCI_U
 S ECODE1=ECODE1_ECXETH_U_ECXRC1_U_ECXQ_U
 I ECXLOGIC>2004 S ECODE1=ECODE1_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U_ECXPTYPE_U_ECXCVE_U_ECXCVEDT_U_ECXCVENC_U_ECXORCT_U_ECXPTHA_U_ECXNPRFI
 I ECXLOGIC>2005 S ECODE1=ECODE1_U_ECXPA_U_ECSRPC_U,ECODE2=ECATPC_U_ECSAPC_U_ECXPAPC
 I ECXLOGIC>2006 S ECODE2=ECODE2_U_ECXERI_U_ECXAO_U_ECXHNC
 I ECXLOGIC>2007 S ECODE2=ECODE2_U_ECXOEF_U_ECXOEFDT_U_ECXCLIN_U_ECXCRST_U_ECXSTCD_U_ECXPODX_U_ECXPODX1_U_ECXPODX2_U_ECXPODX3_U_ECXPODX4_U_ECXPODX5_U_ECSANPI_U_ECASNPI_U_ECATNPI_U_ECPTNPI_U_ECPANPI_U_ECSRNPI
 I ECXLOGIC>2008 S ECODE2=ECODE2_U_$G(ECENEC)_U_$G(ECENRI)_U_$G(ECENMST)_U_$G(ECENSC)_U_$G(ECXAST)_U_$G(ECXEST)_U_$G(ECXRST)_U_$G(ECXMST)
 I ECXLOGIC>2010 S ECODE2=ECODE2_U_$G(ECXSHADI)_U_$G(ECXSHAD)_U,ECODE3=$G(EC1A)_U_$G(EC1APC)_U_$G(EC1ANPI)
 I ECXLOGIC>2010 S ECODE3=ECODE3_U_$G(EC2A)_U_$G(EC2APC)_U_(EC2ANPI)_U_$G(ECPQ)_U_$G(ECPQPC)_U_$G(ECPQNPI)_U_$G(ECQA)_U_$G(ECQAPC)_U_$G(ECQANPI)_U_$G(ECASA)_U_ECXPATCAT
 I ECXLOGIC>2011 S ECODE3=ECODE3_U_$G(ECXDOB)
 I ECXLOGIC>2013 S ECODE3=ECODE3_U_ECXVNS_U_ECXCLST_U_ECXECL ;144
 I ECXLOGIC>2013 S ECODE3=ECODE3_U_ECXCONC_U_ECICD10_U_ECICD101_U_ECICD102_U_ECICD103_U_ECICD104_U_ECICD105 ;144 Concurrent case ICD-10
 I ECXLOGIC>2014 S ECODE3=ECODE3_U_ECXSVCI_U_ECXSVCL ;149
 I ECXLOGIC>2017 S ECODE3=ECODE3_U,ECODE4=ECXNONMS_U_$G(ECXORG1)_U_$G(ECXORG2)_U_$G(ECXORG3)_U_$G(ECXSTANO)_U ;166,184 - Added "^"
 I ECXLOGIC>2022 S ECODE5=$G(ECXCERN)_U,ECODE6=ECXNMPI_U_ECXSIGI ;184
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,^ECX(ECFILE,EC7,2)=$G(ECODE2),^ECX(ECFILE,EC7,3)=$G(ECODE3),^ECX(ECFILE,EC7,4)=$G(ECODE4) ;166, 184 move Record count to below
 S ^ECX(ECFILE,EC7,5)=$G(ECODE5),^ECX(ECFILE,EC7,6)=$G(ECODE6) ;184
 S ECRN=ECRN+1 ;184 Moved from above
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 ;
TIME ; given date/time get increment
 ;A1=later, A2=earlier, TIME=difference
 N CON,TIMEDIF
 S CON=$P($G(^SRF(ECD0,"CON")),U)
 ;
 ;-Get time diff (in secs) & set to .5 if < 7.5 minutes (rounds to 1)
 S TIMEDIF=$$FMDIFF^XLFDT(A1,A2,2)/900
 S TIMEDIF=$S(TIMEDIF>0&(TIMEDIF<.5):.5,1:TIMEDIF)
 I 'CON D
 .S TIME=$J($TR($J(TIMEDIF,4,0)," "),2,1)
 .S:TIME>"99.0" TIME="99.0"
 I CON D
 .S TIME=$J(($TR($J(TIMEDIF,4,0)," ")/2),2,1)
 .S:TIME>"99.5" TIME="99.5"
 S:TIME<0 TIME="###"
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="SUR"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
