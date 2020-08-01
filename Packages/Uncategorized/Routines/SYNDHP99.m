SYNDHP99 ; HC/art - HealthConcourse - retrieve VistA data for a resource id ;08/29/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 QUIT
 ;
GETREC(RETSTR,RESID) ; Get VistA record for Resource ID
 ;Inputs: RETSTR - return string, by reference
 ;        RESID  - resource id - V_site_file#_record#
 ;Output: RETSTR - VistA record as a JSON string
 ;              or error message
 ;
 S ^TMP("ZZZ")=RESID_"^333"
 new D set D="-"
 new P set P="|"
 set DUZ=$$DUZ^SYNDHP69
 set RETSTR=""
 ;
 ;check parameter
 if $g(RESID)="" set RETSTR=$$ERRMSG("resourceId is null",RESID) QUIT
 if $e(RESID)'="V" set RETSTR=$$ERRMSG("this is not a VistA resourceId",RESID) QUIT
 if $p(RESID,D,2)'=DUZ(2) set RETSTR=$$ERRMSG("this is not the site requested",RESID) QUIT
 if +$p(RESID,D,3)=0 set RETSTR=$$ERRMSG("the file number must be numeric",RESID) QUIT
 if +$p(RESID,D,4)=0 set RETSTR=$$ERRMSG("the record number must be numeric",RESID) QUIT
 ;
 ;load file array
 new IDX,FILES,VFILES,FNBR,EP,FNAME
 for IDX=1:1 set FILES=$p($t(FILELIST+IDX),";;",2) QUIT:FILES="zzzzz"  do
 . set FNBR=$p(FILES,P,1)
 . set EP=$p(FILES,P,2)
 . set FNAME=$p(FILES,P,3)
 . set VFILES(FNBR)=EP_P_FNAME
 I $G(DEBUG) W $$ZW^SYNDHPUTL("VFILES")
 ;
 new FILE,RECORD
 set FILE=$p(RESID,D,3)
 set RECORD=$p(RESID,D,4)
 if '$d(VFILES(FILE)) set RETSTR=$$ERRMSG("this file is currently not supported",RESID) QUIT
 set:FILE=2.98 RECORD=+$O(^DPT(RECORD,"S",0))_","_RECORD_","
 if $$GET1^DIQ(FILE,RECORD_",",.01,"I")="" set RETSTR=$$ERRMSG("the record was not found",RESID) QUIT
 set RECORD=$p(RESID,D,4)
 ;
 new GETTER,GETTERR
 set GETTER=$p($g(VFILES(FILE)),P,1)
 if GETTER="" set RETSTR=$$ERRMSG("fatal internal error",RESID) QUIT
 new ARRAY
 set GETTERR=GETTER_"(.ARRAY,RECORD,""J"",.RETSTR)"
 set:GETTER="GET1HLF^SYNDHP15" GETTERR=GETTER_"(.ARRAY,RECORD,0,""J"",.RETSTR)"
 do @GETTERR
 ;d:GETTER="GET1HLF^SYNDHP15" ^ZTER
 ;
 QUIT
 ;
ERRMSG(MESSAGE,RESID) ;
 QUIT "{""error"":{""code"":500,""message"":""REST API Error - "_MESSAGE_""",""request"":""DHPGETRESID?RESID="_RESID_"""}}"
 ;
FILELIST ;file#|GETer routine|file name
 ;;2|GETPATIENT^SYNDHP20|Patient
 ;;2.98|GETPATAPPT^SYNDHP25|Patient Appointments
 ;;4|GET1SITE^SYNDHP10|Institution
 ;;26.13|GET1FLAG^SYNDHP17|PRF Assignment (flags)
 ;;44|GETHLOC^SYNDHP22|Hospital location
 ;;52|GET1PATRX^SYNDHP28|Prescription
 ;;55|GETPHPAT^SYNDHP30|Pharmacy Patient
 ;;63|GETLABS^SYNDHP21|Lab Data
 ;;70|GET1RADPAT^SYNDHP27|Rad/Nuc Med Patient
 ;;74|GET1RADRPT^SYNDHP29|Rad/Nuc Med Reports
 ;;120.5|GET1VITALS^SYNDHP16|GMRV Vital Measurement
 ;;120.8|GET1ALLERGY^SYNDHP16|Patient Allergies
 ;;124.3|GET1GMR^SYNDHP15|GMR Text
 ;;130|GET1SURG^SYNDHP31|Surgery
 ;;216.8|GET1NCP^SYNDHP15|Nurs Care Plan
 ;;404.51|GET1TEAM^SYNDHP18|Team
 ;;404.52|ASGNHIST^SYNDHP19|Position Assignment History
 ;;404.53|PRECHIST^SYNDHP19|Preceptor Assignment History
 ;;404.57|TEAMPOS^SYNDHP18|Team Position
 ;;404.58|GET1TEAM^SYNDHP18|Team History
 ;;404.59|TEAMPOS^SYNDHP18|Team Position History
 ;;601.84|GET1MHADM^SYNDHP26|MH Administrations
 ;;601.85|GET1MHANS^SYNDHP26|MH Answers
 ;;601.92|GET1MHRES^SYNDHP26|MH Results
 ;;627.8|GET1MHDX^SYNDHP17|Diagnostic Report-Mental Health
 ;;8925|GET1TIU^SYNDHP24|TIU Document
 ;;9000010|GET1VISIT^SYNDHP13|Visit
 ;;9000010.06|GET1VPROV^SYNDHP23|V Provider
 ;;9000010.07|GET1VPOV^SYNDHP13|V POV
 ;;9000010.11|GET1IMMUN^SYNDHP12|V Immunization
 ;;9000010.18|GET1VCPT^SYNDHP14|V CPT
 ;;9000010.23|GET1HLF^SYNDHP15|V Health Factors
 ;;9000010.71|GET1VSCODE^SYNDHP14|V Standard Codes
 ;;9000011|GET1PROB^SYNDHP11|Problem
 ;;zzzzz
 ;
T1 ;
 N RESID S RESID="V-500-9000010-34494"
 N RETSTA
 D GETREC(.RETSTA,RESID)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
T2 ;
 N RESID S RESID="V-500-2.98-24"
 N RETSTA
 D GETREC(.RETSTA,RESID)
 W $$ZW^SYNDHPUTL("RETSTA"),!!
 QUIT
 ;
