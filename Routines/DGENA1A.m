DGENA1A ;ALB/CJM,ISA/KWP,Zoltan,LBD,EG,CKN,ERC - Enrollment API - File Data Continued ; 8/1/08 1:10pm
 ;;5.3;Registration;**121,147,232,314,564,672,659,653,688**;Aug 13,1993;Build 29
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
 ;  DGENRIEN - ptr to PATIENT ENROLLMENT file
 ;  DGENR - array containing the record, pass by reference
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
 ;     from DGENR array
 ;Input -
 ;  DA - ien of record in Patient Enrollment file
 ;  DGENR - array containing an enrollment, pass by reference
 ;Output - 1 on success, 0 on failure
 ;
 ; *** NOTE: This is called from within FM.  There is a problem in ***
 ; *** that ^DIE can not be used.  Instead, the fields             ***
 ; *** are hard-set and cross-referenced.                          ***
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
 S NODE=DGENR("APP")_U_DGENR("DFN")_U_DGENR("SOURCE")_U_DGENR("STATUS")_U_DGENR("REASON")_U_DGENR("FACREC")_U_DGENR("PRIORITY")_U_DGENR("EFFDATE")_U_DGENR("PRIORREC")_U_DGENR("DATE")_U_DGENR("END")_U_DGENR("SUBGRP")
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
 S NODE=NODE_U_DGENR("ELIG","EC")  ;changed to SW Asia Cond - DG*5.3*688
 S NODE=NODE_U_DGENR("ELIG","MTSTA")
 S NODE=NODE_U_DGENR("ELIG","VCD")
 S NODE=NODE_U_DGENR("ELIG","PH")
 S NODE=NODE_U_DGENR("ELIG","UNEMPLOY")
 S NODE=NODE_U_DGENR("ELIG","CVELEDT")
 S NODE=NODE_U_DGENR("ELIG","SHAD") ;field added with DG*5.3*653
 S NODE=NODE_U_DGENR("ELIG","DISLOD") ;field added with DG*5.3*672
 S NODE=NODE_U_DGENR("ELIG","RADEXPM")
 S NODE=NODE_U_DGENR("ELIG","AOEXPLOC") ;field added with DG*5.3*688
 S ^DGEN(27.11,DA,"E")=NODE
 S ^DGEN(27.11,DA,"U")=DGENR("DATETIME")_U_DGENR("USER")
 ;
 ;set the x-refs
 D SETALL(DA,.DGENR)
 Q 1
