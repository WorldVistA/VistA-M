ECVICDDT ;ALB/MGD - Event Capture ICD-10 Implementation Date ;07 Aug 01
 ;;2.0;EVENT CAPTURE;**114**;8 May 96;Build 20
 ;
 ; RPC: EC ICD10IMPLEMENTATIONDATE 
 ;
 ; Reference to $$IMPDATE^LEXU supported by ICR #5679
 ; Reference to DD^%DT supported 
 ;
 ;  Input: Nothing
 ; Output: Implementation Date of ICD-10 Code Set in MM/DD/YYYY format
 ;         OR -1^Error Message
 ;
ICD10(RESULTS) ; Return the ICD-10 Code Set Implementation Date
 N ECICD10,ECICDDY,ECICDMO,ECICDYR,Y
 K ^TMP($J,"ECICD10")
 ; Call to retrieve ICD-10 Implementation Date
 S ECICD10=$$IMPDATE^LEXU("10D")
 ; Return error if lookup failed
 I +ECICD10<0 S ^TMP($J,"ECICD10",1)=ECICD10 Q
 ; Parse out Month and Date info prior to external call
 S ECICDMO=$E(ECICD10,4,5)
 S ECICDDY=$E(ECICD10,6,7)
 ; Call to get external format of year
 S Y=ECICD10
 D DD^%DT
 ; Load year from return value
 S ECICDYR=$P(Y,",",2),ECICDYR=$E(ECICDYR,2,5)
 ; Parse together MM/DD/YYYY
 S ECICD10=ECICDMO_"/"_ECICDDY_"/"_ECICDYR
 S ^TMP($J,"ECICD10",1)=ECICD10
 S RESULTS=$NA(^TMP($J,"ECICD10"))
 Q
