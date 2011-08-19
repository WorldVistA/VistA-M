ACKQUTL3 ;HCIOFO/AG - QUASAR Utility Routine ; 12/13/02 3:51pm
 ;;3.0;QUASAR;**5**;Feb 11, 2000
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
PCECHKV(ACKVIEN) ; is PCE Visit still same patient etc.
 ; this function will check that the Qsr Visit (ACKVIEN) has the same
 ;  values for Patient, Clinic, Date and Time as the PCE Visit that it 
 ;  points to.
 ; inputs:-  ACKVIEN - QUASAR Visit IEN (reqd)
 ; outputs:- see function $$PCECHK below!
 N ACKTGT,ACKPCE,ACKDT,ACKTM,ACKPAT,ACKCLN
 D GETS^DIQ(509850.6,ACKVIEN_",",".01;125;1;2.6;55","I","ACKTGT")
 S ACKPCE=$G(ACKTGT(509850.6,ACKVIEN_",",125,"I"))
 I 'ACKPCE Q "2^"  ; not pointing to a visit
 S ACKDT=$G(ACKTGT(509850.6,ACKVIEN_",",.01,"I"))\1
 S ACKTM=$G(ACKTGT(509850.6,ACKVIEN_",",55,"I"))
 S ACKPAT=$G(ACKTGT(509850.6,ACKVIEN_",",1,"I"))
 S ACKCLN=$G(ACKTGT(509850.6,ACKVIEN_",",2.6,"I"))
 Q $$PCECHK(ACKPCE,ACKDT,ACKTM,ACKPAT,ACKCLN)
 ;
PCECHK(ACKPCE,ACKDT,ACKTM,ACKPAT,ACKCLN) ; is PCE Visit still same patient etc.
 ; this function will check that the Qsr Visit (ACKVIEN) has the same
 ;  values for Patient, Clinic, Date and Time as the PCE Visit that it 
 ;  points to.
 ; inputs:-  ACKPCE - PCE Visit IEN (reqd)
 ;           ACKDT - date of visit (reqd) (fileman internal)
 ;           ACKTM - time of visit (reqd)  (qsr time .n[nnnnn])
 ;           ACKPAT - patient (reqd)
 ;           ACKCLN - clinic (reqd)
 ; outputs:- string
 ;           value: "0^X^Y^Z" - either the date, patient or clinic differ
 ;                    where X=Clinics are same (1 or 0)
 ;                          Y=Patients are same (1 or 0)
 ;                          Z=Dates are same (1 or 0)
 ;                        eg "0^1^0^0" = patient and dates differ
 ;                  "1^.123" - only time is different (.123=Pce time)
 ;                  "2^" - all fields the same
 N PCEDTTM,PCEDT,PCETM,PCEPAT,PCECLN,ACKSTR
 K ^TMP("PXKENC",$J)
 ;
 ; get the visit data from PCE (places it in ^TMP("PXKENC",$J)
 D ENCEVENT^PXAPI(ACKPCE)
 S PCEDTTM=$P($G(^TMP("PXKENC",$J,ACKPCE,"VST",ACKPCE,0)),U,1)
 S PCEDT=PCEDTTM\1,PCETM=PCEDTTM#1
 S PCEPAT=$P($G(^TMP("PXKENC",$J,ACKPCE,"VST",ACKPCE,0)),U,5)
 S PCECLN=$P($G(^TMP("PXKENC",$J,ACKPCE,"VST",ACKPCE,0)),U,22)
 K ^TMP("PXKENC",$J)
 ;
 ; check date, patient and clinic
 I (PCEDT'=ACKDT)!(PCEPAT'=ACKPAT)!(PCECLN'=ACKCLN) D  Q ACKSTR
 . S ACKSTR="0^"
 . S $P(ACKSTR,U,2)=$S(PCECLN=ACKCLN:1,1:0)
 . S $P(ACKSTR,U,3)=$S(PCEPAT=ACKPAT:1,1:0)
 . S $P(ACKSTR,U,4)=$S(PCEDT=ACKDT:1,1:0)
 ;
 ; check Appointment time
 I +PCETM'=+ACKTM Q "1^"_PCETM
 ;
 ; must be the same!
 Q "2^"
 ;
DISPLAY(ACKVIEN,XPOS) ; create summary line for visit selection
 N ACKPAT,ACKCLN,ACKTM,ACKTIME,ACKAM,ACKDISP,ACKLEN
 S ACKTM=$$GET1^DIQ(509850.6,ACKVIEN_",",55,"I"),ACKTIME=$$FMT^ACKQUTL6(ACKTM,2)
 S ACKPAT=$$GET1^DIQ(509850.6,ACKVIEN_",",1,"E")
 S ACKCLN=$$GET1^DIQ(509850.6,ACKVIEN_",",2.6,"E")
 S ACKP=$S($$GET1^DIQ(509850.6,ACKVIEN_",",125,"I"):".",1:" ")
 I XPOS<35 D
 . S ACKLEN=80-XPOS-10-2/2
 . S ACKPAT=$E(ACKPAT_$J("",ACKLEN),1,ACKLEN\1)
 . I $G(%)'="" D
 . . I $TR(%,",","")'?.A D
 . . . S ACKCLN=$E(ACKCLN_$J("",ACKLEN),1,ACKLEN+.5\1)
 . . . S ACKDISP=" "_ACKTIME_ACKP_" "_ACKPAT_" "_ACKCLN
 . . I $TR(%,",","")?.A D
 . . . S ACKCLN=$E(ACKCLN,1,(40-$L(%)))
 . . . S ACKDISP=" "_ACKTIME_ACKP_" "_ACKCLN
 . I $G(%)="" D
 . . S ACKCLN=$E(ACKCLN_$J("",ACKLEN),1,ACKLEN+.5\1)
 . . S ACKDISP=" "_ACKTIME_ACKP_" "_ACKPAT_" "_ACKCLN
 I XPOS'<35 D
 . S ACKLEN=80-XPOS-10-1
 . S ACKPAT=$E(ACKPAT_$J("",ACKLEN),1,ACKLEN)
 . S ACKDISP=" "_ACKTIME_ACKP_" "_ACKPAT
 Q ACKDISP
 ;
PCEERR(ACKVIEN,ACKARR,ACKNUM,ACKWIDE) ; retrieve PCE Errors for a visit and store in ACKARR
 ; inputs:- ACKVIEN - visit ien  (reqd)
 ;          ACKARR - array name in which to place errors (indirection
 ;                   used to file data ie @ACKARR@(x) (reqd)
 ;          ACKNUM - Error number (if only one reqd)  (opt)
 ;          ACKWIDE - max number of characters in each line (opt)
 ; outputs:-
 ;    ACKARR=n  - number of lines to display
 ;    ACKARR(1-n)=text - text of error (wrapped to ACKWIDE characters)
 ; if @ACKARR already contains data then this subroutine will append 
 ;  the PCE Errors starting at line @ACKARR+1. It is up to the calling
 ;  routine to clear the array @ACKARR before calling this function.
 N ACKTMP,ACKCT,ACKSUB,TXT,TXT2,I
 K ^TMP("ACKQUTL3",$J,"PCEERR")
 S ACKTMP=$NA(^TMP("ACKQUTL3",$J,"PCEERR"))
 S ACKNUM=+$G(ACKNUM)
 S ACKWIDE=$S(+$G(ACKWIDE)<1:80,ACKWIDE<40:40,1:ACKWIDE)
 I 'ACKNUM D GETS^DIQ(509850.6,ACKVIEN_",","6.5*","I",ACKTMP,"")
 I ACKNUM D GETS^DIQ(509850.65,ACKNUM_","_ACKVIEN_",","*","I",ACKTMP,"")
 S ACKCT=+$G(@ACKARR)
 S ACKSUB="" F  S ACKSUB=$O(@ACKTMP@(509850.65,ACKSUB)) Q:ACKSUB=""  D
 . I $P(ACKSUB,",",2)'=ACKVIEN Q
 . ; field name and external value
 . S TXT=@ACKTMP@(509850.65,ACKSUB,.02,"I")_" - "_@ACKTMP@(509850.65,ACKSUB,.04,"I")
 . I $L(TXT)'>ACKWIDE D
 . . S ACKCT=ACKCT+1,@ACKARR@(ACKCT)=TXT
 . I $L(TXT)>ACKWIDE D
 . . S TXT=$E(@ACKTMP@(509850.65,ACKSUB,.02,"I"),1,ACKWIDE)
 . . S ACKCT=ACKCT+1,@ACKARR@(ACKCT)=TXT
 . . S TXT=$E(@ACKTMP@(509850.65,ACKSUB,.04,"I"),1,ACKWIDE)
 . . S ACKCT=ACKCT+1,@ACKARR@(ACKCT)=TXT
 . ; pce error message
 . S TXT=@ACKTMP@(509850.65,ACKSUB,1,"I")
 . F  Q:TXT=""  D
 . . S TXT2=$E(TXT,1,ACKWIDE),I=0
 . . I $L(TXT2)=ACKWIDE F I=$L(TXT2):-1:0 Q:$E(TXT2,I)?1P
 . . I I S TXT2=$E(TXT2,1,I)
 . . S TXT=$P(TXT,TXT2,2,255)
 . . S ACKCT=ACKCT+1,@ACKARR@(ACKCT)=TXT2
 S @ACKARR=ACKCT
 K ^TMP("ACKQUTL3",$J,"PCEERR")
 Q
 ;
PROBLIST(ACKPAT,ACKECHO) ; re-build the problem list for a Patient
 ; this function will run down the QUASAR Visits for a patient and
 ;  create an accurate problem list for the patient on the A&SP
 ;  PATIENT file. The function will be called from the Patient 
 ;  Inquiry option and the Delete Visit function.
 ; inputs:- ACKPAT - patient DFN
 ;          ACKECHO - whether to display progress
 N ACKTMP,ACKVIEN,ACKDT,ACKDT1,ACKIVDT,ACKDIEN,ACKICD,ACKARR
 ;
 I '+$G(ACKPAT) Q
 S ACKECHO=+$G(ACKECHO)
 K ^TMP("ACKQUTL3",$J,"PROBLIST")
 S ACKTMP=$NA(^TMP("ACKQUTL3",$J,"PROBLIST"))
 ;
 ; walk down the visits for a patient
 S ACKIVDT=0
 S ACKVIEN=0 F  S ACKVIEN=$O(^ACK(509850.6,"APT",ACKPAT,ACKVIEN)) Q:'ACKVIEN  D
 . ; get visit date
 . S ACKDT=+$$GET1^DIQ(509850.6,ACKVIEN_",",.01,"I")\1
 . ; get Diagnosis multiple for this visit
 . D GETS^DIQ(509850.6,ACKVIEN_",","3*","I",$NA(@ACKTMP@(1)))
 . ; walk down the diagnosis multiple entries
 . S ACKDIEN="" F  S ACKDIEN=$O(@ACKTMP@(1,509850.63,ACKDIEN)) Q:ACKDIEN=""  D
 . . I $P(ACKDIEN,",",2)'=ACKVIEN Q
 . . S ACKICD=@ACKTMP@(1,509850.63,ACKDIEN,.01,"I")
 . . S ACKDT1=$G(@ACKTMP@(2,ACKICD))
 . . I ('ACKDT1)!(ACKDT1>ACKDT) S @ACKTMP@(2,ACKICD)=ACKDT
 . . I ('ACKIVDT)!(ACKIVDT>ACKDT) S ACKIVDT=ACKDT  ; earliest visit date
 ;
 ; update initial visit date for the patient
 K ACKARR
 S ACKARR(509850.2,ACKPAT_",",1)=ACKIVDT
 D FILE^DIE("","ACKARR","")
 ;
 ; clear down the diagnosis history for the patient
 D GETS^DIQ(509850.2,ACKPAT_",","2*","I",$NA(@ACKTMP@(4)))
 S ACKDIEN="" F  S ACKDIEN=$O(@ACKTMP@(4,509850.22,ACKDIEN)) Q:ACKDIEN=""  D
 . I $P(ACKDIEN,",",2)'=ACKPAT Q
 . K ACKARR
 . S ACKARR(509850.22,ACKDIEN,.01)="@"
 . D FILE^DIE("","ACKARR","")
 ;
 ; if no diagnosis history then display message
 I ACKECHO,$O(@ACKTMP@(2,""))="" D  G PROBLISX
 . W !!,"No Diagnosis was found in the A&SP CLINIC VISIT file for this patient.",!
 ;
 ; sort new diagnosis list by date
 S ACKICD="" F  S ACKICD=$O(@ACKTMP@(2,ACKICD)) Q:ACKICD=""  D
 . S ACKDT=@ACKTMP@(2,ACKICD) S @ACKTMP@(3,ACKDT,ACKICD)=""
 ;
 ; update diagnosis history 
 I ACKECHO W !!,"Now updating diagnostic history.",!
 S (ACKDT,ACKICD)="" F  S ACKDT=$O(@ACKTMP@(3,ACKDT)) Q:ACKDT=""  F  S ACKICD=$O(@ACKTMP@(3,ACKDT,ACKICD)) Q:ACKICD=""  D
 . K ACKARR
 . S ACKARR(509850.22,"?+1,"_ACKPAT_",",.01)=ACKICD
 . S ACKARR(509850.22,"?+1,"_ACKPAT_",",1)=ACKDT
 . D UPDATE^DIE("","ACKARR","","")
 ;
PROBLISX ; all done
 K ^TMP("ACKQUTL3",$J,"PROBLIST")
 Q
