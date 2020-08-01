SYNDHP55 ; HC/art - HealthConcourse - retrieve patient procedures ;08/10/2019
 ;;1.0;DHP;;Jan 17, 2017;Build 46
 ;;
 ;;Original routine authored by Andrew Thompson & Ferdinand Frankson of Perspecta 2017-2019
 ;
 ;Surgical Procedures
 ;Visit Procedures
 ;Radiology Procedures
 ;Radiology Reports
 ;
 QUIT
 ;
 ;Surgical Procedures
SRPRCS(PTIEN,FRDAT,TODAT) ; get surgical procedures for a patient
 ; build the array of SNOMED CT codes that correspond to procedures
 ;
 N PROCS,FNUM,FNBR2,PIEN,PIENS,PRCPTCD,PRCPTIEN,PID,SCT,SCTPT,SEQ,DATE,MAPPING
 N VISITID,VISITDT,VISITHL,SURG,PROV,PDATE,PDATEHL,PRDATE,PRDATEHL,SERPROCS,CLINIC,DIVISION
 N ORDER,ORDERIEN,PRINPROC,SCHDPROC
 ;
 N P S P="|"
 N S S S="_"
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 S FNUM=130 ;surgery
 S FNBR2=9000010 ;visit
 N FLIST S FLIST=".015;.021;.09;.14;26;27;50;68;100;120;123"
 S SEQ=0
 ;
 I $G(DEBUG) W !,"Surgical Procedures",!
 ; scan surgery "B" index for IEN
 S PIEN=""
 F  S PIEN=$O(^SRF("B",PTIEN,PIEN)) QUIT:PIEN=""  D
 . N SURGARR,SURGERR
 . S PIENS=PIEN_","
 . D GETS^DIQ(FNUM,PIENS,FLIST,"EI","SURGARR","SURGERR")  ;specific fields
 . I $G(DEBUG),$D(SURGERR) W !,">>ERROR<<",! W $$ZW^SYNDHPUTL("SURGERR")
 . QUIT:$D(SURGERR)
 . S PID=$$RESID^SYNDHP69("V",SITE,FNUM,PIEN)
 . S PDATE=SURGARR(FNUM,PIENS,.09,"I") ;date of operation
 . QUIT:'$$RANGECK^SYNDHPUTL(PDATE,FRDAT,TODAT)  ;quit if outside of requested date range
 . S PDATEHL=$$FMTHL7^XLFDT(PDATE) ;date of operation, hl7 format
 . S CLINIC=SURGARR(FNUM,PIENS,.021,"E") ;associated clinic
 . S DIVISION=SURGARR(FNUM,PIENS,50,"E") ;division
 . S SURG=SURGARR(FNUM,PIENS,.14,"E") ;primary surgeon
 . S PRDATE=SURGARR(FNUM,PIENS,120,"I") ;date of procedure
 . S PRDATEHL=$$FMTHL7^XLFDT(PRDATE) ;date of operation, hl7 format
 . S PROV=SURGARR(FNUM,PIENS,123,"E") ;provider
 . S VISITID=SURGARR(FNUM,PIENS,.015,"I") ;visit, pointer to Visit file
 . S VISITDT=""
 . S:VISITID'="" VISITDT=$$GET1^DIQ(FNBR2,VISITID_",",.01,"I") ;visit/admit date&time
 . S VISITHL=$$FMTHL7^XLFDT(VISITDT) ;hl7 format visit/admit date&time
 . S ORDERIEN=SURGARR(FNUM,PIENS,100,"I") ;order number ien
 . S ORDER=SURGARR(FNUM,PIENS,100,"E") ;order number
 . S PRCPTIEN=SURGARR(FNUM,PIENS,27,"I") ;planned prin procedure code ien
 . S PRCPTCD=SURGARR(FNUM,PIENS,27,"E") ;planned prin procedure code
 . S PRINPROC=SURGARR(FNUM,PIENS,26,"E") ;principal procedure
 . S SCHDPROC=SURGARR(FNUM,PIENS,68,"E") ;scheduled procedure
 . ;LOOKUP SNOMED(sct) - cpt, os5
 . S SCT=""
 . S SCTPT=$S(PRINPROC'="":PRINPROC,1:"")
 . ;map cpt to snomed (currently uses very small map)
 . I PRCPTCD'="" D
 . . S SCT=$$MAP^SYNDHPMP("sct2cpt",PRCPTCD,"I")
 . . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 . ;if no cpt hit, map os5 to snomed
 . I SCT="",PRCPTCD'="" D
 . . S SCT=$$MAP^SYNDHPMP("sct2os5",PRCPTCD,"I")
 . . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 . I $G(DEBUG) D
 . . W !,"Record IEN: ",PIEN,!
 . . W "Planned Principal Procedure (CPT): ",PRCPTIEN,"     ",PRCPTCD,!
 . . W "Principal Procedure: ",?22,PRINPROC,!
 . . W "Scheduled Procedure: ",?22,SCHDPROC,!
 . . W "SCT: ",?22,SCT,!
 . . W "SCT Description: ",?22,SCTPT,!
 . . W "Date of Operation: ",?22,PDATE,"     ",PDATEHL,!
 . . W "Date of Procedure: ",?22,PRDATE,"     ",PRDATEHL,!
 . . W "Primary Surgeon: ",?22,SURG,!
 . . W "Provider: ",?22,PROV,!
 . . W "Clinic: ",?22,CLINIC,!
 . . W "Division: ",?22,DIVISION,!
 . . W "Order: ",?22,ORDERIEN,"     ",ORDER,!
 . . W "Visit IEN: ",?22,VISITID,!
 . . W "Visit Date: ",?22,VISITDT,"     ",VISITHL,!
 . . W "PID: ",?22,PID,!
 . S DATE=$S(PDATE'="":PDATEHL,PRDATE'="":PRDATEHL,VISITDT'="":VISITHL,1:"")
 . ;SCT code1|descrption|CPT code|date|identifier
 . S SEQ=SEQ+1
 . S PROCS(SEQ)=U_SCT_P_SCTPT_P_PRCPTCD_P_PDATEHL_P_PID
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PROCS")
 ;
 ;serialize data
 S SERPROCS=""
 S SEQ=""
 F  S SEQ=$O(PROCS(SEQ)) QUIT:SEQ=""  D
 . S SERPROCS=SERPROCS_PROCS(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SERPROCS")
 ;
 QUIT SERPROCS
 ;
 ;Visit Procedures
VSTPRCS(PATIEN,FRDAT,TODAT) ;
 ;
 N PROCS,FNBR1,FNBR2,PIEN,VISITID,VISITDT,PRPROC
 N VISITHL,CPT,CPTNAME,PID,SEQ,SERPROCS,MAPPING,SCT
 ;
 S PROCS=""
 N P S P="|"
 S SEQ=0
 S FNBR1=9000010.18 ;v cpt
 S FNBR2=9000010 ;visit
 I $G(DEBUG) W !,"Visit Procedures",!
 ;
 S PIEN=""
 F  S PIEN=$O(^AUPNVCPT("C",PATIEN,PIEN)) QUIT:PIEN=""  D
 . N VCPT
 . D GET1VCPT^SYNDHP14(.VCPT,PIEN,0)
 . QUIT:$D(VCPT("Vcpt","ERROR"))
 . I $G(DEBUG) W $$ZW^SYNDHPUTL("VCPT")
 . S VISITDT=VCPT("Vcpt","visitFM") ;visit/admit date&time
 . QUIT:'$$RANGECK^SYNDHPUTL(VISITDT,FRDAT,TODAT)  ;quit if outside of requested date range
 . S VISITHL=VCPT("Vcpt","visitHL7") ;hl7 format visit/admit date&time
 . S PID=VCPT("Vcpt","resourceId")
 . S CPT=VCPT("Vcpt","cpt") ;cpt code
 . S CPTNAME=VCPT("Vcpt","cptName") ;cpt name
 . S VISITDT=VCPT("Vcpt","visitFM") ;visit/admit date&time
 . QUIT:(VISITDT<FRDAT)!(VISITDT>TODAT)  ;quit if outside of requested date range
 . S VISITHL=VCPT("Vcpt","visitHL7") ;hl7 format visit/admit date&time
 . S SCT=VCPT("Vcpt","sct")
 . S SEQ=SEQ+1
 . ;SCT code1|descrption|CPT code|date|identifier
 . S PROCS(SEQ)=U_SCT_P_CPTNAME_P_CPT_P_VISITHL_P_PID
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PROCS")
 ;
 ;serialize data
 S SERPROCS=""
 S SEQ=""
 F  S SEQ=$O(PROCS(SEQ)) QUIT:SEQ=""  D
 . S SERPROCS=SERPROCS_PROCS(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SERPROCS")
 ;
 QUIT SERPROCS
 ;
 ;Radiology Procedures
RADPRCS(PATIEN,FRDAT,TODAT) ;
 ;
 N P S P="|"
 N SEQ S SEQ=0
 I $G(DEBUG) W !,"Radiology Procedures",!
 N RADEX
 D RADEXAM(.RADEX,PATIEN,0,FRDAT,TODAT)
 ;             1      2        3       4            5            6         7        8     9     10     11         12      13        14        15       16
 ; RADEX(SEQ)=PID_U_PatDfn_U_CatEx_U_ExamDate_U_ExamDateHl7_U_CASENBR_U_PROCIEN_U_PROC_U_CPT_U_SCT_U_PDIAGCD_U_REQPHYS_U_PIRES_U_PISTAFF_U_VISITDT_U_VISITHL
 ;
 N SCT,PROC,PROCS,CPT,EXDATE,EXDATEHL,PID
 N IDX S IDX=""
 F  S IDX=$O(RADEX(IDX)) QUIT:IDX=""  D
 . S EXDATE=$P(RADEX(IDX),U,4)
 . QUIT:'$$RANGECK^SYNDHPUTL(EXDATE,FRDAT,TODAT)  ;quit if outside of requested date range
 . S SCT=$P(RADEX(IDX),U,10)
 . S PROC=$P(RADEX(IDX),U,8)
 . S CPT=$P(RADEX(IDX),U,9)
 . S EXDATEHL=$P(RADEX(IDX),U,5)
 . S PID=$P(RADEX(IDX),U,1)
 . ;SCT code|descrption|CPT code|date|identifier
 . S SEQ=SEQ+1
 . S PROCS(SEQ)=U_SCT_P_PROC_P_CPT_P_EXDATEHL_P_PID
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("PROCS")
 ;
 ;serialize data
 N SERPROCS S SERPROCS=""
 N SEQ S SEQ=""
 F  S SEQ=$O(PROCS(SEQ)) QUIT:SEQ=""  D
 . S SERPROCS=SERPROCS_PROCS(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("SERPROCS")
 ;
 QUIT SERPROCS
 ;
 ;
 ;Radiology Procedures
RADEXAM(RADEX,PATIEN,RPT,FRDAT,TODAT) ;Radiology procedures, diagnosis, report for a patient
 ;Inputs: PATIEN - patient IEN
 ;        RPT - return report, 0=no, 1=yes
 ;Output: RADEX - array of radiology exams, by reference
 ;          PID^PatDfn^Category^ExamDate^ExamDateHl7^CASENBR^PROCIEN^PROC^CPT^SCT^PDIAGCD^REQPHYS^
 ;            PIRES^PISTAFF^VISITDT^VISITHL^EnteringUser
 ;
 S RADEX=""
 N S S S="_"
 N SEQ S SEQ=0
 N SITE S SITE=$P($$SITE^VASITE,"^",3)
 N FNBR1 S FNBR1=70 ;RAD/NUC MED PATIENT FILE, this file DINUMed
 N FNBR2 S FNBR2=70.02 ;RAD/NUC MED PATIENT FILE:REGISTERED EXAMS
 N FNBR3 S FNBR3=70.03 ;RAD/NUC MED PATIENT FILE:REGISTERED EXAMS:EXAMINATIONS
 N FNBR4 S FNBR4=9000010 ;visit
 ;
 ;get patient record
 N IENS S IENS=PATIEN_","
 N RADRPT,PATARR,PATERR
 D GETS^DIQ(FNBR1,IENS,".01;.04;.06","EI","PATARR","PATERR")  ;specific fields
 I $G(DEBUG),$D(PATERR) W !,"FNBR1:",FNBR1,!,"IENS:",IENS,!,">>ERROR<<",! W $$ZW^SYNDHPUTL("PATERR")
 QUIT:$D(PATERR)
 N PatDfn S PatDfn=$G(PATARR(FNBR1,IENS,.01,"I")) ;patient dfn
 N CategoryCd S CategoryCd=$G(PATARR(FNBR1,IENS,.04,"I")) ;category code
 N Category S Category=$G(PATARR(FNBR1,IENS,.04,"E")) ;category
 N EnteringUserId S EnteringUserId=$G(PATARR(FNBR1,IENS,.06,"I")) ;user who entered patient
 N EnteringUser S EnteringUser=$G(PATARR(FNBR1,IENS,.06,"E")) ;user who entered patient
 ;get registered exams
 N REXIEN S REXIEN=0
 F  S REXIEN=$O(^RADPT(PATIEN,"DT",REXIEN)) QUIT:'+REXIEN  D
 . N IENS1 S IENS1=REXIEN_","_IENS
 . N REXARR,REXERR
 . D GETS^DIQ(FNBR2,IENS1,".01;2;3;4;5","EI","REXARR","REXERR")  ;specific fields
 . I $G(DEBUG),$D(REXERR) W !,">>ERROR<<",! W $$ZW^SYNDHPUTL("REXERR")
 . QUIT:$D(REXERR)
 . N ExamDate S ExamDate=$G(REXARR(FNBR2,IENS1,.01,"I")) ;exam date
 . QUIT:'$$RANGECK^SYNDHPUTL(ExamDate,FRDAT,TODAT)  ;quit if outside of requested date range
 . N ExamDateHl7 S ExamDateHl7=$$FMTHL7^XLFDT(ExamDate) ;hl7 format exam date
 . ;get examinations
 . N EXIEN S EXIEN=0
 . F  S EXIEN=$O(^RADPT(PATIEN,"DT",REXIEN,"P",EXIEN)) QUIT:'+EXIEN  D
 . . N CASENBR,PROCIEN,PROC,CPT,PIRES,PDIAGCD,REQPHYS,PISTAFF,RPTTEXT,VISITID,VISITDT,VISITHL,SCT,PID
 . . N IENS2 S IENS2=EXIEN_","_IENS1
 . . N EXARR,EXERR
 . . D GETS^DIQ(FNBR3,IENS2,".01;2;12;13;14;15;17;27","EI","EXARR","EXERR")  ;specific fields
 . . I $G(DEBUG),$D(EXERR) W !,">>ERROR<<",! W $$ZW^SYNDHPUTL("EXERR")
 . . QUIT:$D(EXERR)
 . . S CASENBR=$G(EXARR(FNBR3,IENS2,.01,"I")) ;case number
 . . S PROCIEN=$G(EXARR(FNBR3,IENS2,2,"I")) ;procedure ien
 . . S PROC=$G(EXARR(FNBR3,IENS2,2,"E")) ;procedure name
 . . S CPT=""
 . . S:PROCIEN'="" CPT=$$GET1^DIQ(71,PROCIEN_",",9) ;cpt code
 . . S PIRES=$G(EXARR(FNBR3,IENS2,12,"E")) ;primary interpreting resident
 . . S PDIAGCD=$G(EXARR(FNBR3,IENS2,13,"E")) ;primary diagnostic code
 . . S REQPHYS=$G(EXARR(FNBR3,IENS2,14,"E")) ;requesting physician
 . . S PISTAFF=$G(EXARR(FNBR3,IENS2,15,"E")) ;primary interpreting staff
 . . S RPTTEXT=$G(EXARR(FNBR3,IENS2,17,"I")) ;report text (pointer to file 74)
 . . S VISITID=$G(EXARR(FNBR3,IENS2,27)) ;visit id
 . . S VISITDT=""
 . . S:VISITID'="" VISITDT=$$GET1^DIQ(FNBR4,VISITID_",",.01,"I") ;visit/admit date&time
 . . S VISITHL=$$FMTHL7^XLFDT(VISITDT) ;hl7 format visit/admit date&time
 . . S PID=$$RESID^SYNDHP69("V",SITE,FNBR1,PATIEN,FNBR2_U_REXIEN_U_FNBR3_U_EXIEN)
 . . ;LOOKUP SNOMED(sct) - cpt, os5
 . . S SCT=""
 . . ;map cpt to snomed (currently uses very small map)
 . . I CPT'="" D
 . . . S SCT=$$MAP^SYNDHPMP("sct2cpt",CPT,"I")
 . . . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 . . ;if no cpt hit, map os5 to snomed
 . . I SCT="",CPT'="" D
 . . . S SCT=$$MAP^SYNDHPMP("sct2os5",CPT,"I")
 . . . S SCT=$S(+SCT=-1:"",1:$P(SCT,U,2))
 . . ;
 . . I $G(DEBUG) D
 . . . W !,"Patient: ",?32,PatDfn,!
 . . . W "Category: ",?32,CategoryCd,"     ",Category,!
 . . . W "Exam Date: ",?32,ExamDate,"     ",ExamDateHl7,!
 . . . W "Case Number: ",?32,CASENBR,!
 . . . W "Procedure: ",?32,PROCIEN,"     ",PROC,!
 . . . W "CPT: ",?32,CPT,!
 . . . W "SCT: ",?32,SCT,!
 . . . W "Requesting physician: ",?32,REQPHYS,!
 . . . W "Primary diagnostic code: ",?32,PDIAGCD,!
 . . . W "Primary interpreting resident: ",?32,PIRES,!
 . . . W "Primary interpreting staff: ",?32,PISTAFF,!
 . . . W "Pointer to report text:",?32,RPTTEXT,!
 . . . W "Visit Date: ",?32,VISITDT,"     ",VISITHL,!
 . . . W "PID: ",?32,PID,!
 . . ;PID^PatDfn^Category^ExamDate^ExamDateHl7^CASENBR^PROCIEN^PROC^CPT^SCT^PDIAGCD^REQPHYS^PIRES^PISTAFF^VISITDT^VISITHL^EnteringUser
 . . S SEQ=SEQ+1
 . . S RADEX(SEQ)=PID_U_PatDfn_U_Category_U_ExamDate_U_ExamDateHl7_U_CASENBR_U_PROCIEN_U_PROC_U_CPT_U_SCT_U_PDIAGCD_U_REQPHYS_U_PIRES_U_PISTAFF_U_VISITDT_U_VISITHL_U_EnteringUser
 . . ;
 . . I $G(RPT),RPTTEXT'="" D
 . . . D GETRPT(.RADRPT,RPTTEXT,SITE,SEQ,FRDAT,TODAT)
 . . . M RADEX(SEQ)=RADRPT(SEQ)
 ;
 I $G(DEBUG) W ! W $$ZW^SYNDHPUTL("RADEX")
 ;
 QUIT
 ;
GETRPT(RADRPT,RPTTEXT,SITE,SEQ,FRDAT,TODAT) ; get radiology diagnostic report
 ; Inputs: RPTTEXT - radiology diagnostic report IEN from file #70
 ;         SITE - station number
 ;         SEQ - record sequence
 ; Output: RADRPT array
 ;         RADRPT(1) - PID^dayCase^dateTime^dateTimeHL7^status id^status^verifying physician id^verifying physician name
 ;         RADRPT("REPORT")=report
 ;         RADRPT("IMPRESSION")=impression
 ;
 N FNUM S FNUM=74
 I $G(DEBUG) W "<Radiology Report>"
 N DAYCASE,PRSTA,PRSTATUS,PPROV,PPROVNM,PDATE,PDATEHL
 N PID S PID=$$RESID^SYNDHP69("V",SITE,FNUM,RPTTEXT)
 N PIENS S PIENS=RPTTEXT_","
 N EXARR,EXERR
 D GETS^DIQ(FNUM,PIENS,".01;3;5;9;113","EI","EXARR","EXERR")  ;specific fields
 I $G(DEBUG),$D(EXERR) W !,">>ERROR<<",! W $$ZW^SYNDHPUTL("EXERR")
 QUIT:$D(EXERR)
 S PDATE=$G(EXARR(FNUM,PIENS,3,"I")) ;exam date/time
 QUIT:'$$RANGECK^SYNDHPUTL(PDATE,FRDAT,TODAT)  ;quit if outside of requested date range
 S PDATEHL=$$FMTHL7^XLFDT(PDATE) ;exam date/time HL7
 S DAYCASE=$G(EXARR(FNUM,PIENS,.01,"I")) ;day case#
 S PRSTA=$G(EXARR(FNUM,PIENS,5,"I")) ;report status
 S PRSTATUS=$G(EXARR(FNUM,PIENS,5,"E")) ;report status
 ;S PRSTA=$S(PRSTA="V":"final",PRSTA="D":"partial",1:"unknown") ; there are other possible values
 S PPROV=$G(EXARR(FNUM,PIENS,9,"I")) ;verifying physician ien
 S PPROVNM=$G(EXARR(FNUM,PIENS,9,"E")) ;verifying physician name
 ;
 N REPORT,IMPRESS,RPTTEXT,IMPTEXT,RPTLINE,IMPLINE
 S RPTTEXT=""
 S IMPTEXT=""
 D GETS^DIQ(FNUM,PIENS,200,,"REPORT","EXERR")
 I $G(DEBUG),$D(EXERR) W !,">>ERROR<<",! W $$ZW^SYNDHPUTL("EXERR")
 QUIT:$D(EXERR)
 N N S N=0
 F  S N=$O(REPORT(FNUM,PIENS,200,N)) Q:N=""  D
 . S RPTLINE=REPORT(FNUM,PIENS,200,N)
 . S RPTTEXT=RPTTEXT_RPTLINE
 N EXERR
 D GETS^DIQ(FNUM,PIENS,300,,"IMPRESS","EXERR")
 I $G(DEBUG),$D(EXERR) W !,">>ERROR<<",! W $$ZW^SYNDHPUTL("EXERR")
 QUIT:$D(EXERR)
 N N S N=0
 F  S N=$O(IMPRESS(FNUM,PIENS,300,N)) Q:N=""  D
 . S IMPLINE=IMPRESS(FNUM,PIENS,300,N)
 . S IMPTEXT=IMPTEXT_IMPLINE
 ;
 I $G(DEBUG) D
 . W !,"Exam Date/Time:",?25,PDATE,"     ",PDATEHL,!
 . W "Day-Case#:",?25,DAYCASE,!
 . W "Report Status:",?25,PRSTA,"     ",PRSTATUS,!
 . W "Verifying Physician:",?25,PPROV,"     ",PPROVNM,!
 . W "Report:",?25,RPTTEXT,!
 . W "Impression:",?25,IMPTEXT,!
 S RADRPT(SEQ,1)=PID_U_DAYCASE_U_PDATE_U_PDATEHL_U_PRSTA_U_PRSTATUS_U_PPROV_U_PPROVNM
 S RADRPT(SEQ,"REPORT")=RPTTEXT
 S RADRPT(SEQ,"IMPRESSION")=IMPTEXT
 ;
 QUIT
 ;
