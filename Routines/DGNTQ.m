DGNTQ ;ALB/RPM - NOSE/THROAT RADIUM TREATMENT QUESTIONS ; 8/24/01 12:59pm
 ;;5.3;Registration;**397**;Aug 13, 1993
 Q
 ;
ASKSTAT(DGDIRA,DGDIRB,DGDIR0) ;
 ;
 ;  Input
 ;    DGDIR0 - DIR(0) string
 ;    DGDIRA - DIR("A") string
 ;    DGDIRB - DIR("B") string
 ;
 ;  Output
 ;    DGRSLT has the following values:
 ;        0 - if user up-arrows, times out, or enters null
 ;        Y - user response
 ;
 K DIRUT
 S DIR(0)=DGDIR0
 S DIR("A")=DGDIRA
 S DIR("B")=DGDIRB
 D ^DIR
 K DIR
 I $D(DIRUT) S DGRSLT=0
 E  S DGRSLT=Y
 ;
 Q DGRSLT
 ;
REG(DGDFN) ;Entry point from REGISTRATION
 ;This sub-routine asks the Nose/Throat Radium Treatment questions
 ;for Screen 6 of LOAD/EDIT PATIENT DATA.  The answers are filed in
 ;the NTR HISTORY file (#28.11) using the $$FILENTR^DGNTAPI API.
 ;A caret "^" entered as an answer to any of the questions will cause
 ;the sub-routine to QUIT without filing any data.
 ;A user possessing the DGNT VERIFY security key will have additional
 ;verification questions asked.
 ;
 ;  Input
 ;    DGDFN - IEN to PATIENT file (#2)
 ;
 ;  Output  none
 ;
 N I,X,Y  ;protect FileMan ^DIE variables
 N DGNTIEN  ;IEN from existing record from $$GETCUR API call
 N DGNT   ;data array from $$GETCUR API call
 N DGDFLT ;default answer array
 N DGUPD  ;question response array subscripted by "NTR","AVI","SUB"
 N DGRSLT ;result of filer API
 N DGX    ;generic counter
 N DGXMT  ;HL7 transmit flag
 ;
 ;initialize defaults
 S DGNTIEN=$$GETCUR^DGNTAPI(DGDFN,"DGNT")
 I 'DGNTIEN D
 . F DGX="NTR","AVI","SUB","EDT","EUSR","HNC","HDT","HUSR","HSIT","VER","VDT","VUSR","VSIT" S DGUPD(DGX)=""
 I +DGNTIEN>0,$D(DGNT) M DGUPD=DGNT
 F DGX="NTR","AVI","SUB" D
 . S DGDFLT(DGX)=$S($P(DGUPD(DGX),"^",2)]"":$P(DGUPD(DGX),"^",2),1:"NO")
 ;
 ;call reader API $$ASKSTAT passing DFN,DIR(0),DIR("B"),DIR("A")
 S DGUPD("NTR")=$$ASKSTAT("Did you receive Nose or Throat Radium Treatments in the military? ",DGDFLT("NTR"),"28.11,.04AO")
 Q:DGUPD("NTR")=0   ;user entered "^" or timed out
 I DGUPD("NTR")="Y"!(DGUPD("NTR")="U") D
 . S DGUPD("AVI")=$S($$DATOK(DGDFN,2550131):$$ASKSTAT("Did you serve as an aviator in the military before Jan 31, 1955? ",DGDFLT("AVI"),"28.11,.05AO"),1:"")
 . Q:DGUPD("AVI")=0
 . S DGUPD("SUB")=$S($$DATOK(DGDFN,2650101):$$ASKSTAT("Did you have submarine training in the military before Jan 1, 1965? ",DGDFLT("SUB"),"28.11,.06AO"),1:"")
 ;quit if user entered "^" or timed out during questions
 I DGUPD("NTR")=0!(DGUPD("AVI")=0!(DGUPD("SUB")=0)) Q
 ;check for value change and add entry date, user, site and clear
 ;the previous verification/head&neck values
 F DGX="NTR","AVI","SUB" I DGUPD(DGX)'=$P($G(DGNT(DGX)),"^") D  Q
 . S DGUPD("EDT")=$$NOW^XLFDT
 . S DGUPD("EUSR")=DUZ
 . I DGUPD("VDT")]"" D   ;clear verification
 . . F DGX="VER","VDT","VUSR","VSIT" S DGUPD(DGX)=""
 . I DGUPD("HDT")]"" D   ;clear Head/Neck DX
 . . F DGX="HNC","HDT","HUSR","HSIT" S DGUPD(DGX)=""
 ;can user verify?
 I $D(^XUSEC("DGNT VERIFY",DUZ)),(DGUPD("NTR")="Y"!(DGUPD("NTR")="U")) D VERIFY(DGDFN,.DGUPD)
 ;flip Unknown to Yes if verified by Mil Med Record
 I DGUPD("NTR")="U",DGUPD("VER")="M" S DGUPD("NTR")="Y"
 ;file the data using filer API passing DFN and response array
 F DGX="NTR","AVI","SUB","VER","HNC" S DGUPD(DGX)=$P(DGUPD(DGX),"^")
 I $$CHANGE^DGNTUT(DGDFN,.DGUPD) D
 . I DGUPD("NTR")="N" D
 . . S DGUPD("VDT")=$$NOW^XLFDT
 . . S DGUPD("VSIT")=$$SITE^DGNTUT
 . S DGXMT=$S(DGUPD("VDT")'="":1,1:0)
 . S DGRSLT=$$FILENTR^DGNTAPI(DGDFN,.DGUPD,DGXMT)
REGQ Q
 ;
VERIFY(DGDFN,DGVUPD) ;Ask verification questions
 ;
 ;  Input
 ;    DGDFN - IEN to PATIENT file (#2)
 ;    DGVUPD - array of question responses
 ;
 ;  Output none
 ;
 N DGX     ;generic index
 N DGDFLT  ;default answer array
 ;
 ;set up default answer array
 S DGDFLT("VER")=$S($P($G(DGVUPD("VER")),"^",1)]"":$P(DGVUPD("VER"),"^",1),1:"")
 S DGDFLT("HNC")=$S($P($G(DGVUPD("HNC")),"^",2)]"":$P(DGVUPD("HNC"),"^",2),1:"")
 I $$ASKSTAT("Do you want to verify now? ","NO","YAO") D
 . S DGVUPD("VER")=$$ASKSTAT("Nose and throat radium treatment verified by: ",DGDFLT("VER"),"28.11,1.01AO")
 . I DGVUPD("VER")=0 S DGVUPD("VER")=DGDFLT("VER") Q
 . I DGVUPD("VER")'=DGDFLT("VER") D
 . . S DGVUPD("VDT")=$$NOW^XLFDT
 . . S DGVUPD("VUSR")=DUZ
 . . S DGVUPD("VSIT")=$$SITE^DGNTUT
 . I DGVUPD("VER")'="N" D
 . . S DGVUPD("HNC")=$$ASKSTAT("Has the veteran been diagnosed with Cancer of the Head and/or Neck? ",$S(DGDFLT("HNC")]"":DGDFLT("HNC"),1:"NO"),"28.11,2.01AO")
 . . I DGVUPD("HNC")=0 S DGVUPD("HNC")=$E(DGDFLT("HNC")) Q
 . . I DGVUPD("HNC")="N" S DGVUPD("HNC")=""
 . . I DGVUPD("HNC")'=DGDFLT("HNC") D
 . . . S DGVUPD("HDT")=$$NOW^XLFDT
 . . . S DGVUPD("HUSR")=DUZ
 . . . S DGVUPD("HSIT")=$$SITE^DGNTUT
 Q
 ;
DATOK(DGDFN,DGDATE) ;Validate dates before asking questions
 ;Call $$SVCCHK to check Service Entry dates and if no Service
 ;Entry dates are found then at least validate against DOB.
 ;
 ;  Input
 ;    DGDFN - IEN to PATIENT file (#2)
 ;    DGDATE- FM forumat date to validate agains
 ;
 ;  Output
 ;    DGRSLT - 0 = don't ask question
 ;             1 = ask question
 ;
 N DGRSLT
 S DGDFN=$G(DGDFN)
 S DGDATE=$G(DGDATE)
 S DGRSLT=1
 S DGRSLT=$$SVCCHK(DGDFN,DGDATE)
 I DGRSLT<0 S DGRSLT=$$DOBCHK(DGDFN,DGDATE)
 Q DGRSLT
 ;
SVCCHK(DGDFN,DGDATE) ;Did veteran serve prior to DGDATE?
 ;This function searches the veteran's Service Entry dates to find the
 ;earliest date.  If a Service Entry date is found then it is compared
 ;against the DGDATE parameter and returns a zero ("0") if DGDATE
 ;precedes the Service Entry date.  If the Service Entry date precedes
 ;DGDATE a one ("1") is returned.
 ;
 ;  Input
 ;    DGDFN - IEN to PATIENT file (#2)
 ;    DGDATE - FM format date to validate agains
 ;
 ;  Output
 ;    DGRSLT - 0 = DGDATE precedes earliest Service Entry date.
 ;             1 = Service Entry date precedes DGDATE
 ;            -1 = no Service Entry date found.
 ;
 N DFN,VASV,VAERR  ;SVC^VADPT variables
 N DGSVCE    ;Service Entry date
 N DGRSLT
 S DGDFN=+$G(DGDFN)
 S DGDATE=+$G(DGDATE)
 S DGRSLT=-1
 S DFN=DGDFN
 D SVC^VADPT
 F DGX=8:-1:6 I +$G(VASV(DGX,4))>0 D  Q
 . S DGRSLT=1
 . I DGDATE<+$G(VASV(DGX,4)) S DGRSLT=0
 Q DGRSLT
 ;
DOBCHK(DGDFN,DGDATE) ;Was veteran too young to have served at DGDATE?
 ;This function compares the veteran's DOB against DGDATE to determine
 ;if the veteran was less than 15 years old at DGDATE.  This logic
 ;is based on POS^DGRPDD1. 
 ;
 ;  Input
 ;    DGDFN - IEN to PATIENT file (#2)
 ;    DGDATE- FM format date to validate against
 ;
 ;  Output
 ;    DGRSLT - 0 = veteran too young
 ;             1 = veteran old enough
 ;
 N DFN,VA,VADM,VAERR  ;DEM^VADPT variables
 N DGDOB
 N DGRSLT
 S DGDFN=+$G(DGDFN)
 S DGDATE=+$G(DGDATE)
 S DGRSLT=1
 S DFN=DGDFN
 D DEM^VADPT
 S DGDOB=+$G(VADM(3))
 I DGDATE-DGDOB\10000<15 S DGRSLT=0
 Q DGRSLT
 ;
