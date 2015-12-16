ECXUTL2 ;ALB/JAP - Utilities for DSS Extracts (cont.) ;2/6/15  12:02
 ;;3.0;DSS EXTRACTS;**8,13,23,24,33,35,39,46,71,84,92,105,112,120,127,144,149,154**;Dec 22, 1997;Build 13
 ;
ECXDEF(ECXHEAD,ECXPACK,ECXGRP,ECXFILE,ECXRTN,ECXPIECE,ECXVER) ;variables specific to extract from file #727.1
 ;   input 
 ;   ECXHEAD = extract header code
 ;   all other formal list parameters passed by reference
 ;   output
 ;   ECXPACK = type field (#7)
 ;   ECXGRP  = group field (#9)
 ;   ECXFILE = file number field (#1)
 ;   ECXRTN  = routine field (#4)
 ;   ECXPIECE= running piece field (#11)
 ;   ECXVER  = dss version
 N ECXIEN,ECXARR,DIC,DA,DR,DIQ
 S (ECXPACK,ECXGRP,ECXFILE,ECXRTN,ECXPIECE,ECXVER)="",ECXIEN=0
 S ECXIEN=+$O(^ECX(727.1,"C",ECXHEAD,ECXIEN))
 I ECXIEN=0 D  Q
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" It appears that you may have a problem with File #727.1 --")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" The "_ECHEAD_" Extract is not properly defined.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" Contact National VISTA Support for further assistance.")
 .D MES^XPDUTL(" ")
 .I $E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" W ! D ^DIR K DIR
 .W !!
 S DIC="^ECX(727.1,",DA=ECXIEN,DR=".01;1;4;7;9;11;13",DIQ="ECXARR"
 D EN^DIQ1
 S ECXPACK=ECXARR(727.1,ECXIEN,7)
 ;if this is an inactive extract type, skip it unless building for audit 
 I ECXARR(727.1,ECXIEN,13)="YES" I '+$G(ECXAUDIT) D  Q  ;154, allow extract to run if for audit purposes (ECXAUDIT=1 if coming from audit report)
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" The "_ECHEAD_" Extract is no longer active/valid.")
 .D MES^XPDUTL(" ")
 .D MES^XPDUTL(" Contact National VISTA Support for further assistance.")
 .D MES^XPDUTL(" ")
 .I $E(IOST)="C" D
 ..S SS=22-$Y F JJ=1:1:SS W !
 ..S DIR(0)="E" W ! D ^DIR K DIR
 .W !!
 S ECXGRP=ECXARR(727.1,ECXIEN,9)
 S ECXFILE=ECXARR(727.1,ECXIEN,1)
 S ECXRTN="START^"_ECXARR(727.1,ECXIEN,4)
 S ECXPIECE=ECXARR(727.1,ECXIEN,11)
 ;version of dss/tsi in Austin as specified by btso
 S ECXVER=7
 Q
PATDEM(DFN,DT1,PAR,FLG) ; determine patient information
 ;  DFN   =
 ;  DT    =
 ;  PAR   =
 ;  FLG   =
 N DT2,PAT,OK,X
 D KPATDEM
 S FLG=$G(FLG),PAR=$S($D(PAR):PAR,1:"1;2;3;4;5;"),DT2=$P(DT1,".")
 Q:'$$PAT^ECXUTL3(DFN,DT2,PAR,.PAT) 0
 S ECXMPI=PAT("MPI")
 I PAR["1" D
 .S ECXSSN=PAT("SSN"),ECXPNM=PAT("NAME"),ECXDOB=PAT("DOB")
 .S ECXSEX=PAT("SEX"),ECXREL=PAT("RELIGION"),ECXRACE=PAT("RACE")
 .S ECXMAR=PAT("MARITAL")
 .S ECXETH=PAT("ETHNIC"),ECXRC1=PAT("RACE1")
 I PAR["2" D
 .S ECXCNTY=PAT("COUNTY"),ECXSTATE=PAT("STATE"),ECXZIP=PAT("ZIP")
 .S ECXCNTRY=PAT("COUNTRY")
 I PAR["3" D
 .S ECXPOS=PAT("POS"),ECSC=PAT("SC STAT"),ECXSVC=PAT("SC%")
 .S ECXVET=PAT("VET"),ECXMEAN=PAT("MEANS"),ECXELIG=PAT("ELIG")
 .S ECXENRL=PAT("ENROLL LOC")
 .S ECXERI=PAT("ERI")
 I PAR["4" S ECXEMP=PAT("EMPLOY")
 I PAR["5" D
 .S ECXVIET=PAT("VIETNAM"),ECXAST=PAT("AO STAT"),ECXRST=PAT("IR STAT")
 .S ECXEST=PAT("EC STAT"),ECXPST=PAT("POW STAT"),ECXPLOC=PAT("POW LOC")
 .S ECXPHI=PAT("PHI"),ECXMST=PAT("MST STAT"),ECXAOL=PAT("AOL")
 .S ECXOEF=PAT("ECXOEF"),ECXOEFDT=PAT("ECXOEFDT")
 .S ECXCLST=PAT("CL STAT") ;144 Camp Lejeune Status
 .S ECXSVCI=PAT("COMBSVCI") ;149 COMBAT SVC IND
 .S ECXSVCL=PAT("COMBSVCL") ;149 COMBAT SVC LOC
 I PAR["6" D
 .S (ECXPAYOR,ECXSAI)="" D VISN19(DFN,.ECXPAYOR,.ECXSAI)
 I FLG'[3 D
 .S X=$$PRIMARY(DFN,DT2),ECPTTM=$P(X,U),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3)
 .S ECPTNPI=$P(X,U,4),ECASPR=$P(X,U,5),ECCLAS2=$P(X,U,6)
 .S ECASNPI=$P(X,U,7)
 I FLG'[2 D
 .S ECXINP=$$INP^ECXUTL2(DFN,DT1),ECXA=$P(ECXINP,U),ECXMN=$P(ECXINP,U,2)
 .S ECXTS=$P(ECXINP,U,3),ECXDOM=$P(ECXINP,U,10),ECXADMDT=$P(ECXINP,U,4)
 I FLG'[1 S X=$$ENROLLM(DFN)
 Q 1
 ;
KPATDEM ;
 K ECXADMDT,ECAO,ECASNPI,ECASPR,ECCLAS,ECCLAS2,ECENV,ECPTNPI,ECPTPR,ECPTTM
 K ECRE,ECSC,ECXA,ECXAST,ECXCAT,ECXCNTY,ECXEST,ECXENRL,ECXDOB
 K ECXDOM,ECXELIG,ECXINP,ECXMPI,ECXMN,ECXNM,ECXPHI,ECXPLOC,ECXMEAN,ECXMST
 K ECXPAYOR,ECXPNM,ECXPOS,ECXPRIOR,ECXPST,ECXRACE,ECXREL,ECXRST,ECXSAI
 K ECXSEX,ECXSSN,ECXSTAT,ECXSTATE,ECXSVC,ECXTS,ECXVIET,ECXZIP,VA,VAERR
 K ECXSBGRP,ECXSVCI,ECXSVCL ;149
 Q
ENROLLM(DFN,RNDT) ;determines enrollment status, category, priority
 ;and user enrollee status
 ; input
 ;    DFN      = IEN from Patient file (Required)
 ;    RNDT     = Extract Run Date
 ; output
 ;    ECXSTAT  = Enrollment status
 ;    ECXPRIOR = Enrollment priority
 ;    ECXCAT   = Enrollment priority
 ;    ECXSBGRP = Enrollment subgroup
 ;    ECXUESTA = User enrollee
 ;    return value 0 if no data found, 1 if data found
 N CAT,PRIOR,STAT,X,X1,X2,X3,ENRIEN,ENR,FL,SBGRP
 S (ECXCAT,ECXPRIOR,ECXSTAT,ECXSBGRP,ECXEUSTA)=""
 I $G(DFN)="" Q 0
 ;User enrollee status, if current or future date set to 'U'
 ;DBIA #3989
 S ECXUESTA=$S($$UESTAT^EASUER(DFN):"U",1:"")
 ;Patient type
 S ECXPTYPE=$$TYPE^ECXUTL5(DFN)
 ;Combat Veteran Status DBIA #4156
 S X3=$$CVEDT^ECXUTL5(DFN,$S($G(ECD):ECD,$G(ECXDATE):ECXDATE,1:DT))
 ;enrollment priority DBIA
 S STAT=$$STATUS^DGENA(DFN),PRIOR=$$PRIORITY^DGENA(DFN)
 S CAT=$$CATEGORY^DGENA4(DFN,STAT),SBGRP=$$ENRSBGRP^DGENA4(DFN)
 ;find current enrollment when status=2 or 19
 I "^2^19^"[("^"_STAT_"^") S ECXSTAT=STAT,ECXPRIOR=PRIOR,ECXCAT=CAT,ECXSBGRP=$S(SBGRP=1:"a",SBGRP=3:"c",SBGRP=5:"e",SBGRP=7:"g",1:"") Q 1
 ;find previous enrollment
 S ENRIEN=$$FINDCUR^DGENA(DFN) I ENRIEN="" Q 0
 I $G(RNDT)="" D NOW^%DTC S RNDT=X
 S RNDT=($E(RNDT,1,3)-1)_$E(RNDT,4,7),FL=0
 F  S ENRIEN=$$FINDPRI^DGENA(ENRIEN) Q:'ENRIEN  D  Q:FL
 . S ENR=$$GET^DGENA(ENRIEN,.ENR)
 . I "^2^19^"[("^"_$G(ENR("STATUS"))_"^"),$G(ENR("EFFDATE"))>RNDT D
 . . S ECXSTAT=$G(ENR("STATUS")),ECXPRIOR=PRIOR,FL=1
 . . S ECXCAT=$$CATEGORY^DGENA4(DFN,ECXSTAT)
 . . S ECXSBGRP=$$ENRSBGRP^DGENA4(DFN)
 . . S ECXSBGRP=$S(SBGRP=1:"a",SBGRP=3:"c",SBGRP=5:"e",SBGRP=7:"g",1:"")
 I FL Q 1
 ;no enrollment status found =2 or 19
 S ECXSTAT=STAT,ECXPRIOR=PRIOR,ECXCAT=CAT,ECXSBGRP=$S(SBGRP=1:"a",SBGRP=3:"c",SBGRP=5:"e",SBGRP=7:"g",1:"")
 Q 1
PRIMARY(ECXDFN,ECXDATE,ECXPREFX) ;determine patient's pc team and pc provider
 ; input
 ; ECXDFN    = file #2 ien (required)
 ; ECXDATE   = date of interest (required)
 ; ECXPREFX  = prefix for provider data (optional)
 ;             defaults to "2" if not specified otherwise
 ; output
 ; ECXPRIME  = pc team ien^prefix_pc provider ien^pc provider person
 ;class^pc provider npi^prefix_assoc pc provider ien^assoc pc provider
 ;person class^assoc pc provider npi
 N ECPTTM,ECPTPR,ECCLAS,ECPRIME,ECASPR,ECCLAS2
 S:'$D(ECXPREFX) ECXPREFX=2 S:(+ECXPREFX=0) ECXPREFX=2
 ;get pc team data
 S ECPTTM=+$$OUTPTTM^SDUTL3(ECXDFN,ECXDATE) S:ECPTTM=0 ECPTTM=""
 ;get primary pc provider data
 S ECPTPR=+$$OUTPTPR^SDUTL3(ECXDFN,ECXDATE)
 S ECCLAS="" I ECPTPR>0 S ECCLAS=$$PRVCLASS^ECXUTL(ECPTPR,ECXDATE)
 N ECXUSRTN S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECPTPR,ECXDATE)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECPTNPI=$P(ECXUSRTN,U)
 S:ECPTPR=0 ECPTPR="" S:ECPTPR]"" ECPTPR=ECXPREFX_ECPTPR
 ;assoc pc provider call ok if routine scapmca from patch177 is present
 S ECASPR=""
 S X="SCAPMCA" X ^%ZOSF("TEST") I $T D
 .S ECASPR=+$$OUTPTAP^SDUTL3(ECXDFN,ECXDATE)
 S ECCLAS2="" I ECASPR>0 S ECCLAS2=$$PRVCLASS^ECXUTL(ECASPR,ECXDATE)
 N ECXUSRTN S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECASPR,ECXDATE)
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECASNPI=$P(ECXUSRTN,U)
 S:ECASPR=0 ECASPR="" S:ECASPR]"" ECASPR=ECXPREFX_ECASPR
 ;assemble
 S ECXPRIME=ECPTTM_U_ECPTPR_U_ECCLAS_U_ECPTNPI_U_ECASPR_U_ECCLAS2_U_ECASNPI
 Q ECXPRIME
INP(ECXDFN,ECXDATE) ; check for inpatient status
 ; input
 ; ECXDFN  = file #2 ien (required)
 ; ECXDATE = date of interest (required)
 ; output
 ; ECXINP  = patient status^movment # (file #405 ien)
 ;       current treat. spec. (file #42.4 ien)^admission date/time^
 ;       current ward (file #42 ien)^discharge date/time^
 ;       ward provider^attending phys.^ward (file #44 ien);facility
 ;       (file #40.8 ien);dss dept^dom
 ;           where patient status = I for inpatient
 ;                                = O for outpatient
 N DFN,DSSDEPT,ECA,ECADM,ECMN,ECTS,ECWARD,ECDC,ECXINP,ECXPRO
 N ECXATP,ECXDD,ECXDOM,ECXPROF,ECXPWP,ECXWW,FAC,VAIP,WRD,ECXPWPPC
 N ECXATPPC
 D FIELD^DID(405,.19,,"SPECIFIER","ECXDD")
 S ECXPROF=$E(+$P(ECXDD("SPECIFIER"),"P",2)) K ECXDD
 ;- Inpat/outpat indicator (ECA) initially set to "O" (outpatient)
 S DFN=ECXDFN,ECA="O"
 S (DSSDEPT,ECMN,ECTS,ECADM,ECWARD,ECDC,ECXATP,ECXPWP,ECXWW,WRD,FAC,ECXPWPPC,ECXATPPC)=""
 S VAIP("D")=ECXDATE D IN5^VADPT
 S ECMN=$G(VAIP(1))
 I ECMN D
 .S ECTS=+$P($G(^DIC(45.7,+VAIP(8),0)),U,2) S:ECTS=0 ECTS=""
 .;- Get inpat/outpat indicator
 .S ECA=$$INOUTP^ECXUTL4(ECTS)
 .S ECADM=+$G(VAIP(13,1)) S:ECADM=0 ECADM=""
 .S ECWARD=+$G(VAIP(5)) S:ECWARD=0 ECWARD=""
 .I ECWARD D
 ..S WRD=+$P($G(^DIC(42,+ECWARD,44)),U)
 ..S FAC=$P($G(^DIC(42,+ECWARD,0)),U,11)
 ..S DSSDEPT=$P($G(^ECX(727.4,ECWARD,0)),U,2)
 .S ECXWW=WRD_";"_FAC_";"_DSSDEPT,ECDC=+$G(VAIP(17,1)) S:ECDC=0 ECDC=""
 .S ECXPWP=+VAIP(7) S:ECXPWP=0 ECXPWP=""
 .S ECXATP=+VAIP(18) S:ECXATP=0 ECXATP=""
 .S ECXPWPPC=$$PRVCLASS^ECXUTL(ECXPWP,ECADM)
 .S ECXATPPC=$$PRVCLASS^ECXUTL(ECXATP,ECADM)
 .;prefix file #200 iens
 .S:ECXPWP ECXPWP=ECXPROF_ECXPWP S:ECXATP ECXATP=ECXPROF_ECXATP
 S ECXDOM=$P($G(^ECX(727.831,+ECTS,0)),U,2)
 S ECXINP=ECA_U_ECMN_U_ECTS_U_ECADM_U_ECWARD_U_ECDC_U_ECXPWP_U_ECXATP_U_ECXWW_U_ECXDOM_U_ECXPWPPC_U_ECXATPPC
 Q ECXINP
VISN19(ECXDFN,ECXPAYOR,ECXSAI) ;visn 19 sharing agreement data
 ; input  ECXDFN = patient file ien
 ; output ECXPAYOR, ECXSAI (passed by reference)
 N JJ,ALIAS,INSUR,DIC,DIQ,DA,DR,ECXARY,ECXERR,ECXDA
 S (ECXPAYOR,ECXSAI)=""
 D GETS^DIQ(2,ECXDFN,"1*,","I","ECXARY","ECXERR")
 I $D(ECXERR) Q
 S JJ=0 F  S JJ=$O(ECXARY(2.01,JJ)) Q:JJ=""  D  I ECXPAYOR]"" Q
 . S ALIAS=$G(ECXARY(2.01,JJ,.01,"I"))
 . S ECXPAYOR=$S(ALIAS="SHARING AGREEMENT":"A",ALIAS="TRICARE":"B",ALIAS="CAT C":"C",ALIAS="CATEGORY C":"C",ALIAS="CHAMPVA":"D",ALIAS="CHAMPUS":"E",1:"")
 . W !,$G(CNT)+1
 . W !,"The value of ECXPAYOR is: ",ECXPAYOR
 ;K ECXARY,ECXERR
 I ECXPAYOR]"" D GETS^DIQ(2,ECXDFN,".3121*,","I","ECXARY","ECXERR") D
 . I $D(ECXERR) Q
 . S JJ=0,ECXDA=$O(ECXARY(2.312,JJ)) I ECXDA="" Q
 . S DA=$G(ECXARY(2.312,ECXDA,.01,"I")) I DA="" Q
 . S INSUR=$$GET1^DIQ(36,DA,".01","I","","ECXERR")
 . I '$D(ECXERR) S ECXSAI=$E(ECXARY(2.312,ECXDA,.01,"I"),1,11)
 Q
