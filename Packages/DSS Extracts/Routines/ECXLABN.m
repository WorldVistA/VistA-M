ECXLABN ;ALB/JAP,BIR/CML-Lab Extract for DSS (New Format - With LMIP Codes) ;6/4/19  14:40
 ;;3.0;DSS EXTRACTS;**1,11,8,13,28,24,30,31,32,33,39,42,46,70,71,80,92,107,105,112,127,132,144,149,154,161,170,174,184**;Dec 22, 1997;Build 124
BEG ;entry point
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; entry when queued
 K ^LRO(64.03),^TMP($J,"ECXP")
 N ECDOCPC
 S LRSDT=ECSD,LREDT=ECED,QFLG=0
 D ^LRCAPDSS
 ;quit if no completion date for API compile
 I '$P($G(^LRO(64.03,1,1,1,0)),U,4) Q
 ;quit if tasked and user sends stop request
 I $D(ZTQUEUED),$$S^%ZTLOAD D  Q
 .S QFLG=1
 .K ^LRO(64.03) S ^LRO(64.03,0)="WKLD LOG FILE^64.03^"
 ;otherwise, continue
 K ECXDD D FIELD^DID(64.03,1,,"SPECIFIER","ECXDD")
 S ECPROF=$E(+$P(ECXDD("SPECIFIER"),"P",2)),ECLRN=1 K ECXDD
 F  S ECLRN=$O(^LRO(64.03,ECLRN)) Q:'ECLRN  D  Q:QFLG
 .Q:'$D(^LRO(64.03,ECLRN,0))
 .S EC1=^LRO(64.03,ECLRN,0),ECDOC=ECPROF_$P(EC1,U,2)
 .S ECDOCNPI=$$NPI^XUSNPI("Individual_ID",$P(EC1,U,2),$P(EC1,U,4))
 .S:+ECDOCNPI'>0 ECDOCNPI="" S ECDOCNPI=$P(ECDOCNPI,U)
 .S ECLOC=$P(EC1,U,15),EC=$P(EC1,U,3),ECDOCPC=$$PRVCLASS^ECXUTL($P(EC1,U,2),$P(EC1,U,4))
 .I EC]"" D GET
 K ^LRO(64.03),^TMP($J,"ECXP") S ^LRO(64.03,0)="WKLD LOG FILE^64.03^"
 K ECDOCNPI,ECXAGC,ECXL1,ECXL2
 Q
 ;
GET ;get data
 N X,ECXSTN,QFLAG,ECXDFN,ECXESC,ECXCLST,ECXFAC,ECXCPT,CPT1,CPTNUM,ECXASIH ;144,170
 N ECXCERN,ECXNMPI,ECXSIGI ;184
 S (ECXESC,ECXCLST)="" ;144
 S ECF=$S($P(EC,";",2)="DPT(":2,$P(EC,";",2)="LRT(67,":67,1:0) Q:'ECF
 S ECIFN=$P(EC,";"),QFLAG=0
 ;resolve ecloc
 S ECXL1=+$P(ECLOC,";",1),ECXL2=$P(ECLOC,";",2)
 I ECF=2 S ECLOC=$S(ECXL1>0:ECXL1,1:"") I ECXL2]"",ECXL2'="SC(" S ECLOC=""
 I ECF=67 D  S ECLOC=ECXSTN
 .S (ECXSTN,ECXAGC)=""
 .I (ECXL2'="DIC(4,")!('$D(^DIC(4,ECXL1))) S ECXSTN="XXXXX",ECXAGC="XX" Q
 .S ECXSTN=$P(^DIC(4,ECXL1,"99"),U,1),ECXAGC=$E($P(^(99),U,5),1,2)
 .S:ECXSTN="" ECXSTN="ZZZZZ" S:ECXAGC="" ECXAGC="ZZ"
 S ECDT=$P(EC1,U,13),ECD=$P(ECDT,"."),ECTM=$$ECXTIME^ECXUTL(ECDT)
 S ECWKLD=$P(EC1,U,11),ECWK="" I $D(^LAM(ECWKLD,0)) S ECWK=$P(^(0),U,2)
 S CPT1="" ;170
 D GETCPT(.ECXCPT,ECWKLD) ;170 Get CTP codes related to the workload code
 S CPTNUM=0 F  S CPTNUM=$O(ECXCPT(CPTNUM)) Q:CPTNUM=""!(CPT1'="")  S CPT1=ECXCPT(CPTNUM) ;170,174 Get CPT for the workload code if available
 S (ECXADMDT,ECTREAT,ECNA,ECSN,ECMN,ECPTTM,ECPTPR,ECCLAS)="",ECA="O",ECXERR=0
 S (ECPTNPI,ECASPR,ECCLAS2,ECASNPI)=""
 ;get the patient data if record is in file #2
 I ECF=2 D PAT(ECIFN,ECDT,.ECXERR) S ECXDFN=ECIFN
 Q:ECXERR
 ;get patient data if record is in file #67
 I ECF=67 S ECSN="000123456",ECNA="RFRL",ECXDFN=0 I $D(^LRT(67,ECIFN,0)) D  Q:QFLAG
 .S (ECXMPI,ECXNMPI,ECXSIGI)="",EC0=^LRT(67,ECIFN,0),ECNA=$E($P($P(EC0,U),",")_"    ",1,4) ;184 - Added ECXNMPI,ECXSIGI
 .S ECSN=$P(EC0,U,9),ECXERI="" D
 ..S ECNA=$TR(ECNA,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ..I ECSN="" S ECSN="000123456" Q
 ..S ECSN=$TR(ECSN," "),ECSN=$TR(ECSN,"-")
 ..I ($L(ECSN)<9)!($L(ECSN)>10) S ECSN="000123456" Q
 ..I $L(ECSN)=9,ECSN'?9N S ECSN="000123456" Q
 ..I $L(ECSN)=10,ECSN'?9N1"P" S ECSN="000123456"
 ..I '$$SSN^ECXUTL5(ECSN,ECF) S QFLAG=1
 ;
 ;- Only set treating spec (TS) to TS in file #64.03 if it does not exist
 I ECA="I",ECTREAT="" S ECTREAT=$P($G(^DIC(45.7,+$P(EC1,U,10),0)),U,2)
 S (ECXDOM,ECXDSSD)=""
 S X=$G(^ECX(727.831,+ECTREAT,0)) S:X'="" ECXDOM=$P(X,U,2)
 ;
 ;- Get ordering stop code and ordering date
 S ECXORDST=+$P(EC1,U,15),ECXORDST=$S(ECXORDST:$P($G(^ECX(728.44,ECXORDST,0)),U,2),1:"")
 S ECXORDDT=$S($P(EC1,U,14):$$ECXDATE^ECXUTL($P(EC1,U,14),ECXYM),1:"")
 ;
 ;- Get Production Division - ECXDIEN added p-80
 N ECXPDIV,ECXDIEN S ECXDIEN=$O(^DIC(4,"D",ECINST,"")),ECXPDIV=$$RADDIV^ECXDEPT(ECXDIEN),ECXFAC=ECINST ;P-46,170
 K ECXDIEN
 ;
 ;- Observation patient indicator (YES/NO)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECA,ECTREAT)
 ; ******* - PATCH 127, ADD PATCAT CODE ********
 S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ;
 ;- get lab billable procedure, dss feeder key, data name, data location, and pathologist information
 N ECXLEX,ECXPATH,ECXPATHP,ECXPATHN ;149
 S ECXLEX="" I $D(^LRO(64.03,ECLRN,2)) S ECXLEX=^(2)
 S ECLRBILL=$P(ECXLEX,U),ECDSSFK=$P(ECXLEX,U,2)
 S ECLRTNM=$P(ECXLEX,U,3),ECLRDTNM=$P(ECXLEX,U,4)
 S ECXPATH=$P(ECXLEX,U,5) ;149 Pathologist
 S ECXPATHP=$$PRVCLASS^ECXUTL(ECXPATH,$P(EC1,U,4)) ;149 Pathologist provider class
 S ECXPATHN=$$NPI^XUSNPI("Individual_ID",ECXPATH,$P(EC1,U,4)) S:+ECXPATHN'>0 ECXPATHN="" S ECXPATHN=$P(ECXPATHN,U) ;149 Pathologist NPI
 ;- If no encounter number don't file record
 S ECXENC=$$ENCNUM^ECXUTL4(ECA,ECSN,ECXADMDT,ECD,ECTREAT,ECXOBS,ECHEAD,,) Q:ECXENC=""
 ;create extract record only if patient name and accession area exist
 I ECNA]"" S ECT=$P(EC1,U,8),ECURG=$P(EC1,U,9),EC=+$P(EC1,U,7) I EC D
 .S:ECF=2 ECACA=EC_U_$P($G(^LRO(68,EC,0)),U,11)
 .S:ECF=67 ECACA=ECXAGC_U_$P($G(^LRO(68,EC,0)),U,11)
 .;--getting LOINC Code
 .N ECXLNC,ECLRID,LRIFN,LRIDT,ECRSLT,ECRSP8
 .S ECXLNC="",ECLRID=0
 .;--getting lab patient id
 .S LRIFN=+$P(EC1,U,3)
 .I ECF=2 S:$D(^DPT(LRIFN,"LR")) ECLRID=^DPT(LRIFN,"LR")
 .I ECF=67 S:$D(^LRT(67,LRIFN,"LR")) ECLRID=^LRT(67,LRIFN,"LR")
 .; using ECINST=institution, LRIFN=lab file patient id, EC=test (pt 60), LRIDT=date and time to get loinc
 .S LRIDT=$P(EC1,U,12)
 .;--looking up test to find subscript to lookup value
 .D
 ..N ECTST S ECTST=$P(EC1,U,8)
 ..S ECPT=$S($D(^LAB(60,ECTST,0)):$P(^LAB(60,ECTST,0),U,12),1:""),ECPT=$P(ECPT,",",2)
 ..Q:$G(ECPT)']""  Q:'$D(^LR(ECLRID,"CH",LRIDT,ECPT))
 ..S ECRSLT=$$TSTRES^LRRPU(ECLRID,"CH",LRIDT,ECPT,"",1) ;DBIA #4658
 ..S ECRSP8=$P(ECRSLT,U,8)
 ..S ECXLNC=$P($P(ECRSP8,"!",3),";")
 ..Q:$G(ECXLNC)']""
 .I ECXLOGIC>2018 D  ;170 Added section to update facility and/or production division with accessioning facility and releasing facility
 ..N ECXACC,ECXRF,ECXACCSN,ECXRFSN
 ..S ECXACC=$P($G(^LR(ECLRID,"CH",LRIDT,0)),U,14) S ECXACCSN=$$RADDIV^ECXDEPT(ECXACC) S ECXFAC=$S(ECXACC&(ECXACCSN'=""):ECXACCSN,ECXACC&(ECXACCSN=""):"9999A",1:ECXFAC) ;Set facility field based on accessioning site value
 ..S ECXRF=$P($G(^LR(ECLRID,"CH",LRIDT,"RF")),U) S ECXRFSN=$$RADDIV^ECXDEPT(ECXRF) S ECXPDIV=$S(ECXRF&(ECXRFSN'=""):ECXRFSN,ECXRF&(ECXRFSN=""):"9999R",1:ECXPDIV) ;Set production division field based on releasing site
 .I $G(ECXASIH) S ECA="A" ;170
 .D FILE
 Q
 ;
PAT(ECXDFN,ECXDATE,ECXERR) ;get/set patient data
 N X,OK,PT
 ;get data
 I $D(^TMP($J,"ECXP",ECXDFN)) D
 .S PT=^TMP($J,"ECXP",ECXDFN),ECNA=$P(PT,U)
 .S ECSN=$P(PT,U,2),(ECXNMPI,ECXMPI)=$P(PT,U,3),ECXERI=$P(PT,U,4),ECXCLST=$P(PT,U,5),ECXSIGI=$P(PT,U,6) ;144,184 - Added ECXNMPI,ECXSIGI
 ;set data and save for later
 I '$D(^TMP($J,"ECXP",ECXDFN)) D  Q:'OK
 .K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,$P(ECSD,"."),"1;3;5",.ECXPAT) ;154 Add service information (5) to list
 .I 'OK S ECXERR=1 Q
 .S ECNA=ECXPAT("NAME"),ECSN=ECXPAT("SSN"),(ECXMPI,ECXNMPI)=ECXPAT("MPI") ;184 - Added ECXNMPI
 .S ECXERI=ECXPAT("ERI")
 .S ECXCLST=ECXPAT("CL STAT") ;144
 .S ECXSIGI=ECXPAT("SIGI") ;184 Self Identified Gender
 .S ^TMP($J,"ECXP",ECXDFN)=ECNA_U_ECSN_U_ECXMPI_U_ECXERI_U_ECXCLST_U_ECXSIGI ;144,184 -Added ECXSIGI
 ;get date specific data
 S X=$$INP^ECXUTL2(ECXDFN,ECXDATE),ECA=$P(X,U),ECMN=$P(X,U,2),ECTREAT=$P(X,U,3),ECXADMDT=$P(X,U,4),ECXASIH=$P(X,U,14) ;170
 S X=$$PRIMARY^ECXUTL2(ECXDFN,$P(ECXDATE,"."),ECPROF)
 S ECPTTM=$P(X,U,1),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4)
 S ECASPR=$P(X,U,5),ECCLAS2=$P(X,U,6),ECASNPI=$P(X,U,7)
 Q
 ;
FILE ;file record
 ;node0
 ;facility^patient number^SSN (or equivalent)^name^in/out ECA^
 ;day^accession area^abbreviation^test^urgency^treating spec^
 ;location^provider and file^
 ;movement number^file^time^workload code^Placehold primary care team^
 ;Placehold primary care provider
 ;node1
 ;mpi^placeholder^provider npi^pc provider npi^Placehold pc prov person class^
 ;Placehold assoc pc prov^Placehold assoc pc prov person class^assoc pc prov npi^
 ;dom ECXDOM^observ pat ind ECXOBS^encounter num ECXENC^
 ;ord stop code ECXORDST^ord date ECXORDDT^production division
 ;ECXPDIV^^ordering provider person class^emergency response indicator
 ;(FEMA) ECXERI^Placehold associate pc provider npi ECASNPI^Placehold primary care provider
 ;npi ECPTNPI^provider npi ECDOCNPI^LOINC code ECLNC^lab billable procedure^dss feeder key
 ;node2
 ;data name^data location^PATCAT^Encounter SC ECXESC^Camp Lejeune Status ECXCLST^Pathologist ECXPATH^Pathologist Person Class ECXPATHP^Pathologist NPI ECXPATHN^CPT code CPT1
 ;ECDOCPC
 ;node3
 ;Cerner Data (ECXCERN) ;184
 ;node 4
 ;New MPI (ECXNMPI) ;184
 N DA,DIK
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 I ECXLOGIC>2018 S (ECPTTM,ECPTPR,ECCLAS,ECASPR,ECCLAS2,ECASNPI,ECPTNPI)="" ;170 PCMM-related fields will be null
 S ECODE=EC7_U_EC23_U_ECXFAC_U_ECIFN_U_ECSN_U_ECNA_U_ECA_U ;170 Replaced ECINST with ECXFAC for facility value
 S ECODE=ECODE_$$ECXDATE^ECXUTL(ECD,ECXYM)_U_ECACA_U_ECT_U_ECURG_U
 ;convert specialty to PTF Code for transmission
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECTREAT,.ECXDATA)
 S ECTREAT=$G(ECXDATA(7))
 ;convert eclrbill  to y/n
 S ECLRBILL=$S(ECLRBILL=1:"Y",1:"N")
 ;convert ecdssfk to y/n
 S ECDSSFK=$S(ECDSSFK=1:"Y",1:"")
 ;done
 S ECODE=ECODE_ECTREAT_U_ECLOC_U_ECDOC_U_ECMN_U_ECF_U_ECTM_U_ECWK_U
 S ECODE=ECODE_ECPTTM_U_ECPTPR_U
 ;(ECACA=acc area^abbreviation)
 I ECXLOGIC>2022 S ECXMPI="" ;184 - field retired
 S ECODE1=ECXMPI_U_ECXDSSD_U_U_U_ECCLAS_U_ECASPR_U_ECCLAS2_U_U_ECXDOM_U_ECXOBS_U_ECXENC_U
 S ECODE1=ECODE1_ECXORDST_U_ECXORDDT_U_ECXPDIV_U
 I ECXLOGIC>2004 S ECODE1=ECODE1_U_ECDOCPC
 I ECXLOGIC>2006 S ECODE1=ECODE1_U_ECXERI
 I ECXLOGIC>2007 S ECODE1=ECODE1_U_ECASNPI_U_ECPTNPI_U_ECDOCNPI
 I ECXLOGIC>2008 S ECODE1=ECODE1_U_$G(ECXLNC)
 I ECXLOGIC>2010 S ECODE1=ECODE1_U_ECLRBILL_U_ECDSSFK_U,ECODE2=ECLRTNM_U_ECLRDTNM_U_ECXPATCAT
 I ECXLOGIC>2013 S ECODE2=ECODE2_U_ECXESC_U_ECXCLST ;144
 I ECXLOGIC>2014 S ECODE2=ECODE2_U_$S(ECXPATH:2_ECXPATH,1:ECXPATH)_U_ECXPATHP_U_ECXPATHN ;149
 I ECXLOGIC>2018 S ECODE2=ECODE2_U_CPT1_U ;170 CPT code added ,184 - Aded "^" 
 I ECXLOGIC>2022 S ECODE3=$G(ECXCERN)_U,ECODE4=ECXNMPI_U_ECXSIGI ;184
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1,^ECX(ECFILE,EC7,2)=$G(ECODE2) ;184 - Move record count to below ,ECRN=ECRN+1
 S ^ECX(ECFILE,EC7,3)=$G(ECODE3),^ECX(ECFILE,EC7,4)=$G(ECODE4) ;184
 S ECRN=ECRN+1 ;184 Move record count from above
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="LAB"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ; entry point for the background requeuing handled by ECXTAUTO
 D SETUP,QUE^ECXTAUTO,^ECXKILL Q
 ;
GETCPT(CPT,ECWKLD) ;170 Section added to get CPT codes associated with workload code
 N CODE,REC
 D GETS^DIQ(64,ECWKLD_",","18*","I","CODE") ;Get Code multiple
 S REC="" F  S REC=$O(CODE(64.018,REC)) Q:REC=""  I CODE(64.018,REC,5,"I")="CPT",CODE(64.018,REC,3,"I")="" S CPT(+REC)=+CODE(64.018,REC,.01,"I") ;If code is a CPT code and it's active, store it
 Q
