ECXEC ;ALB/JAP,BIR/JLP,PTD-DSS Event Capture Extract ;5/31/19  11:28
 ;;3.0;DSS EXTRACTS;**11,8,13,24,27,33,39,46,49,71,89,92,105,120,127,132,136,144,149,154,161,166,170,173,174,181,184**;Dec 22, 1997;Build 124
 ;
 ; Reference to DEM^VADPT in ICR #10061
 ; Reference to ^TMP($J) in SACC 2.3.2.5.1
 ;
BEG ;entry point from option
 I '$D(^ECH) W !,"Event Capture is not initialized",!! Q
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
START ;begin EC extract
 N X,Y,ECDCM,ECXNPRFI,ECXVIET,ECX4CHAR ; 144 national 4char code
 N ECXICD10P,ECXICD101,ECXICD102,ECXICD103,ECXICD104,LATE,EFY ;166,170
 S EFY=$$FISCAL^ECXUTL1(ECED) ;170 Determine extract fiscal year based on ending date of extract
 S ECED=ECED+.3,ECLL=0
 K ^TMP("EC",$J)
 K ^TMP($J,"ECXECM") ;181
 F  S ECLL=$O(^ECH("AC1",ECLL)),ECD=ECSD-.1 Q:'ECLL  D
 .F  S ECD=$O(^ECH("AC1",ECLL,ECD)),ECDA=0 Q:(ECD>ECED)!('ECD)  D
 ..F  S ECDA=$O(^ECH("AC1",ECLL,ECD,ECDA)) Q:'ECDA  D UPDATE
 ;166 Done processing by date, now find any "late" state home records
 S ECDA=0,LATE=1 F  S ECDA=$O(^XTMP("ECEFPAT",ECDA)) Q:'+ECDA  D
 .I $G(^XTMP("ECEFPAT",ECDA))=1 Q  ;Record already counted in "regular" process
 .I '$D(^ECH(ECDA,0)) Q  ;Record in table but not in file
 .I $P($G(^ECH(ECDA,0)),U,3)>ECED Q  ;Record has a procedure date/time after end date of extract so we'll skip it
 .I $$FISCAL^ECXUTL1($P($G(^ECH(ECDA,0)),U,3))<EFY S ^XTMP("ECEFPAT",ECDA)=3 Q  ;170 If the fiscal year associated with the procedure date is from a previous fiscal year, skip and set for deletion
 .D UPDATE ;process record
 D CLEAN ;166 extract completed, clear out ^XTMP records
 I $D(^TMP($J,"ECXECM")) D EN^ECXEC1 ;181 - Send messages for records with NO DSS Units
 Q
 ;
UPDATE ;sets record and updates counters
 N ECXESC,ECXECL,ECXCLST,ECXRES1,ECXRES2,ECXRES3,ECPNM,ECDSSE,ROOT ;149,154
 N ECXTEMPW,ECXTEMPD,ECXSTANO,ECXASIH,ECXSVH  ;166,170,174
 N ECXCERN,ECXNMPI,ECXSIGI ;184
 S (ECXESC,ECXECL,ECXCLST,ECXRES1,ECXRES2,ECXRES3,ECXCERN)="" ;144;184 - Added ECXCERN
 S ECCH=^ECH(ECDA,0),ECL=$P(ECCH,U,4),ECXDFN=$P(ECCH,U,2)
 S ECXPDIV=$$RADDIV^ECXDEPT(ECL)  ;Get production division from file 4
 S ECDT=$P(ECCH,U,3),ECM=$P(ECCH,U,6),ECC=$P(ECCH,U,8)
 S ECTM=$$ECXTIME^ECXUTL(ECDT),ECP=$P(ECCH,U,9) ;154 Moved line to be in front of call to ECXUTL2
 I $P(ECP,";",2)[725 S ECPNM=$$GET1^DIQ(725,+ECP,1) ;154 Get procedure name
 Q:'$$PATDEM^ECXUTL2(ECXDFN,ECDT,"1;3;5;")
 Q:ECP']""
 D:ECP[";"  ;181 - Moved these lines from below to be in front of calling SETTMP
 .S ECP=$S(ECP["ICPT":$P(^ICPT(+ECP,0),U)_"01",ECP<90000:$P(^EC(725,+ECP,0),U,2)_"N",1:$P(^EC(725,+ECP,0),U,2)_"L"),ECC=$S(ECC:ECC,1:"")
 S ECXSTANO=ECXPDIV               ;166 tjl - Set default Patient Division
 I ECXA="I",$D(^DGPM(ECXMN,0)) D  ;166 tjl - Set Patient Division for inpatients based on Patient Movement record
 . S ECXTEMPW=$P($G(^DGPM(ECXMN,0)),U,6)
 . S ECXTEMPD=$P($G(^DIC(42,+ECXTEMPW,0)),U,11)
 . S ECXSTANO=$$GETDIV^ECXDEPT(ECXTEMPD)
 S ECO=$P(ECCH,U,12),ECV=$P(ECCH,U,10),ECDU=$P(ECCH,U,7)
 I ECDU="" D SETTMP Q  ;181 - if DSS Unit is missing set global for mail message
 S ECXUNIT=$G(^ECD(ECDU,0)),ECCS=+$P(ECXUNIT,U,4),ECDCM=$P(ECXUNIT,U,5)
 S ECXDSSP="",ECXDSSD=$E(ECDCM,1,10),ECUSTOP=$P(ECXUNIT,U,10),ECUPCE=$P(ECXUNIT,U,14)
 S ICD9=$P($G(^ECH(ECDA,"P")),U,2) ;154
 S (ECXICD9,ECXICD10P,ECX4CHAR)="" I ICD9'="" S ECXICD10P=$$CODEC^ICDEX(80,ICD9) ;144,154,161
 F I=1:1:4 S @("ECXICD9"_I)=""
 F I=1:1:4 S @("ECXICD10"_I)=""
 S (CNT,I)=0
 F  S CNT=$O(^ECH(ECDA,"DX",CNT)) Q:'CNT  D  Q:I>3
 .S ICD9=$P($G(^ECH(ECDA,"DX",CNT,0)),U) D:ICD9'=""
 ..S I=I+1,@("ECXICD10"_I)=$$CODEC^ICDEX(80,ICD9) ;154,161
 ;derivation of dss identifier depends on whether dss unit is 
 ;set to send data to pce
 S ECAC=$P($G(ECCH),U,19) S:ECAC=0 ECAC="" ;144 Change value to null if value from event capture patient file is 0
 S ECX4CHAR=$$RJ^XLFSTR($$GET1^DIQ(728.44,+ECAC,7,"E"),4,0) ; 144,154 use the assoc clinic to get 4char code, default to 0000 if non-existent
 ;if this is a record that 'goes to pce', then get the dss identifier
 ;from the clinic stop codes
 S (ECAC1S,ECAC2S)="000"
 I ECUPCE="A"!(ECUPCE="O"&(ECXA="O"))!(ECUPCE="OOS") D  ;173 Add "OOS" units
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
 .S ECAC1S=$$RJ^XLFSTR($P($G(^DIC(40.7,+ECUSTOP,0)),U,2),3,0) ;154
 .S ECAC2S=$$RJ^XLFSTR($P($G(^DIC(40.7,+$P(ECXUNIT,U,13),0)),U,2),3,0) ;154
 .S ECX4CHAR=$$RJ^XLFSTR($$GET1^DIQ(728.441,+$P(ECXUNIT,U,15),.01,"E"),4,0) ;154
 S ECDSS=ECAC1S_ECAC2S
 I ECXLOGIC>2003 I "^18^23^24^41^65^94^108^"[("^"_ECXTS_"^") S ECDSS=$$TSMAP^ECXUTL4(ECXTS)
 S ECXDIV=""
 ;
 ;- Ord Div, Contrct St/End Dates, Contrct Type placeholders for FY2002
 S (ECXODIV,ECXCSDT,ECXCEDT,ECXCTYP)=""
 ;setup provider(s) as'2'_ien
 S (ECU1A,ECU2A,ECU3A,ECU1NPI,ECU2NPI,ECU3NPI,ECXPPC1,ECXPPC2,ECXPPC3,ECU1,ECU2,ECU3,ECU4,ECU5,ECU6,ECU7)="" ;144 CVW
 S (ECU4A,ECU5A,ECU6A,ECU7A,ECU4NPI,ECU5NPI,ECU6NPI,ECU7NPI,ECXPPC4,ECXPPC5,ECXPPC6,ECXPPC7)="" ;144
 K ECXPRV S ECXPROV=$$GETPRV^ECPRVMUT(ECDA,.ECXPRV) I ECXPROV Q
 F I=1:1:7 S Y=$O(ECXPRV("")) I Y'="" S @("ECU"_I)=+ECXPRV(Y) K ECXPRV(Y)
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
 ;144 add 2 more providers, prov per class, prov npi cvw
 S:$L(ECU6) ECXPPC6=$$PRVCLASS^ECXUTL(ECU6,ECDT),ECU6A="2"_$P(ECU6,";")
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECU6,ECDT)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECU6NPI=$P(ECXUSRTN,U)
 S:$L(ECU7) ECXPPC7=$$PRVCLASS^ECXUTL(ECU7,ECDT),ECU7A="2"_$P(ECU7,";")
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECU7,ECDT)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECU7NPI=$P(ECXUSRTN,U)
 ;change for version 2 where ECP is a variable pointer and we want to
 ;expand it category = category or null if stored as 0
 ;D:ECP[";"  ;181 - Moved to begin of UPDATE
 ;.S ECP=$S(ECP["ICPT":$P(^ICPT(+ECP,0),U)_"01",ECP<90000:$P(^EC(725,+ECP,0),U,2)_"N",1:$P(^EC(725,+ECP,0),U,2)_"L"),ECC=$S(ECC:ECC,1:"")
 ;pick up EC to PCE data from "P" in File 721
 S ECPCE=$G(^ECH(ECDA,"P")),ECPCE1=$P(ECPCE,U),ECPCE2=$P(ECPCE,U,2)
 S ECPCE7=$S($P(ECPCE,U,7)=1:"Y",1:"N")
 S ECXRES1=$$GET1^DIQ(720.5,$P($G(^ECH(ECDA,0)),U,23),.01,"E") ;149 Proc Reason 1
 S ECXRES2=$$GET1^DIQ(720.5,$P($G(^ECH(ECDA,0)),U,24),.01,"E") ;149 Proc Reason 2
 S ECXRES3=$$GET1^DIQ(720.5,$P($G(^ECH(ECDA,1)),U,1),.01,"E")  ;149 Proc Reason 3
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
 .S ECXECL=$G(ECXVIST("ENCCL")),ECXESC=$G(ECXVIST("ENCSC")) ;144
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
 S ECXSVH=$P($G(^ECH(ECDA,2)),U,5) ;174 Set state veteran home name from field in the EVENT CAPTURE PATIENT file
 ; - If no encounter number don't file record
 S ECDSSE=$S(ECAC1S<101!(ECAC1S>999):"ECS",1:ECAC1S)_ECAC2S ;154 If stop code is invalid set it to ECS for encounter number creation
 I ECXLOGIC>2018 D  ;170 If procedure is in range, change specific patient data for record
 .I "^CH103^CH104^CH105^CH106^CH107^CH108^CH109^"[("^"_$G(ECPNM)_"^") S ECXSSN="000123457",ECXPNM="ZZCH",ECXA="O" ;If specific Chaplain codes, use fake name and SSN and set to outpatient
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECDT,ECXTS,ECXOBS,ECHEAD,ECDSSE,ECCS) ;154 Send ECDSSE for encounter number creation
 I $G(ECXASIH) S ECXA="A" ;170
 D:ECXENC'="" FILE
 I $D(^XTMP("ECEFPAT",ECDA)) S ^XTMP("ECEFPAT",ECDA)=$S($G(LATE):2,1:1) ;166 If this record was entered through the state home spreadsheet then mark it with 1 if within date range or 2 if "late"
 Q
 ;
FILE ;file record in #727.815
 ;node0
 ;ecode=inst ECL^dfn ECXDFN^ssn ECXSSN^name ECXPNM^i/o status ECXA^day^
 ;DSS unit ECDU^category ECC^procedure ECP^volume ECV^
 ;cost center ECCS^ordering sec ECO^section ECM^
 ;provider ECU1A^prov per cls ECXPPC1^prov 2 ECU2A^prov#2 per cls ECXPPC2
 ;^prov 3 ECU3A^prov#3 per cls ECXPPC3^^mov # ECXMN^treat spec ECXTS
 ;^time ECTM^Placehold primary care team ECPTTM^Placehold primary care provider ECPTPR
 ;^pce cpt code (ECXCPT)^Placeholder ECXICD9^Placeholder ECXICD91^
 ;Placeholder ECXICD92^Placeholder ECXICD93^Placeholder ECXICD94^ 
 ;agent orange ECXAST^radiation exposure ECXRST^
 ;environmental contaminants ECXEST^service connected ECPTPR^sent to pce
 ;ECPCE7^^dss identifier ECDSS^placeholder
 ;node1
 ;mpi ECXMPI^placeholder ECXDSSD^PLACEHOLDER
 ;placeholder^placeholder^placeholder^
 ;placeholder^Placehold pc prov person class ECCLAS^
 ;Placehold assoc pc prov ECASPR^Placehold assoc pc prov person class ECCLAS2^
 ;placeholder^
 ;divison ECXDIV^mst status ECXMST^dom ECXDOM^date of birth ECXDOB^
 ;enrollment category ECXCAT^ enrollment status ECXSTAT^enrollment
 ;priority ECXPRIOR^period of service ECXPOS^purple heart indicator
 ;ECXPHI^observ pat ind ECXOBS^encounter num ECXENC^
 ;ao loc ECXAOL^ord div ECXODIV^contr st dt ECXCSDT^
 ;contr end dt ECXCEDT^contr typ ECXCTYP^CNH stat ECXCNH^
 ;production division ECXPDIV^eligibility ECXELIG^
 ;head & neck cancer ind. ECXHNCI^Placehold ethnicity ECXETH^Placehold race1 ECXRC1
 ;enrollment location ECXENRL^^enrollment priority
 ;ECXPRIOR_enrollment subgroup ECXSBGRP^user enrollee ECXUESTA^patient
 ;type ECXPTYPE^combat vet elig ECXCVE
 ;NODE 2
 ;combat vet elig end date ECXCVEDT
 ;enc cv eligible ECXCVENC^national patient record flag
 ;ECXNPRFI^emerg response indic(FEMA) ECXERI^agent orange indic ECXAO^
 ;environ contam ECXECE^head/neck cancer ECXHNC^encntr mst ECXMIL
 ;^radiation ECXIR^OEF/OIF ECXOEF^OEF/OIF return date ECXOEFDT
 ;^Placehold associate pc provider npi ECASNPI^Placehold primary care provider npi ECPTNPI^
 ;provider npi ECU1NPI^provider #2 ECU2NPI^provider #3 ECU3NPI^
 ;shad status ECXSHADI^shad encounter ECXSHAD^patcat ECXPATCAT^
 ;prov #4 ECU4A^prov #4 pc ECXPPC4^prov #4 ECXU4NPI^prov #5 ECU5A^
 ;prov #5 pc ECXPPC5^prov #5 ECXU5NPI^
 ;primary ICD-10 code ECXICD10P^Secondary ICD-10 Code #1 ECXICD101^
 ;Secondary ICD-10 Code #2 ECXICD102^Secondary ICD-10 Code #3 ECXICD103^
 ;Secondary ICD-10 Code #4 ECXICD104
 ;NODE 3
 ;Encounter SC ECXESC^Vietnam Status ECXVIET^
 ;Provider #6 ECU6A^ Prov #6 PC ECXPPC6^Prov #6 NPI ECU6NPI^Provider #7 ECU7A^ Prov #7 PC ECXPPC7^Prov #7 NPI ECU7NPI
 ;National 4CHAR code ECX4CHAR^NULL^Camp Lejeune Status ECXCLST^Encounter Camp Lejeune ECXECL
 ;Reason #1 (ECXRES1) ^ Reason #2 (ECXRES2) ^ Reason #3 (ECXRES3) ^ Combat Service Indicator (ECXSVCI) ^ Combat Service Location (ECXSVCL)
 ;Clinic IEN (ECAC) 154
 ;^ Patient Division (ECXSTANO) 166^State Home Name (ECXSVH) 174^PlaceHold CERNER (ECXCERN)^New MPI (ECXNMPI)^Self Identified Gender (ECXSIGI) ; 184
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTS=$G(ECXDATA(7))
 ;done
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 I ECXLOGIC>2018 D  ;170 Changes related to FY19
 .S (ECXETH,ECXRC1)="" ;170 Ethnicity and Race 1 fields will now be null
 .S (ECPTTM,ECPTPR,ECCLAS,ECASPR,ECCLAS2,ECASNPI,ECPTNPI)="" ;170 PCMM-related fields will be null
 I ECXLOGIC>2022 S ECXNMPI=ECXMPI,ECXMPI="" ;184 Field retired: MPI, Added New field:NMPI
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
 I ECXLOGIC>2012 S ECODE2=ECODE2_U_ECXICD10P_U_ECXICD101_U_ECXICD102_U_ECXICD103_U_ECXICD104_U
 I ECXLOGIC>2013 S ECODE3=ECXESC_U_ECXVIET_U_ECU6A_U_ECXPPC6_U_ECU6NPI_U_ECU7A_U_ECXPPC7_U_ECU7NPI_U_ECX4CHAR_U_$S(ECXLOGIC>2015:"",1:ECAC)_U_ECXCLST_U_ECXECL ; 154
 I ECXLOGIC>2014 S ECODE3=ECODE3_U_ECXRES1_U_ECXRES2_U_ECXRES3_U_ECXSVCI_U_ECXSVCL ;149
 I ECXLOGIC>2015 S ECODE3=ECODE3_U_ECAC ;154 MOVED CLINIC IEN
 I ECXLOGIC>2017 S ECODE3=ECODE3_U_ECXSTANO  ;166
 I ECXLOGIC>2019 S ECODE3=ECODE3_U_ECXSVH ;174
 I ECXLOGIC>2022 S ECODE3=ECODE3_U_ECXCERN_U_ECXNMPI_U_ECXSIGI ;184
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,^ECX(ECFILE,EC7,2)=$G(ECODE2),^ECX(ECFILE,EC7,3)=$G(ECODE3),ECRN=ECRN+1 ;144
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
 ;
CLEAN ;166 Section added to clean out table when extract finishes
 N RECNO
 S RECNO=0 F  S RECNO=$O(^XTMP("ECEFPAT",RECNO)) Q:'+RECNO  D
 .I $G(^XTMP("ECEFPAT",RECNO))'="" K ^XTMP("ECEFPAT",RECNO) ;If record was counted, delete entry from table
 Q
 ;
SETTMP ;181 - Set global TMP for Mail Message
 N ECXNODSS,PNAME,SSN,DFN,ECDTEX,VADM
 S DFN=ECXDFN D DEM^VADPT ; ICR #10061
 S ECDTEX=$$ECXDATE^ECXUTL(ECDT,ECXYM)
 S ECDTEX=$E(ECDTEX,5,6)_"/"_$E(ECDTEX,7,8)_"/"_$E(ECDTEX,1,4)
 I '$D(^TMP($J,"ECXECM","NODSS")) S ^TMP($J,"ECXECM","NODSS")=0
 S ECXNODSS=^TMP($J,"ECXECM","NODSS")+1
 S ^TMP($J,"ECXECM","NODSS",ECXNODSS,0)=$J($E(VADM(1),1,25),25)_" ("_$P(VADM(2),U,2)_") "_$J($G(ECP),12)_" "_$J(ECDTEX,12)_" "_$$ECXTIMEX^ECXUTL(ECTM)
 S ^TMP($J,"ECXECM","NODSS")=ECXNODSS
 Q
