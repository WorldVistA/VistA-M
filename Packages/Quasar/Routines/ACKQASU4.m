ACKQASU4 ;HCIOFO/AG - New/Edit Visit Utilities  ; 12/31/07 7:28am
 ;;3.0;QUASAR;**17**;Feb 11, 2000;Build 28
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
COPYPCE(ACKVIEN,ACKPCENO) ; Copies the visit data from given PCE Visit
 ; inputs:- ACKVIEN - QUASAR Visit ien to receive data
 ;          ACKPCENO - PCE Visit ien to copy from
 ; outputs:- 0^ - everything ok
 ;           n^ - n errors found
 ;   errors filed in ^TMP("ACKQASU4",$J,"COPYPCE","ERROR",n)=field^int^ext^message
 ; NB. In the validation of Dx and CPT codes, the Visit Stop Code (A,S,
 ; AT or ST) is read from the Qsr Visit record. For this validation to
 ; work therefore, the Visit Stop Code must already be filed on the Qsr
 ; visit.
 N ACKERR,ACKARR,ACKVELG,ACKI,ACKICD,ACKE,ACKTMP,ACKPRIM,ACKSTUD
 N ACKSC,ACKAO,ACKIR,ACKEC,ACKREC,ACKPRV,ACKTYP,ACKCPT,ACKQTY,ACKVTME
 N ACKDPRIM,ACKQPRV,ACKPRVCK
 K ^TMP("ACKQASU4",$J,"COPYPCE") ; initialise return array
 S ACKERR=0  ; error counter
 ;
 ; get the PCE Visit data - returned in ^TMP("PXKENC",$J,pce ien,...)
 D ENCEVENT^PXAPI(ACKPCENO,"")
 ;
 ;  Get Diagnostic codes
 S ACKI="",ACKDPRIM=""
 F  S ACKI=$O(^TMP("PXKENC",$J,ACKPCENO,"POV",ACKI)) Q:ACKI=""  D
 . S ACKICD=$P($G(^TMP("PXKENC",$J,ACKPCENO,"POV",ACKI,0)),U,1)  ; icd ien
 . I ACKDPRIM="",$P($G(^TMP("PXKENC",$J,ACKPCENO,"POV",ACKI,0)),U,12)="P" S ACKDPRIM=1
 . ; add to visit
 . S ACKE=$$SETDIAG^ACKQASU5(ACKVIEN,ACKICD,ACKDPRIM)
 . I ACKDPRIM S ACKDPRIM="0"
 . ; if error returned then file
 . I 'ACKE D  Q
 . . S ACKTMP="Diagnosis"_U_ACKICD_U_$$GET1^DIQ(80,ACKICD,.01,"E")_U_$P(ACKE,U,2)
 . . D ADDERR
 . ; if successful then ensure Diagnosis is added to  Patient Diagnostic history
 . D DIAGHIST
 ;
 ;  get all the providers and file
 S ACKI="",ACKPRIM="",ACKSTUD=""
 F  S ACKI=$O(^TMP("PXKENC",$J,ACKPCENO,"PRV",ACKI)) Q:ACKI=""  D
 . S ACKREC=$G(^TMP("PXKENC",$J,ACKPCENO,"PRV",ACKI,0))
 . S ACKPRV=$P(ACKREC,U,1)  ; provider ien
 . S ACKTYP=$P(ACKREC,U,4)  ; primary/secondary
 . I ACKTYP="P" D COPYPRIM Q   ; copy primary provider
 . I ACKTYP="S" D COPYSCND Q   ; copy secondary provider
 ;
 ; Get procedure codes
 S ACKI=""
 F  S ACKI=$O(^TMP("PXKENC",$J,ACKPCENO,"CPT",ACKI)) Q:ACKI=""  D
 . S ACKREC=$G(^TMP("PXKENC",$J,ACKPCENO,"CPT",ACKI,0))
 . S ACKCPT=$P(ACKREC,U,1),ACKQTY=$P(ACKREC,U,16)  ; unpack cpt and volume
 . ;  Get Procedure Provider
 . S ACKPRV=$P($G(^TMP("PXKENC",$J,ACKPCENO,"CPT",ACKI,12)),U,4)
 . S ACKQPRV=$$PROVCHK(ACKPRV)
 . I ACKPRV'="" D
 . . S ACKPRVCK=$$STACT^ACKQUTL(ACKQPRV,ACKVD)
 . . I ACKPRVCK'="0",ACKPRVCK'="-6" D
 . . . S ACKTMP="Provider"_U_ACKPRV_U_$$GET1^DIQ(200,ACKPRV_",",.01,"E")_U
 . . . S ACKTMP=ACKTMP_"Invalid Procedure Provider"
 . . . D ADDERR
 . . . S ACKQPRV=""
 . ; add to visit
 . S ACKE=$$SETPROC^ACKQASU5(ACKVIEN,ACKCPT,ACKQTY,ACKQPRV)
 . ; if error returned then file
 . I 'ACKE D  Q
 . . S ACKTMP="Procedure"_U_ACKCPT_U_$$GET1^DIQ(81,ACKCPT,.01,"E")_U_$P(ACKE,U,2)
 . . D ADDERR
 . ; if successful then do the modifiers for this procedure
 . S ACKM=0,ACKPIEN=+ACKE   ; ACKPIEN=procedure ien from visit file
 . F  S ACKM=$O(^TMP("PXKENC",$J,ACKPCENO,"CPT",ACKI,1,ACKM)) Q:'ACKM  D
 . . S ACKMOD=$P($G(^TMP("PXKENC",$J,ACKPCENO,"CPT",ACKI,1,ACKM,0)),U,1)
 . . ; add to visit
 . . S ACKE=$$SETMDFR^ACKQASU5(ACKVIEN,ACKPIEN,ACKMOD)
 . . ; if error returned then file
 . . I '+ACKE D  Q
 . . . S ACKTMP="Modifier"_U_ACKMOD_U_$$GET1^DIQ(81.3,ACKMOD_",",.01,"E")_U_$P(ACKE,U,2)
 . . . D ADDERR
 ;
 ; now file header items
 K ACKARR,ACKPRV
 ;
 ;  If PCE visit has an eligibility write to a&sp visit file
 S ACKVELG=$P($G(^TMP("PXKENC",$J,ACKPCENO,"VST",ACKPCENO,0)),U,21)
 I ACKVELG'="" S ACKARR(509850.6,ACKVIEN_",",80)=ACKVELG
 ;
 ;  Get service connected,Agent Orange,Radiation and Environmental
 ;  Contaminents from PCE file and set them to the Visit file.
 S ACKREC=$G(^TMP("PXKENC",$J,ACKPCENO,"VST",ACKPCENO,800))
 S ACKSC=$P(ACKREC,U,1)  ; service connected
 S ACKAO=$P(ACKREC,U,2)  ; agent orange
 S ACKIR=$P(ACKREC,U,3)  ; ionizing radiation
 S ACKEC=$P(ACKREC,U,4)  ; environmental contaminants
 S ACKARR(509850.6,ACKVIEN_",",20)=$S(+ACKSC:1,ACKSC=0:0,1:"")
 S ACKARR(509850.6,ACKVIEN_",",25)=$S(+ACKAO:1,ACKAO=0:0,1:"")
 S ACKARR(509850.6,ACKVIEN_",",30)=$S(+ACKIR:1,ACKIR=0:0,1:"")
 S ACKARR(509850.6,ACKVIEN_",",35)=$S(+ACKEC:1,ACKEC=0:0,1:"")
 ;
 ; Update QUASAR visit record
 D FILE^DIE("","ACKARR")
 K ACKARR
 ;
COPYPCEX ; Exit point
 K ^TMP("PXKENC",$J)  ; Clear PCE data
 I ACKERR S ^TMP("ACKQASU4",$J,"COPYPCE","ERROR")=ACKERR  ; final error count
 Q ACKERR_U  ; return error count
 ;
 ;
COPYPRIM ; Copy the primary provider to QUASAR
 ;
 ; If we haven't successfully filed a primary then attempt to
 I ACKPRIM="" D  Q  ;
 . S ACKQPRV=$$PROVCHK(ACKPRV)
 . S ACKE=$$SETPRIM^ACKQASU6(ACKVIEN,ACKQPRV)  ; Attempt to add to visit
 . I +ACKE S ACKPRIM=ACKQPRV  ; Record that we now have a primary
 . I '+ACKE D  ; error occurred
 . . S ACKTMP="Provider"_U_ACKPRV_U_$$GET1^DIQ(200,ACKPRV_",",.01,"E")_U
 . . S ACKTMP=ACKTMP_$P(ACKE,U,2)
 . . D ADDERR
 ;
 ; if we already have a primary then add an error message
 S ACKTMP="Provider"_U_ACKPRV_U_$$GET1^DIQ(200,ACKPRV_",",.01,"E")_U
 S ACKTMP=ACKTMP_"Visit already has a Primary Provider"
 D ADDERR
 ;
 ; return to provider loop
 Q
 ;
COPYSCND ; copy a secondary provider to QUASAR
 ;
 ; determine the Quasar classification for this provider
 S ACKQPRV=$$PROVCHK(ACKPRV)
 S ACKTYPQ=$$GET1^DIQ(509850.3,$S(ACKQPRV="":" ",1:ACKQPRV)_",",.02,"I")
 ;
 ; if they are a student and we haven't one already, 
 ;  then attempt to file as student
 I ACKTYPQ="S",ACKSTUD="" D  Q   ; student
 . S ACKE=$$SETSTUD^ACKQASU6(ACKVIEN,ACKQPRV)
 . I +ACKE S ACKSTUD=ACKQPRV Q  ; record that we now have a student
 . I '+ACKE D  ;         Error occurred
 . . S ACKTMP="Student"_U_ACKPRV_U_$$GET1^DIQ(200,ACKPRV_",",.01,"E")_U
 . . S ACKTMP=ACKTMP_$P(ACKE,U,2)
 . . D ADDERR
 ;
 ; if they are a student and we already have one then set error
 I ACKTYPQ="S",ACKSTUD'="" D  Q
 . S ACKTMP="Student"_U_ACKPRV_U_$$GET1^DIQ(200,ACKPRV_",",.01,"E")_U
 . S ACKTMP=ACKTMP_"Visit already has a Student"
 . D ADDERR
 ;
 ; if they are a regular provider, and we do not already have
 ;  a secondary provider then attempt to file
 I (ACKTYPQ="C")!(ACKTYPQ="F")!(ACKTYPQ="O") D  Q
 . S ACKE=$$SETSCND^ACKQASU6(ACKVIEN,ACKQPRV)  ; attempt to add to visit
 . I +ACKE Q    ; All okay
 . I '+ACKE D   ; Error occurred
 . . S ACKTMP="Provider"_U_ACKPRV_U_$$GET1^DIQ(200,ACKPRV_",",.01,"E")_U
 . . S ACKTMP=ACKTMP_$P(ACKE,U,2)
 . . D ADDERR
 ;
 ; if we get this far then provider must be unknown to Quasar
 S ACKTMP="Provider"_U_ACKPRV_U_$$GET1^DIQ(200,ACKPRV_",",.01,"E")_U
 S ACKTMP=ACKTMP_"Provider not defined for Audiology and Speech Pathology"
 D ADDERR
 ;
 ; end of checking a secondary provider
 Q
 ;
ADDERR ; add an error to return array in ^TMP
 ;  ACKERR is current error count, ACKTMP is the error detail
 S ACKERR=ACKERR+1
 S ^TMP("ACKQASU4",$J,"COPYPCE","ERROR",ACKERR)=ACKTMP
 Q
 ;
DIAGHIST ; ensure diagnosis is on Patient history
 ; this s/r checks for ACKICD (diagnosis ien) on the patient history
 ; of patient ACKPAT
 ; if the ICD is not found a new entry is automatically added using the
 ; visit date in ACKVD
 N ACKTGT
 ;
 ; look for the diagnosis on the current history
 D FIND^DIC(509850.22,","_ACKPAT_",","","Q",ACKICD,1,"B","","","ACKTGT")
 ;
 ; if found then exit 
 I +$P($G(ACKTGT("DILIST",0)),U,1)=1 Q  ; exactly one found
 ; 
 ; create a new entry
 S ACKUPD(509850.22,"+1,"_ACKPAT_",",.01)=ACKICD
 S ACKUPD(509850.22,"+1,"_ACKPAT_",",1)=ACKVD
 D UPDATE^DIE("","ACKUPD","","")
 ;
 ; end
 Q
 ;
PROVCHK(ACKPRV) ;  Check to see if Provider is on Quasar Staff file - if so
 ;          function passes back Quasars Provider IEN No else null
 ;
 N ACKA,ACKB,NPNAME S ACKB=""
 I ACKPRV="" Q ACKB
 ;ACKQ*3*17 
 S NPNAME=$$GET1^DIQ(200,ACKPRV,.01,"")
 I '$D(^ACK(509850.3,"B",NPNAME)) Q ACKB
 Q $O(^ACK(509850.3,"B",NPNAME,ACKB))
 ;
