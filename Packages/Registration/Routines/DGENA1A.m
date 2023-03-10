DGENA1A ;ALB/CJM,ISA/KWP,Zoltan,LBD,EG,CKN,ERC,TDM,JLS,HM,KUM,RN - Enrollment API - File Data Continued ;5/10/11 12:03pm
 ;;5.3;Registration;**121,147,232,314,564,672,659,653,688,841,909,940,972,952,993,1027,1045**;Aug 13,1993;Build 15
 ;
KILLALL(DGENRIEN) ;
 ;kills all x-refs on the record in the Patient Enrollment file
 ;pointed to by DGENRIEN
 ;
 N DGENR,SUB,VALUE
 Q:'$G(DGENRIEN)
 Q:'$$GET^DGENA(DGENRIEN,.DGENR)
 S SUB=""
 F  S SUB=$O(DGENR(SUB)) Q:SUB=""  D
 .Q:(SUB="ELIG")
 .Q:DGENR(SUB)=""
 .D KILL(27.11,DGENRIEN,$$FIELD^DGENU(SUB),DGENR(SUB))
 S SUB=""
 F  S SUB=$O(DGENR("ELIG",SUB)) Q:SUB=""  D
 .Q:DGENR("ELIG",SUB)=""
 .D KILL(27.11,DGENRIEN,$$FIELD^DGENU(SUB),DGENR("ELIG",SUB))
 Q
 ;
SETALL(DGENRIEN,DGENR) ;
 ;Sets all x-refs on the record in the Patient Enrollment file.
 ;Inputs:
 ; DGENRIEN - pointer to PATIENT ENROLLMENT file
 ; DGENR - array containing the record, pass by reference
 ;
 N SUB,VALUE
 Q:'$G(DGENRIEN)
 Q:'$D(DGENR)
 ;
 S SUB=""
 F  S SUB=$O(DGENR(SUB)) Q:SUB=""  D
 .Q:(SUB="ELIG")
 .Q:DGENR(SUB)=""
 .D SET(27.11,DGENRIEN,$$FIELD^DGENU(SUB),DGENR(SUB))
 S SUB=""
 F  S SUB=$O(DGENR("ELIG",SUB)) Q:SUB=""  D
 .Q:DGENR("ELIG",SUB)=""
 .D SET(27.11,DGENRIEN,$$FIELD^DGENU(SUB),DGENR("ELIG",SUB))
 Q
 ;
KILL(FILE,IEN,FIELD,VALUE) ;
 ;executes all the kill logic for x-refs on the field=FIELD for the
 ;record=DGENRIEN for the file=FILE for the field value=VALUE
 ;
 N D0,DA,DIV,DGIX,X
 S DA=IEN,X=VALUE,DGIX=0
 F  S DGIX=$O(^DD(FILE,FIELD,1,DGIX)) Q:'DGIX  X ^(DGIX,2) S X=VALUE
 Q
 ;
SET(FILE,IEN,FIELD,VALUE) ;
 ;executes all the set logic for x-refs on the field=FIELD for the
 ;record=DGENRIEN for the file=FILE for the field value=VALUE
 ;
 N D0,DA,DIV,DGIX,X
 S DA=IEN,X=VALUE,DGIX=0
 F  S DGIX=$O(^DD(FILE,FIELD,1,DGIX)) Q:'DGIX  X ^(DGIX,1)
 Q
 ;
EDIT(DA,DGENR) ;
 ;Description: Overlays a currently existing record, ien=DA, with values
 ; from DGENR array
 ;Input -
 ; DA - ien of record in Patient Enrollment file
 ; DGENR - array containing an enrollment, pass by reference
 ;Output - 1 on success, 0 on failure
 ;
 ; *** NOTE: This is called from within FM. There is a problem in ***
 ; *** that ^DIE cannot be used. Instead, the fields ***
 ; *** are hard-set and cross-referenced. ***
 ;
 N NODE
 Q:'$G(DA) 0
 S NODE=$G(^DGEN(27.11,$G(DA),0))
 Q:NODE="" 0
 ;
 ;kill off all the cross-references (FM doesn't have an API to do this)
 D KILLALL(DA)
 ;
 ;now hand-set all the fields
 ;Phase II Add subgroup to the 12 piece (SRS 6.4)
 ;DG*5.3*993 Status being set for a Register Only Patients
 ;DG*5.3*1045 Status of Register Only Patients only when Ineligible Date is blank
 N DGEIEN,DGINELIG,DGENPTA,DGINELREA
 I $$GET^DGENPTA(DFN,.DGENPTA) S DGINELIG=$G(DGENPTA("INELDATE")),DGINELREA=$G(DGENPTA("INELREA"))
 S DGEIEN=$$FINDCUR^DGENA(DFN)
 I DGEIEN S DGENRYN=$$GET1^DIQ(27.11,DGEIEN_",",.14,"I")
 I $G(DGENRYN)=0,$G(DGINELIG)="",DGENR("STATUS")'=6,DGENR("STATUS")'=20,DGENR("SOURCE")'=2 S DGENR("STATUS")=25
 I $G(DGENR("PTAPPLIED"))=0,$G(DGINELIG)="",DGENR("STATUS")'=6,DGENR("STATUS")'=20,DGENR("SOURCE")'=2 S DGENR("STATUS")=25    ;  DG*5.3*993
 ;I $G(DGINELIG)'="",$G(DGINELREA)'="",DGENR("SOURCE")'=2 S DGENR("STATUS")=20  ; DG*5.3*1045
 I $G(DGINELIG)'="",DGENR("SOURCE")'=2 S DGENR("STATUS")=20  ; DG*5.3*1045
 I $G(DGENR("REGREA"))="",DGENR("SOURCE")'=2 S DGENR("REGREA")=$$GET1^DIQ(27.11,DGEIEN_",",.15,"I")
 I $G(DGENR("REGDATE"))="",DGENR("SOURCE")'=2 S DGENR("REGDATE")=$$GET1^DIQ(27.11,DGEIEN_",",.16,"I")
 I $G(DGENR("REGSRC"))="",DGENR("SOURCE")'=2 S DGENR("REGSRC")=$$GET1^DIQ(27.11,DGEIEN_",",.17,"I")
 S NODE=DGENR("APP")_U_DGENR("DFN")_U_DGENR("SOURCE")_U_DGENR("STATUS")_U_DGENR("REASON")_U_DGENR("FACREC") ;DJE field added with DG*5.3*940 - Closed Application (line split) - RM#867186
 S NODE=NODE_U_DGENR("PRIORITY")_U_DGENR("EFFDATE")_U_DGENR("PRIORREC")_U_DGENR("DATE")_U_DGENR("END")_U_DGENR("SUBGRP")_U_DGENR("RCODE") ;DJE field added with DG*5.3*940 - Closed Application - RM#867186
 S ^DGEN(27.11,DA,0)=NODE
 S ^DGEN(27.11,DA,"R")=DGENR("REMARKS")
 S NODE=DGENR("ELIG","CODE")
 S NODE=NODE_U_DGENR("ELIG","SC")
 S NODE=NODE_U_DGENR("ELIG","SCPER")
 S NODE=NODE_U_DGENR("ELIG","POW")
 S NODE=NODE_U_DGENR("ELIG","A&A")
 S NODE=NODE_U_DGENR("ELIG","HB")
 S NODE=NODE_U_DGENR("ELIG","VAPEN")
 S NODE=NODE_U_DGENR("ELIG","VACKAMT")
 S NODE=NODE_U_DGENR("ELIG","DISRET")
 S NODE=NODE_U_DGENR("ELIG","MEDICAID")
 S NODE=NODE_U_DGENR("ELIG","AO")
 S NODE=NODE_U_DGENR("ELIG","IR")
 S NODE=NODE_U_DGENR("ELIG","EC") ;changed to SW Asia Cond - DG*5.3*688
 S NODE=NODE_U_DGENR("ELIG","MTSTA")
 S NODE=NODE_U_DGENR("ELIG","VCD")
 S NODE=NODE_U_DGENR("ELIG","PH")
 S NODE=NODE_U_DGENR("ELIG","UNEMPLOY")
 S NODE=NODE_U_DGENR("ELIG","CVELEDT")
 S NODE=NODE_U_DGENR("ELIG","SHAD") ;field added with DG*5.3*653
 S NODE=NODE_U_DGENR("ELIG","DISLOD") ;field added with DG*5.3*672
 S NODE=NODE_U_DGENR("ELIG","RADEXPM")
 S NODE=NODE_U_DGENR("ELIG","AOEXPLOC") ;field added with DG*5.3*688
 S NODE=NODE_U_DGENR("ELIG","MOH") ;field added with DG*5.3*841
 S NODE=NODE_U_DGENR("ELIG","CLE") ;field added with DG*5.3*909
 S NODE=NODE_U_DGENR("ELIG","CLEDT") ;field added with DG*5.3*909
 S NODE=NODE_U_DGENR("ELIG","CLEST") ;field added with DG*5.3*909
 S NODE=NODE_U_DGENR("ELIG","CLESOR") ;field added with DG*5.3*909
 S NODE=NODE_U_DGENR("ELIG","MOHAWRDDATE") ;field added with DG*5.3*972 HM
 S NODE=NODE_U_DGENR("ELIG","MOHSTATDATE") ;field added with DG*5.3*972 HM
 S NODE=NODE_U_DGENR("ELIG","MOHEXEMPDATE") ;field added with DG*5.3*972 HM
 S NODE=NODE_U_$G(DGENR("ELIG","OTHTYPE")) ; DG*5.3*952
 S ^DGEN(27.11,DA,"E")=NODE
 S ^DGEN(27.11,DA,"U")=DGENR("DATETIME")_U_DGENR("USER")
 ;
 ;DG*5.3*993 New fields for decoupling mods - update using FileMan for Auditing
 D
 . ;DG*5.3*1027 - Move update of PTAPPLIED to DGENA1
 . ;N DGFDA S DGFDA(27.11,DA_",",.14)=$G(DGENR("PTAPPLIED")),DGFDA(27.11,DA_",",.15)=$G(DGENR("REGREA"))
 . N DGFDA S DGFDA(27.11,DA_",",.15)=$G(DGENR("REGREA"))
 . S DGFDA(27.11,DA_",",.16)=$G(DGENR("REGDATE")),DGFDA(27.11,DA_",",.17)=$G(DGENR("REGSRC"))
 . D FILE^DIE("","DGFDA")
 ;DG*5.3*993 End of decoupling mods
 ;
 ;set the x-refs
 D SETALL(DA,.DGENR)
 Q 1
