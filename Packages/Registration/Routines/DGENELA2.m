DGENELA2 ;ALB/CJM,ERC - Patient Eligibility API ; 13 JUN 1997
 ;;5.3;Registration;**147,688**;Aug 13,1993;Build 29
 ;
DELELIG(DFN,DGELG) ;
 ;Description: Deletes eligibilities from the patient file Patient
 ;Eligibilities multiple that are not contained in DGELG() array.
 ;
 ;Input:
 ;  DFN - ien of Patient record
 ;  DGELG() - eligibility array (pass by reference)
 ;Output: none
 ;
 N DIK,DA,CODE
 S DA(1)=DFN
 S DIK="^DPT("_DFN_",""E"","
 S DA=0 F  S DA=$O(^DPT(DFN,"E",DA)) Q:'DA  D
 .S CODE=+$G(^DPT(DFN,"E",DA,0))
 .;
 .;don't delete if it belongs
 .Q:$D(DGELG("ELIG","CODE",CODE))
 .;
 .;don't delete if it's the primary eligibility code
 .Q:(CODE=DGELG("ELIG","CODE"))
 .D ^DIK
 Q
 ;
DELRDIS(DFN) ;
 ;Description: deletes Rated Disability multiple from the patient file
 ;
 ;Input:
 ;  DFN - ien of Patient record
 ;Output: none
 ;
 N DIK,DA
 S DA(1)=DFN
 S DIK="^DPT("_DFN_",.372,"
 S DA=0 F  S DA=$O(^DPT(DFN,.372,DA)) Q:'DA  D ^DIK
 Q
UPDZ11 ;update the VistA Patient file record with data
 ;from the incoming Z11
 ;
 ;call moved from STORE^DGENELA1
 I '$$UPD^DGENDBS(2,DFN,.DATA) S ERROR="FILEMAN FAILED TO UPDATE THE PATIENT RECORD" Q
 ;
 ;check P&T and P&T Effective Date - the date field has a 
 ;lower field number if gets updated first.  And if the P&T was 'N' or
 ;null and the date field is set, the date field will be deleted by 
 ;the trigger cross reference on P&T
 N DATA3013
 I $G(DATA(.304))="Y",($G(DATA(.3013))]""),($P($G(^DPT(DFN,.3)),U,13)'=DATA(.3013)) D
 . S DATA3013(.3013)=DATA(.3013)
 . I '$$UPD^DGENDBS(2,DFN,.DATA3013) S ERROR="FILEMAN FAILED TO UPDATE P&T EFFECTIVE DATE" Q
 Q
