ECXBCM ;ALB/JAP-Bar Code Medical Administration Extract ;12/4/15  10:46
 ;;3.0;DSS EXTRACTS;**107,127,132,136,143,144,148,149,154,160**;Dec 22, 1997 ;Build 1
 ;
BEG ;entry point from option
 ;ECFILE=^ECX(727.833,
 D SETUP I ECFILE="" Q
 D ^ECXTRAC,^ECXKILL
 Q
 ;
START ; start package specific extract
 ; 
 N ECXVAP,RERUN,ECXLDT ;143,154
 S RERUN=0,ECXLDT=+$P($G(^ECX(728,1,ECNODE)),U,ECPIECE) I ECXLDT'<ECSD S RERUN=1 ;154 If re-running date range, set RERUN to 1, 160 added ^ to global reference
 S ECED=ECED+.3,ECD=ECSD1
 S PIEN=0
 I $G(ECSD)="" S ECSD=DT
 ; loop thru and get each new patient, reset the start date to ECSD - begin date from ECXTRAC
 F  S PIEN=$O(^PSB(53.79,"AADT",PIEN)) Q:('PIEN)  S IDAT=ECSD D
 .F  S IDAT=$O(^PSB(53.79,"AADT",PIEN,IDAT)) Q:'IDAT!(IDAT>ECED)  S RIEN="" D
 ..F  S RIEN=$O(^PSB(53.79,"AADT",PIEN,IDAT,RIEN)) Q:'RIEN  D
 ...S ECXNOD=^PSB(53.79,RIEN,0) Q:'ECXNOD  S ECXDFN=$P($G(ECXNOD),U) D GET(ECSD,ECED)
 I 'RERUN D CLEAN(0,$$FMADD^XLFDT(ECSD,-180)) ;154 If not a rerun, clean out items given global
 Q
 ;
GET(ECSD,ECED) ;get extract data
 N ECXESC,ECXECL,ECXCLST ;144
 S (ACTDT,ECXADT,ECXAMED,ECXASTA,ECXATM,ECXORN,ECXORT,ECXOSC,ECPRO,PLACEHLD,ECXFAC,DRG,ECXESC,ECXECL,ECXCLST)="" ;144
 ; get needed YYYYDD variable
 I $G(ECXYM)="" S ECXYM=$$ECXYM^ECXUTL(DT)
 ;Get Facility
 I $G(ECXFAC)="" D
 .S ECXFAC=+$P(^ECX(728,1,0),U) K ECXDIC S DA=ECXFAC,DIC="^DIC(4,",DIQ(0)="I",DIQ="ECXDIC",DR=".01;99"
 .D EN^DIQ1 S ECXFAC=$G(ECXDIC(4,DA,99,"I")) K DIC,DIQ,DA,DR,ECXDIC
 ;
 S ECXORN=$$GET1^DIQ(53.79,RIEN,.11)
 ;get inpatient data
 S (ECXA,ECXMN,ECXADM,ECXTS,ECXW)=""
 S X=$$INP^ECXUTL2(ECXDFN,IDAT)
 S ECXA=$P(X,U),ECXMN=$P(X,U,2),ECXTS=$P(X,U,3),ECXADM=$P(X,U,4)
 S W=$P(X,U,9),ECXDOM=$P(X,U,10),ECXW=$P(W,";")
 ; Ordering Stop Code - based on Unit dose or IV
 I ECXORN["U" Q:$$CHKUD(ECXDFN,ECSD,ECED)  S:ECXA="O" ECXOSC=$$DOUDO^ECXUTL5(ECXDFN,+ECXORN)
 I ECXORN["V" Q:$$CHKIV(ECXDFN,ECSD,ECED)  S:ECXA="O" ECXOSC=$$DOIVPO^ECXUTL5(ECXDFN,+ECXORN)
 S ECXASTA=$$GET1^DIQ(53.79,RIEN,.09,"I")
 I "^G^S^C^I^"'[("^"_ECXASTA_"^") Q  ;160 process 'G'iven, 'S'topped,'C'ompleted,'I'nfusing
 ;get patient demographics
 S ECXERR=0 D PAT(ECXDFN,IDAT,.ECXERR) Q:ECXERR
 S ECPRO=$$ORDPROV^ECXUTL(ECXDFN,ECXORN,"")
 S ACTDT=$$GET1^DIQ(53.79,RIEN,.06,"I")
 I ACTDT'=IDAT Q
 S ECXADT=$$ECXDATE^ECXUTL(ACTDT,ECXYM)
 S ECXATM=$$ECXTIME^ECXUTL(ACTDT)
 S ECXORT=$P($G(^TMP("PSJ",$J,1)),U,3) K ^TMP("PSJ",$J)
 S ECPROPC=$P($$GET^XUA4A72(ECPRO,$P(ACTDT,".")),U,7)
 N ECXUSRTN
 S ECXUSRTN=$$NPI^XUSNPI("Individual_ID",ECPRO,$P(ACTDT,"."))
 S:+ECXUSRTN'>0 ECXUSRTN="" S ECPRONPI=$P(ECXUSRTN,U)
 S ECXAMED=$$GET1^DIQ(53.79,RIEN,.08,"I")
 ;Component code data
 D CCODE(RIEN)
 Q
 ;
CMPT ; during component/sequence processing, retrieve rest of data record then file it.
 S (ECXSCADT,ECXOS,ECXIVID,ECXIR,SCADT,ECXSCADT,ECXSCATM,DRUG,ECVNDC,ECINV,ECVACL,ECXVAP)="" ;143
 I $G(DRG) D
 .S DRUG=$$PHAAPI^ECXUTL5(DRG)
 .S ECVNDC=$P(DRUG,U,3)
 .S ECINV=$P(DRUG,U,4)
 .I ECXLOGIC<2014 D
 ..S ECINV=$S(ECINV["I":"I",1:"")
 .;New way to calculate cost dea spl hndlg **144
 .I ECXLOGIC>2013 D
 ..S ECINV=$S((+ECINV>0)&(+ECINV<6):+ECINV,ECINV["I":"I",1:"")
 .S ECVACL=$P(DRUG,U,2)
 .S ECXVAP=$P(DRUG,U,6) ;143 set ECXVAP to VA PRODUCT IEN
 S SCADT=$$GET1^DIQ(53.79,RIEN,.13,"I")
 S ECXSCADT=$$ECXDATE^ECXUTL(SCADT,ECXYM)
 S ECXSCATM=$$ECXTIME^ECXUTL(SCADT)
 S ECXOS=$$GET1^DIQ(53.79,RIEN,.12,"I")
 S ECXIVID=$$GET1^DIQ(53.79,RIEN,.26)
 S ECXIR=$$GET1^DIQ(53.79,RIEN,.35)
 S ECXDIV=$$RADDIV^ECXDEPT($$GET1^DIQ(53.79,RIEN,.03,"I"))
 S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS)
 S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADM,ACTDT,ECXTS,ECXOBS,ECHEAD,,)
 D:ECXENC'="" FILE^ECXBCM1 ;154 Moved filing task for space considerations
 Q
 ;
PAT(ECXDFN,ECXDATE,ECXERR)  ;get patient demographics, primary care, and inpatient data
 N X
 S (ECXCAT,ECXSTAT,ECXPRIOR,ECXSBGRP,ECXOEF,ECXOEFDT)=""
 ;get patient data
 K ECXPAT S OK=$$PAT^ECXUTL3(ECXDFN,$P(ECXDATE,"."),"1;2;3;5",.ECXPAT)
 I 'OK K ECXPAT S ECXERR=1 Q
 S ECXPNM=ECXPAT("NAME")
 S ECXSSN=ECXPAT("SSN")
 S ECXMPI=ECXPAT("MPI")
 S ECXDOB=ECXPAT("DOB")
 S ECXELIG=ECXPAT("ELIG")
 S ECXSEX=ECXPAT("SEX")
 S ECXSTATE=ECXPAT("STATE")
 S ECXCNTY=ECXPAT("COUNTY")
 S ECXZIP=ECXPAT("ZIP")
 S ECXVET=ECXPAT("VET")
 S ECXCNTRY=ECXPAT("COUNTRY")
 S ECXPOS=ECXPAT("POS")
 S ECXPST=ECXPAT("POW STAT")
 S ECXPLOC=ECXPAT("POW LOC")
 S ECXRST=ECXPAT("IR STAT")
 S ECXAST=ECXPAT("AO STAT")
 S ECXAOL=ECXPAT("AOL")
 S ECXPHI=ECXPAT("PHI")
 S ECXMST=ECXPAT("MST STAT")
 S ECXENRL=ECXPAT("ENROLL LOC")
 S ECXMTST=ECXPAT("MEANS")
 S ECXEST=ECXPAT("EC STAT")
 S ECXCLST=ECXPAT("CL STAT") ;144 Camp Lejeune status
 S ECXSVCI=ECXPAT("COMBSVCI") ;149 COMBAT SVC IND
 S ECXSVCL=ECXPAT("COMBSVCL") ;149 COMBAT SVC LOC
 S ECXCNHU=$$CNHSTAT^ECXUTL4(ECXDFN) S ECXCNHU=$S(ECXCNHU'="":$E(ECXCNHU,1),1:"") ;get CNHU status
 ;get enrollment data (category, status and priority)
 I $$ENROLLM^ECXUTL2(ECXDFN)
 S ECXHNCI=$$HNCI^ECXUTL4(ECXDFN)                  ; Head and Neck Cancer Indicator
 S ECXSHADI=$$SHAD^ECXUTL4(ECXDFN)                 ; PROJ 112/SHAD Indicator
 I ECXSHADI="U" S ECXSHADI=""                      ; If Shad comes back as "U" force to null
 S ECXETH=ECXPAT("ETHNIC"),ECXRC1=ECXPAT("RACE1")  ; Race and Ethnicity
 S ECXERI=ECXPAT("ERI")                            ; emergency response indicator (FEMA)
 S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)               ; PATCAT code / patch 127  
 S ECXOEF=ECXPAT("ECXOEF")
 S ECXOEFDT=ECXPAT("ECXOEFDT")
 ;
 ;get primary care data
 S X=$$PRIMARY^ECXUTL2(ECXDFN,$P(ECXDATE,"."))
 S ECPTTM=$P(X,U),ECPTPR=$P(X,U,2),ECCLAS=$P(X,U,3),ECPTNPI=$P(X,U,4)
 ;get national patient record flag, if it exists
 D NPRF^ECXUTL5     ; sets ECXNPRFI
 Q
 ;
CCODE(RIEN) ; get component information
 ;  input - IEN of the BCMA MEDICATION LOG File
 ; 
 ; output - CCIEN: pointer to a variable pointer field to file #50, #52.6, or #52.7
 ;          CCDORD: .02 field of file #50, #52.6, or #52.7
 ;          CCDGVN: .03 FIELD of file #50, #52.6, or #52.7
 ;          CCUNIT: .04 field of file #50, #52.6, or #52.7
 ;          CCTYPE: derived field, "D", "A", or "S"
 ;
 S (CCIEN,CCDORD,CCDGVN,CCUNIT,CCTYPE)=""
 F I=.5,.6,.7 D
 .I '$O(^PSB(53.79,RIEN,I,0)) Q
 .S J=0 F  S J=$O(^PSB(53.79,RIEN,I,J)) Q:'J  D
 ..S DATA=^PSB(53.79,RIEN,I,J,0)
 ..S (UNITCOST,ECXDRGC,ECXIVSC,ECXIVAC)=0 ;144 NEW COST FIELDS
 ..S CCIEN=$P(DATA,U),CCDORD=$P(DATA,U,2),CCDGVN=$S(+($P(DATA,U,3))>0:+($P(DATA,U,3)),1:1),CCUNIT=$S(+($P(DATA,U,4))>0:+($P(DATA,U,4)),1:1)
 ..I I=.5 D  ;144 New drug Cost Fields added
 ...S DRG=CCIEN,UNITCOST=$$GET1^DIQ(50,DRG,16,"I")
 ...S ECXDRGC=(CCDGVN*CCUNIT)*UNITCOST
 ..I I=.6 D  ;144 New IV Additive Cost Fields added
 ...S DRG=$$GET1^DIQ(52.6,CCIEN,1,"I"),UNITCOST=$$GET1^DIQ(52.6,CCIEN,7,"I")
 ...S ECXIVAC=CCDGVN*UNITCOST
 ..I I=.7 D  ;144 New IV Solution Cost Fields added
 ...S DRG=$$GET1^DIQ(52.7,CCIEN,1,"I"),UNITCOST=$$GET1^DIQ(52.7,CCIEN,7,"I")
 ...S ECXIVSC=CCDGVN*UNITCOST
 ..S CCTYPE=$S(I=.5:"D",I=.6:"A",I=.7:"S",1:"")
 ..S CCIEN=$S(I=.5:CCIEN_";PSDRUG(",I=.6:CCIEN_";PS(52.6,",I=.7:CCIEN_";PS(52.7,",1:"")
 ..S CCDGVN=$P(DATA,U,3) ;148 Reset component dose given to original value
 ..S CCUNIT=$P(DATA,U,4) ;148 Reset component unit to original value
 ..I ECXORN["U" I $$MULTI I '$$FIRST Q  ;154,160 If it's a unit dose type order and it's a multi-dose container, only count if it's the 1st administration
 ..D CMPT
 Q
 ;
CHKIV(ECXDFN,ECSD,ECED) ; Check file 728.113 for matching IV records 
 ;  input - ECXDFN   DFN of the patient from the BCMA file
 ;          ECSD:    Start Date for the extract 
 ;          ECED:    End Date for the extract 
 ; return - True     if the Order is in file 728.113  
 ;          False    if the Order is Not in file 728.113 
 ;
 N IVIEN,ORD,IVORN,ECD,EXTRACT,STDATE,ENDDATE
 S (ORD,ECD,STDATE,ENDDATE)=0
 S (IVORN,EXTRACT)=""
 I '$O(^ECX(728.113,0)) D     ; Check to see if data exists in the file, if not, recreate
 .S EXTRACT="IV"
 .S STDATE=$E($$FMADD^XLFDT(ECSD,-140),1,5)_"01"
 .S ENDDATE=ECED
 .D START^PSJDSS
 S IVORN=$P(ECXORN,"V")
 S ECD=$E($$FMADD^XLFDT(ECSD,-140),1,5)_"01"
 F  S ECD=$O(^ECX(728.113,"A",ECD)) Q:'ECD!(ECD>ECED)!(ORD=IVORN)  D
 .S ORD=0
 .F  S ORD=$O(^ECX(728.113,"A",ECD,ECXDFN,ORD)) Q:'ORD!(ORD=IVORN)
 I ORD=IVORN Q 1
 Q 0 ;Checks show order not in IV 728.113
 ;
CHKUD(ECXDFN,ECSD,ECED) ; Check file 728.904 for matching Unit dose records
 ;  input - ECXDFN   DFN of the patient from the BCMA file
 ;          ECSD:    Start Date for the extract 
 ;          ECED:    End Date for the extract 
 ; return - True     if the Order is in file 728.904
 ;          False    if the Order is Not in file 728.904
 ;
 N UDIEN,UDORN,ORD,EXTRACT,STDATE,ENDDATE
 S (ORD,STDATE,ENDDATE)=0
 S (UDORN,EXTRACT)=""
 I '$O(^ECX(728.904,0)) D    ; Check to see if data exists in the file, if not, recreate
 .S EXTRACT="UD"
 .S STDATE=$E($$FMADD^XLFDT(ECSD,-140),1,5)_"01"
 .S ENDDATE=ECED
 .D START^PSJDSS
 S UDORN=$P(ECXORN,"U")
 F  S ORD=$O(^ECX(728.904,"AO",ECXDFN,ORD)) Q:'ORD!(ORD=UDORN)
 I ORD=UDORN Q 1
 ;I $$GET1^DIQ(55.06,UDORN_","_ECXDFN,7,"I")="R" Q 1
 Q 0 ;Checks show order not in UD 728.904
 ;
FIRST() ;154 Section added to determine if this is the first administration of the medication since pharmacist verification
 N ALIEN,ADATE,FIRST,VDATE,DONE,IENS,ON
 S FIRST=0,VDATE="",DONE=0
 S ON=+ECXORN ;get numeric portion of order multiple IEN
 S ALIEN=0 F  S ALIEN=$O(^PS(55,ECXDFN,$S(ECXORN["U":5,1:"IV"),ON,$S(ECXORN["U":9,1:"A"),ALIEN)) Q:'+ALIEN!(DONE)  S IENS=ALIEN_","_ON_","_ECXDFN_"," D
 .S ADATE=$$GET1^DIQ($S(ECXORN["U":55.09,1:55.04),IENS,$S(ECXORN["U":".01",1:".05"),"I")
 .I ADATE>IDAT S DONE=1 Q  ;activity date is after administration date
 .I ECXORN["U" I "^VP^VPR^"[("^"_$$GET1^DIQ(55.09,IENS,"2:1")_"^") S VDATE=ADATE
 .I ECXORN["V" I $$GET1^DIQ(55.04,IENS,".04")="ORDER VERIFIED BY PHARMACIST" S VDATE=ADATE
 I VDATE'="" D
 .I '$D(^XTMP("ECXBCM",VDATE,ECXDFN,ECXORN))!($G(^XTMP("ECXBCM",VDATE,ECXDFN,ECXORN))=RIEN) S FIRST=1
 .I '$D(^XTMP("ECXBCM",VDATE,ECXDFN,ECXORN)) S ^XTMP("ECXBCM",VDATE,ECXDFN,ECXORN)=RIEN
 Q FIRST
 ;
CLEAN(START,END) ;154 Section added to delete old log entries
 N DATE,PAT,ON
 S DATE=START F  S DATE=$O(^XTMP("ECXBCM",DATE)) Q:'+DATE!(DATE>END)  S PAT=0 F  S PAT=$O(^XTMP("ECXBCM",DATE,PAT)) Q:'+PAT  S ON=0 F  S ON=$O(^XTMP("ECXBCM",DATE,PAT,ON)) Q:'+ON  K ^XTMP("ECXBCM",DATE,PAT,ON)
 S ^XTMP("ECXBCM",0)=$$FMADD^XLFDT($$DT^XLFDT,365)_"^"_$$DT^XLFDT_"^"_"Log of BCMA orders that have already been counted"
 Q
 ;
MULTI() ;154 Section added to determine if this is a multi-dose container
 N COMP,TERM,OFF,UNIT,MULTI
 S MULTI=1 ;Assume it is a multi-dose container
 S UNIT=$$UP^XLFSTR($TR(CCUNIT," 0123456789","")) ;Convert to upper case and remove any numbers or spaces
 F COMP="EQUAL","CONTAIN" F OFF=1:1 S TERM=$P($T(@COMP+OFF),";",2) Q:TERM="DONE"!('MULTI)  D
 .I COMP="EQUAL" I UNIT=TERM S MULTI=0 Q  ;Not a multi-dose container
 .I COMP="CONTAIN" I UNIT[TERM S MULTI=0 ;Not a multi-dose container
 Q MULTI
 ;
EQUAL ;154, list of terms for equality check
 ;AMP
 ;AMPULE
 ;BOTTLE
 ;CAP
 ;LOZENGE
 ;PACKAGE
 ;PACKET
 ;PKG
 ;SUPPOSITORY
 ;SYRINGE
 ;TAB
 ;UNITDOSE
 ;VIAL
 ;EACH
 ;VI
 ;VL
 ;SYR
 ;SYG
 ;AMPOULE
 ;CARTRIDGE
 ;CHEWTAB
 ;LOZ
 ;TUBEX
 ;DONE
CONTAIN ;154, list of terms for contains check
 ;AMP,
 ;CAP,
 ;CAP/
 ;SUPP
 ;TAB,
 ;SOLUTAB
 ;SOFTGEL
 ;DONE
 ;
SETUP ;Set required input for ECXTRAC.
 S ECHEAD="BCM"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
