HMPRPCRC ;AFS/WPB - Check and clear the HMP resource device ;Jan 20, 2017
 ;;2.0;ENTERPRISE HEALTH MANAGEMENT PLATFORM;**3**;Jan 20, 2017;Build 15
 ;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
EN(LST) ; return the data for any jobs running in all 'busy' slots
 ;Input: 
 ;RESOURCE - Name of the resource to check - required
 ;Returns LST array:
 ;$P(1) : SLOT #
 ;$P(2) : CPU
 ;$P(3) : JOB #
 ;$P(4) : TASK #
 ;$P(5) : TASK STATUS
 ;$P(6) : START DATE/TIME
 ;$P(7) : CURRENT DATE/TIME
 ;$P(8) : TIME DIFFERENCE BETWEEN START AND CURRENT TIME AS DAYS HR:MM:SS
 ;
 N HMPERR,HMPIEN,HMPSLOT,MXSLOTS,SLOTS
 S HMPIEN=$$FIND1^DIC(3.54,"","MX","HMP EXTRACT RESOURCE","","","HMPERR")
 I $G(HMPIEN)=0!($G(HMPIEN)="") S LST="Resource doesn't exist" Q
 D GETS^DIQ(3.54,HMPIEN_",","**","I","HMPSLOT","HMPERR")
 I '$D(HMPSLOT) S LST="All slots are open" Q
 S MXSLOTS=$G(HMPSLOT(3.54,HMPIEN_",",1,"I"))
 F SLOTS=1:1:MXSLOTS+1 D
 .N CDTTM,DIFF,JOB,ST,START,STATUS,ZTSK,ZTCPU,%
 .S LST(SLOTS)=""
 .S ZTCPU=$G(HMPSLOT(3.542,SLOTS_",1,",1,"I")),JOB=$G(HMPSLOT(3.542,SLOTS_",1,",2,"I")),ZTSK=$G(HMPSLOT(3.542,SLOTS_",1,",3,"I")),START=$$HTE^XLFDT($G(HMPSLOT(3.542,SLOTS_",1,",4,"I")))
 .I $G(ZTSK)'="" D
 ..D NOW^%DTC S CDTTM=%
 ..S:$G(HMPSLOT(3.542,SLOTS_",1,",4,"I"))'="" ST=$$HTFM^XLFDT($G(HMPSLOT(3.542,SLOTS_",1,",4,"I")))
 ..D ISQED^%ZTLOAD S STATUS=$S(ZTSK(0)=0:"TASK IS NOT SCHEDULED",ZTSK(0)="":"TASK DOESN'T EXIST",ZTSK(0)=1:"TASK IS SCHEDULED",1:"")
 ..S:$G(ST)'="" DIFF=$$FMDIFF^XLFDT(CDTTM,ST,3)
 .S LST(SLOTS)=$S(ZTSK="":"SLOT IS OPEN",ZTSK>0:SLOTS_"^"_$G(ZTCPU)_"^"_$G(JOB)_"^"_$G(ZTSK)_"^"_$G(STATUS)_"^"_$G(START))_"^"_$G(CDTTM)_"^"_$G(DIFF)
 Q
CLEAR(RESULTS,SLOT) ; clear a resource slot
 ;Input:
 ;RESOURCE - Name of the resource to check - required
 ;SLOT - Slot number to clear
 ;Output: returns 1 if successful, otherwise returns 0^reason
 S RESULTS=1
 N HMPERR,HMPIEN,HMPSLOT,MXSLOTS
 S HMPIEN=$$FIND1^DIC(3.54,"","MX","HMP EXTRACT RESOURCE","","","HMPERR")
 I $G(HMPIEN)=0!($G(HMPIEN)="") S RESULTS="0^Resource doesn't exist" Q
 D KILLRES^%ZISC(HMPIEN,SLOT)
 Q
