RORX005A ;HOIFO/BH,SG - INPATIENT UTILIZATION (QUERY) ;4/21/09 2:20pm
 ;;1.5;CLINICAL CASE REGISTRIES;**1,8,10,13,19,21**;Feb 17, 2006;Build 45
 ;
 ; This routine uses the following IAs:
 ;
 ; #92           ^DGPT(  #45.7 (controlled)
 ; #417          .01 field and "C" x-ref of file #40.8 (controlled)
 ; #2056         $$GET1^DIQ (supported)
 ; #3545         ^DGPT("AAD" (private)
 ; #10061        IN5^VADPT (supported) 
 ; #10103        FMADD^XLFDT, FMDIFF^XLFDT (supported)
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;ROR*1.5*8    MAR  2010   V CARR       Modified to handle ICD9 filter for
 ;                                      'include' or 'exclude'.
 ;ROR*1.5*13   DEC  2010   A SAUNDERS   User can select specific patients.
 ;ROR*1.5*19   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;                                      
 ;******************************************************************************
 ;******************************************************************************
 Q
 ;
 ;***** ADDS THE INPATIENT STAY
 ;
 ; DFN           Patient IEN (in file #2)
 ; PTFIEN        IEN of the PTF record
 ; LOS           Length of stay
 ; BSID          Bed section ID
 ; DATE          Movement date/time (FileMan)
 ;
ADDSTAY(DFN,PTFIEN,LOS,BSID,DATE) ;
 N DST,I,TMP
 S:$G(BSID)="" BSID=0
 ;--- Number of patients for the bedsection
 I 'BSID  S DST=$NA(@RORDST@("IP",DFN))
 E  S DST=$NA(@RORDST@("IPB",BSID))  D:'$D(@DST@("P",DFN))
 . S @DST@("P")=$G(@DST@("P"))+1,@DST@("P",DFN)=""
 ;--- No bed section ID
 S:BSID<0 @RORDST@("IPNOBS",RORPNAME,DATE,PTFIEN,DFN)=""
 ;--- Short stays (visits)
 I LOS'>0  S @DST@("V")=$G(@DST@("V"))+1  Q
 ;--- Days and stays
 S @DST@("D")=$G(@DST@("D"))+LOS
 S @DST@("S")=$G(@DST@("S"))+1
 ;--- Lengths of stay for median value calculations
 S I=$O(@RORDST@("IPMLOS",BSID,LOS,""),-1)+1
 S @RORDST@("IPMLOS",BSID,LOS,I)=""
 Q
 ;
 ;***** LOADS AND PROCESSES THE INPATIENT DATA
 ;
 ; DFN           Patient IEN (in file #2)
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Number of non-fatal errors
 ;
IPDATA(DFN) ;
 N RORDST        ; Closed reference to the category node in ^TMP
 ;
 N BSID,DATE,DISDT,ENDT,FACILITY,LOS,PTFIEN,RC,RORMSG,STDT,SUFFIX,TMP,VAHOW,VAIP,VAROOT,XDATE
 S RORDST=$NA(^TMP("RORX005",$J))
 ;---
 S XDATE=RORSDT
 F  S RC=0  D  Q:RC<2  S XDATE=$O(^DGPT("AAD",DFN,XDATE))  Q:XDATE'>0
 . I XDATE'<ROREDT1  S RC=1  Q
 . K DATE,LOS,VAIP  S VAIP(16,1)=XDATE
 . F  D  Q:RC
 . . S VAIP("D")=+$G(VAIP(16,1))
 . . I VAIP("D")'>0  S RC=2  Q
 . . D IN5^VADPT
 . . I $G(VAIP(1))'>0  S RC=2  Q
 . . S DATE=+VAIP(3)
 . . Q:+$G(VAIP(4))=3
 . . ;--- Check the movement date
 . . I DATE'<ROREDT1  S RC=1  Q
 . . S:DATE<RORSDT DATE=RORSDT
 . . ;--- Check the PTF record - Task removed April 2009
 . . S PTFIEN=+$G(VAIP(12))  Q:PTFIEN'>0
 . . I '$D(PTFIEN(PTFIEN))  D  Q:RC
 . . . S PTFIEN(PTFIEN)=0
 . . . Q:$$PTF^RORXU001(PTFIEN,"FP",,,.SUFFIX,,.FACILITY)
 . . . ;--- Check the suffix
 . . . ;I SUFFIX'=""  Q:$$VSUFFIX(SUFFIX)  ; ROR 1.5
 . . . ;--- Check the division
 . . . S TMP=$$PARAM^RORTSK01("DIVISIONS","ALL")
 . . . I 'TMP  D  Q:'$D(RORTSK("PARAMS","DIVISIONS","C",DIVIEN))
 . . . . S TMP=FACILITY_SUFFIX
 . . . . S DIVIEN=$S(TMP'="":+$O(^DG(40.8,"C",TMP,"")),1:0)
 . . . K DIVIEN ;kill statement added
 . . . S PTFIEN(PTFIEN)=1
 . . ;--- Skip the PTF record if necessary
 . . Q:'PTFIEN(PTFIEN)
 . . ;--- Process the admission (only once)
 . . I '$D(LOS)  D  Q:RC
 . . . S LOS=$$LOS(+$G(VAIP(13,1)),+$G(VAIP(17,1)))
 . . . D ADDSTAY(DFN,PTFIEN,LOS)
 . . ;--- Process the movement
 . . S ENDT=$G(VAIP(16,1))\1
 . . S:(ENDT'>0)!(ENDT'<ROREDT1) ENDT=ROREDT,RC=2
 . . Q:ENDT<RORSDT
 . . S LOS=$$FMDIFF^XLFDT(ENDT,DATE\1,1)  S:LOS'>0 LOS=0
 . . ;--- Use the IEN in the SPECIALTY file (#42.4) as the Bedsection 
 . . ;    ID if it is available (it should be). Otherwise, use the
 . . ;--- IEN in the FACILITY TREATING SPECIALTY file (#45.7).
 . . I $G(VAIP(8))>0  D
 . . . K RORMSG S TMP=$$GET1^DIQ(45.7,+VAIP(8),1,"I",,"RORMSG")
 . . . ;D:$G(DIERR) DBS^RORERR("RORMSG",-9,,DFN,45.7,+VAIP(8))
 . . . D:$G(RORMSG("DIERR")) DBS^RORERR("RORMSG",-9,,DFN,45.7,+VAIP(8))
 . . . S BSID=$S(TMP>0:TMP_";42.4",1:+VAIP(8)_";45.7")
 . . E  S BSID=-1
 . . D ADDSTAY(DFN,PTFIEN,LOS,BSID,+VAIP(3))
 . S:$G(DATE)>XDATE XDATE=DATE
 ;---
 Q $S(RC<0:RC,1:0)
 ;
 ;***** CALCULATES THE LENGTH OF STAY
LOS(STDT,ENDT) ;
 N DAYS
 S:STDT<RORSDT STDT=RORSDT
 S:(ENDT'>0)!(ENDT>ROREDT) ENDT=ROREDT
 S DAYS=$$FMDIFF^XLFDT(ENDT\1,STDT\1,1)
 Q $S(DAYS'<0:DAYS,1:0)
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
 N RORLAST4      ; Last 4 digits of the current patient's SSN
 N RORPNAME      ; Name of the current patient
 N RORICN        ; National ICN
 N RORPTN        ; Number of patients in the registry
 ;
 N CNT,ECNT,IEN,IENS,PATIEN,RC,TMP,VA,VADM,XREFNODE
 N RCC,FLAG
 S XREFNODE=$NA(^RORDATA(798,"AC",+RORREG))
 S RORPTN=$$REGSIZE^RORUTL02(+RORREG)  S:RORPTN<0 RORPTN=0
 S ROREDT1=$$FMADD^XLFDT(ROREDT,1)
 S (CNT,ECNT,RC)=0
 ;--- Browse through the registry records
 S IEN=0
 S FLAG=$G(RORTSK("PARAMS","ICDFILT","A","FILTER"))
 F  S IEN=$O(@XREFNODE@(IEN))  Q:IEN'>0  D  Q:RC<0
 . S TMP=$S(RORPTN>0:CNT/RORPTN,1:"")
 . S RC=$$LOOP^RORTSK01(TMP)  Q:RC<0
 . S IENS=IEN_",",CNT=CNT+1
 . ;--- Get the patient DFN
 . S PATIEN=$$PTIEN^RORUTL01(IEN)  Q:PATIEN'>0
 . ;check for patient list and quit if not on list
 . I $D(RORTSK("PARAMS","PATIENTS","C")),'$D(RORTSK("PARAMS","PATIENTS","C",PATIEN)) Q
 . ;--- Check if the patient should be skipped
 . Q:$$SKIP^RORXU005(IEN,FLAGS,RORSDT,ROREDT)
 . ;--- Filter patient on ICD codes
 . S RCC=0
 . I FLAG'="ALL" D
 . . S RCC=$$ICD^RORXU010(PATIEN)
 . I (FLAG="INCLUDE")&(RCC=0) Q
 . I (FLAG="EXCLUDE")&(RCC=1) Q
 . ;--- End of filter
 . ;
 . ;--- Get the patient's data
 . D VADEM^RORUTL05(PATIEN,1)
 . S RORPNAME=VADM(1),RORLAST4=VA("BID")
 . S RORICN=$S($$PARAM^RORTSK01("PATIENTS","ICN"):$$ICN^RORUTL02(PATIEN),1:"")
 . ;
 . ;--- Get the inpatient data
 . S RC=$$IPDATA(PATIEN)
 . I RC  S ECNT=ECNT+1  Q:RC<0
 . ;
 . ;--- Calculate intermediate totals
 . S RC=$$TOTALS^RORX005B(PATIEN)
 . I RC  S ECNT=ECNT+1  Q:RC<0
 ;---
 Q $S(RC<0:RC,1:ECNT)
 ;
 ;***** CHECKS THE SUFFIX FOR VALIDITY
 ;
 ; SUFFIX        Suffix
 ;
 ; Return Values:
 ;        0  Ok
 ;        1  Invalid suffix
VSUFFIX(SUFFIX) ;
 Q '("9AA,9AB,9AC,9AD,9AE,9BB,A0,A4,A5,BU,BV,PA"[SUFFIX)
