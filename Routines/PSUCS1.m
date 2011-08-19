PSUCS1 ;BIR/DJE - PBM CONTROLLED SUBSTANCE GENERATE RECORDS ;20 OCT 1999
 ;;4.0;PHARMACY BENEFITS MANAGEMENT;;MARCH, 2005
 ;
 ;DBIA(s)
 ; Reference to file #58.81 supported by DBIA 2520
 ;
 ;3.2.5.1.  Functional Requirement 1
 ;3.2.5.2.  Functional Requirement 2
 ; DTTM=DATE/TIME
 ; PSULOC=PSULOCATION
 ; PSUTYP=DISPENSING TYPE
 ; PSUIENDA=TRANSACTION
INIT ;
 S PSUCSJB=$G(PSUCSJB,"PSUCS_"_PSUJOB)
 ;*** THE DEFAULT RECORD INDICATOR IS 'H' AND 
 ;
 K ^XTMP(PSUCSJB)
 I '$D(^XTMP(PSUCSJB)) D
 . S X1=DT,X2=6 D C^%DTC
 . S ^XTMP(PSUCSJB,0)=X_"^"_DT_"^ Controlled Substance Extraction"
 S FACILITY=PSUSNDR
 S PSUSDT=$G(PSUSDT,"")
 S PSUEDT=$G(PSUEDT,"")
 S PSUEDT=PSUEDT\1+.24
 ;S PSURI="H"   DAM TEST
 S PSUMCHK=0
 Q
 ;
EN ;ENTRY POINT
 D INIT
 S DTTM=PSUSDT
 F  S DTTM=$O(^PSD(58.81,"AF",DTTM)) Q:(DTTM="")!(DTTM'<PSUEDT)  D
 .S PSULOC=""
 .F  S PSULOC=$O(^PSD(58.81,"AF",DTTM,PSULOC)) Q:PSULOC=""  D
 .. S PSUTYP=""
 .. F  S PSUTYP=$O(^PSD(58.81,"AF",DTTM,PSULOC,PSUTYP)) Q:PSUTYP=""  D
 ... ;3.2.5.3.  Functional Requirement 3
 ... ;'2'-Dispensed from Pharmacy or '17'- Logged for Patient.
 ... Q:(PSUTYP'=17)&(PSUTYP'=2) 
 ... ; section 3.2.5.10.
 ... ; Check for type 17
 ... S PSUIENDA=""
 ... F  S PSUIENDA=$O(^PSD(58.81,"AF",DTTM,PSULOC,PSUTYP,PSUIENDA)) Q:PSUIENDA=""  D
 .... ; patient IEN
 .... S PSUPIEN(73)=$$VALI^PSUTL(58.81,PSUIENDA,"73")
 .... ;
 .... ; Screen out test patients
 .... Q:$$TESTPAT^PSUTL1(PSUPIEN(73))
 .... ; Field # 58.81,3 [DATE/TIME]Field to be extracted***
 .... S PSUDTM(3)=$$VALI^PSUTL(58.81,PSUIENDA,"3")
 .... ;S PSURI="H" S SENDER=PSUSNDR ;DUZ    DAM TEST
 .... I PSUTYP=2 D TYP2^PSUCS2 D:'$G(PSUQUIT) BUILDREC^PSUCS5 K PSUSSN,PSUPLC,PSUQUIT ;**9
 .... I PSUTYP=17,PSUPIEN(73)'="" D TYP17^PSUCS3 K PSUPLC
 .... ;     type 17s to be processed after all are gathered
 .... ;     into ^XTMP(,"MC",LOC,PAT,DRG)
 ....;3.2.5.5.  Functional Requirement 5
 D EN^PSUCS17 ; process type 17s that have been gathered
 Q
