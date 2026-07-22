RCDMCRUT ;EDE/YMG - SC exemption utilities; 09/19/2025
 ;;4.5;Accounts Receivable;**464**;Mar 20, 1995;Build 6
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
 Q
 ;
GETRDDT(RCDFN,RCMIN,RCMAX) ; get the earliest date of service connected rated disabilities
 ;
 ; RCDFN - patient DFN
 ; RCMIN - min % in field 2.04/2 (inclusive)
 ; RCMAX - max % in field 2.04/2 (inclusive)
 ;
 ; returns the earliest date from field 2.04/5, or 0 if no dates were found.
 ;
 N RCDT,TMPARY,Z
 S RCDT=0
 D GETS^DIQ(2,RCDFN,".3721*","I","TMPARY")
 S Z="" F  S Z=$O(TMPARY(2.04,Z)) Q:Z=""  D
 .I TMPARY(2.04,Z,2,"I")<RCMIN Q
 .I TMPARY(2.04,Z,2,"I")>RCMAX Q
 .I TMPARY(2.04,Z,3,"I")'=1 Q  ; not SC
 .I TMPARY(2.04,Z,6,"I")'>0 Q  ; no effective date
 .I RCDT=0!(RCDT>TMPARY(2.04,Z,6,"I")) S RCDT=TMPARY(2.04,Z,6,"I")
 .Q
 Q RCDT
 ;
GETENRDT(RCDFN) ; get effective date from Enrollment file, if priority group 1 and verified status
 N ENRIEN,RCDT,TMPARY
 S RCDT=0
 I $$STATUS^DGENA(RCDFN)=2,$$PRIORITY^DGENA(RCDFN)=1 D
 .S ENRIEN=$$FINDCUR^DGENA(RCDFN)
 .I ENRIEN>0,$$GET^DGENA(ENRIEN,.TMPARY) S RCDT=+TMPARY("EFFDATE")
 .Q
 Q RCDT
 ;
GETEFFDT(RCDFN,RCMIN,RCMAX) ; get the earliest SC effective date
 ;
 ; RCDFN - patient DFN
 ; RCMIN - min % in field 2.04/2 (inclusive)
 ; RCMAX - max % in field 2.04/2 (inclusive)
 ;
 ; returns the earliest of rated disablities effective date and enrollment effective date, or 0 if no dates were found.
 ;
 N TMPDT1,TMPDT2
 S TMPDT1=$$GETRDDT(RCDFN,RCMIN,RCMAX)
 S TMPDT2=$$GETENRDT(RCDFN)
 I TMPDT1,TMPDT2 Q $S(TMPDT2<TMPDT1:TMPDT2,1:TMPDT1)
 I TMPDT2 Q TMPDT2
 Q TMPDT1
