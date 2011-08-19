RORX016B ;HCIOFO/BH,SG - OUTPATIENT UTILIZATION (SORT) ; 9/14/05 10:08am
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 Q
 ;
 ;***** SORTS THE RESULTS AND COMPILES THE TOTALS
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
SORT() ;
 N I,NDSC,NAME,NODE,NSC,NV,RC,RORBUF,RORMSG,STOP,TMP
 S NODE=$NA(^TMP("RORX016",$J))  Q:$D(@NODE)<10 0
 ;--- Outpatient stop codes
 S RC=$$LOOP^RORTSK01(0)  Q:RC<0 RC
 S STOP="",(NDSC,NSC)=0
 F  S STOP=$O(@NODE@("OPS",STOP))  Q:STOP=""  D
 . S NSC=NSC+$G(@NODE@("OPS",STOP,"S")),NDSC=NDSC+1
 . D FIND^DIC(40.7,,"@;.01","UX",STOP,1,"C",,,"RORBUF","RORMSG")
 . D:$G(DIERR) DBS^RORERR("RORMSG",-9,,,40.7)
 . S NAME=$G(RORBUF("DILIST","ID",1,.01))  K RORBUF
 . S @NODE@("OPS",STOP)=$S(NAME'="":NAME,1:"Unknown")
 S @NODE@("OPS")=NSC_U_NDSC
 ;---
 Q 0
 ;
 ;***** CALCULATES THE INTERMEDIATE TOTALS
 ;
 ; PATIEN        Patient IEN (DFN)
 ; CATSUB        Category subscript in the temporary global
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;
TOTALS(PATIEN) ;
 N NODE,TMP
 S NODE=$NA(^TMP("RORX016",$J))
 ;
 ;=== Outpatient data
 D:$D(@NODE@("OP",PATIEN))>1
 . N DATE,NDSC,NPSC,NSC,NV,NVSC,SCLST,STOP
 . S @NODE@("OP")=$G(@NODE@("OP"))+1
 . ;---
 . S (DATE,NPSC,NV)=0
 . F  S DATE=$O(@NODE@("OP",PATIEN,DATE))  Q:DATE'>0  D
 . . S NV=NV+1                              ; Number of visits
 . . S NVSC=@NODE@("OP",PATIEN,DATE)        ; Number of visist's stops
 . . ;--- Count the patient's stops
 . . S STOP=""
 . . F  S STOP=$O(@NODE@("OP",PATIEN,DATE,STOP))  Q:STOP=""  D
 . . . S NSC=@NODE@("OP",PATIEN,DATE,STOP)  ; Number of stops
 . . . S @NODE@("OPS",STOP,"S")=$G(@NODE@("OPS",STOP,"S"))+NSC
 . . . S @NODE@("OPS",STOP,"V")=$G(@NODE@("OPS",STOP,"V"))+(NSC/NVSC)
 . . . S SCLST(STOP)=""
 . . S NPSC=NPSC+NVSC                       ; Total number of stops
 . K @NODE@("OP",PATIEN)
 . ;--- Count the different stops and patients
 . S STOP="",NDSC=0
 . F  S STOP=$O(SCLST(STOP))  Q:STOP=""  D
 . . S @NODE@("OPS",STOP,"P")=$G(@NODE@("OPS",STOP,"P"))+1
 . . S NDSC=NDSC+1                          ; Number of diff. stops
 . ;--- Count the visits
 . S:NV>0 @NODE@("OPV")=$G(@NODE@("OPV"))+NV
 . ;--- Count the stop codes
 . D:NPSC>0
 . . S @NODE@("OP",PATIEN)=NPSC_U_NDSC_U_$G(VA("BID"))_U_NV
 . . S @NODE@("OPS1",NPSC)=$G(@NODE@("OPS1",NPSC))+1
 . . S @NODE@("OPS1",NPSC,RORPNAME,PATIEN)=""
 Q 0
