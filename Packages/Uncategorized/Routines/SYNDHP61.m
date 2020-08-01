SYNDHP61 ; Write To VistA ;5/4/18  10:43
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of DXC Technology 2017-2018
 ;
 QUIT
 ;
 ; vitals update
VITUPD(RETSTA,DHPPAT,DHPSCT,DHPOBS,DHPUNT,DHPDTM,DHPROV,DHPLOC) ; vitals update
 ;
 ; Input:
 ;  DHPPAT  - patient ICN           (mandatory)
 ;  DHPSCT  - SNOMED CT code        (mandatory)
 ;  DHPOBS  - Observation Value     (mandatory)
 ;  DHPUNT  - Observation units     (mandatory)
 ;  DHPDTM  - Observation Date/Time (mandatory) HL7 format
 ;  DHPROV  - provider              (mandatory) NPI#
 ;  DHPLOC  - location              (mandatory) name
 ; Output:
 ;  1 - success
 ; -1 - failure
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" Q
 ; set up array of allowed SCT codes
 ;
 D VITSCT
 ;
 I '$D(SCTA(DHPSCT)) S RETSTA="-1^SNOMED CT code not recognised as vitals" Q
 ; build FDA and update vitals file (FN)
 D VITFDA
 D UPDATE^DIE(,"FDA",,"ZZERR")
 S RETSTA=$S($D(ZZERR):-1,1:1)
 Q
 ;
VITSCT ; set up recognised SCT codes for VITALS
 ; map incoming SNOMED CT code to VistA Vital Type (file FN1)
 S SCTA(27113001)="9^Body weight"
 S SCTA(50373000)="8^Body height"
 S SCTA(75367002)="1^Blood pressure"
 S SCTA(78564009)="5^Pulse rate"
 S SCTA(386725007)="2^Body Temperature"
 S SCTA(86290005)="3^Respiration"
 S SCTA(48094003)="10^Abdominal girth measurement"
 S SCTA(21727005)="11^Audiometry"
 S SCTA(252465000)="21^Pulse oximetry"
 S SCTA(22253000)="22^Pain"
 ; map incoming SNOMED CT code to VistA Vital Type (file FN1)
 S SCTX(9)="27113001^Body weight"
 S SCTX(8)="50373000^Body height"
 S SCTX(1)="75367002^Blood pressure"
 S SCTX(5)="78564009^Pulse rate"
 S SCTX(2)="386725007^Body Temperature"
 S SCTX(3)="86290005^Respiration"
 S SCTX(10)="48094003^Abdominal girth measurement"
 S SCTX(11)="21727005^Audiometry"
 S SCTX(21)="252465000^Pulse oximetry"
 S SCTX(22)="22253000^Pain"
 Q
 ;
VITFDA ; build FDA array for Vitals
 K FDA,ZZERR,ORIEN
 N PATIEN,PRVIEN,LOCIEN
 S FN=120.5
 ;S DHPLOC=$G(DHPLOC,10000000286)
 ;S DHPROV=$G(DHPROV,101)
 S DHPOBS=$$SI2IMP(DHPSCT,DHPOBS)
 S ORIEN(1)=$$NEXTIEN()
 S PATIEN=$O(^DPT("AFICN",DHPPAT,""))
 S PRVIEN=0
 I $G(DHPROV)'="" S PRVIEN=$O(^VA(200,"ANPI",DHPROV,""))
 I 'PRVIEN S PRVIEN=$O(^XUSEC("PROVIDER",0))
 I 'PRVIEN S $EC=",U-SET-UP-A-BLOODY-PROVIDER,"
 S LOCIEN=$O(^SC("B",DHPLOC,""))
 ;
 S FDA(FN,"+1,",.01)=$$HL7TFM^XLFDT(DHPDTM) ;date/time vitals taken
 S FDA(FN,"+1,",.02)=PATIEN ;patient
 S FDA(FN,"+1,",.03)=+SCTA(DHPSCT) ;vital type
 S FDA(FN,"+1,",.04)=$$HL7TFM^XLFDT(DHPDTM) ;date/time vitals entered
 S FDA(FN,"+1,",.05)=DHPLOC ;hospital location
 S FDA(FN,"+1,",.06)=PRVIEN ;entered by
 S FDA(FN,"+1,",1.2)=DHPOBS ;rate
 Q
 ;
NEXTIEN() ;
 ; Get new code IEN
 Q $O(^GMR(FN,9E29),-1)+1
 ;
SI2IMP(SCT,OBS) ; convert metric units to imperial
 ;
 N UNITS
 S UNITS=$$UP^XLFSTR(DHPUNT)
 I SCT=27113001,UNITS="KG" Q $J(OBS*2.20462,0,1)  ; weight kg to lbs
 I SCT=50373000,UNITS="CM" Q $J(OBS*0.393701,0,0) ; height cm to inches
 I SCT=386725007,UNITS="CEL" Q $J(OBS/5*9+32,0,1) ; celsius to fahrenheit
 Q OBS
 ;
 ;
 ; -------- problem/condition update
 ;
PROBUPD(RETSTA,DHPPAT,DHPSCT,DHPSDES,DHPROV,DHPDTM,DHPRID) ; problems update
 ;
 ; Alternate entry for creating problem/condition if snomed code does not map to icd code, so can't use DATA2PCE
 ; 
 ; Input:
 ;  DHPPAT -   patient ICN                (mandatory)
 ;  DHPSCT -   SNOMED CT code             (mandatory)
 ;  DHPSDES -  SNOMED CT designation code (optional)      >>>not used in code below, code (DHPSCDES) is looked up in Lexicon <<<
 ;  DHPROV -   Provider     (NPI)              (optional)
 ;  DHPDTM -   Observation Date/Time  (HL7)    (mandatory)
 ;  DHPRID -   DHP unique resource ID     (optional)
 ;               agency_facility
 ;
 ; Output:
 ;  1 - success
 ; -1 - failure
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" Q
 ;
 ;I '$D(SCTA(DHPSCT)) S RETSTA="-1^SNOMED CT code not recognised as vitals" Q
 ; build FDA and update vitals file (FN)
 K LEX
 S LEX=$$CODE^LEXTRAN(DHPSCT,"SCT")
 I +LEX=-2 S RETSTA=LEX Q
 D PROBFDA
 D UPDATE^DIE(,"FDA",,"ZZERR")
 ;W ! ZW ZZERR
 S RETSTA=$S($D(ZZERR):-1,1:1)
 Q
 ;
 ;
PROBFDA ; build FDA array for Problems
 ;
 K FDA,ZZERR,ORIEN
 S P="|"
 S FN=9000011
 ;S DHPOBS=$$UNCNVT(DHPSCT,DHPOBS)
 S ORIEN(1)=$$NEXTIEN()
 S PATIEN=$O(^DPT("AFICN",DHPPAT,""))
 S MAPVUID=5217693 ; VUID for SNOMED CT to ICD-10-CM mapping
 K LEX
 S DHPICD=$$GETASSN^LEXTRAN1(DHPSCT,MAPVUID)
 S DHPICD=$O(LEX(1,""))
 I DHPICD="" S DHPICD="R69."
 S DHPICD=+$$ICDDX^ICDEX(DHPICD,30)
 S FDA(FN,"+1,",.01)=DHPICD ;diagnosis
 S FDA(FN,"+1,",.02)=PATIEN ;patient name
 S FDA(FN,"+1,",.03)=$$NOW^XLFDT() ;date last modified
 S FDA(FN,"+1,",.04)="P" ; or "F" personal history/family history
 ;
 S DHPLOC=+DHPRID
 S FDA(FN,"+1,",.06)=DHPLOC ; location
 S FDA(FN,"+1,",1.07)=$$HL7TFM^XLFDT(DHPDTM) ;date resolved <<<<<<<<<<<<< not if still active
 S FDA(FN,"+1,",.08)=$$NOW^XLFDT() ;date entered
 S FDA(FN,"+1,",.13)=$$HL7TFM^XLFDT(DHPDTM) ;date of onset
 S STATII=P_"A"_P_"I"_P
 S FDA(FN,"+1,",.12)=$S(STATII[(P_$G(DHPSTA)_P):DHPSTA,1:"A") ;status
 S FDA(FN,"+1,",80001)=DHPSCT ; snomed ct concept code
 ;
 N LEX
 S LEX=$$CODE^LEXTRAN(DHPSCT,"SCT",,,,1,1)
 S DHPSCDES=$P($G(LEX("P")),U,3)
 S LEXIEN=$P(LEX("P"),U,2)
 S EXPRSN=$P(LEX("P"),U)
 S PROVNAR=$$PROVNARTL(EXPRSN)
 S FDA(FN,"+1,",.05)=PROVNAR ;provider narrative
 S FDA(FN,"+1,",1.01)=LEXIEN ;problem
 S FDA(FN,"+1,",80002)=DHPSCDES ;snomed ct designation code
 S FDA(FN,"+1,",80201)=$$HL7TFM^XLFDT(DHPDTM) ;date of interest
 S FDA(FN,"+1,",80202)="10D" ;coding system
 S NUM=$O(^AUPNPROB("AA",PATIEN,DHPLOC,""),-1) ;get last NMBR used
 S NUM=+$RE(+$RE(NUM))
 S NUM=NUM+1
 S FDA(FN,"+1,",.07)=NUM ;nmbr
 S PRVIEN="" I DHPROV'="" S PRVIEN=$O(^VA(200,"ANPI",DHPROV,""))
 S FDA(FN,"+1,",1.03)=PRVIEN ;entered by
 S FDA(FN,"+1,",1.04)=PRVIEN ;recording provider
 S FDA(FN,"+1,",1.05)=PRVIEN ;responsible provider
 ;W ! ZW FDA
 Q
PROVNARTL(EXPRSN) ; deal with provider narrative
 ;
 N PROVNAR
 I '$D(^AUTNPOV("B",EXPRSN)) D PROVNADD(EXPRSN)
 S PROVNAR=$O(^AUTNPOV("B",EXPRSN,""))
 Q PROVNAR
 ;
PROVNADD(EXPRSN) ;
 N PNIEN
 S PNIEN=$O(^AUTNPOV(99999999999),-1)+1
 S ^AUTNPOV(PNIEN,0)=EXPRSN
 S ^AUTNPOV("B",EXPRSN,PNIEN)=""
 Q
 ;
 ; -------- Immunization update
 ;
IMMUNUPD(RETSTA,DHPPAT,VISIT,IMMUNIZ,ANATLOC,ADMINRT,DOSE,EVENTDT,IMMPROV) ;Immunization update
 ;
 ; Input:
 ;  DHPPAT  - patient ICN  (mandatory)
 ;  VISIT   - visit ien    (mandatory)
 ;  IMMUNIZ - cvx code     (mandatory)
 ;  ANATLOC - anatomical location
 ;  ADMINRT - route of administration
 ;  DOSE    - dose
 ;  EVENTDT - event date/time (HL7 format)
 ;  IMMPROV - immunization provider (NPI)
 ;
 ; Output:   RETSTA
 ;  1 - success
 ; -1 - failure -1^message
 ;
 N IMMIEN
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" QUIT
 ;
 I $G(IMMUNIZ)="" S RETSTA="-1^Immunization (CVX code) is required" QUIT
 S IMMIEN=$O(^AUTTIMM("C",IMMUNIZ,""))
 I IMMIEN="" S RETSTA="-1^Immunization (CVX code) not found" QUIT
 I +$$GET1^DIQ(9999999.14,IMMIEN_",",.07,"I") S RETSTA="-1^Immunization is inactive" QUIT
 ;
 I $G(VISIT)="" S RETSTA="-1^Visit IEN is required" QUIT
 I '$D(^AUPNVSIT(VISIT)) S RETSTA="-1^Visit not found" QUIT
 ;
 N PACKAGE,SOURCE,USER,ERRDISP,ZZERR,PPEDIT,ZZERDESC,ACCOUNT
 N IMMDATA,IMMPRVIEN,PPEDIT
 ;
 S RETSTA=1
 D SETUP
 QUIT:RETSTA=-1
 ;
 S RETSTA=$$DATA2PCE^PXAI("IMMDATA",PACKAGE,SOURCE,.VISIT,USER,$G(ERRDISP),.ZZERR,$G(PPEDIT),.ZZERDESC,.ACCOUNT)
 ;I $D(ZZERR) ZW ZZERR
 I $D(ZZERDESC) M RETSTA("ZZERDESC")=ZZERDESC
 I $D(ZZERR) M RETSTA("ZZERR")=ZZERR
 M RESTSTA("IMMDATA")=IMMDATA
 QUIT
 ;
 ; $$DATA2PCE Output:
 ;+   1  if no errors and processed completely
 ;+  -1  if errors occurred but processed completely as possible
 ;+  -2  if could not get a visit
 ;+  -3  if called incorrectly
 ;
SETUP ; set data for $$DATA2PCE call
 ;
 S PACKAGE=507 ;PCE PATIENT CARE ENCOUNTER
 S SOURCE="DHP DATA INGEST"
 S USER=$$DUZ^SYNDHP69
 N EVDATFM
 S EVDATFM=$$HL7TFM^XLFDT(EVENTDT)
 S ERRDISP=1 ;for testing only, set to null otherwise  <<<<<<<<<<<<<<<<<<<<<<<
 S PPEDIT=""
 S ACCOUNT=""
 ;
 S IMMDATA("IMMUNIZATION",1,"IMMUN")=IMMIEN
 ;don't send null data values to create records
 ; There are extra data elements here for possible future use
 I $G(IMMPROV)'="" D
 . S IMMPRVIEN=$O(^VA(200,"ANPI",IMMPROV,""))
 . QUIT:IMMPRVIEN=""
 . S IMMDATA("IMMUNIZATION",1,"ENC PROVIDER")=IMMPRVIEN
 S:$G(EVENTDT)'="" IMMDATA("IMMUNIZATION",1,"EVENT D/T")=EVDATFM
 S:$G(SERIES)'="" IMMDATA("IMMUNIZATION",1,"SERIES")=SERIES
 S:$G(REACTION)'="" IMMDATA("IMMUNIZATION",1,"REACTION")=REACTION
 S:$G(CONTRA)'="" IMMDATA("IMMUNIZATION",1,"CONTRAINDICATED")=CONTRA
 S:$G(DXCODE)'="" IMMDATA("IMMUNIZATION",1,"DIAGNOSIS")=DXCODE
 S:$G(COMMENT)'="" IMMDATA("IMMUNIZATION",1,"COMMENT")=COMMENT
 S:$G(LOTNUM)'="" IMMDATA("IMMUNIZATION",1,"LOT NUM")=LOTNUM
 S:$G(INFOSRC)'="" IMMDATA("IMMUNIZATION",1,"INFO SOURCE")=INFOSRC
 S:$G(ADMINRT)'="" IMMDATA("IMMUNIZATION",1,"ADMIN ROUTE")=ADMINRT
 S:$G(ANATLOC)'="" IMMDATA("IMMUNIZATION",1,"ANATOMIC LOC")=ANATLOC
 S:$G(DOSE)'="" IMMDATA("IMMUNIZATION",1,"DOSE")=DOSE
 S:$G(DOSEUNIT)'="" IMMDATA("IMMUNIZATION",1,"DOSE UNITS")=DOSEUNIT
 N SERCAT
 S SERCAT=$S(EVDATFM\1<$$DT^XLFDT:"E",1:"A")
 S IMMDATA("IMMUNIZATION",1,"SERVICE CATEGORY")=SERCAT ; A for current E for historical
 QUIT
 ;
 ; -------- Encounter update
 ;
ENCTUPD(RETSTA,DHPPAT,STARTDT,ENDDT,ENCPROV,CLINIC,SCTDX,SCTCPT) ;Encounter update
 ;return visit id/ien
 ;
 S U="^"
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" QUIT
 ;
 I $G(ENCPROV)'="" D
 .S ENCPRVIEN=$O(^VA(200,"ANPI",ENCPROV,""))
 .I 'ENCPRVIEN S ENCPRVIEN=$O(^XUSEC("PROVIDER",0))
 .I 'ENCPRVIEN S $EC=",U-SET-UP-A-BLOODY-PROVIDER,"
 S PATIEN=$O(^DPT("AFICN",DHPPAT,""),-1)
 S SOURCE="DHP DATA INGEST"
 S PACKAGE=$$FIND1^DIC(9.4,,"","PCE")
 S LOCATION=$O(^SC("B",CLINIC,""))
 S USER=$$DUZ^SYNDHP69
 ;
 ;chop off seconds
 N APPTDATE
 S APPTDATE=$$HL7TFM^XLFDT(STARTDT)
 S APPTTM=$E($P(APPTDATE,".",2),1,4)
 S $P(APPTDATE,".",2)=APPTTM
 ;
 ; map SNOMED CT code in SCTDX to ICD-10
 S MAPVUID=5217693 ; VUID for SNOMED CT to ICD-10-CM mapping
 ;K LEX
 ;S DHPICD=$$GETASSN^LEXTRAN1(SCTDX,MAPVUID)
 ;S DHPICD=$O(LEX(1,""))
 ;I DHPICD="" S DHPICD="R69."
 ;S DHPICD=+$$ICDDX^ICDEX(DHPICD,30)
 I $G(SCTDX)'="" D  ;
 .S MAPPING=$S(APPTDATE>3150930:"sct2icd",1:"sct2icdnine") ; APPTDATE IS IN FM FORMAT
 .S DHPICD=$$MAP^SYNDHPMP(MAPPING,SCTDX)
 .I +DHPICD=-1 S RETSTA="-1^SNOMED CT CODE "_SCTDX_" not mapped" Q
 .;S DHPICD=+$$ICDDX^ICDEX($P(DHPICD,U,2),30)
 .I +DHPICD'=-1 S DHPICD=+$$ICDDX^ICDEX($P(DHPICD,U,2),30)
 ;
 ; map SNOMED CT code in SCTCPT to CPT
 ;S DHPCPT=$S($$MAP^SYNQLDM(SCTCPT)'="":$$MAP^SYNQLDM(SCTCPT),1:92002)
 S DHPCPT=$$MAP^SYNQLDM(SCTCPT)
 I DHPCPT'="" D
 .I '$D(^ICPT("B",DHPCPT)) S DHPCPT=""
 I DHPCPT="" D
 .S DHPCPT=$$MAP^SYNDHPMP("sct2os5",SCTCPT)
 .I +DHPCPT=-1 S DHPCPT="" Q
 .S DHPCPT=$P(DHPCPT,U,2)
 ;
 I DHPCPT="" S RETSTA="-1^SNOMED CT CODE "_SCTCPT_" not mapped" Q
 ; create root array
 K ENCDATA
 S ENCDATA("ENCOUNTER",1,"PATIENT")=PATIEN
 S ENCDATA("ENCOUNTER",1,"ENCOUNTER TYPE")="P"
 S ENCDATA("ENCOUNTER",1,"ENC D/T")=APPTDATE
 S ENCDATA("ENCOUNTER",1,"HOS LOC")=LOCATION
 N SERCAT
 S SERCAT=$S(APPTDATE\1<$$DT^XLFDT:"E",1:"A")
 S SERCAT="A"
 S ENCDATA("ENCOUNTER",1,"SERVICE CATEGORY")=SERCAT ; A for current E for historical
 S ENCDATA("PROVIDER",1,"NAME")=ENCPRVIEN
 S ENCDATA("PROVIDER",1,"PRIMARY")=1
 ; gpl 100%
 I +$G(DHPICD)=-1 D  ; no mapping was found
 . I $G(SCTDX)="" Q  ; no code passed in
 . S ENCDATA("STD CODES",1,"CODE")=SCTDX
 . S ENCDATA("STD CODES",1,"CODING SYSTEM")="SCT"
 . S ENCDATA("STD CODES",1,"EVENT D/T")=APPTDATE
 . S ENCDATA("STD CODES",1,"COMMENT")="Purpose of Visit - POV."
 . S ENCDATA("STD CODES",1,"ENC PROVIDER")=ENCPRVIEN
 . ; health factor for CPRS display (v 30,31)
 . N HFIEN
 . S HFIEN=$O(^AUTTHF("B","SYN SNOMED PURPOSE OF VISIT",""))
 . I HFIEN'="" D  ; Health factor exists
 . . S ENCDATA("HEALTH FACTOR",1,"HEALTH FACTOR")=HFIEN
 . . S ENCDATA("HEALTH FACTOR",1,"EVENT D/T")=APPTDATE
 . . S ENCDATA("HEALTH FACTOR",1,"COMMENT")=SCTDX
 E  D  ; mapping was found
 . I $G(SCTDX)'="" S ENCDATA("DX/PL",1,"DIAGNOSIS")=DHPICD
 . I $G(SCTDX)'="" S ENCDATA("DX/PL",1,"ENC PROVIDER")=ENCPRVIEN
 . I $G(SCTDX)'="" S ENCDATA("DX/PL",1,"PRIMARY")=1
 S ENCDATA("PROCEDURE",1,"PROCEDURE")=DHPCPT
 S ENCDATA("PROCEDURE",1,"QTY")=1
 I $G(SCTDX)'="" I +DHPICD'=-1 S ENCDATA("PROCEDURE",1,"DIAGNOSIS")=DHPICD
 ;
 K ZZERR,ZZERDESC,VISIT
 S RETSTA=$$DATA2PCE^PXAI("ENCDATA",PACKAGE,SOURCE,.VISIT,USER,$G(ERRDISP),.ZZERR,$G(PPEDIT),.ZZERDESC,.ACCOUNT)
 S RETSTA=RETSTA_"^"_$G(VISIT)
 I $D(ZZERDESC) M RETSTA("ZZERDESC")=ZZERDESC
 I $D(ZZERR) M RETSTA("ZZERR")=ZZERR
 M RETSTA("ENCDATA")=ENCDATA
 ;
 ;change APPTDATE back to HL7 format for these next calls
 S APPTDATE=$$FMTHL7^XLFDT(APPTDATE)
 ;create appointment
 N DHPLEN
 S DHPLEN=""
 D APPTADD^SYNDHP62(.RETSTA,DHPPAT,CLINIC,APPTDATE,DHPLEN)
 QUIT:$G(RETSTA("APPT"))'=1
 ;
 ;check-in appointment
 N DHPCIDT
 S DHPCIDT=""
 D APPTCKIN^SYNDHP62(.RETSTA,DHPPAT,CLINIC,APPTDATE,DHPCIDT)
 QUIT:$G(RETSTA("CKIN"))'=1
 ;
 ;check-out appointment
 N DHPCODT
 S DHPCODT=""
 D APTCKOUT^SYNDHP62(.RETSTA,DHPPAT,CLINIC,APPTDATE,DHPCODT)
 ;
 QUIT
 ;
 ; -------------------------------------------------------------------------
 ;;
TEST ;
T1 D PROBUPD(.ZXC,"5482156687V807096",267036007,158482014,9990006675,20180118,"5OO_EXT")
 Q
T2 D ENCTUPD(.ZXC,"5482156687V807096",20161227154556,20161227161234,"9990000348","GENERAL MEDICINE",73211009,10492003)
 Q
T3 S IDT=20170115154546
 F SDT=IDT:1E8:(IDT+9E8) S EDT=SDT+2E8 D
 .;K VISIT
 .K ZXC
 .D ENCTUPD(.ZXC,"9004935583V839304",SDT,EDT,"9990000348","GENERAL MEDICINE",73211009,10492003)
 .W !!,"___________________________________________________",!!
 .;ZW ZXC
 .W !!
 .;ZW ENCDATA
 .W !!,"___________________________________________________",!!
 .;ZW ZZERDESC
 .W !!,"___________________________________________________",!!
 .;ZW ZZERR
 Q
