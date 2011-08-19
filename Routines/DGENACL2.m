DGENACL2 ;ALB/MRY - NEW ENROLLEE APPOINTMENT CALL LIST - UPDATE ;08/14/2008
 ;;5.3;Registration;**788**;08/13/93;Build 18
 ;
EXTRACT ;
 N DGNAM,DGSSN,DGENRIEN,DGENR,DGENCAT,DGENSTA,DGSTA1,DGENPRI,DGENCV,DGENCVDT,DGENCVEL,DGCOM,DGPFSITE
 N SDCNT,SDADT,SDARRY,SDCL,Y,FDATA,SDEXIT,DGRDTI,DGSTA
 ;get preferred facility
 S DGPFSITE=$$GET1^DIQ(4,+$$GET1^DIQ(2,DFNIEN,27.02,"I"),99)
 S DGPFTF=$S(+$$GET1^DIQ(2,DFNIEN,27.02,"I"):$$GET1^DIQ(2,DFNIEN,27.02,"I"),1:"NULL")
 I +DGSITE'=+DGPFSITE Q  ;if not same division skip
 I DGPFTFLG=1,'$D(DGPFTF(DGPFTF)) Q  ;selection of preferred facilities
 ;get enrollment information
 S DGENRIEN=$$FINDCUR^DGENA(DFNIEN)
 I DGENRIEN,$$GET^DGENA(DGENRIEN,.DGENR) ;set-up enrollment arry
 I $G(DGENR("APP"))<3050801 Q
 S DGENCAT=$$CATEGORY^DGENA4(,$G(DGENR("STATUS"))) ;enrollment category
 I DGENCAT'="E" Q
 S DGENCAT=$$EXTERNAL^DILFD(27.15,.02,"",DGENCAT)
 S DGENSTA=$S($G(DGENR("STATUS")):$$EXT^DGENU("STATUS",DGENR("STATUS")),1:"")
 S DGENPRI=$S($G(DGENR("PRIORITY")):DGENR("PRIORITY"),1:"")_$S($G(DGENR("SUBGRP")):$$EXT^DGENU("SUBGRP",DGENR("SUBGRP")),1:"")
 D APPTCK ;check appts.
 I +DGERROR Q  ;RSA API error
 I SDEXIT Q  ;quit if appointment < 'date notified of request date'.
 ;if call list, quit if request status 'filled' or 'completed'.
 I DGRPT=1 Q:(SDCNT>0)!(DGSTA="C")!(DGSTA="F")
 S SDADT=$G(SDADT)
 S DGNAM=$$GET1^DIQ(2,DFNIEN,.01),DGSSN=$E($$GET1^DIQ(2,DFNIEN,.09),6,9)
 S DGENCV=$$CVEDT^DGCV(DFNIEN),DGENCVDT=$P($G(DGENCV),"^",2),DGENCVEL=$P($G(DGENCV),"^",3)
 ;build temp file
 S DGPFTF=$S(+DGPFTF:$$GET1^DIQ(4,DGPFTF,.01)_"("_DGPFSITE_")",1:"ZZZZZ")
 S DGSTA1=$S(DGSTA="":1,DGSTA="I":2,DGSTA="E":3,DGSTA="F":4,1:DGSTA)
 S ^TMP($J,"DGEN NEACL",DGPFTF,DGSTA1,DGRDTI,DGNAM,DFNIEN)=SDADT
 I $G(DGENCAT)'=""!($G(DGENSTA)'="")!($G(DGENPRI)'="")!($G(DGENCVEL)'="") D
 . S ^TMP($J,"DGEN NEACL",DGPFTF,DGSTA1,DGRDTI,DGNAM,DFNIEN,"PRIORITY")=DGENCAT_"^"_DGENSTA_"^"_DGENPRI_"^"_DGENCVEL
 Q
 ;
APPTCK ;
 ;quit, if no appointment questioned asked?
 S DGRDTI=$$GET1^DIQ(2,DFNIEN,1010.1511,"I") I 'DGRDTI S SDEXIT=1 Q
 ;get request status
 S DGSTA=$$GET1^DIQ(2,DFNIEN,1010.161,"I")
 ;look for any appointments made (quit if none, or appt. date < 'notify of request date'
 K ^TMP($J,"SDAMA301")
 S SDARRY(4)=DFNIEN
 S SDARRY("FLDS")=1
 S SDARRY("MAX")=1
 S SDEXIT=0
 S SDCNT=$$SDAPI^SDAMA301(.SDARRY) I SDCNT<0 S DGERROR=$$ERR() Q
 Q:(SDCNT'>0)  ;no appointment
 ;quit if appointment < 'notify of request date'
 S SDCL=0 F  S SDCL=$O(^TMP($J,"SDAMA301",DFNIEN,SDCL)) Q:'SDCL  D  I SDEXIT=1 Q
 . I $O(^TMP($J,"SDAMA301",DFNIEN,SDCL,0))<DGRDTI S SDEXIT=1
 ;
 K ^TMP($J,"SDAMA301")
 ;Check appointments (scheduled/kept, inpatient, no action)
 S SDARRY(1)=DGRDTI_";" ;look out from 'notify of request date' to future.
 S SDARRY(3)="R;I;NT"
 S SDARRY(4)=DFNIEN,SDARRY("FLDS")=1
 S SDCNT=$$SDAPI^SDAMA301(.SDARRY) Q:(SDCNT'>0)
 ;Exclude no count clinic appointments from appointment count
 N SDCOUNT
 S SDCOUNT=0 ;count clinic
 S SDCL=0 F  S SDCL=$O(^TMP($J,"SDAMA301",DFNIEN,SDCL)) Q:'SDCL  D  Q:SDCOUNT
 . I $$GET1^DIQ(44,SDCL,2502,"I")="Y" Q  ;don't include no-count
 . S SDADT=$O(^TMP($J,"SDAMA301",DFNIEN,SDCL,0)) ;get appointment date of count clinic
 . S SDCOUNT=SDCOUNT+1
 I SDCOUNT=0 S SDCNT=0 Q  ;if no-count clinics was only one found, keep on call list.
 ;if appointment found and status '="filled", set status to 'filled'
 I DGSTA'="F" D
 . S DGCOM=$$GET1^DIQ(2,DFNIEN,1010.163)
 . S DGCOM=DGCOM_$S(DGCOM'="":"<>",1:"")_"AutoComm:"_$S(DGSTA="":"null",1:$S($$GET1^DIQ(2,DFNIEN,1010.161,"I")="I":"IN PROGRESS",1:$$GET1^DIQ(2,DFNIEN,1010.161)))_"|FILLED"
 . S FDATA(2,DFNIEN_",",1010.161)="F"
 . S FDATA(2,DFNIEN_",",1010.163)=DGCOM
 . D FILE^DIE("","FDATA","DPTERR")
 . S DGSTA=$$GET1^DIQ(2,DFNIEN,1010.161,"I")
 Q
ERR() ; Process error message.
 N DGERR
 S DGERR=0
 I $D(^TMP($J,"SDAMA301",101)) D
 . S DGERR=101_"^"_"  *** RSA: Process DATABASE IS UNAVAILABLE ***"
 I $D(^TMP($J,"SDAMA301",115)) D
 . S DGERR=115_"^"_"  *** RSA: Appointment request filter contains invalid values ***"
 I $D(^TMP($J,"SDAMA301",116)) D
 . S DGERR=116_"^"_"  *** RSA: Data doesn't exist error has occurred ***"
 I $D(^TMP($J,"SDAMA301",117)) D
 . S DGERR=117_"^"_"  *** RSA: Other undefined error has occurred ***"
 Q DGERR
