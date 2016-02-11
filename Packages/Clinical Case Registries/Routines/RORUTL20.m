RORUTL20 ;ALBFO/TK - INPATIENT PROCEDURES UTILITIES ;1/29/07 9:53am
 ;;1.5;CLINICAL CASE REGISTRIES;**26**;Feb 17, 2006;Build 53
 ;
 ; This routine uses the following IAs:
 ;
 ; #6130         PTFICD^DGPTFUT
 ; #4205         CPTINFO^DGAPI
 ;               PTFINFO^DGAPI
 ; #2056         GETS^DIQ
 ; #1995         CODEC^ICPTCOD
 ; #5747         CODEC^ICDEX
 ; #2055         ROOT^DILFD
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                 --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;
 ;ROR*1.5*26   APR  2015   T KOPP       Added routine for all PTF procedures
 ;                                      extract utility (INPROC)
 ;
 ;******************************************************************************
 ;******************************************************************************
 Q
 ; Input:
 ;  DE = the code representing the type of procedure to extract (C=CPT,I=ICD)
 ;  IENS: the iens variable for the entry in file 45 (example: "10,")
 ;  RORUPD: array passed by reference to accommodate use of the RORUPD("DSBEG")
 ;          and RORUPD("ROREND") pre-set values.  
 ; Output:
 ;    Sets up RORVALS array for other procedure, surgical procedure and CPT multiples in file 45
 ;
SETPROC(DE,IENS,RORUPD,RORVALS) ;
 N RORBUF,RORTYPE
 S DE=$G(DE,"B")
 S RORTYPE=$S(DE=152:"I",DE="153":"C",1:DE)
 D INPROC(IENS,RORTYPE,.RORBUF,$G(RORUPD("DSBEG"),2850101),$G(RORUPD("DSEND"),9999999))
 I $G(RORBUF(0))>0 D
 . I RORTYPE="I"!(RORTYPE="B") D
 . . N S1,S2,SCT
 . . S S1="ICD",S2="",SCT=0
 . . F  S S2=$O(RORBUF(S1,S2)) Q:S2=""  D
 . . . S SCT=SCT+1,RORVALS("PPTF","I",SCT,"I")=$P(RORBUF(S1,S2),U,2)
 . I RORTYPE="C"!(RORTYPE="B") D
 . . N S1,S2,SCT
 . . S S1="CPT",S2="",SCT=0
 . . F  S S2=$O(RORBUF(S1,S2)) Q:S2=""  D
 . . . S SCT=SCT+1,RORVALS("PPTF","C",SCT,"I")=$P(RORBUF(S1,S2),U,2)
 Q
 ;
 ; Returns all inpatient ICD and/or CPT procedure codes for a patient
 ;
 ; Input:
 ;   PTIEN    : DFN of patient
 ;   RORTYPE  : Code to indicate the type of procedure to return
 ;                I = ICD only  C = CPT only  B = both (default)
 ;   RORIBUF  : the array, passed by reference where the data will be returned
 ;   RORSDT   : start date to consider (optional)
 ;   ROREDT   : end date to consider (optional)
 ;
 ; Output:
 ; Returns array RORIBUF("ICD-401,"file 45.01 ien,file 45 ien")=ICD DATE^internal icd code
 ;               RORIBUF("ICD-601,"file 45.05 ien,file 45 ien")=ICD DATE^internal icd code
 ;               RORIBUF("CPT","file 45.06 ien,file 45 ien")=CPT DATE^internal cpt code
 ; RORIBUF(0)=-1 if error or 0 if success
 ;
INPROC(IEN45,RORTYPE,RORIBUF,RORSDT,ROREDT) ;  Get all inpatient procedures from PTF
 N RORDATE,DATE,RORIEN,IEN,IENS,NODE,RORBUF,RORMSG,FLD,RC,PTIEN
 N C,RORCPT,RORCPTCT,RORPTF,RORCD,REF401,ROR401,REF601,ROR601,Z
 I '$D(RORTYPE) S RORTYPE="B"
 K RORIBUF
 K ^TMP("PTF",$J),^TMP("RORPTF",$J)
 S IEN45=","_IEN45
 ;--- Surgical procedures
 S RORIBUF(0)=0,RC=0
 I RORTYPE="I"!(RORTYPE="B") D  ; 'I'CD only or 'B'OTH ICD and CPT
 . S ROR401=$$ROOT^DILFD(45.01,IEN45,1),REF401=$NA(@ROR401)
 . S RORIEN=0 F  S RORIEN=$O(@REF401@(RORIEN)) Q:RORIEN'>0  D
 . . K RORBUF,RORMSG
 . . S IENS=+RORIEN_IEN45
 . . D GETS^DIQ(45.01,IENS,".01;","I","RORBUF","RORMSG")
 . . I $G(RORMSG) S RC=$$ERROR^RORERR(-57,,,,RORMSG(0),"GETS^DIQ;401"),RORIBUF(0)=-1 Q
 . . S RORDATE=$G(RORBUF(45.01,IENS,.01,"I"))
 . . Q:'RORDATE
 . . I $G(RORSDT)!($G(ROREDT)) Q:'$$CHKDT(RORDATE\1,$G(RORSDT,0),$G(ROREDT,9999999))
 . . K ROR ;D PTFICD^DGPTFUT(401,IEN45,RORIEN,.ROR)
 . . S FLD="" F  S FLD=$O(ROR(FLD)) Q:FLD=""  I $G(ROR(FLD)) D
 . . . S RORIBUF("ICD-401",RORIEN_IEN45_FLD)=RORDATE_U_+ROR(FLD),RORIBUF(0)=$G(RORIBUF(0))+1
 . ;--- Other procedures
 . S ROR601=$$ROOT^DILFD(45.05,IEN45,1),REF601=$NA(@ROR601)
 . S IEN=0 F  S IEN=$O(@REF601@(IEN)) Q:IEN'>0  D
 . . K RORBUF,RORMSG
 . . S IENS=IEN_","_IEN45_","
 . . D GETS^DIQ(45.05,IENS,"","I","RORBUF","RORMSG")
 . . I $G(RORMSG) S RC=$$ERROR^RORERR(-57,,,,RORMSG(0),"GETS^DIQ;601"),RORIBUF(0)=-1 Q
 . . S RORDATE=$G(RORBUF(45.05,IENS,.01,"I"))
 . . Q:'RORDATE
 . . I $G(RORSDT)!($G(ROREDT)) Q:'$$CHKDT(RORDATE\1,$G(RORSDT,0),$G(ROREDT,9999999))
 . . K ROR ;D PTFICD^DGPTFUT(601,IEN45,IEN,.ROR)
 . . S FLD="" F  S FLD=$O(ROR(FLD)) Q:FLD=""  I $G(ROR(FLD)) D
 . . . S RORIBUF("ICD-601",IEN_","_IEN45)=RORDATE_U_+ROR(FLD),RORIBUF(0)=$G(RORIBUF(0))+1
 ;--- CPT codes
 I RORTYPE="C"!(RORTYPE="B") D  ; 'C'PT only or 'B'OTH ICD and CPT
 . K ^TMP("PTF",$J),RORBUF,RORMSG
 . S IEN45=$E(IEN45,2,$L(IEN45))
 . D GETS^DIQ(45,IEN45,".01;","I","RORBUF","RORMSG")
 . I $G(RORMSG) S RC=$$ERROR^RORERR(-57,,,,RORMSG(0),"GETS^DIQ;CPT"),RORIBUF(0)=-1 Q
 . S PTIEN=+$G(RORBUF(45,IEN45,.01,"I"))
 . D PTFINFOR^DGAPI(PTIEN,+IEN45) ;List of CPT code records in PTF
 . K ^TMP("RORPTF",$J) M ^TMP("RORPTF",$J)=^TMP("PTF",$J)
 . S RORPTF=0,RORCPTCT=0
 . S Z=0 F  S Z=$O(^TMP("RORPTF",$J,Z)) Q:'Z  D
 . . S RORDATE=+$G(^TMP("RORPTF",$J,Z))
 . . D CPTINFO^DGAPI(PTIEN,+IEN45,+^TMP("RORPTF",$J,Z))  ; Pulls CPT code nodes from file 46
 . . I $G(RORSDT)!($G(ROREDT)) Q:'$$CHKDT(RORDATE\1,$G(RORSDT,0),$G(ROREDT,9999999))
 . . S RORCPT=0 F  S RORCPT=$O(^TMP("PTF",$J,46,RORCPT)) Q:'RORCPT  D
 . . . S IEN=+$G(^TMP("PTF",$J,46,RORCPT)),RORCD=$P($G(^(RORCPT)),U,2)
 . . . I RORCD S RORCPTCT=RORCPTCT+1,RORIBUF("CPT",IEN_IEN45_RORCPTCT)=RORDATE_U_RORCD,RORIBUF(0)=$G(RORIBUF(0))+1
 . K ^TMP("PTF",$J),^TMP("RORPTF",$J)
 ;
 Q
 ;
CHKDT(DATE,SDATE,EDATE) ; Check dates - returns 1 if DATE is within SDATE-EDATE range
 I (DATE<SDATE)!(DATE'<EDATE) Q 0
 Q 1
 ;
