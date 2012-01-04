ECXSURG1 ;ALB/JA,BIR/DMA,PTD-Surgery Extract for DSS ;10/14/10  18:10
 ;;3.0;DSS EXTRACTS;**105,112,120,127,132**;Dec 22, 1997;Build 18
 ;
FILE ;file record
 ;node0
 ;division^dfn^ssn^name^in/out (ECXA)^day^case #^
 ;surg specialty^or room #^
 ;surgeon^attending^anesthesia supervisor^anesthesia technique^
 ;primary/secondary/prostheses^cpt^^pt time^op time^anes time^
 ;prostheses^qty^^
 ;movement number^treating specialty^cancel/abort (ECCAN)^time^or type^
 ;attending's service^non-or dss id^recovery room time^^
 ;primary care team^primary care provider^admission date
 ;node1
 ;mpi^dss dept ECXDSSD^surgeon npi^attending npi^anes supervisor npi^
 ;pc provider npi^pc prov person class^
 ;assoc pc provider^assoc pc prov person class^assoc pc prov npi^
 ;cpt&modifiers ECXCPT^dom ECXDOM^enrollment category ECXCAT^
 ;enrollment status ECXSTAT^enrollment priority ECXPRIOR^
 ;period of service ECXPOS^purple heart indicator ECXPHI^
 ;observ pat ind ECXOBS^encounter num ECXENC^ao loc ECXAOL^
 ;production division ECXPDIV^head & neck canc ind ECXHNCI^
 ;ethnicity ECXETH^race1 ECXRC1^new quantity ECXQ^
 ;^user enrollee ECXUESTA^patient type ECXPTYPE^combat vet elig
 ;ECXCVE^combat vet elig end date ECXCVEDT^enc cv eligible ECXCVENC
 ;or clean time ECXORCT^time pt in hold area ECXPTHA^national patient
 ;record flag ECXNPRFI^princ anesthetist ECXPA^surgeon per class ECSRPC
 ;node2
 ;atten surgeon per class ECATPC^anesthesia super person class ECSAPC^
 ;princ anesthetist PC ECXPAPC^emergency response indicator(FEMA) ECXERI^
 ;agent orange indic ECXAO^head/neck cancer ECXHNC
 ;OEF/OIF ECXOEF^OEF/OIF return date ECXOEFDT^clinic pointer ECXCLIN
 ;credit stop ECXCRST^stop code ECXSTCD^princ postop diagnosis code
 ;ECXPODX^other postop diagnosis code #1 ECXPODX1^other postop
 ;diagnosis code #2 ECXPODX2^ other postop diag code #3 ECXPODX3^
 ;other postop diag code #4 ECXPODX4^other postop diag code #5
 ;ECXPODX5^anesthesia sup npi ECSANPI^assoc pc prov npi ECASNPI^
 ;attending surgeon npi ECATNPI^primary care provider npi ECPTNPI^
 ;principle anesthetist npi ECPANPI^surgeon npi ECSRNPI
 ;encounter ec ECENEC^radiation encounter indicator ECENRI^
 ;mst encounter indicator ECENMST^encounter sc ECENSC^
 ;agent orange status ECXAST^
 ;environmental contaminants ECXEST^radiation status ECXRST^
 ;mst status ECXMST^shad indicator ECXSHADI^encounter shad ECXSHAD^
 ;1st assist EC1A^1st assist pc EC1APC^1st assist npi EC1ANPI^
 ;2nd assist EC2A^2nd assist pc EC2APC^2nd assist npi EC2ANPI^
 ;perfusionist ECPQ^perfusionist pc ECPQPC^perfusionist npi ECQANPI^
 ;anesthesia severity ECASA^patcat PATCAT^date of birth ECXDOB
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA,ECXTSC
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTSC=$G(ECXDATA(7))
 ;done
 N DA,DIK,STR
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
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
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,^ECX(ECFILE,EC7,2)=ECODE2,^ECX(ECFILE,EC7,3)=ECODE3,ECRN=ECRN+1
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
