ECXNUT ;ALB/JRC Nutrition DSS Extract ; 10/31/08 1:57pm
 ;;3.0;DSS EXTRACTS;**92,107,105,112,120,127**;Dec 22, 1997;Build 36
BEG ;entry point from option
 N EC23,EC7,ECED,ECFILE,ECGRP,ECHEAD,ECINST,ECPACK,ECPIECE,ECRN,ECRTN,ECSD1,ECVER,ECXYM
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 ;Init variables
 N ECSD,ARRAY
 S ECED=ECED+.3,ECSD=ECSD1,ARRAY="^TMP($J,""FH"")"
 K @ARRAY
 ;
 ;Call n&fs api and store in ^TMP($J,"FH" global
 D DATA^FHDSSAPI(ECSD,ECED)
 ;
 ;Get n&fs records from ^TMP($J,"FH" global and file
 D GETMEALS^ECXNUT1
 ;
 ;kill ^tmp global
 K @ARRAY
 ;
 Q
 ;
GET ;gather extract data
 ;Init variables
 N ECXORDPC,ECXSSN,ECXPNM,ECXSEX,ECXDOB,ECXMPI,ECXRC1,ECXETH,ECXVET,ECXENRL,ECXELIG,ECXMST,ECXPST,ECXPLOC,ECXPHI,ECXMNS,ECXSTATE,ECXCNTY,ECXZIP,ECXPOS,ECXAST,ECXAOL,ECXRST,ECXEST,ECXTM,ECXDATE,ECXMN,ECXSPC
 N ECXADMDT,ECXWRD,ECXFAC,ECXPRV,ECXPRNPI,ECXATT,ECXATNPI,ECXDOM,ECXATTPC,ECXPRVPC,ECXPDIV,ECXCBOC,ECPTPR,ECCLASS,ECPTTM,ECXOBS,ECXHNCI,ECXNPRFI,ECXERI,ECXENC,ECPAT,ECXERR,ADM,W,X,ECXCAT,ECXCVE,ECXPRIOR,ECXPTYPE,ECXSTAT,ECXUESTA,ECXA,ECORNPI
 N ECXOEF,ECXOEFDT,ECXCNTRY
 ;
 ;- Prefix ordering pro with a 2 and get person class
 S ECXORDPC=$$PRVCLASS^ECXUTL(+ECXORDPH,DATE)
 S ECORNPI=$$NPI^XUSNPI("Individual_ID",+ECXORDPH,DATE)
 S:+ECORNPI'>0 ECORNPI="" S ECORNPI=$P(ECORNPI,U)
 S ECXORDPH=$S(ECXORDPH:2_ECXORDPH,1:"")
 ;
 ;set patient file (#2) dfn and get patient demographics
 S ECXDFN=$P($G(^TMP($J,"FH","ZN",FHDFN)),U,3)
 S ECXERR=0 D PAT(ECXDFN)
 Q:ECXERR
 ;Set demographic variables
 S ECXSSN=ECPAT("SSN"),ECXPNM=ECPAT("NAME"),ECXSEX=ECPAT("SEX"),ECXDOB=ECPAT("DOB"),ECXMPI=ECPAT("MPI"),ECXRC1=ECPAT("RACE1"),ECXETH=ECPAT("ETHNIC"),ECXVET=ECPAT("VET"),ECXENRL=ECPAT("ENROLL LOC"),ECXELIG=ECPAT("ELIG")
 S ECXMST=ECPAT("MST STAT"),ECXPST=ECPAT("POW STAT"),ECXPLOC=ECPAT("POW LOC"),ECXPHI=ECPAT("PHI"),ECXMNS=ECPAT("MEANS"),ECXSTATE=ECPAT("STATE"),ECXCNTY=ECPAT("COUNTY"),ECXZIP=ECPAT("ZIP")
 S ECXCNTRY=ECPAT("COUNTRY")
 S ECXPOS=ECPAT("POS"),ECXAST=ECPAT("AO STAT"),ECXAOL=ECPAT("AOL"),ECXRST=ECPAT("IR STAT"),ECXEST=ECPAT("EC STAT")
 ;
 ;Get oef/oif data
 S ECXOEF=ECPAT("ECXOEF")
 S ECXOEFDT=ECPAT("ECXOEFDT")
 ;
 ;Get enrollment status
 I $$ENROLLM^ECXUTL2(ECXDFN)
 ;
 S ECXTM=$$ECXTIME^ECXUTL(DATE)
 S ECXDATE=$$ECXDATE^ECXUTL(+DATE,ECXYM)
 ;
 ;- Use movement record date & time
 S ADM=$$INP^ECXUTL2(ECXDFN,DATE),ECXA=$P(ADM,U)
 I $G(P)="INP",$G(ECXA)'="I" Q
 S ECXMN=$P(ADM,U,2),ECXSPC=$P(ADM,U,3),ECXADMDT=$P(ADM,U,4)
 S W=$P(ADM,U,9),ECXWRD=$P(W,";",1),ECXFAC=$P(W,";",2)
 S ECXPRV=$P(ADM,U,7),ECXPRNPI="",ECXATT=$P(ADM,U,8),ECXATNPI=""
 S ECXDOM=$P(ADM,U,10),ECXATTPC=$P(ADM,U,12),ECXPRVPC=$P(ADM,U,11)
 ;
 S ECXPDIV=$$GETDIV^ECXDEPT(ECXFAC)  ;Get production division
 S ECXCBOC=$$CBOC^ECXSCX2(+ECXFAC) ;Get cboc facility
 ;
 ;- Get primary care data
 S X=$$PRIMARY^ECXUTL2(ECXDFN,DATE)
 S ECPTPR=$P(X,U,2),ECCLASS=$P(X,U,3),ECPTTM=$P(X,U),ECPTNPI=$P(X,U,4)
 ;
 ;- Observation patient indicator (YES/NO)
 S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXSPC)
 ;
 ;- Get head and neck cancer indicator
 S ECXHNCI=$$HNCI^ECXUTL4(ECXDFN)
 ;
 ;- Get shad indicator
 S ECXSHADI=$$SHAD^ECXUTL4(ECXDFN)
 ;
 ;- Get national patient record flag indicator
 N ECXNPRFI D NPRF^ECXUTL5
 ;
 ;- National response indicator
 S ECXERI=$$EMGRES^DGUTL(ECXDFN)
 ;  
 ; ******* - PATCH 127, ADD PATCAT CODE ********
 S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ;
 ;- If null encounter number, don't file record
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,DATE,ECXSPC,ECXOBS,ECHEAD,,)
 D:ECXENC'="" FILE
 Q
 ;
PAT(ECXDFN) ;get/set patient data
 ; INPUT - ECXDFN = patient ien (DFN)
 ; OUTPUT - ECPAT array:
 ;          ECPAT("SSN")
 ;          ECPAT("NAME")
 ; returns 0 or 1 in ECXERR - 0=successful
 ;                            1=error condition
 N X,OK
 ;get data
 S ECXERR=0
 K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,"","1;2;3;5",.ECPAT)
 I 'OK S ECXERR=1
 Q ECXERR
 ;
FILE ;file the n&fs extract record
 ;node
 ;facility^dfn^ssn^name^in/out^day^time^treating specialty^
 ;ordering provider^ordering provider person class^primary 
 ;care provider^primary person class^primary care team^mpi^dob^sex^
 ;race 1^ethnicity^veteran^enrollment status^enrollment location^
 ;enrollment category^enrollment priority^eligibility^period of
 ;service^agent orange status^agent orange location^radiation status
 ;^environmental contaminants^mst status^head & neck cancer indicator
 ;pow status^pow location^purple heart indicator^means test^state code
 ;^county code^zip+4^observation patient indicator^rrtp,prrtp and
 ;saartp indicator^encounter number^patient division^food production
 ;division^delivery division^product feeder key^food production
 ;facility^delivery location type^delivery feeder location^quantity^
 ;cboc^status^user enrollee^patient type^cv status eligibility^
 ;national patient record flag^emergency response indicator^admission
 ;date^oef/oif ECXOEF^oef/oif return date ECXOEFDT^ordering provider
 ;npi ECORNPI^primary care provider npi ECPTNPI^country ECXCNTRY^
 ;shad indicator ECXSHADI
 ;patient category ECXPATCAT
 ;
 N DA,DIK,ECODE,ECODE1
 S EC7=$O(^ECX(ECFILE,999999999),-1),EC7=EC7+1
 S ECODE=EC7_U_EC23_U_ECINST_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 ;
 ;convert specialty to PTF Code
 ;
 N ECXDATA
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXSPC,.ECXDATA)
 S ECXSPC=$G(ECXDATA(7))
 ;
 S ECODE=ECODE_ECXDATE_U_ECXTM_U_ECXSPC_U_ECXORDPH_U_ECXORDPC_U
 S ECODE=ECODE_ECPTPR_U_ECCLASS_U_ECPTTM_U_ECXMPI_U_ECXDOB_U_ECXSEX_U
 S ECODE=ECODE_ECXRC1_U_ECXETH_U_ECXVET_U_ECXSTAT_U_ECXENRL_U_ECXCAT_U
 S ECODE=ECODE_ECXPRIOR_U_ECXELIG_U_ECXPOS_U_ECXAST_U_ECXAOL_U_ECXRST
 S ECODE=ECODE_U_ECXEST_U_ECXMST_U_ECXHNCI_U_ECXPST_U_ECXPLOC_U_ECXPHI
 S ECODE=ECODE_U_ECXMNS_U_ECXSTATE_U_ECXCNTY_U
 S ECODE1=ECXZIP_U_ECXOBS_U_ECXDOM_U_ECXENC_U_ECXPDIV_U_ECXFPD_U
 S ECODE1=ECODE1_ECXFDD_U_ECXKEY_U_ECXFPF_U_ECXDLT_U_ECXDFL_U_ECXQTY_U
 S ECODE1=ECODE1_ECXCBOC_U_ECXUESTA_U_ECXPTYPE_U_ECXCVE_U_ECXNPRFI_U
 S ECODE1=ECODE1_ECXERI_U_$S(ECXADMDT:$$ECXDATE^ECXUTL(ECXADMDT,ECXYM),1:"")
 I ECXLOGIC>2007 S ECODE1=ECODE1_U_ECXOEF_U_ECXOEFDT_U_$G(ECXTFU)_U_ECORNPI_U_ECPTNPI
 I ECXLOGIC>2009 S ECODE1=ECODE1_U_ECXCNTRY
 I ECXLOGIC>2010 S ECODE1=ECODE1_U_ECXSHADI_U_ECXPATCAT
 S ^ECX(ECFILE,EC7,0)=ECODE,^ECX(ECFILE,EC7,1)=ECODE1
 S ECRN=ECRN+1
 S DA=EC7,DIK="^ECX("_ECFILE_"," D IX1^DIK K DIK,DA
 Q
 ;
SETUP ;Set required input for ECXTRAC.
 S ECHEAD="NUT"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
