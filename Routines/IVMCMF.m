IVMCMF ;ALB/RMM,TDM - INCOME TEST EDIT CHECK DRIVER ; 2/1/07 10:14am
 ;;2.0;INCOME VERIFICATION MATCH;**71,82,107,115**;21-OCT-94;Build 28
 ;
 ; This routine will perform edit checks to validate income tests which
 ; are transmitted to VistA from the IVM Center. Any errors will be 
 ; recorded and will be added to the record in the ANNUAL MEANS TEST 
 ; File #408.31.
 ;
 ; This routine is called from IVMCM1.
 ;
 ; Required Input:
 ;   The global array ^TMP($J,"IVMCM" which contains the income test
 ;   The local variable IVMTYPE, which may be:
 ;       1 - Means Test
 ;       2 - Copay Test
 ;       4 - Long Term Care Test
 ;
 ; Output:
 ;   Array IVMERR as a list of error condition(s) found (free text)
 ;
EN(IVMERR) ; Entry point to begin edit checks.
 ;
 N ARRAY,DEP,I,IEN,SPOUSE,CNT,HLERR,ISEG,J
 S (DEP,CNT)=1,SPOUSE=0
 I +$G(IVMTYPE)'>0 S CNT=CNT+1,IVMERR(CNT)="Income Test Type not Specified"
 ;
 ; Build strings for the veteran
 ;S ARRAY("PID")=$$CLEAR($G(^TMP($J,"IVMCM","PIDV")))
 S I=0 F  S I=$O(^TMP($J,"IVMCM","PIDV",I)) Q:I=""  D
 .I $D(^TMP($J,"IVMCM","PIDV",I))=1 D
 ..S ARRAY("PID",I)=$$CLEAR(^TMP($J,"IVMCM","PIDV",I))
 .I $D(^TMP($J,"IVMCM","PIDV",I))=10 D
 ..S J=0 F  S J=$O(^TMP($J,"IVMCM","PIDV",I,J)) Q:J=""  D
 ...S ARRAY("PID",I,J)=$$CLEAR(^TMP($J,"IVMCM","PIDV",I,J))
 ;
 S ARRAY("ZIC")=$$CLEAR($G(^TMP($J,"IVMCM","ZICV"))),$P(ARRAY("ZIC"),HLFS,21)=$$TOTAL^IVMCME(ARRAY("ZIC"))
 S ARRAY("ZIR")=$$CLEAR($G(^TMP($J,"IVMCM","ZIRV")))
 ;
 ; Build string for spouse as dependent
 S ARRAY(DEP,"ZDP")=$$CLEAR($G(^TMP($J,"IVMCM","ZDPS")))
 S ARRAY(DEP,"ZIC")=$$CLEAR($G(^TMP($J,"IVMCM","ZICS")))
 S ARRAY(DEP,"ZIR")=$$CLEAR($G(^TMP($J,"IVMCM","ZIRS")))
 D ADJ^IVMCME
 ;
 ; Build strings for children as dependents
 S IEN=0 F  S IEN=$O(^TMP($J,"IVMCM","ZDPC",IEN)) Q:'IEN  D
 . S DEP=DEP+1
 . S ARRAY(DEP,"ZDP")=$$CLEAR($G(^TMP($J,"IVMCM","ZDPC",IEN)))
 . S ARRAY(DEP,"ZIC")=$$CLEAR($G(^TMP($J,"IVMCM","ZICC",IEN)))
 . S ARRAY(DEP,"ZIR")=$$CLEAR($G(^TMP($J,"IVMCM","ZIRC",IEN)))
 . D ADJ^IVMCME
 ;
 ; Build strings for inactive spouse and children dependents
 F ISEG="ZDPIS","ZDPIC" D
 . S IEN=0 F  S IEN=$O(^TMP($J,"IVMCM",ISEG,IEN)) Q:'IEN  D
 . . S DEP=DEP+1
 . . S ARRAY(DEP,"ZDP")=$$CLEAR($G(^TMP($J,"IVMCM",ISEG,IEN)))
 ;
 ; - build income test string and check for errors
 S ARRAY("ZMT")=$$CLEAR($G(^TMP($J,"IVMCM","ZMT"_IVMTYPE)))
 ;
 I '$$UPLDOK() S HLERR="Income Test not Uploaded",OK2UPLD=0 D ACK^IVMPREC Q
 ;
 ; Check Income Test before applying consistency checks
 ; - If AGREED TO PAY DEDUCTIBLE is NO
 ; - or DECLINES TO GIVE INCOME INFO and AGREED TO PAY DEDUCTIBLE are YES
 ; Quit, the consistency checks are unnecessary.
 N APD,DTGII S APD=$P(ARRAY("ZMT"),U,11),DTGII=$P(ARRAY("ZMT"),U,14)
 I APD=0!(APD=1&(DTGII=1)) Q
 ;
 D CHECK
ENQ Q
 ;
CLEAR(NODE) ; Convert HLQ to NULL
 N I
 F I=1:1:$L(NODE,HLFS) I $P(NODE,HLFS,I)=HLQ S $P(NODE,HLFS,I)=""
 Q NODE
 ;
CHECK ; Check validity of transmission data
 N IEN
 I "^1^2^4^"[("^"_IVMTYPE_"^") D ZMT^IVMCMF2(ARRAY("ZMT"))
 D ZIR^IVMCMF1(ARRAY("ZIR"))
 ;
 S IEN="" F  S IEN=$O(ARRAY(IEN)) Q:'IEN  D
 . D ZDP^IVMCMF2(ARRAY(IEN,"ZDP"))
 . I $D(ARRAY(IEN,"ZIC")) D ZIC^IVMCMF1(ARRAY(IEN,"ZIC"),IEN)
 . I $D(ARRAY(IEN,"ZIR")) D ZIR^IVMCMF1(ARRAY(IEN,"ZIR"),IEN)
CHECKQ Q
 ;
UPLDOK() ; Check if the test is complete and OK to upload
 ; Quit if not a valid test type
 I "^1^2^3^4^"'[(U_IVMTYPE_U) Q 0
 ;
 ; Check the Income Test Status
 N DGSTAT S DGSTAT=$P(ARRAY("ZMT"),U,3)
 I IVMTYPE=1,"^C^A^G^N^P^"'[(U_DGSTAT_U) Q 0
 I IVMTYPE=2,"^M^E^L^"'[(U_DGSTAT_U) Q 0
 I IVMTYPE=4,"^0^1^"'[(U_DGSTAT_U) Q 0
 ;
 ; Check if the test has been completed
 I IVMTYPE'=3,+$P(ARRAY("ZMT"),U,10)'>0 Q 0
 Q 1
 ;
UPDMTSIG(MTIEN,TMSTAMP,MTSIG,MTSIGDT) ;
 ;if the timestamp matchs AND MT Sig or MT Sig Date changed, update MT Sig info
 I '$G(MTIEN) Q 0
 S MTSIG=$G(MTSIG),MTSIGDT=$G(MTSIGDT)
 N ND0,ND2,DATA
 S ND2=$G(^DGMT(408.31,MTIEN,2))
 I $G(TMSTAMP)'=$P(ND2,"^",2) Q 0
 S ND0=$G(^DGMT(408.31,MTIEN,0))
 I MTSIG=$P(ND0,"^",29)&(MTSIGDT=$P(ND0,"^",24)) Q 0
 S DATA(.24)=MTSIGDT  ; dt vet signed test
 S DATA(.29)=MTSIG    ; means test signed
 I $$UPD^DGENDBS(408.31,MTIEN,.DATA)
 Q 1
