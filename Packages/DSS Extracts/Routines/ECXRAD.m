ECXRAD ;ALB/JAP,BIR/PDW,PTD-Extract for Radiology ;6/28/12  11:08
 ;;3.0;DSS EXTRACTS;**11,8,13,16,24,33,39,46,71,84,92,105,120,127,136**;Dec 22, 1997;Build 28
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;start rad extract
 S QFLG=0
 K ECXDD D FIELD^DID(70.03,14,,"SPECIFIER","ECXDD") S ECPROF=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 S ECXDFN="",ECDT=ECSD-.1,ECED1=ECED+.3
 F  S ECDT=$O(^RADPT("AR",ECDT)) Q:ECDT>ECED1!(ECDT'>0)  D  Q:QFLG
 .S ECXDFN=""
 .F  S ECXDFN=$O(^RADPT("AR",ECDT,ECXDFN)) Q:ECXDFN=""  I '$D(^TMP("ECL",$J,ECXDFN)) D GET Q:QFLG
 K ^TMP("ECL",$J)
 Q
 ;
GET ;get data
 N ECXIEN,X,SUB,TYPE,ECDOCPC,ECXIS,ECXISPC,ECXPRCL,ECXCSC,ECXUSRTN,ECXCM,ECSTAT ;136
 S ^TMP("ECL",$J,ECXDFN)=""
 ;with dfn get all exams within date range
 S ECXMDT=ECSD-.1
 F  S ECXMDT=$O(^RADPT(ECXDFN,"DT","B",ECXMDT)) Q:((ECXMDT>ECED1)!(ECXMDT=""))  D  Q:QFLG
 .S ECXMDA=$O(^RADPT(ECXDFN,"DT","B",ECXMDT,"")) Q:ECXMDA=""
 .S ECXIEN=+$P($G(^RADPT(ECXDFN,"DT",ECXMDA,"P",1,0)),U,11)
 .S ECTM=$$ECXTIME^ECXUTL(ECXMDT) S:ECTM>235959 ECTM=235959
 .S ECXDAY=$$ECXDATE^ECXUTL(ECXMDT,ECXYM)
 .K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,$P(ECXMDT,"."),"1;3",.ECXPAT)
 .Q:'OK
 .S ECXPNM=ECXPAT("NAME"),ECXSSN=ECXPAT("SSN"),ECXMPI=ECXPAT("MPI")
 .;get emergency response indicator (FEMA)
 .S ECXERI=ECXPAT("ERI")
 .S X=$$PRIMARY^ECXUTL2(ECXDFN,$P(ECXMDT,"."),ECPROF)
 .S ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4)
 .S ECASPR=$P(X,U,5),ECCLAS2=$P(X,U,6),ECASNPI=$P(X,U,7)
 .S X=$$INP^ECXUTL2(ECXDFN,ECXMDT),ECXA=$P(X,U),ECXMN=$P(X,U,2)
 .S ECXTS=$P(X,U,3),ECXDOM=$P(X,U,10),ECXADMDT=$P(X,U,4)
 .;
 .;- Observation patient indicator (YES/NO)
 .S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 .;for dfn & date get exam(s) ien
 .S ECXMDA=""
 .F  S ECXMDA=$O(^RADPT(ECXDFN,"DT","B",ECXMDT,ECXMDA)) Q:+ECXMDA=0  D
 ..S ECXDIV=$P(^RADPT(ECXDFN,"DT",ECXMDA,0),U,3),ECLOC=$P(^(0),U,4),ECTY=$P(^(0),U,2)
 ..;
 ..;- Ordering stop code (based on imaging location)
 ..S ECXORDST=$$GET1^DIQ(40.7,$$GET1^DIQ(79.1,$G(ECLOC),22,"I"),1)
 ..;
 ..;- Get ordering date using Imaging Order ptr to #75.1 in subfile 70.03
 ..S ECXIEN=+$P($G(^RADPT(ECXDFN,"DT",ECXMDA,"P",1,0)),U,11)
 ..S ECXORDDT=$$ECXDATE^ECXUTL($P($G(^RAO(75.1,ECXIEN,0)),U,16),ECXYM)
 ..;
 ..;******* - PATCH 127, ADD PATCAT CODE ********
 ..S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ..;- If no encounter number don't file record
 ..S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXMDT,ECXTS,ECXOBS,ECHEAD,ECTY,) Q:ECXENC=""
 ..;procedures and modifiers for specific exam (case numbers)
 ..;ward/clinic,service,provider,diagnostic code
 ..S ECCN=0
 ..F  S ECCN=$O(^RADPT(ECXDFN,"DT",ECXMDA,"P",ECCN)) Q:ECCN'>0  D
 ...S ECCA=^RADPT(ECXDFN,"DT",ECXMDA,"P",ECCN,0)
 ...S ECXCM=$P(ECCA,U,26) S ECXCM=$S("^0^1^2^3^"[("^"_ECXCM_"^"):ECXCM,1:"") ;136 - Get Credit Method and validate that it's a number between 0 and 3 otherwise set it to null
 ...S ECXW=$P(ECCA,U,6),ECXW=$P($G(^DIC(42,+ECXW,44)),U)
 ...S:ECXW="" ECXW=$P(ECCA,U,8)
 ...S ECDOCNPI=$$NPI^XUSNPI("Individual_ID",$P(ECCA,U,14),ECDT)
 ...S:+ECDOCNPI'>0 ECDOCNPI="" S ECDOCNPI=$P(ECDOCNPI,U)
 ...S (ECXDSSD,ECXDSSP)=""
 ...S ECS=$P(ECCA,U,7),ECDOC=ECPROF_$P(ECCA,U,14),ECDI=$P(ECCA,U,13),ECDOCPC=$$PRVCLASS^ECXUTL($P(ECCA,U,14),ECDT)
 ...S ECPRO=$P(ECCA,U,2),ECSTAT=$P($G(^RA(72,+$P(ECCA,U,3),0)),U,3)
 ...;get the primary interpreting staff and the person class DBIA #65
 ...S ECXIS=$P(ECCA,U,15),ECXISPC=$$PRVCLASS^ECXUTL(ECXIS,ECDT)
 ...S ECISNPI=$$NPI^XUSNPI("Individual_ID",ECXIS,ECDT)
 ...S:+ECISNPI'>0 ECISNPI="" S ECISNPI=$P(ECISNPI,U)
 ...;prefix interpreting radiologist with a "2" if not null
 ...S ECXIS=$S(ECXIS:"2"_ECXIS,1:"")
 ...;get the principal clinic ien DBIA #65
 ...S ECXPRCL=$P(ECCA,U,8)
 ...;get the clinic stop code from file #44
 ...S ECXCSC=$$GET1^DIQ(40.7,$$GET1^DIQ(44,ECXPRCL,8,"I"),1)
 ...Q:'ECPRO 
 ...Q:+ECSTAT=0
 ...;get CPT code & modifiers
 ...S ECPT=+$P($G(^RAMIS(71,+ECPRO,0)),U,9),ECXCMOD=""
 ...;quit if this is a 'parent' procedure
 ...S TYPE=$P($G(^RAMIS(71,+ECPRO,0)),U,6)
 ...Q:((ECPT=0)&(TYPE="P"))
 ...;if site is using radiology with cpt modifiers then get them
 ...K ARR,ERR D FIELD^DID(70.03,135,,"LABEL","ARR","ERR")
 ...I $D(ARR("LABEL")) D
 ....K ARR,ERR D FIELD^DID(70.03,135,,"GLOBAL SUBSCRIPT LOCATION","ARR","ERR")
 ....Q:$D(ERR("DIERR"))
 ....S SUB=$P(ARR("GLOBAL SUBSCRIPT LOCATION"),";") S ECMOD=0
 ....Q:'$D(^RADPT(ECXDFN,"DT",ECXMDA,"P",ECCN,SUB))
 ....F  S ECMOD=$O(^RADPT(ECXDFN,"DT",ECXMDA,"P",ECCN,SUB,ECMOD)) Q:ECMOD'>0  S ECXCMOD=ECXCMOD_$P(^(ECMOD,0),U)_";"
 ...S ECXCPT=$$CPT^ECXUTL3(ECPT,ECXCMOD)
 ...;get procedure radiology modifiers
 ...S ECMOD=0,ECMODS=""
 ...F  S ECMOD=$O(^RADPT(ECXDFN,"DT",ECXMDA,"P",ECCN,"M",ECMOD)) Q:ECMOD'>0  S ECMODS=ECMODS_$P(^(ECMOD,0),U)_";"
 ...S ECXPDIV=$$RADDIV^ECXDEPT(ECXDIV) ;p-46
 ...D FILE
 Q
 ;
FILE ;file record
 ;node0
 ;rad div^dfn^ssn^name^in/out (ECXA)^day^cpt code^procedure^img loc^ward^
 ;ser^diag code^req physician^modifiers^mov #^treat spec^time^
 ;imaging type^primary care team^primary care provider
 ;node1
 ;mpi^dss dept^placeholder^placeholder^pc prov person class^
 ;assoc pc provider^assoc pc prov person class^placeholder^dom^
 ;observ pat ind^encounter num^ord stop code^ord date^division^
 ;dss product ECXDSSP^requesting provider person class ECDOCPC^interp-
 ;reting radiologist ECXIS^interpreting radiologist pc ECXISPC^princi-
 ;pal clinic ECXPRCL^clinc stop code ECXCSC^emergency response indicator
 ;(FEMA) ECXERI^assoc pc provider npi^interpreting rad npi^pc provider npi^req physician npi^Patient Category (PATCAT) ECXPATCAT^Credit Method ECXCM
 ;
 ;convert specialty to PTF Code for transmission
 N ECXDATA,ECXTSC
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTSC=$G(ECXDATA(7))
 ;done
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_ECXDIV_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S ECODE=ECODE_ECXDAY_U_ECXCPT_U_ECPRO_U_ECLOC_U_ECXW_U_ECS_U_ECDI_U
 S ECODE=ECODE_ECDOC_U_ECMODS_U_ECXMN_U_ECXTSC_U_ECTM_U_ECTY_U_ECPTTM_U
 S ECODE=ECODE_ECPTPR_U
 S ECODE1=ECXMPI_U_ECXDSSD_U_U_U_ECCLAS_U_ECASPR_U
 S ECODE1=ECODE1_ECCLAS2_U_U_ECXDOM_U_ECXOBS_U_ECXENC_U_ECXORDST_U
 S ECODE1=ECODE1_ECXORDDT_U_ECXPDIV_U
 I ECXLOGIC>2004 S ECODE1=ECODE1_ECXDSSP_U_ECDOCPC
 I ECXLOGIC>2005 S ECODE1=ECODE1_U_ECXIS_U_ECXISPC_U_ECXPRCL_U_ECXCSC
 I ECXLOGIC>2006 S ECODE1=ECODE1_U_ECXERI
 I ECXLOGIC>2007 S ECODE1=ECODE1_U_ECASNPI_U_ECISNPI_U_ECPTNPI_U_ECDOCNPI
 I ECXLOGIC>2010 S ECODE1=ECODE1_U_ECXPATCAT ;127 PATCAT
 I ECXLOGIC>2012 S ECODE1=ECODE1_U_ECXCM ;136 Credit Method
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="RAD"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
