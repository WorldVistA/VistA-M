ACKQASU5 ;HCIOFO/AG - New/Edit Visit Utilities  ;  04/01/99
 ;;3.0;QUASAR;;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
SETDIAG(ACKVIEN,ACKICD,ACKDPRIM) ; add ICD9 code to A&SP Clinic Visit
 ; inputs: ACKVIEN  - A&SP visit ien
 ;         ACKICD   - ICD9 Diagnosis ien from ICD9 file
 ;         ACKDPRIM - Primary Diag. flag 
 ; outputs: 1^ - everything ok
 ;          0^xxxxxxx - update failed (reason=xxxxxx)
 ; NB. This function checks the Stop Code for the visit against the 
 ; valid stop codes for the Diagnosis. It therefore assumes that the
 ; visit stop code has already been filed.
 N ACKDIAG,ACKICDN,ACKE,ACKARR,ACKSTAT,ACKVSC,ACKDSC
 ;
 S ACKDIAG=""
 ; find the ICD code on the QUASAR file
 S ACKICDN=$$FIND1^DIC(509850.1,",","Q",ACKICD,"","","")
 ;
 ; if not found then set error message and exit
 I 'ACKICDN D  G SETDIAGX
 . S ACKDIAG="0^Diagnosis not valid for Audiology and Speech Pathology"
 ;
 ; if found, get status (active/inactive)
 S ACKSTAT=$$GET1^DIQ(509850.1,ACKICDN_",",.06,"I")
 ;
 ; if inactive then set error message and exit
 I ACKSTAT'=1 D  G SETDIAGX
 . S ACKDIAG="0^Diagnosis not Active"
 ;
 ; get the stop code for the visit and the stop code for the Diagnosis
 S ACKVSC=$$GET1^DIQ(509850.6,ACKVIEN_",",4,"I")
 S ACKDSC=$$GET1^DIQ(509850.1,ACKICDN_",",.04,"I")
 ;
 ; if diagnosis is for different stop code then set error and exit
 I ACKDSC="S",(ACKVSC="A")!(ACKVSC="AT") D  G SETDIAGX
 . S ACKDIAG="0^Diagnosis is not valid for an Audiology Visit"
 I ACKDSC="A",(ACKVSC="S")!(ACKVSC="ST") D  G SETDIAGX
 . S ACKDIAG="0^Diagnosis is not valid for a Speech Pathology Visit"
 ;
 ; see if the code already exists on the visit
 S ACKE=$$FIND1^DIC(509850.63,","_ACKVIEN_",","Q",ACKICDN,"","","")
 ;
 ; if it does already exist on the visit then set error message and exit
 ;  (null value also is an error as this means an error occurred in the lookup)
 I ACKE'=0 D  G SETDIAGX
 . S ACKDIAG="0^Duplicate Diagnosis"
 ;
 ; all ok, then add the diagnosis to the visit
 S ACKARR(509850.63,"+1,"_ACKVIEN_",",.01)=ACKICDN
 I ACKDPRIM S ACKARR(509850.63,"+1,"_ACKVIEN_",",.12)=1
 D UPDATE^DIE("","ACKARR","","")
 S ACKDIAG="1^"  ; set return flag to OK
 ;
SETDIAGX ; exit point
 Q ACKDIAG
 ;
SETPROC(ACKVIEN,ACKCPT,ACKQTY,ACKPPRV) ; add CPT code to A&SP Clinic Visit
 ; inputs: ACKVIEN - A&SP visit ien
 ;         ACKCPT - CPT Procedure ien from ICPT file
 ;         ACKQTY - number of time procedure was performed (opt)
 ;         ACKPPRV - Procedure Provider
 ; outputs: n^ - everything ok (n=cpt ien on visit)
 ;          0^xxxxxxx - update failed (reason=xxxxxx)
 ; NB. This function checks the Stop Code for the visit against the 
 ; valid stop codes for the procedure. It therefore assumes that the
 ; visit stop code has already been filed.
 N ACKPROC,ACKCPTN,ACKE,ACKARR,ACKSTAT,ACKVSC,ACKPSC,ACKIEN
 ;
 ; initialise return variable and procedure quantity
 S ACKPROC="",ACKQTY=$S(+$G(ACKQTY)=0:1,1:ACKQTY)
 ;
 ; find the ICD code on the QUASAR file
 S ACKCPTN=$$FIND1^DIC(509850.4,",","Q",ACKCPT,"","","")
 ;
 ; if not found then set error message and exit
 I 'ACKCPTN D  G SETPROCX
 . S ACKPROC="0^Procedure not valid for Audiology and Speech Pathology"
 ;
 ; if found, get status (active/inactive)
 S ACKSTAT=$$GET1^DIQ(509850.4,ACKCPTN_",",.04,"I")
 ;
 ; if inactive then set error message and exit
 I ACKSTAT'=1 D  G SETPROCX
 . S ACKPROC="0^Procedure not Active"
 ;
 ; get the stop code for the visit and the stop code for the Procedure
 S ACKVSC=$$GET1^DIQ(509850.6,ACKVIEN_",",4,"I")
 S ACKPSC=$$GET1^DIQ(509850.4,ACKCPTN_",",.02,"I")
 ;
 ; if procedure is for different stop code then set error and exit
 I ACKPSC="S",(ACKVSC="A")!(ACKVSC="AT") D  G SETPROCX
 . S ACKPROC="0^Procedure is not valid for an Audiology Visit"
 I ACKPSC="A",(ACKVSC="S")!(ACKVSC="ST") D  G SETPROCX
 . S ACKPROC="0^Procedure is not valid for a Speech Pathology Visit"
 ;
 ; all ok, then add the procedure to the visit
 S ACKARR(509850.61,"+1,"_ACKVIEN_",",.01)=ACKCPTN
 S ACKARR(509850.61,"+1,"_ACKVIEN_",",.03)=ACKQTY
 S ACKARR(509850.61,"+1,"_ACKVIEN_",",.05)=ACKPPRV
 K ACKIEN
 D UPDATE^DIE("","ACKARR","ACKIEN","")
 S ACKPROC=+$G(ACKIEN(1))_"^"  ; set return flag to OK
 ;
SETPROCX ; exit point
 Q ACKPROC
 ;
SETMDFR(ACKVIEN,ACKPIEN,ACKMOD) ; add modifier to A&SP Clinic Visit
 ; inputs: ACKVIEN - A&SP visit ien
 ;         ACKPIEN - Procedure ien from visit file
 ;         ACKMOD - modifier (ien from file 81.3)
 ; outputs: 1^ - everything ok
 ;          0^xxxxxxx - update failed (reason=xxxxxx)
 N ACKMDFR,ACKMODN,ACKARR,ACKSTAT
 ;
 ; initialise return variable 
 S ACKMDFR=""
 ;
 ; find the modifier code on the QUASAR file
 S ACKMODN=$$FIND1^DIC(509850.5,",","Q",ACKMOD,"","","")
 ;
 ; if not found then set error message and exit
 I 'ACKMODN D  G SETMODX
 . S ACKMOD="0^Modifier not valid for Audiology and Speech Pathology"
 ;
 ; if found, get status (active/inactive)
 S ACKSTAT=$$GET1^DIQ(509850.5,ACKMODN_",",1,"I")
 ;
 ; if inactive then set error message and exit
 I ACKSTAT'=1 D  G SETMODX
 . S ACKMOD="0^Modifier not Active"
 ;
 ; all ok, then add the modifier to the visit and procedure
 S ACKARR(509850.64,"+1,"_ACKPIEN_","_ACKVIEN_",",.01)=ACKMODN
 D UPDATE^DIE("","ACKARR","","")
 S ACKMOD="1^"  ; set return flag to OK
 ;
SETMODX ; exit point
 Q ACKMOD
 ;
 ;
PRIMARY(ACKVIEN,ACKDD) ;  Does the visit contain a Primary Diagnosis
 ;  Input  - Visit IEN
 ;  Output - 1=Visit has a Primary Diagnosis 
 ;           0=Visit Does not have a Primary Diagnosis
 ;             or User editing diagnosis that is the Primary
 ;
 I ACKDD'="",$$GET1^DIQ(509850.63,ACKDD_","_ACKVIEN_",",".12","I")=1 K ACKDD Q 0
 N ACKFLAG,ACKK3
 D LIST^DIC(509850.63,","_ACKVIEN_",",".12","I","*","","","","","","ACKDIAG")
 S ACKK3=0,ACKFLAG=0
 F  S ACKK3=$O(ACKDIAG("DILIST","ID",ACKK3)) Q:ACKK3=""!(ACKFLAG)  D
 . I ACKDIAG("DILIST","ID",ACKK3,".12")=1 S ACKFLAG=1
 K ACKDD
 Q ACKFLAG
 ;
POSTDIAG(ACKVIEN) ;  After Diagnosis codes have been entered check that
 ;                  one is a Primary diagnosis.
 ;
 ;     Input  - Visit IEN
 ;     Output - 1=A primary has been entered
 ;              0=A Primary needs to be entered
 ;
 I $$PRIMARY(ACKVIEN,"") Q 1
 W !!,"One of the Diagnosis codes entered must be defined as the Primary Diagnosis."
 Q 0
 ;
TIMECHEK(ACKVIEN,ACKPARAM) ;  Prevet user from editing  a Visit Time
 ;
 ;   Input ACKVIEN   - Visit IEN
 ;         ACKPARMAM - 1=Called from Template
 ;                     Null=Called from input Tranform of Visit Time
 ;   Output 0=Visit has No Visit Time
 ;          1=Visit has Visit Time
 ;
 N ACKQTME
 S ACKQTME=$$GET1^DIQ(509850.6,ACKVIEN,55,"E")
 I ACKQTME="" Q 0
 I ACKPARAM=1 D
 . W !,"APPOINTMENT TIME : "_ACKQTME_"   (Uneditable)"
 K ACKPARAM
 Q 1
 ;
TIMERR ;
 W !,"     NOTE - Once entered this field cannot be edited."
 W !,"     If you wish to edit the Visit Time use the Delete Visit option then",!
 W "     re-enter the visit with the correct Visit Time.",!
 ; 
