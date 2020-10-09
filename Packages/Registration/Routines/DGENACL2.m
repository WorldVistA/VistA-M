DGENACL2 ;ALB/MRY,ARF,ARF - NEW ENROLLEE APPOINTMENT CALL LIST - UPDATE ;08/14/2008
 ;;5.3;Registration;**788,893,982,1015**;08/13/93;Build 7
 ;
EXTRACT ;
 N DGNAM,DGSSN,DGENRIEN,DGENR,DGENCAT,DGENSTA,DGSTA1,DGENPRI,DGENCV,DGENCVDT,DGENCVEL,DGCOM,DGPFSITE
 N SDCNT,SDADT,SDARRY,SDCL,Y,FDATA,SDEXIT,DGRDTI,DGSTA
 ;get preferred facility
 S DGPFSITE=$$GET1^DIQ(4,+$$GET1^DIQ(2,DFNIEN,27.02,"I"),99)
 S DGPFTF=$S(+$$GET1^DIQ(2,DFNIEN,27.02,"I"):$$GET1^DIQ(2,DFNIEN,27.02,"I"),1:"NULL")
 I $E(DGSITE,1,3)'=$E(DGPFSITE,1,3) Q  ;DG*5.3*893 LLS replaced: I +DGSITE'=+DGPFSITE Q  ;if not same division skip
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
 ;if call list, quit if request status 'filled' or 'cancelled'.
 ; jam - dg*5.3*982 - remove (SDCNT>0) condition (number of appts) - The number of appointments is irrelevant to whether or not a patient is on the call list
 ;I DGRPT=1 Q:(SDCNT>0)!(DGSTA="C")!(DGSTA="F")
 I DGRPT=1 Q:(DGSTA="C")!(DGSTA="F")
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
 S SDARRY(4)=DFNIEN,SDARRY("FLDS")=1 ;arf - DG*5.3*1015 - added SDARRY("FLDS") 
 ; jam; DG*5.3*982; add fields 13, 14 and 15 (Primary Stop Code and IEN and Credit Stop Code and IEN and Non-Count Clinic indicator)
 ;S SDARRY("FLDS")="13;14;15" ;arf - DG*5.3*1015 - line commented out
 K SDARRY("MAX") ;DG*5.3*893 LLS - added
 ;jam DG*5.3*982 - add check for error returned from API
 ;  call to API ($$SDAPI^SDAMA301) is supported by ICR #4433
 S SDCNT=$$SDAPI^SDAMA301(.SDARRY) I SDCNT<0 S DGERROR=$$ERR() Q
 Q:(SDCNT'>0)
 ;
 ;N DGSTOP,DGCREDIT,DGAPPT  ;DG*5.3*982 - arf - added new variables ;arf - DG*5.3*1015 line commented out
 ;DG*5.3*893 - LLS - This is the begin of the modified section.
 K ^TMP("DGEN",$J,"BY_APPT_DT")
 S SDCL=0 F  S SDCL=$O(^TMP($J,"SDAMA301",DFNIEN,SDCL)) Q:'SDCL  D  ;re-sort by appt dt/tm
 . I $$GET1^DIQ(44,SDCL,2502,"I")="Y" Q  ;don't include no-count clinic appointment
 . S SDADT="" F  S SDADT=$O(^TMP($J,"SDAMA301",DFNIEN,SDCL,SDADT)) Q:'SDADT  D
 . . S ^TMP("DGEN",$J,"BY_APPT_DT",SDADT)=^TMP($J,"SDAMA301",DFNIEN,SDCL,SDADT)
 ;. S SDADT="" F  S SDADT=$O(^TMP($J,"SDAMA301",DFNIEN,SDCL,SDADT)) Q:'SDADT  D  ;arf - DG*5.3*1015 next 8 lines commented to remove functionality
 ;. . S DGAPPT=^TMP($J,"SDAMA301",DFNIEN,SDCL,SDADT)
 ;. . I $P(DGAPPT,U,15)="Y" Q                  ; - do not include non-count clinic appointments - DG*5.3*982 - modified - use p15 instead of global reference
 ;. . ; DG*5.3*982 Check for Primary Care Appointments:
 ;. . S DGCREDIT=$P($P(DGAPPT,U,14),";",2)   ; - Set the appointment's Credit Stop Code
 ;. . S DGSTOP=$P($P(DGAPPT,U,13),";",2)     ; - Set the appointment's Stop Code Number
 ;. . I '$$PCACHK(DGSTOP,DGCREDIT) Q         ; - Check for a Primary Care Appointment match - quit if not
 ;. . S ^TMP("DGEN",$J,"BY_APPT_DT",SDADT)=^TMP($J,"SDAMA301",DFNIEN,SDCL,SDADT)  ; - Only Primary Care Appointments ;arf - DG*5.3*1015 end
 ;
 S SDADT=$O(^TMP("DGEN",$J,"BY_APPT_DT",""))
 I SDADT="" Q  ;no appointments found for 'count' clinics, so keep on call list
 ;DG*5.3*893 - LLS - This is the end of the modified section.
 ;
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
 ;
PCACHK(DGSTCODE,DGCRCODE) ; Check for Primary Care Appt. ; jam; DG*5.3*982 
 ; Input: DGSTCODE - Stop Code
 ;        DGCRCODE - Credit Stop Code
 ; Returns; TRUE if Stop Code and Credit Stop Code combination qualifies as a Primary Care Appt.
 N DGPCA,DGCNT,DGLINE
 S DGPCA=0
 F DGCNT=1:1 S DGLINE=$P($T(CCODES+DGCNT),";;",2) Q:DGLINE=""  I $P(DGLINE,";")=$G(DGSTCODE) D  Q
 . I $P(DGLINE,";",2)[("^"_$G(DGCRCODE)_"^") S DGPCA=1
 Q DGPCA
CCODES ; jam; DG*5.3*982 ;Stop and Credit Stop Codes that qualify as Primary Care appt. - FORMAT:  ;;StopCode;^CreditStopCode1^CreditStopCode2^....^
 ;;160;^322^323^
 ;;210;^322^323^
 ;;310;^322^323^
 ;;313;^322^323^
 ;;322;^117^160^185^186^187^188^^
 ;;323;^117^160^185^186^187^188^^
 ;;348;^117^160^185^186^187^188^^
 ;;350;^117^160^185^186^187^188^^
