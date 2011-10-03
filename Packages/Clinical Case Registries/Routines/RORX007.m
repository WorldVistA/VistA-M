RORX007 ;HCIOFO/BH,SG - RADIOLOGY UTILIZATION ; 10/14/05 1:37pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #10061        DEM^VADPT (supported)
 ;
 Q
 ;
 ;***** COMPILES THE "RADIOLOGY UTILIZATION" REPORT
 ; REPORT CODE: 007
 ;
 ; .RORTSK       Task number and task parameters
 ;
 ; The ^TMP("RORX007",$J) and ^TMP($J,"RAE1") global nodes are
 ; used by this function.
 ;
 ; ^TMP("RORX007",$J,
 ;
 ;     "PAT",
 ;       DFN,
 ;         ProcName)     Number of procedures
 ;
 ;     "PATSORT",
 ;       ProcQnty,
 ;         Name,
 ;           Last4)      Patient data
 ;                         ^01: Number of different procedures
 ;                         ^02: Date of death
 ;
 ;     "PROC",
 ;       ProcName,
 ;         DFN)          Number of procedures
 ;
 ;     "PROCSORT",
 ;       ProcQnty,
 ;         ProcName,
 ;           CPT)        Number of individual patients
 ;
 ;     "TOTAL")          Category Totals
 ;                         ^01: Total number of procedures
 ;                         ^02: Number of different procedures
 ;                         ^03: Total number of patients
 ;                         ^04: Number of individual patients
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
RADUTL(RORTSK) ;
 N ROREDT        ; End date
 N RORREG        ; Registry IEN
 N RORSDT        ; Start date
 ;
 N CNT,ECNT,RC,REPORT,RORPTN,SFLAGS,TMP
 ;--- Root node of the report
 S REPORT=$$ADDVAL^RORTSK11(RORTSK,"REPORT")
 Q:REPORT<0 REPORT
 ;
 ;--- Get and prepare the report parameters
 S RORREG=$$PARAM^RORTSK01("REGIEN")
 S RC=$$PARAMS^RORX007A(REPORT,.RORSDT,.ROREDT,.SFLAGS)
 Q:RC<0 RC
 ;
 ;--- Initialize constants and variables
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S ECNT=0  K ^TMP("RORX007",$J)
 ;
 ;--- Report header
 S RC=$$HEADER^RORX007A(REPORT)  Q:RC<0 RC
 ;
 D
 . ;--- Query the registry
 . D TPPSETUP^RORTSK01(75)
 . S RC=$$QUERY^RORX007A(SFLAGS)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Sort the data
 . D TPPSETUP^RORTSK01(10)
 . S RC=$$SORT()
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 . ;--- Store the results
 . D TPPSETUP^RORTSK01(15)
 . S RC=$$STORE(REPORT)
 . I RC  Q:RC<0  S ECNT=ECNT+RC
 ;
 ;--- Cleanup
 K ^TMP("RORX007",$J),^TMP($J,"RAE1")
 Q $S(RC<0:RC,ECNT>0:-43,1:0)
 ;
 ;***** SORTS THE RESULTS AND COMPILES THE TOTALS
 ;
 ; SPCNT         Number of patients selected for the report
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
SORT(SPCNT) ;
 N DFN,DOD,DPCNT,ECNT,NAME,NODE,PRCNT,PQ,PRN,RC,TMP,TOTAL,VA,VADM,VAHOW,VAROOT
 S (ECNT,RC)=0
 S NODE=$NA(^TMP("RORX007",$J))
 Q:$D(@NODE)<10 0
 ;--- Procedures
 S RC=$$LOOP^RORTSK01(0)  Q:RC<0 RC
 S PRN=""
 F  S PRN=$O(@NODE@("PROC",PRN))  Q:PRN=""  D
 . S (DPCNT,PRCNT)=0
 . S DFN=""
 . F  S DFN=$O(@NODE@("PROC",PRN,DFN))  Q:DFN=""  D
 . . S PQ=$G(@NODE@("PROC",PRN,DFN))
 . . S DPCNT=DPCNT+1,PRCNT=PRCNT+PQ
 . ;---
 . S @NODE@("PROCSORT",PRCNT,$P(PRN,U),$P(PRN,U,2))=DPCNT
 . S TOTAL("DPR")=$G(TOTAL("DPR"))+1      ; Different procedures
 . S TOTAL("TPT")=$G(TOTAL("TPT"))+DPCNT  ; Number of patients
 K @NODE@("PROC")
 ;--- Patients
 S RC=$$LOOP^RORTSK01(0.5)  Q:RC<0 RC
 S DFN=""
 F  S DFN=$O(@NODE@("PAT",DFN))  Q:DFN=""  D
 . S (DPCNT,PRCNT)=0
 . D DEM^VADPT
 . S NAME=$G(VADM(1))  Q:NAME=""
 . S LAST4=$G(VA("BID"))  S:LAST4="" LAST4=" "
 . S DOD=$$DATE^RORXU002($P(VADM(6),U)\1)
 . S PRN=""
 . F  S PRN=$O(@NODE@("PAT",DFN,PRN))  Q:PRN=""  D
 . . S PQ=$G(@NODE@("PAT",DFN,PRN))
 . . S DPCNT=DPCNT+1,PRCNT=PRCNT+PQ
 . ;---
 . S @NODE@("PATSORT",PRCNT,NAME,LAST4)=DPCNT_U_DOD
 . S TOTAL("TPR")=$G(TOTAL("TPR"))+PRCNT  ; Number of procedures
 . S TOTAL("DPT")=$G(TOTAL("DPT"))+1      ; Different patients
 K @NODE@("PAT")
 ;--- Totals
 S TMP=$G(TOTAL("TPR"))_U_$G(TOTAL("DPR"))
 S @NODE@("TOTAL")=TMP_U_$G(TOTAL("TPT"))_U_$G(TOTAL("DPT"))
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** STORES THE RESULTS
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
STORE(PARTAG) ;
 N RORSONLY      ; Output summary only
 ;
 N RC,TMP
 S RORSONLY=$$SMRYONLY^RORXU006()
 S RC=0
 ;--- Tables
 Q:$D(^TMP("RORX007",$J))<10 0
 ;--- Procedures
 S RC=$$LOOP^RORTSK01(0)    Q:RC<0 RC
 S RC=$$TBLPROC(PARTAG)     Q:RC<0 RC
 ;--- Patients
 S RC=$$LOOP^RORTSK01(0.5)  Q:RC<0 RC
 S RC=$$TBLPAT(PARTAG)      Q:RC<0 RC
 ;--- Totals
 S TMP=$G(^TMP("RORX007",$J,"TOTAL"))
 D ADDVAL^RORTSK11(RORTSK,"NPR",$P(TMP,U,1),PARTAG)
 D ADDVAL^RORTSK11(RORTSK,"NDP",$P(TMP,U,2),PARTAG)
 D ADDVAL^RORTSK11(RORTSK,"NP",$P(TMP,U,4),PARTAG)
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** STORES THE TABLE OF PATIENTS
 ;
 ; PRNTELMT      IEN of the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TBLPAT(PRNTELMT) ;
 N BUF,ITEM,LAST4,MAXUTNUM,NAME,NODE,PRCNT,RC,TABLE,TMP,UTNUM
 S MAXUTNUM=$$PARAM^RORTSK01("MAXUTNUM")
 Q:MAXUTNUM'>0 0
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"PATIENTS",,PRNTELMT)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","PATIENTS")
 S NODE=$NA(^TMP("RORX007",$J,"PATSORT"))
 ;--- Table
 S PRCNT="",(RC,UTNUM)=0
 F  S PRCNT=$O(@NODE@(PRCNT),-1)  Q:PRCNT=""  D  Q:RC
 . S NAME=""
 . F  S NAME=$O(@NODE@(PRCNT,NAME))  Q:NAME=""  D  Q:RC
 . . S LAST4=""
 . . F  S LAST4=$O(@NODE@(PRCNT,NAME,LAST4))  Q:LAST4=""  D  Q:RC
 . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PATIENT",,TABLE)
 . . . D ADDVAL^RORTSK11(RORTSK,"NAME",NAME,ITEM,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"LAST4",LAST4,ITEM,1)
 . . . S BUF=@NODE@(PRCNT,NAME,LAST4)
 . . . D ADDVAL^RORTSK11(RORTSK,"DOD",$P(BUF,U,2),ITEM,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"TOTAL",PRCNT,ITEM,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"UNIQUE",+BUF,ITEM,1)
 . . . S UTNUM=UTNUM+1  S:UTNUM'<MAXUTNUM RC=1
 Q:RC<0 RC
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** STORES THE TABLE OF PROCEDURES
 ;
 ; PRNTELMT      IEN of the parent tag
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TBLPROC(PRNTELMT) ;
 N CPT,ITEM,MINRPNUM,NODE,PRCNT,PRN,TABLE,TMP
 S MINRPNUM=$$PARAM^RORTSK01("MINRPNUM")
 Q:MINRPNUM'>0 0
 S TABLE=$$ADDVAL^RORTSK11(RORTSK,"PROCEDURES",,PRNTELMT)
 Q:TABLE<0 TABLE
 D ADDATTR^RORTSK11(RORTSK,TABLE,"TABLE","PROCEDURES")
 S NODE=$NA(^TMP("RORX007",$J,"PROCSORT"))
 ;--- Table
 S PRCNT="",RC=0
 F  S PRCNT=$O(@NODE@(PRCNT),-1)  Q:PRCNT<MINRPNUM  D  Q:RC
 . S PRN=""
 . F  S PRN=$O(@NODE@(PRCNT,PRN))  Q:PRN=""  D  Q:RC
 . . S CPT=""
 . . F  S CPT=$O(@NODE@(PRCNT,PRN,CPT))  Q:CPT=""  D  Q:RC
 . . . S ITEM=$$ADDVAL^RORTSK11(RORTSK,"PROCEDURE",,TABLE)
 . . . D ADDVAL^RORTSK11(RORTSK,"NAME",PRN,ITEM,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"CPT",CPT,ITEM,2)
 . . . S TMP=+@NODE@(PRCNT,PRN,CPT)
 . . . D ADDVAL^RORTSK11(RORTSK,"PATIENTS",TMP,ITEM,1)
 . . . D ADDVAL^RORTSK11(RORTSK,"TOTAL",PRCNT,ITEM,1)
 Q:RC<0 RC
 ;---
 Q $S(RC<0:RC,1:0)
