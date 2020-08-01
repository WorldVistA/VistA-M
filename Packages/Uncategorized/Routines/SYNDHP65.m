SYNDHP65 ;DHP/AFHIL -fjf -  Write Procedures to VistA ; 12th Sept 2018
 ;;0.2;VISTA SYN DATA LOADER;;Feb 07, 2019;Build 10
 ;
 ;
PRCADD(RETSTA,DHPPAT,DHPVST,DHPCNT,DHPSCT,DHPDTM)
 ;
 ; Ingest Procedures into VistA
 ;
 ; Input:
 ;   DHPPAT   - patient ICN              (mandatory)
 ;   DHPVST   - Visit Identifier         (mandatory)
 ;   DHPCNT   - No of times performed    (mandatory)
 ;   DHPSCT   - SCT Procedure code       (mandatory)
 ;   DHPDTM   - Procedure Date/Time      (mandatory) HL7 format
 ; Output:
 ;   1 - success
 ;  -1 - failure
 ;
 I '$D(^DPT("AFICN",DHPPAT)) S RETSTA="-1^Patient not recognised" Q
 ;
 I $G(DHPSCT)="" S RETSTA="-1^SNOMED CT code is required" Q
 I $G(DHPVST)="" S RETSTA="-1^Visit IEN is required" Q
 I '$D(^AUPNVSIT(DHPVST)) S RETSTA="-1^Visit not found" Q
 ;
 D INIT
 ;
 ; use SNOMED CT to OS5 mapping
 S MAPPING="sct2os5"
 ;
 S DHPOS5=$$MAP^SYNDHPMP(MAPPING,DHPSCT)
 I +DHPOS5'=1 S RETSTA="-1^Code "_DHPSCT_" not mapped" Q
 S DHPOS5=$P(DHPOS5,U,2)
 ;
 S PROCDATA("PROCEDURE",1,"PROCEDURE")=DHPOS5
 S PROCDATA("PROCEDURE",1,"QTY")=DHPCNT
 ;
 S DATFM=$$HL7TFM^XLFDT(DHPDTM)
 S PROCDATA("PROCEDURE",1,"EVENT D/T")=DATFM
 ;
 ;
 S RETSTA=1
 S RETSTA=$$DATA2PCE^PXAI("PROCDATA",PACKAGE,SOURCE,.DHPVST,USER,$G(ERRDISP),.ZZERR,$G(PPEDIT),.ZZERDESC,.ACCOUNT)
 ;I $D(ZZERR) ZWRITE ZZERR
 ;
 Q
 ;
INIT ; Initiate variables
 ;
 S PACKAGE=$$FIND1^DIC(9.4,,"","PCE")
 S SOURCE="DHP DATA INGEST"
 S USER=$$DUZ^SYNDHP69
 S ERRDISP=""
 I $G(DEBUG)=1 S ERRDISP=1
 S PPEDIT=""
 S ACCOUNT=""
 S P="|"
 ;
 S ERRDISP=1 ;for testing only, set to null otherwise  <<<<<<<<<<<<<<<<<<<<<<<
 S PPEDIT=""
 S ACCOUNT=""
 ;
 Q
 ;
T1 ;
 D PRCADD(.ZXC,"5000000352V586511",20559,1,56876005,20151002)
 Q
