EDPARPT1 ;SLC/BWF - Ad Hoc Reports ;5/16/2012 11:51am
 ;;2.0;EMERGENCY DEPARTMENT;**6**;Feb 24, 2012;Build 200
 Q
ELAPSED(LIEN) ; elapsed time
 N ELAPSE,IN,OUT
 S ELAPSE=""
 S OUT=$$GET1^DIQ(230,LIEN,.09,"I")
 I 'OUT Q "" ; patient has no 'out' time
 I $$GET1^DIQ(230,LIEN,.0701,"I")'=1 Q "" ; patient's record is not closed
 S IN=$$GET1^DIQ(230,LIEN,.08,"I")
 S ELAPSE=$$FMDIFF^XLFDT(IN,OUT,2)
 I ELAPSE>60 S ELAPSE=ELAPSE/60 Q $P(ELAPSE,".") ; get minutes
 Q ""
SMULT(LIEN,IARRY,FLD) ; list of doctors/nurses/residents/status/acuity or any 'standard multiples (single fields that can change) associated with the patient for this ed visit
 N CNT,INVDT,HIEN,VAL,FDATA,FERR,LOCAL,PIEN
 S CNT=0
 ; get field values in the reverse order that they were assigned to the patient
 S INVDT=0 F  S INVDT=$O(^EDP(230.1,"ADR",LIEN,INVDT)) Q:'INVDT  D
 .S HIEN=0 F  S HIEN=$O(^EDP(230.1,"ADR",LIEN,INVDT,HIEN)) Q:'HIEN  D
 ..; quit if this field is null
 ..I $$GET1^DIQ(230.1,HIEN,FLD,"I")="" Q
 ..D FIELD^DID(230.1,FLD,,"TYPE;POINTER","FDATA","FERR")
 ..I $G(FDATA("TYPE"))="POINTER" D  Q
 ...; if the field is a pointer, and it is pointing to VA(200, get the elements needed (name^initials^log history time)
 ...I $G(FDATA("POINTER"))="VA(200," D  Q
 ....S PIEN=$$GET1^DIQ(230.1,HIEN,FLD,"I")
 ....S VAL=$$GET1^DIQ(200,PIEN,.01,"E")_" ("_$$GET1^DIQ(230.1,HIEN,.02,"E")_")"
 ....S CNT=CNT+1,IARRY(CNT)=VAL,LOCAL($P(VAL,U))=""
 ...; force the log history timestamp to ALWAYS be on piece 3 for now, to provide consistency with pointers to VA(200
 ...; this helps when using the FORMAT LOGIC from file 232.11
 ...S VAL=$$GET1^DIQ(230.1,HIEN,FLD,"E")_" ("_$$GET1^DIQ(230.1,HIEN,.02,"E")_")"
 ...S CNT=CNT+1,IARRY(CNT)=VAL
 Q
TRIAGE(LIEN) ; The elapsed time between the patient's time-in and his or her initial acuity assessment.
 N ACU,IDT,FOUND,ETIME,IN,TRNURSE
 S FOUND=0,ETIME="",TRNURSE=""
 S IDT=0 F  S IDT=$O(^EDP(230.1,"ADR",LIEN,IDT)) Q:'IDT  D
 .S HIEN=0 F  S HIEN=$O(^EDP(230.1,"ADR",LIEN,IDT,HIEN)) Q:'HIEN!(FOUND)  D
 ..; this field was not edited or added
 ..I $$GET1^DIQ(230.1,HIEN,3.3,"I")="" Q
 ..S FOUND=1
 ..S IN=$$GET1^DIQ(230,LIEN,.08,"I")
 ..S ETIME=$$FMDIFF^XLFDT($$GET1^DIQ(230.1,HIEN,.02,"I"),IN,2)
 ..S ETIME=ETIME/60
 ..S TRNURSE=$$GET1^DIQ(230.1,HIEN,3.6,"E")
 Q $P(ETIME,".")_U_TRNURSE
 ;
D2DOC(LIEN) ; elapsed time from door to doc
 N ETIME,HIEN,IDT,FOUND,IN,DOCTIME
 S ETIME=""
 S (FOUND,IDT)=0 F  S IDT=$O(^EDP(230.1,"ADR",LIEN,IDT)) Q:'IDT!(FOUND)  D
 .S HIEN=0 F  S HIEN=$O(^EDP(230.1,"ADR",LIEN,IDT,HIEN)) Q:'HIEN!(FOUND)  D
 ..; this field was not edited or added
 ..I $$GET1^DIQ(230.1,HIEN,3.5,"I")="" Q
 ..S FOUND=1
 ..S IN=$$GET1^DIQ(230,LIEN,.08,"I"),DOCTIME=$$GET1^DIQ(230.1,HIEN,.02,"I")
 ..S ETIME=$$FMDIFF^XLFDT(DOCTIME,IN,2),ETIME=ETIME/60
 Q $P(ETIME,".")
 ;
WAIT(LIEN,AREA) ; The elapsed time between the patient's time-in and his or her first assignment to a location other than the waiting room 
 N WAIT,IDT,FOUND,HIEN,ETIME,IN
 S ETIME=""
 S (IDT,FOUND)=0 F  S IDT=$O(^EDP(230.1,"ADR",LIEN,IDT)) Q:'IDT!(FOUND)  D
 .S HIEN=0 F  S HIEN=$O(^EDP(230.1,"ADR",LIEN,IDT,HIEN)) Q:'HIEN!(FOUND)  D
 ..I $$GET1^DIQ(230.1,HIEN,3.4,"I")="" Q
 ..; the patient is still in the waiting room
 ..I $$GET1^DIQ(230.1,HIEN,3.4,"E")=$$GET1^DIQ(231.9,AREA,1.12,"E") Q
 ..S IN=$$GET1^DIQ(230,LIEN,.08,"I"),FOUND=1
 ..S ETIME=$$FMDIFF^XLFDT($$GET1^DIQ(230.1,HIEN,.02,"I"),IN,2),ETIME=ETIME/60
 Q $P(ETIME,".")
 ;
 ; input
 ;      LIEN - Log entry ien from file 230 (required)
 ;      TYPE - type of data being requested (required)
 ;             1 - admdec
 ;             2 - admdel
ADMDECL(LIEN,TYPE) ; elapsed time between the patient's time-in and the status change to 'Admit to.'
 N ADMDEC,IN,HIEN,IDT,FOUND,ELAPSE,STAT,STIME
 S ELAPSE=""
 S (IDT,FOUND)=0 F  S IDT=$O(^EDP(230.1,"ADR",LIEN,IDT)) Q:'IDT!(FOUND)  D
 .S HIEN=0 F  S HIEN=$O(^EDP(230.1,"ADR",LIEN,IDT,HIEN)) Q:'HIEN!(FOUND)  D
 ..S STAT=$$GET1^DIQ(230.1,HIEN,3.2,"E")
 ..I TYPE=1,STAT'="adm.status.admitted" Q
 ..I TYPE=2,STAT'["edp.disposition" Q
 ..S FOUND=1
 ..S STIME=$$GET1^DIQ(230.1,HIEN,.02,"I"),IN=$$GET1^DIQ(230,LIEN,.08,"I")
 ..S ELAPSE=$$FMDIFF^XLFDT(STIME,IN,2),ELAPSE=ELAPSE/60
 Q $P(ELAPSE,".")
 ; 
 ; input:
 ;     LIEN  - log ien (required)
 ;     IARRY - data storage location IARRY(CNT)=DATA (required)
 ;     AREA  - the AREA associated with this log entry
 ;     TYPE  - 1: ICD coded dx list
 ;             2: free text dx list
DXMULT(LIEN,IARRY,AREA,TYPE) ; patients free text or ICD-9-CM diagnosis - could be multiple 
 N EDPVISIT
 I TYPE=1 D  Q
 .S EDPVISIT=$P(^EDP(230,LIEN,0),U,12)
 .I EDPVISIT,$P($G(^EDPB(231.9,AREA,1)),U,2) D DXPCE^EDPQPCE(EDPVISIT,.IARRY)
 I TYPE=2 D DXFREE2^EDPQPCE(LIEN,.IARRY)
 Q
PID(DFN) ;
 N PID,PNAME,SSN
 D ^VADPT
 S PID=$E(VADM(1),1)_VA("BID")
 K VA,VADM
 Q PID
