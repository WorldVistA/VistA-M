ECXMTL ;ALB/JAP - DSS Mental Health Extract ; 8/17/07 9:52am
 ;;3.0;DSS EXTRACTS;**24,30,33,39,46,49,71,82,84,92,105,120,127**;Dec 22, 1997;Build 36
 ;
BEG ;entry point from option
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;entry point from tasked job
 S QFLG=0
 ;get first record #
 S EC7=$O(^ECX(ECFILE,999999999),-1)
 ;call mh/dss api for extract record creation
 ;variables ecfile,ecxym,ecinst,ecsd,eced passed in by taskmanager
 S ECXSEQ=EC7,ECXECX=$P(EC23,U,2),ECXERR=0
 ;call mh api to create extract records
 S X="YSDSS" X ^%ZOSF("TEST") I '$T S QFLG=1 Q
 D UPD^YSDSS(ECFILE,.ECXSEQ,ECXYM,ECXECX,ECINST,ECSD,ECED,.ECXERR)
 Q:ECXERR
 Q:QFLG
 ;if no error, continue
 D UPDATE
 Q
 ;
UPDATE ;add non-mh data to each record created by mh api
 N ECXADT,JJ,ECXNPRFI
 S EC7=EC7+1
 F JJ=EC7:1:ECXSEQ Q:QFLG  D
 .Q:'$D(^ECX(ECFILE,JJ,0))
 .S ECXDFN=$P(^ECX(ECFILE,JJ,0),U,5),ECXDATE=$P(^ECX(ECFILE,JJ,0),U,9),ECXPRV=$P(^ECX(ECFILE,JJ,0),U,18)
 .S ECXSCNUM=$P(^ECX(ECFILE,JJ,0),U,23),ECXSCNAM=$P(^ECX(ECFILE,JJ,0),U,24)
 .D PAT(ECXDFN,ECXDATE)
 .S (ECXPRCLS,ECPRNPI,ECXDIV,ECXPDIV)="" I ECXPRV D PROV(.ECXPRV,ECXDATE)
 .S ECXDSSI=""
 .I ECXLOGIC>2003 D
 ..I "^18^23^24^41^65^94^108^"[("^"_ECXTS_"^") S ECXDSSI=$$TSMAP^ECXUTL4(ECXTS)
 .;
 .;- Observation patient indicator (YES/NO)
 .S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECXDSSI)
 .;
 .;- set national patient record flag if exist
 .D NPRF^ECXUTL5
 .;
 .;- If no encounter number don't file record
 .S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADT,ECXDATE,ECXTS,ECXOBS,ECHEAD,,) Q:ECXENC=""
 .S ECD=ECXDATE,ECXDATE=$$ECXDATE^ECXUTL(ECXDATE,ECXYM)
 .;adjust scale name & scale number
 .S ECXSCNAM=$E(ECXSCNAM,1,10)
 .I ECXSCNUM]"",ECXSCNUM'=+ECXSCNUM S ECXSCNUM=+$E(ECXSCNUM,2,99)
 .N ECXDEPT S ECXDEPT="" ;dss department use postponed S ECXDEPT=$$MTL^ECXDEPT(ECXDIV,ECXSCNAM,ECINST) ;p-46 line added
 .;Set division to external value if extract is for FY05 or higher
 .D FILE
 Q
 ;
PAT(ECXDFN,ECXDATE) ;determine in/outpatient status, demographics, primary care
 N OK
 S (ECXADT,ECXPNM,ECXSSN,ECXMPI)=""
 K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,ECXDATE,"1;3;5;",.ECXPAT)
 S ECXPNM=ECXPAT("NAME"),ECXSSN=ECXPAT("SSN"),ECXMPI=ECXPAT("MPI")
 S ECXDOB=ECXPAT("DOB")
 ;agent orange status
 S ECXAST=ECXPAT("AO STAT")
 ;- Purple Heart Indicator, Period of Service, Agent Orange Location
 S ECXPHI=$G(ECXPAT("PHI")),ECXPOS=ECXPAT("POS"),ECXAOL=ECXPAT("AOL")
 I $$ENROLLM^ECXUTL2(ECXDFN)
 ;Combat Veteran Status
 S X3=$$CVEDT^ECXUTL5(ECXDFN,$S($G(ECD):ECD,$G(ECXDATE):ECXDATE,1:DT))
 ; - Head and Neck Cancer Indicator
 S ECXHNCI=$$HNCI^ECXUTL4(ECXDFN)
 ; - Race and Ethnicity
 S ECXETH=ECXPAT("ETHNIC")
 S ECXRC1=ECXPAT("RACE1")
 ;get primary care data
 S X=$$PRIMARY^ECXUTL2(ECXDFN,ECXDATE),ECPTTM=$P(X,U)
 S ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4)
 S ECASPR=$P(X,U,5),ECCLAS2=$P(X,U,6),ECASNPI=$P(X,U,7)
 ;get inpatient data
 S X=$$INP^ECXUTL2(ECXDFN,ECXDATE),ECXDOM=$P(X,U,10),ECXTS=$P(X,U,3)
 S ECXA=$P(X,U),(ECXADT,ECXADMDT)=$P($P(X,U,4),"."),ECXDCDT=$P($P(X,U,6),".")
 S ECXWPRV=$P(X,U,7),ECXATT=$P(X,U,8)
 S ECWPRNPI=$$NPI^XUSNPI("Individual_ID",ECXWPRV,ECXDATE)
 S:+ECWPRNPI'>0 ECWPRNPI="" S ECWPRNPI=$P(ECWPRNPI,U)
 S ECATTNPI=$$NPI^XUSNPI("Individual_ID",ECXATT,ECXDATE)
 S:+ECATTNPI'>0 ECATTNPI="" S ECATTNPI=$P(ECATTNPI,U)
 ;Get ward provider and attending phy person classes
 S ECXWPRPC=$P(X,U,11),ECXATTPC=$P(X,U,12)
 I ECXADMDT S ECXADMDT=$$ECXDATE^ECXUTL(ECXADMDT,ECXYM)
 I ECXDCDT S ECXDCDT=$$ECXDATE^ECXUTL(ECXDCDT,ECXYM)
 Q
 ;
PROV(ECXPRV,ECXDATE) ;get provider data
 N INST,DGIEN,ARR,DIC,DR,DA,DIQ
 S ECXPRCLS=$$PRVCLASS^ECXUTL(ECXPRV,ECXDATE)
 S ECPRNPI=$$NPI^XUSNPI("Individual_ID",ECXPRV,ECXDATE)
 S:+ECPRNPI'>0 ECPRNPI="" S ECPRNPI=$P(ECPRNPI,U)
 ;get division identifier using provider
 S (ECXDIV,ECXPDIV)=""
 S IEN=0 F  D  Q:'IEN  Q:'INST  Q:ECXDIV
 .;get pointer to file #4 from provider record
 .I '$D(^VA(200,ECXPRV,0)) Q
 .S IEN=$O(^VA(200,ECXPRV,2,IEN))
 .Q:'IEN
 .S DIC="^VA(200,",DR="16",DA=ECXPRV
 .S DR(200.02)=".01",DA(200.02)=IEN,DIQ="ARR",DIQ(0)="I"
 .D EN^DIQ1
 .S INST=$G(ARR(200.02,IEN,.01,"I"))
 .Q:'INST
 .;get production division
 .S ECXPDIV=$$RADDIV^ECXDEPT(INST) ;p-46 line added
 .;get medical center division
 .S DGIEN=$O(^DG(40.8,"AD",INST,0)) I DGIEN D
 ..S ECXDIV=$P($G(^ECX(727.3,DGIEN,0)),U,2)
 S ECXPRV="2"_ECXPRV
 Q
 ;
FILE ;file record in #727.812
 ;node0
 ;facility^dfn^ssn ECXSSN^name ECXPNM^i/o status ECXA^
 ;day ECXDATE^division ECXDIV^admit date ECXADMDT^
 ;d/c date ECXDCDT^dss id ECXDSSI^pc team ECPTTM^pc provider ECPTPR^
 ;placeholder^pc prov person class ECCLAS^
 ;provider ECXPRV^placeholder^prov person class ECXPRCLS^
 ;test name ECXSCNAM(?)^test ien ECXSCNUM(?)^scale number^scale name^
 ;test score^scale score^attend phys^ward provider
 ;node1
 ;mpi^assoc pc provider^placeholder^
 ;assoc pc prov person class^asi class^asi special^asi encounter date^
 ;purple heart ind.^dom prrtp & saartp ind.^enrollment cat^
 ;enrollment stat^enrollment prior^period of serv.^obs. pat ind.^
 ;encounter num^agent orange loc^dob^production division^dss
 ;department ECXDEPT^head & neck canc. indi.^ethnicity^race1^^
 ;enrollment prior ECXPRIOR_enrollment subgroup
 ;ECXSBGRP^enrollee user ECXUESTA^division ECXDIV^patient type
 ;ECXPTYPE^combat vet elig ECXCVE^combat vet elig end date ECXCVEDT^
 ;enc cv eligible ECXCVENC^national patient record flag ECXNPRFI
 ;attending phy person class ECXATTPC^ward provider person class 
 ;ECXWPRPC^^agent orange status ECXAST^asso prov npi ECASNPI^att phy
 ;npi ECATTNPI^primary care prov npi ECPTNPI^provider npi ECPRNPI^ward
 ;provider npi ECWPRNPI
 N DA,DIK,STR
 I $P(^ECX(ECFILE,JJ,0),U,21)="ASI" S $P(^ECX(ECFILE,JJ,1),U,7)=ECXDATE
 S $P(^ECX(ECFILE,JJ,0),U,6,9)=ECXSSN_U_ECXPNM_U_ECXA_U_ECXDATE
 S STR=$S(ECXLOGIC<2005:ECXDIV,1:"")_U_ECXADMDT_U_ECXDCDT_U_ECXDSSI_U_ECPTTM_U_ECPTPR_U
 S STR=STR_U_ECCLAS,$P(^ECX(ECFILE,JJ,0),U,10,17)=STR,STR=""
 S $P(^ECX(ECFILE,JJ,0),U,18,20)=ECXPRV_U_U_ECXPRCLS
 S $P(^ECX(ECFILE,JJ,0),U,23,24)=ECXSCNUM_U_ECXSCNAM
 S $P(^ECX(ECFILE,JJ,0),U,27,29)=ECXATT_U_ECXWPRV_U
 I '$D(^ECX(ECFILE,JJ,1)) S ^ECX(727.812,JJ,1)="^^^^^"
 S $P(^ECX(ECFILE,JJ,1),U,1,4)=ECXMPI_U_ECASPR_U_U_ECCLAS2
 S STR=ECXPHI_U_ECXDOM_U_ECXCAT_U_ECXSTAT_U_$S(ECXLOGIC<2005:ECXPRIOR,1:"")_U_ECXPOS_U
 S STR=STR_ECXOBS_U_ECXENC_U_ECXAOL_U_ECXDOB_U_ECXPDIV_U_ECXDEPT_U
 S STR=STR_ECXHNCI_U_ECXETH_U_ECXRC1_U
 I ECXLOGIC>2004 S STR=STR_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U_ECXDIV_U_ECXPTYPE_U_ECXCVE_U_ECXCVEDT_U_ECXCVENC_U_ECXNPRFI
 I ECXLOGIC>2005 S STR=STR_U_ECXATTPC_U_ECXWPRPC
 S $P(^ECX(ECFILE,JJ,1),U,8,22)=STR
 I ECXLOGIC>2006 S $P(^ECX(ECFILE,JJ,1),U,34)=ECXAST_U
 I ECXLOGIC>2007 S $P(^ECX(ECFILE,JJ,1),U,35)=ECASNPI_U_ECATTNPI_U_ECPTNPI_U D
 . S ^ECX(ECFILE,JJ,2)=ECPRNPI_U_ECWPRNPI
 S DA=JJ,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 S ECRN=ECRN+1
 I $D(ZTQUEUED),$$S^%ZTLOAD S QFLG=1
 Q
 ;
SETUP ;Set required input for ECXTRAC
 S ECHEAD="MTL"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
 ;
QUE ;Entry point for the background requeuing handled by ECXTAUTO.
 D SETUP,QUE^ECXTAUTO,^ECXKILL
 Q
