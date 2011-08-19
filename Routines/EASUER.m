EASUER ;ALB/CKN - GEOGRAPHIC MEANS TEST PHASE II ; 03-MAR-2003
 ;;1.0;ENROLLMENT APPLICATION SYSTEM;**25,37,50,55**;Mar 15, 2001
 ;This routine contains several APIs that will be called from
 ;different packages like Scheduling, PCE and Fee basis to notify
 ;Enrollment package whenever any inpatient/outpatient encounter occurs,
 ;or any appointment made or any changes made to fee basis authorization.
 Q
SCHED ;This API will be called from SDAM APPOINTMENT EVENTS via EAS UE SCHED 
 ;EVENT protocol whenever any changes made to veteran's appointment.
 ;Input variables used in this api:
 ;             SDATA     -  piece 1 - ien of multiple entry of the 
 ;                                    APPOINTMENTS multiple of the
 ;                                    HOSPITAL LOCATION file.
 ;                          piece 2 - ien of PATIENT file (DFN)
 ;                          piece 3 - internal Date/time of appt.
 ;                          piece 4 - ien of clinic in the HOSPITAL
 ;                                    LOCATION file.
 ;             SDAMEVT   -  ien pointing to an entry in the APPOINTMENT
 ;                          TRANSACTION file (#409.66).
 ;
 N DFN,APT,APTDT
 S DFN=$P($G(SDATA),"^",2) Q:DFN=""  ;Veteran's IEN
 I $G(SDAMEVT)=1 D  ;if new appointment is made
 . S APTDT=$P($G(SDATA),"^",3),APTDT=$$FY(APTDT)
 . ;check current User Enrollee data and update it if necessary.
 . I $$UPDCHK(DFN,APTDT) D FILE(DFN,APTDT)
 Q
ENC ;This API will be called from PXK VISIT DATA EVENT via EAS UE PCE EVENT
 ;whenever any inpatient/outpatient encounter occurs.
 ;Input:
 ;^TMP("PXKCO",$J,VISIT,"V FILE STRING",V FILE RECORD,DDSUBSCRIPT,"AFTER/BEFORE")=DATA
 ;where: subscript piece 1 - string notation representing package "PXKCO"
 ;       subscript piece 2 - Job number ($J)
 ;       subscript piece 3 - ien of VISIT file
 ;       subscript piece 4 - string representing the VISIT or V file
 ;                           data category
 ;       subscript piece 5 - ien of the entry in the file represented in
 ;                           subscript #4
 ;       subscript piece 6 - subscript or DD node on which the data is stored.
 ;       subscript piece 7 - string designating whether or not the data
 ;                           is an "after" or "before" reflection of data.
 ;
 N VSIT,NODE,DFN,VDT
 I '$D(^TMP("PXKCO",$J)) Q
 S VSIT=$O(^TMP("PXKCO",$J,"")) Q:VSIT=""  ;ien of VISIT file
 S NODE=$G(^AUPNVSIT(VSIT,0))
 ;get Veteran's IEN and encounter date
 S DFN=$P($G(NODE),"^",5),VDT=$P($G(NODE),"^",1)
 S VDT=$$FY(VDT)
 ;check current User Enrollee data and update if necessary
 I $$UPDCHK(DFN,VDT) D FILE(DFN,VDT)
 Q
FBAUTH(FBDFN,FBTODT) ;This Enrollment api will be called from Fee basis
 ;applications at the time of any fee basis authorization changes.
 ;Input:         FBDFN  -  Veteran's ien
 ;              FBTODT  -  Latest date of authorization.
 ;
 N XDT
 S XDT=$$FY(FBTODT)
 I $$UPDCHK(FBDFN,XDT) D FILE(FBDFN,XDT)
 Q
INP ;This Enrollment api will be called from DGPM MOVEMENT EVENT via 
 ;EAS UE INP EVENT protocol whenever inpatient veteran is admitted,
 ;transfered,discharged or any movement.
 ;supported variables of this event:
 ;       DFN  - Pointer to patient in PATIENT file (#2)
 ;    DGPMDA  - Pointer to primary movement in PATIENT MOVEMENT file.
 ;     DGPMP  - Zero node of primary movement prior to add/edit/del
 ;     DGPMA  - Zero node of primary movement after add/edit/delete
 ;
 N XDT
 I '$G(DFN)!'$G(DGPMDA) Q
 S XDT=$P($G(^DGPM(DGPMDA,0)),"^")  ;Date of movement
 S XDT=$$FY(XDT) I $$UPDCHK(DFN,XDT) D FILE(DFN,XDT)
 Q
UESTAT(DFN) ;This api will be called at the time of Annual MT renewal
 ;process to check if veteran has UE status for current FY.
 N UESTAT,UESITE,UESTN,CURSTN,PRNT,CHILD,CIEN
 I '$G(DFN) Q 0  ;No DFN
 S UESTAT=$P($G(^DPT(DFN,.361)),"^",7)
 I UESTAT="" Q 0  ;Not User Enrollee
 I UESTAT<$$FY(DT) Q 0  ;Not User Enrollee for current FY
 S UESITE=$P($G(^DPT(DFN,.361)),"^",8) Q:+UESITE=0 0
 ; *** Modifications for patch 55 to handle VISN or HCS UE Sites
 S UESTN=$$STA^XUAF4(UESITE)
 S CURSTN=$P($$SITE^VASITE,"^",3)
 ;
 I UESTN']"" D
 . D CHILDREN^XUAF4("CHILD","`"_UESITE,"PARENT FACILITY")
 . S CIEN=0 F  S CIEN=$O(CHILD("C",CIEN)) Q:'CIEN  I CIEN=CURSTN S UESTN=$$STA^XUAF4(CIEN) Q
 . I UESTN']"" D
 . . D CHILDREN^XUAF4("CHILD","`"_UESITE,"VISN")
 . . S CIEN=0 F  S CIEN=$O(CHILD("C",CIEN)) Q:'CIEN  I CIEN=CURSTN S UESTN=$$STA^XUAF4(CIEN) Q
 ;
 S PRNT=$$PSITE(CURSTN),CURSTN=$$STA^XUAF4(PRNT)
 I UESTN'=CURSTN Q 2  ;Not same site
 Q 1
UPDCHK(DFN,APTDT) ;This api will determine whether to update User Enrollee data.
 I '$G(DFN) Q 0  ;No DFN
 I $P($G(^DPT(DFN,"VET")),"^")="N" Q 0  ;Quit if Non veteran
 I APTDT<3030000 Q 0  ;Quit if APTDT is less than FY 2003
 N CURSTAT
 S CURSTAT=$P($G(^DPT(DFN,.361)),"^",7)
 I APTDT>CURSTAT Q 1
 Q 0
FY(XDATE) ;Returns a fiscal year for the date
 N ENFY S ENFY=""
 I $G(XDATE)?7N.E S ENFY=$S($E(XDATE,4,5)<10:$E(XDATE,1,3),1:$E(XDATE,1,3)+1)
 Q ENFY_"0000"
 ;
PSITE(STA) ;Get parent site IEN
 N PRNT,PRNTYP
 ;
 S PRNT=0
 ; First pass, get the parent facility, then get the facility type for the parent
 ; If the parent is a VAMC, then quit returning parent
 ; If the parent is either a VISN or HCS type, then return the current station, not the parent
 ;
 S PRNT=+$$PRNT^XUAF4(STA)
 I PRNT>0 D
 . S PRNTYP=$$GET1^DIQ(4,PRNT,13)
 . I PRNTYP="VAMC" Q
 . I "HCS,VISN"[PRNTYP S PRNT=STA Q
 E  D
 . I $$GET1^DIQ(4,STA,13)="VAMC" S PRNT=STA Q
 . E  S REVSTA=$E(STA,1,3),PRNT=+$$PRNT^XUAF4(REVSTA) D
 . . I $$GET1^DIQ(4,PRNT,13)="VAMC" Q
 . . S PRNT=+$O(^DIC(4,"D",REVSTA,""))
 Q PRNT
 ;
CHKPRNT(PRNT) ; Check if parent is a VISN entity, removed with Patch 50
 Q 0
 ;
FILE(XIEN,XDT) ;Update User Enrollee fields and queue Z07
 N DATA,FILEUPD,SITE,PRNT,EVENT,IYR
 S SITE=$$SITE^VASITE,SITE=$P($G(SITE),"^",3)
 S PRNT=$$PSITE(SITE) Q:'+$G(PRNT)
 S DATA(.3617)=XDT,DATA(.3618)=PRNT
 I '$$UPD^DGENDBS(2,.XIEN,.DATA) Q
 S IYR=$$INCYR(XIEN)
 S EVENT("ENROLL")=1 I $$LOG^IVMPLOG(XIEN,IYR,.EVENT)
 Q
INCYR(XIEN) ;Get valid income year
 ;N INCYR,LMT,R3015,I,TEMP
 I $D(^IVM(301.5,"APT",XIEN)) D  Q INCYR
 . S INCYR=$O(^IVM(301.5,"APT",XIEN,""),-1)
 F I=1,2,4 D
 . S LMT=$$LST^DGMTU(XIEN,,I)
 . I +$G(LMT) S TEMP($P(LMT,"^",2))=""
 I $D(TEMP) S LMT=$O(TEMP(""),-1),INCYR=($E(LMT,1,3)-1)_"0000" Q INCYR
 S INCYR=($E(DT,1,3)-1)_"0000"
 Q INCYR
