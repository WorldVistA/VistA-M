ECXEC ;ALB/JAP,BIR/JLP,PTD-DSS Event Capture Extract  ; 10/2/07 2:33pm
 ;;3.0;DSS EXTRACTS;**11,8,13,24,27,33,39,46,49,71,89,92,105,120,127,132,136**;Dec 22, 1997;Build 28
BEG ;entry point from option
 I '$D(^ECH) W !,"Event Capture is not initialized",!! Q
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
START ;begin EC extract
 N X,Y,ECDCM,ECXNPRFI
 N ECXICD10P,ECXICD101,ECXICD102,ECXICD103,ECXICD104
 S ECED=ECED+.3,ECLL=0
 K ^TMP("EC",$J)
 F  S ECLL=$O(^ECH("AC1",ECLL)),ECD=ECSD-.1 Q:'ECLL  D
 .F  S ECD=$O(^ECH("AC1",ECLL,ECD)),ECDA=0 Q:(ECD>ECED)!('ECD)  D
 ..F  S ECDA=$O(^ECH("AC1",ECLL,ECD,ECDA)) Q:'ECDA  D UPDATE
 Q
 ;
UPDATE ;sets record and updates counters
 S ECCH=^ECH(ECDA,0),ECL=$P(ECCH,U,4),ECXDFN=$P(ECCH,U,2)
 S ECXPDIV=$$RADDIV^ECXDEPT(ECL)  ;Get production division from file 4
 S ECDT=$P(ECCH,U,3),ECM=$P(ECCH,U,6),ECC=$P(ECCH,U,8)
 Q:'$$PATDEM^ECXUTL2(ECXDFN,ECDT,"1;3;5;")
 S ECTM=$$ECXTIME^ECXUTL(ECDT),ECP=$P(ECCH,U,9)
 Q:ECP']""
 S ECO=$P(ECCH,U,12),ECV=$P(ECCH,U,10),ECDU=$P(ECCH,U,7)
 S ECXUNIT=$G(^ECD(ECDU,0)),ECCS=+$P(ECXUNIT,U,4),ECDCM=$P(ECXUNIT,U,5)
 S ECXDSSP="",ECXDSSD=$E(ECDCM,1,10),ECUSTOP=$P(ECXUNIT,U,10),ECUPCE=$P(ECXUNIT,U,14)
 S ICD9=$P($G(^ECH(ECDA,"P")),U,2) S:ICD9="" ICD9=" "
 S ECXICD9=$P($G(^ICD9(ICD9,0)),U),ECXICD10P=""
 F I=1:1:4 S @("ECXICD9"_I)=""
 F I=1:1:4 S @("ECXICD10"_I)=""
 S (CNT,I)=0
 F  S CNT=$O(^ECH(ECDA,"DX",CNT)) Q:'CNT  D  Q:I>3
 .S ICD9=$P($G(^ECH(ECDA,"DX",CNT,0)),U) D:ICD9'=""
 ..S I=I+1,@("ECXICD9"_I)=$P($G(^ICD9(ICD9,0)),U)
 ;derivation of dss identifier depends on whether dss unit is 
 ;set to send data to pce
 S ECAC=$P($G(ECCH),U,19)
 ;if this is a record that 'goes to pce', then get the dss identifier
 ;from the clinic stop codes
 S (ECAC1S,ECAC2S)="000"
 I ECUPCE="A"!(ECUPCE="O"&(ECXA="O")) D
 .D:+ECAC
 ..S ECAC1=$P($G(^SC(+ECAC,0)),U,7),ECAC2=$P($G(^(0)),U,18)
 ..I 'ECAC2 S ECAC2S="000"
 ..I 'ECAC1 S (ECAC1S,ECAC2S)="000" Q
 ..S ECAC1S=$P($G(^DIC(40.7,+ECAC1,0)),U,2)
 ..S ECAC2S=$P($G(^DIC(40.7,+ECAC2,0)),U,2)
 ..S ECAC1S=$$RJ^XLFSTR(ECAC1S,3,0),ECAC2S=$$RJ^XLFSTR(ECAC2S,3,0)
 .S:'ECAC (ECAC1S,ECAC2S)="000"
 ;if this record doesn't go to pce, then get the dss identifier
 ;from the dss unit
 I ECUPCE=""!(ECUPCE="N")!(ECUPCE="O"&(ECXA="I")) D
 .I +ECUSTOP D
 ..S ECAC1S=$P($G(^DIC(40.7,+ECUSTOP,0)),U,2)
 ..S ECAC1S=$$RJ^XLFSTR(ECAC1S,3,0),ECAC2S="000"
 .I 'ECUSTOP D
 ..S (ECAC1S,ECAC2S)="000"
 S ECDSS=ECAC1S_ECAC2S
 I ECXLOGIC>2003 I "^18^23^24^41^65^94^108^"[("^"_ECXTS_"^") S ECDSS=$$TSMAP^ECXUTL4(ECXTS)
 S ECXDIV=""
 ;
 ;- Ord Div, Contrct St/End Dates, Contrct Type placeholders for FY2002
 S (ECXODIV,ECXCSDT,ECXCEDT,ECXCTYP)=""
 ;setup provider(s) as'2'_ien
 S (ECU1A,ECU2A,ECU3A,ECU1NPI,ECU2NPI,ECU3NPI,ECXPPC1,ECXPPC2,ECXPPC3)=""
 S (ECU1,ECU2,ECU3,ECU4,ECU5,ECU4A,ECU5A,ECU4NPI,ECU5NPI,ECXPPC4,ECXPPC5)=""
 K ECXPRV S ECXPROV=$$GETPRV^ECPRVMUT(ECDA,.ECXPRV) I ECXPROV Q
 F I=1:1:5 S Y=$O(ECXPRV("")) I Y'="" S @("ECU"_I)=+ECXPRV(Y) K ECXPRV(Y)
 S:$L(ECU1) ECXPPC1=$$PRVCLASS^ECXUTL(ECU1,ECDT),ECU1A="2"_$P(ECU1,";")
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECU1,ECDT)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECU1NPI=$P(ECXUSRTN,U)
 S:$L(ECU2) ECXPPC2=$$PRVCLASS^ECXUTL(ECU2,ECDT),ECU2A="2"_$P(ECU2,";")
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECU2,ECDT)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECU2NPI=$P(ECXUSRTN,U)
 S:$L(ECU3) ECXPPC3=$$PRVCLASS^ECXUTL(ECU3,ECDT),ECU3A="2"_$P(ECU3,";")
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECU3,ECDT)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECU3NPI=$P(ECXUSRTN,U)
 S:$L(ECU4) ECXPPC4=$$PRVCLASS^ECXUTL(ECU4,ECDT),ECU4A="2"_$P(ECU4,";")
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECU4,ECDT)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECU4NPI=$P(ECXUSRTN,U)
 S:$L(ECU5) ECXPPC5=$$PRVCLASS^ECXUTL(ECU5,ECDT),ECU5A="2"_$P(ECU5,";")
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECU5,ECDT)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECU5NPI=$P(ECXUSRTN,U)
 ;change for version 2 where ECP is a variable pointer and we want to
 ;expand it category = category or null if stored as 0
 D:ECP[";"
 .S ECP=$S(ECP["ICPT":$P(^ICPT(+ECP,0),U)_"01",ECP<90000:$P(^EC(725,+ECP,0),U,2)_"N",1:$P(^EC(725,+ECP,0),U,2)_"L"),ECC=$S(ECC:ECC,1:"")
 ;pick up EC to PCE data from "P" in File 721
 S ECPCE=$G(^ECH(ECDA,"P")),ECPCE1=$P(ECPCE,U),ECPCE2=$P(ECPCE,U,2)
 S ECPCE7=$S($P(ECPCE,U,7)=1:"Y",1:"N")
 S ECXCMOD=""
 I $D(^ECH(ECDA,"MOD")) D
 .S MOD=0,M=""
 .F  S MOD=$O(^ECH(ECDA,"MOD",MOD)) Q:'MOD  S M=$P(^(MOD,0),U) D
 ..I M S ECXCMOD=ECXCMOD_M_";"
 .K MOD,M
 S:ECP?1.N ECP=$$CPT^ECXUTL3($E(ECP,1,5),"",ECV)
 S ECXCPT=$$CPT^ECXUTL3(ECPCE1,ECXCMOD,ECV)
 ;
 ;- Observation Patient Indicator (YES/NO)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECDSS)
 ;
 ;- CNH status (YES/NO)
 S ECXCNH=$$CNHSTAT^ECXUTL4(ECXDFN)
 ;
 ;- encounter classification
 S (ECXAO,ECXECE,ECXHNC,ECXMIL,ECXIR,ECXSHAD)="",ECXVISIT=$P(ECCH,U,21)
 I ECXVISIT'="" D
 .D VISIT^ECXSCX1(ECXDFN,ECXVISIT,.ECXVIST,.ECXERR) I ECXERR K ECXERR Q
 .S ECXAO=$G(ECXVIST("AO")),ECXECE=$G(ECXVIST("PGE")),ECXSHAD=$G(ECXVIST("SHAD"))
 .S ECXHNC=$G(ECXVIST("HNC")),ECXMIL=$G(ECXVIST("MST")),ECXIR=$G(ECXVIST("IR"))
 ; - Head and Neck Cancer Indicator
 S ECXHNCI=$$HNCI^ECXUTL4(ECXDFN)
 ; - PROJ 112/SHAD Indicator
 S ECXSHADI=$$SHAD^ECXUTL4(ECXDFN)
 ; ******* - PATCH 127, ADD PATCAT CODE 
 S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ;
 ; - Get national patient record flag Indicator if exist
 D NPRF^ECXUTL5
 ;
 ; - If no encounter number don't file record
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECDT,ECXTS,ECXOBS,ECHEAD,ECDSS,ECCS)
 D:ECXENC'="" FILE
 Q
 ;
FILE ;file record in #727.815
 ;node0
 ;ecode=inst ECL^dfn ECXDFN^ssn ECXSSN^name ECXPNM^i/o status ECXA^day^
 ;DSS unit ECDU^category ECC^procedure ECP^volume ECV^
 ;cost center ECCS^ordering sec ECO^section ECM^
 ;provider ECU1A^prov per cls ECXPPC1^prov 2 ECU2A^prov#2 per cls ECXPPC2
 ;^prov 3 ECU3A^prov#3 per cls ECXPPC3^^mov # ECXMN^treat spec ECXTS
 ;^time ECTM^primary care team ECPTTM^primary care provider ECPTPR
 ;^pce cpt code (ECXCPT)^primary icd-9 code ECXICD9^secondary icd-9
 ;ECXICD91^secondary icd-9 ECXICD92^secondary icd-9 ECXICD93^secondary 
 ;icd-9 ECXICD94^agent orange ECXAST^radiation exposure ECXRST^
 ;environmental contaminants ECXEST^service connected ECPTPR^sent to pce
 ;ECPCE7^^dss identifier ECDSS^dss dept
 ;node1
 ;mpi ECXMPI^dss dept ECXDSSD^PLACEHOLDER
 ;placeholder^placeholder^placeholder^
 ;placeholder^pc prov person class ECCLAS^
 ;assoc pc prov ECASPR^assoc pc prov person class ECCLAS2^
 ;placeholder^
 ;divison ECXDIV^mst status ECXMST^dom ECXDOM^date of birth ECXDOB^
 ;enrollment category ECXCAT^ enrollment status ECXSTAT^enrollment
 ;priority ECXPRIOR^period of service ECXPOS^purple heart indicator
 ;ECXPHI^observ pat ind ECXOBS^encounter num ECXENC^
 ;ao loc ECXAOL^ord div ECXODIV^contr st dt ECXCSDT^
 ;contr end dt ECXCEDT^contr typ ECXCTYP^CNH stat ECXCNH^
 ;production division ECXPDIV^eligibility ECXELIG^
 ;head & neck cancer ind. ECXHNCI^ethnicity ECXETH^race1 ECXRAC1
 ;enrollment location ECXENRL^^enrollment priority
 ;ECXPRIOR_enrollment subgroup ECXSBGRP^user enrollee ECXUESTA^patient
 ;type ECXPTYPE^combat vet elig ECXCVE^combat vet elig end date
 ;ECXCVEDT^enc cv eligible ECXCVENC^national patient record flag
 ;ECXNPRFI^emerg response indic(FEMA) ECXERI^agent orange indic ECXAO^
 ;environ contam ECXECE^head/neck cancer ECXHNC^encntr mst ECXMIL
 ;^radiation ECXIR^OEF/OIF ECXOEF^OEF/OIF return date ECXOEFDT
 ;^associate pc provider npi ECASNPI^primary care provider npi ECPTNPI^
 ;provider npi ECU1NPI^provider #2 ECU2NPI^provider #3 ECU3NPI^
 ;shad status ECXSHADI^shad encounter ECXSHAD^patcat ECXPATCAT^
 ;prov #4 ECU4A^prov #4 pc ECXPPC4^prov #4 ECXU4NPI^prov #5 ECU5A^
 ;prov #5 pc ECXPPC5^prov #5 ECXU5NPI^
 ;primary ICD-10 code (currently null) ECXICD10P^Secondary ICD-10 Code #1 (currently null) ECXICD101^
 ;Secondary ICD-10 Code #2 (currently null) ECXICD102^Secondary ICD-10 Code #3 (currently null) ECXICD103^
 ;Secondary ICD-10 Code #4 (currently null) ECXICD104  
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTS=$G(ECXDATA(7))
 ;done
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_ECL_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECDT,ECXYM)_U_ECDU_U_ECC_U
 S ECODE=ECODE_ECP_U_ECV_U_ECCS_U_ECO_U_ECM_U_ECU1A_U_ECXPPC1_U
 S ECODE=ECODE_ECU2A_U_ECXPPC2_U_ECU3A_U_ECXPPC3_U_U_ECXMN_U
 S ECODE=ECODE_ECXTS_U_ECTM_U
 S ECODE=ECODE_ECPTTM_U_ECPTPR_U_ECXCPT_U_ECXICD9_U
 S ECODE=ECODE_ECXICD91_U_ECXICD92_U_ECXICD93_U
 S ECODE=ECODE_ECXICD94_U_ECXAST_U_ECXRST_U_ECXEST_U
 S ECODE=ECODE_ECSC_U_ECPCE7_U_U_ECDSS_U_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_U_U_U_ECCLAS_U
 S ECODE1=ECODE1_U_ECASPR_U_ECCLAS2_U_U_ECXDIV_U
 S ECODE1=ECODE1_ECXMST_U_ECXDOM_U_ECXDOB_U_ECXCAT_U_ECXSTAT_U
 S ECODE1=ECODE1_$S(ECXLOGIC<2005:ECXPRIOR,1:"")_U_ECXPOS_U_ECXPHI_U_ECXOBS_U_ECXENC_U_ECXAOL_U
 S ECODE1=ECODE1_ECXODIV_U_ECXCSDT_U_ECXCEDT_U_ECXCTYP_U_ECXCNH_U_ECXPDIV_U
 S ECODE1=ECODE1_ECXELIG_U_ECXHNCI_U_ECXETH_U_ECXRC1
 I ECXLOGIC>2003 S ECODE1=ECODE1_U_ECXENRL_U
 I ECXLOGIC>2004 S ECODE1=ECODE1_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U_ECXPTYPE_U_ECXCVE_U
 I ECXLOGIC>2004 S ECODE2=ECXCVEDT_U_ECXCVENC_U_ECXNPRFI
 I ECXLOGIC>2006 S ECODE2=ECODE2_U_ECXERI_U_ECXAO_U_ECXECE_U_ECXHNC_U_ECXMIL_U_ECXIR_U
 I ECXLOGIC>2007 S ECODE2=ECODE2_U_ECXOEF_U_ECXOEFDT_U_ECASNPI_U_ECPTNPI_U_ECU1NPI_U_ECU2NPI_U_ECU3NPI
 ; PATCAT added
 I ECXLOGIC>2010 S ECODE2=ECODE2_U_ECXSHADI_U_ECXSHAD_U_ECXPATCAT
 I ECXLOGIC>2011 S ECODE2=ECODE2_U_ECU4A_U_ECXPPC4_U_ECU4NPI_U_ECU5A_U_ECXPPC5_U_ECU5NPI
 I ECXLOGIC>2012 S ECODE2=ECODE2_U_ECXICD10P_U_ECXICD101_U_ECXICD102_U_ECXICD103_U_ECXICD104
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,^ECX(ECFILE,EC7,2)=$G(ECODE2),ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD
 Q
 ;
SETUP ;Set required input for ECXTRAC
 N OUT
 S ECHEAD="ECS",OUT=0
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q:($G(ECXQQ))
 W @IOF,!,"Setting up for ",ECPACK," DSS Extract -",!
 W !,"   Reminder: A maintenance option, ECS Extract Unusual Volume Report, may"
 W !,"   assist in identifying problematic data. It should be run before the"
 W !,"   Event Capture Extract is performed.",!
 D PAUSE^ECXTRAC
 I OUT S ECFILE=""
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 N ECXQQ
 S ECXQQ=1 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
