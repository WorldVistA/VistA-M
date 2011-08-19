RORX009A ;HOIFO/SG,VAC - PRESCRIPTION UTILIZ. (QUERY & SORT) ;4/7/09 2:08pm
 ;;1.5;CLINICAL CASE REGISTRIES;**8,13**;Feb 17, 2006;Build 27
 ;
 ; This routine uses the following IAs:
 ;
 ; #10103         FMADD^XLFDT (supported)
 ;   
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*8    MAR  2010   V CARR       Modified to handle ICD9 filter for
 ;                                      'include' or 'exclude'.
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   User can select specific patients,
 ;                                      clinics, or divisions for the report.
 ;                                      
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** QUERIES THE REGISTRY
 ;
 ; FLAGS         Flags for the $$SKIP^RORXU005
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
QUERY(FLAGS) ;
 N ROREDT1       ; Day after the end date
 N RORPTN        ; Number of patients in the registry
 N RORCDLIST     ; Flag to indicate whether a clinic or division list exists
 N RORCDSTDT     ; Start date for clinic/division utilization search
 N RORCDENDT     ; End date for clinic/division utilization search
 ;
 N CNT,ECNT,IEN,IENS,PATIEN,RC,RORXDST,RXFLAGS,TMP,XREFNODE
 N RCC,FLAG
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S ROREDT1=$$FMADD^XLFDT(ROREDT,1)
 S (CNT,ECNT,RC)=0
 ;
 ;--- Prepare parameters for the pharmacy search API
 S RORXDST=$NA(^TMP("RORX009",$J))
 S RORXDST("RORCB")="$$RXSCB^RORX009A"
 S RORXDST("GENERIC")=$$PARAM^RORTSK01("DRUGS","AGGR_GENERIC")
 S RXFLAGS="E"
 S:$$PARAM^RORTSK01("PATIENTS","INPATIENT") RXFLAGS=RXFLAGS_"IV"
 S:$$PARAM^RORTSK01("PATIENTS","OUTPATIENT") RXFLAGS=RXFLAGS_"O"
 Q:RXFLAGS="E" 0
 ;
 ;=== Set up Clinic/Division list parameters
 S RORCDLIST=$$CDPARMS^RORXU001(.RORTSK,.RORCDSTDT,.RORCDENDT)
 ;
 ;--- Browse through the registry records
 S IEN=0
 S FLAG=$G(RORTSK("PARAMS","ICD9FILT","A","FILTER"))
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN)  Q:PATIEN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS,RORSDT,ROREDT)
 . ;--- Check if patient filtered for ICD9 Codes
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN,RORREG)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- End of ICD9 Filter check.
 . ;
 . ;--- Check for Clinic or Division list and quit if not in list
 . I RORCDLIST,'$$CDUTIL^RORXU001(.RORTSK,PATIEN,RORCDSTDT,RORCDENDT) Q
 . ;
 . ;--- Search the pharmacy data
 . M RORXDST("RORXGRP")=RORXGRP("C")
 . S TMP=$$RXSEARCH^RORUTL14(PATIEN,RORXL,.RORXDST,RXFLAGS,RORSDT,ROREDT1)
 . I TMP<0  S ECNT=ECNT+1  Q
 . ;--- No medications from some groups
 . Q:$D(RORXDST("RORXGRP"))>1
 . ;--- Skip the patient if no data has been found
 . I '$D(@RORXDST@("IP",PATIEN)),'$D(@RORXDST@("OP",PATIEN))  Q
 . ;
 . ;--- Calculate intermediate totals
 . S RC=$$TOTALS(PATIEN)
 . I RC  S ECNT=ECNT+1  Q:RC<0
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CALLBACK FUNCTION FOR THE PHARMACY SEARCH API
RXSCB(ROR8DST,ORDER,ORDFLG,DRUG,DATE) ;
 N DRUGIEN,DRUGNAME,IRP,RPS,RXCNT,SUBS,TMP
 I ROR8DST("GENERIC")  D
 . S DRUGIEN=+ROR8DST("RORXGEN"),DRUGNAME=$P(ROR8DST("RORXGEN"),U,2)
 E  S DRUGIEN=+DRUG,DRUGNAME=$P(DRUG,U,2)
 Q:(DRUGIEN'>0)!(DRUGNAME="") 1
 ;=== Check the drug groups
 S TMP=$$RXGRPCHK^RORXU007(.ROR8DST,+DRUG,RORXL)
 Q:TMP TMP
 ;=== Process the order
 S SUBS=$S(ORDFLG["I":"IP",ORDFLG["O":"OP",1:"")  Q:SUBS="" 1
 S RXCNT=0
 ;--- Count the original order, refills and partials
 I ORDFLG["I"  S RXCNT=RXCNT+1  ; Inpatient
 E  D                           ; Outpatient
 . S TMP=+$P($G(^TMP("PS",$J,"RXN",0)),U,6)  ; Original Fill Date
 . S:(TMP'<ROR8DST("RORSDT"))&(TMP<ROR8DST("ROREDT")) RXCNT=RXCNT+1
 F RPS="PAR","REF"  S IRP=0  D
 . F  S IRP=$O(^TMP("PS",$J,RPS,IRP))  Q:IRP'>0  S RXCNT=RXCNT+1
 ;--- Update the counters
 D:RXCNT>0
 . S TMP=$G(@ROR8DST@(SUBS,+ROR8DST("RORDFN"),"D",DRUGIEN))
 . S @ROR8DST@(SUBS,+ROR8DST("RORDFN"),"D",DRUGIEN)=TMP+RXCNT
 . S TMP=SUBS_"D"
 . S:'$D(@ROR8DST@(TMP,DRUGIEN)) @ROR8DST@(TMP,DRUGIEN)=DRUGNAME
 Q 0
 ;
 ;***** SORTS THE RESULTS AND COMPILES THE TOTALS
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
SORT() ;
 N ECNT,NODE,RC
 S (ECNT,RC)=0
 S NODE=$NA(^TMP("RORX009",$J))
 Q:$D(@NODE)<10 0
 ;---
 S RC=$$LOOP^RORTSK01(0)    Q:RC<0 RC
 D SORTRX(NODE,"IPD")
 ;---
 S RC=$$LOOP^RORTSK01(.33)  Q:RC<0 RC
 D SORTRX(NODE,"OPD")
 ;---
 S RC=$$LOOP^RORTSK01(.66)  Q:RC<0 RC
 S RC=$$SUMRX(NODE)
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** SORTS THE DRUG LIST
 ;
 ; NODE          Closed root of the category section
 ;               in the temporary global
 ;
 ; SUBS          Drug list subscript ("IPD" or "OPD")
 ;
SORTRX(NODE,SUBS) ;
 N IEN,NAME,NDRUGS,SUM,TMP
 S IEN=0,NDRUGS=0
 F  S IEN=$O(@NODE@(SUBS,IEN))  Q:IEN'>0  D
 . S NAME=@NODE@(SUBS,IEN),NDRUGS=NDRUGS+1
 . S TMP=+$G(@NODE@(SUBS,IEN,"D"))
 . S @NODE@(SUBS,"B",TMP,NAME,IEN)=""
 ;--- Numbers of different drugs
 S @NODE@(SUBS)=NDRUGS
 Q
 ;
 ;***** COMBINES THE INPATIENT AND OUTPATIENT DATA
 ;
 ; NODE          Closed root of the category section
 ;               in the temporary global
 ;
SUMRX(NODE) ;
 N COUNT,I,MAXUTNUM,NDRX,NRX,RC,RXIEN,SUMNRX,TMP
 Q:($D(@NODE@("IPRX"))<10)!($D(@NODE@("OPRX"))<10) 0
 S MAXUTNUM=$$PARAM^RORTSK01("MAXUTNUM")
 Q:MAXUTNUM'>0 0
 ;
 ;=== Outpatient data
 S NRX="",(COUNT,RC)=0
 F  S NRX=$O(@NODE@("OPRX",NRX),-1)  Q:NRX=""  D  Q:RC
 . S RC=$$LOOP^RORTSK01()  Q:RC<0
 . S @NODE@("SUMRX",NRX)=$G(@NODE@("OPRX",NRX))
 . S NAME=""
 . F  S NAME=$O(@NODE@("OPRX",NRX,NAME))  Q:NAME=""  D  Q:RC
 . . S DFN=""
 . . F  S DFN=$O(@NODE@("OPRX",NRX,NAME,DFN))  Q:DFN=""  D  Q:RC
 . . . ;--- Include only the patients with highest utilization
 . . . S COUNT=COUNT+1  I COUNT>MAXUTNUM  S RC=1  Q
 . . . ;--- Calculate the totals
 . . . S (NDRX,SUMNRX)=0
 . . . F I="IP","OP"  S TMP=$G(@NODE@(I,DFN))  D
 . . . . S NDRX=NDRX+$P(TMP,U,5),SUMNRX=SUMNRX+$P(TMP,U,4)
 . . . S @NODE@("SUMRX",SUMNRX,NAME,DFN,"OP")=""
 . . . S @NODE@("SUMRX",SUMNRX)=$G(@NODE@("SUMRX",SUMNRX))+1
 . . . ;--- Adjust the total number of different drugs
 . . . ;--- (some drugs could be both inpatient and outpatient)
 . . . S RXIEN=0
 . . . F  S RXIEN=$O(@NODE@("OP",DFN,"D",RXIEN))  Q:RXIEN'>0  D
 . . . . S:$D(@NODE@("IP",DFN,"D",RXIEN)) NDRX=NDRX-1
 . . . ;--- Store the number of different drugs
 . . . S @NODE@("SUMRX",SUMNRX,NAME,DFN)=NDRX
 ;
 ;=== Inpatient data
 S NRX="",(COUNT,RC)=0
 F  S NRX=$O(@NODE@("IPRX",NRX),-1)  Q:NRX=""  D  Q:RC
 . S RC=$$LOOP^RORTSK01()  Q:RC<0
 . S NAME=""
 . F  S NAME=$O(@NODE@("IPRX",NRX,NAME))  Q:NAME=""  D  Q:RC
 . . S DFN=""
 . . F  S DFN=$O(@NODE@("IPRX",NRX,NAME,DFN))  Q:DFN=""  D  Q:RC
 . . . ;--- Include only the patients with highest utilization
 . . . S COUNT=COUNT+1  I COUNT>MAXUTNUM  S RC=1  Q
 . . . ;--- Calculate the totals
 . . . S (NDRX,SUMNRX)=0
 . . . F I="IP","OP"  S TMP=$G(@NODE@(I,DFN))  D
 . . . . S NDRX=NDRX+$P(TMP,U,5),SUMNRX=SUMNRX+$P(TMP,U,4)
 . . . S @NODE@("SUMRX",SUMNRX,NAME,DFN,"IP")=""
 . . . ;--- Quit if the patient has been processed already
 . . . Q:$D(@NODE@("SUMRX",SUMNRX,NAME,DFN,"OP"))
 . . . S @NODE@("SUMRX",SUMNRX)=$G(@NODE@("SUMRX",SUMNRX))+1
 . . . ;--- Adjust the total number of different drugs
 . . . ;--- (some drugs could be both inpatient and outpatient)
 . . . S RXIEN=0
 . . . F  S RXIEN=$O(@NODE@("IP",DFN,"D",RXIEN))  Q:RXIEN'>0  D
 . . . . S:$D(@NODE@("OP",DFN,"D",RXIEN)) NDRX=NDRX-1
 . . . ;--- Store the number of different drugs
 . . . S @NODE@("SUMRX",SUMNRX,NAME,DFN)=NDRX
 ;===
 Q $S(RC<0:RC,1:0)
 ;
 ;***** CALCULATES THE INTERMEDIATE TOTALS
 ;
 ; PATIEN        Patient IEN (DFN)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
TOTALS(PATIEN) ;
 N DOD,IEN,LAST4,NDRUGS,NODE,NRX,PTNAME,PTNRX,RXS,SUBS,TMP,VA,VADM,VAERR
 S NODE=$NA(^TMP("RORX009",$J))
 ;--- Get the patient's data
 D VADEM^RORUTL05(PATIEN,1)
 S PTNAME=VADM(1),LAST4=VA("BID"),DOD=$$DATE^RORXU002(VADM(6)\1)
 ;---
 F SUBS="IP","OP"  D:$D(@NODE@(SUBS,PATIEN))>1
 . S RXS=SUBS_"D"
 . S IEN=0,(NDRUGS,PTNRX)=0
 . F  S IEN=$O(@NODE@(SUBS,PATIEN,"D",IEN))  Q:IEN'>0  D
 . . S NRX=@NODE@(SUBS,PATIEN,"D",IEN)
 . . S NDRUGS=NDRUGS+1,PTNRX=PTNRX+NRX
 . . ;---
 . . S @NODE@(RXS,IEN,"D")=$G(@NODE@(RXS,IEN,"D"))+NRX
 . . S @NODE@(RXS,IEN,"P")=$G(@NODE@(RXS,IEN,"P"))+1
 . . ;---
 . . S TMP=$G(@NODE@(RXS,IEN,"M"))
 . . D:NRX'<TMP
 . . . I NRX>TMP  S @NODE@(RXS,IEN,"M")=NRX_U_1  Q
 . . . S $P(@NODE@(RXS,IEN,"M"),U,2)=$P(TMP,U,2)+1
 . ;---
 . S @NODE@(SUBS)=$G(@NODE@(SUBS))+1
 . S @NODE@(SUBS,PATIEN)=LAST4_U_PTNAME_U_DOD_U_PTNRX_U_NDRUGS
 . ;---
 . S RXS=SUBS_"RX"
 . S @NODE@(RXS)=$G(@NODE@(RXS))+PTNRX
 . S @NODE@(RXS,PTNRX)=$G(@NODE@(RXS,PTNRX))+1
 . S @NODE@(RXS,PTNRX,PTNAME,PATIEN)=""
 ;---
 Q 0
