TIUPXAP2 ; SLC/JER - More code for the workload capture ;12/4/02@07:54:52 [1/18/05 9:27am]
 ;;1.0;TEXT INTEGRATION UTILITIES;**20,67,82,107,126,124,149,179,190**;Jun 20, 1997;Build 1
TEST ; Test the PXAPI Data Capture dialogs
 N CPT,DFN,ICD,ICDARR,CPTARR,SC,DTOUT,TIU,TIUOK
 S DFN=+$$PATIENT^TIULA
 S TIU("LOC")=$$SELLOC^TIUVSIT
 D GETICD^TIUPXAPI(TIU("LOC"),.ICDARR)
 D ICD^TIUPXAPI(.ICD,.ICDARR)
 D GETCPT^TIUPXAPC(TIU("LOC"),.CPTARR)
CPTCALL D CPT^TIUPXAPC(.CPT,.CPTARR)
 I '$D(CPT),'$D(DTOUT) W !!,$C(7),"You MUST enter one or more Procedures." G CPTCALL
 D SCASK^TIUPXAPS(.SC,+DFN,.TIU)
 I $D(DTOUT)!(+$O(ICD(0))'>0)&(+$O(CPT(0))'>0)&(+$O(SC(0))'>0) D  Q
 . W !,$C(7),"Insufficient information for Workload Credit."
 . W !,"Missing information will have to be captured by another method."
 S TIUOK=$$CONFIRM^TIUPXAPI(.ICD,.CPT,.SC)
 I '+TIUOK D  G TEST
 . W !!,"Changes Discarded. Please Enter Corrected Workload Data..." H 3
 . K ICD,CPT,SC,ICDARR,CPTARR
 K CPTARR,ICDARR
 W "Done."
 Q
CMBLST(EMCODES,CPTCODES) ; Combine E/M and other CPT codes
 N TIUI,TIUJ,TMPARRY S (TIUI,TIUJ)=0
 M TMPARRY=EMCODES S TIUI=EMCODES(0)
 F  S TIUJ=$O(CPTCODES(TIUJ)) Q:+TIUJ'>0  D
 . S TIUI=+$G(TIUI)+1,TMPARRY(TIUI)=CPTCODES(TIUJ),TMPARRY(0)=TIUI
 . ;Merge CPT Modifiers
 . M TMPARRY(TIUI,"MODIFIER")=CPTCODES(TIUJ,"MODIFIER")
 K CPTCODES
 M CPTCODES=TMPARRY
 Q
PICK(LOW,HIGH,PROMPT,TYPE) ; List selection
 N X,Y S PROMPT=$G(PROMPT,"Select Item"),TYPE=$G(TYPE,"LO")
 W !
 S Y=$$READ^TIUU(TYPE_U_LOW_":"_HIGH,PROMPT)
 Q Y
EDTENC(TIUDA,CHNG) ; Edit the encounter for a given note
 N TIUD0,TIUD12,TIUDFN,TIUI,TIUVSIT,TIUHL,TIUEDT,TIUPAUSE,TIUERR,TIUWHAT
 N TIUCONT,DA
 Q:$D(XWBOS)
 Q:+$P($G(TIUDPRM(0)),U,14)
 D FULL^VALM1
 S TIUD0=$G(^TIU(8925,+TIUDA,0)),TIUD12=$G(^(12))
 S TIUHL=$P(TIUD12,U,11)
 I $P($G(^SC(+TIUHL,0)),U,3)'="C" Q
 ;
 ;If not ok to ask workload, quit
 I '$$WORKOK^TIUPXAP1(+TIUDA) Q
 ;
 S TIUDFN=$P(TIUD0,U,2),TIUEDT=$P(TIUD0,U,7),TIUVSIT=$P(TIUD0,U,3)
 N TIUMVSTF,TIUVSITS
 ;If no visit has been filed with the document
 I $G(TIUVSIT)'>0 D
 . ;Check for the visit
 . S TIUVSITS=$$GETENC^PXAPI(TIUDFN,TIUEDT,TIUHL)
 . I TIUVSITS>0 S TIUVSIT=+TIUVSITS
 . ;Set a flag if multiple visits
 . I $P(TIUVSITS,U,2)'="" S TIUMVSTF=1
 . ;If only one visit update the document
 . I $G(TIUVSIT)>0,'$G(TIUMVSTF) D
 . . S TIUERR=$$UPDVST(TIUDA,TIUVSIT)
 . . K ^TMP("PXKENC",$J)
 W !!
 ;Ask the user if they wish to enter workload if the parameter is defined
 ;and the multiple visit flag is not set
 I $D(TIUDPRM(0)),'$G(TIUMVSTF),$G(TIUVSIT)>0 D  Q:'+TIUCONT
 . S TIUCONT=$$READ^TIUU("Y","Do you wish to enter workload data at this time","YES")
 I $G(VALMAR)="^TMP(""TIUR"",$J)" D
 . N TIU D GETTIU^TIULD(.TIU,TIUDA)
 . W !!,"For ",$G(TIU("PNM"))," ",$G(TIU("PID"))," Visit on "
 . W $P($G(TIU("EDT")),U,2),"...",!
 I $P($P(TIUD0,U,7),".")>DT D  Q
 . W !!,$C(7),"ACRP will not accept data for future Encounters.",!
 . W !,"Workload questions won't be asked for this note.",!
 . S TIUPAUSE=$$READ^TIUU("EA","Press RETURN to continue...")
 I $G(VALMAR)'="^TMP(""TIUR"",$J)" W !!,"Editing Encounter Data...",!
 S TIUWHAT=$S($$CHKAPPT(TIUVSIT,TIUDFN,TIUEDT,TIUHL):"INTV",1:"ADDEDIT")
 S TIUERR=$$INTV^PXAPI(TIUWHAT,"TIU","TEXT INTEGRATION UTILITIES",.TIUVSIT,$S(+$G(TIUVSIT):"",1:TIUHL),TIUDFN,$S(+$G(TIUVSIT):"",1:TIUEDT))
 ;
 ;If an error is returned prompt to continue otherwise if a Visit
 ;IEN is returned and one is not already defined update the document
 I +TIUERR<0 D
 . W ! S TIUPAUSE=$$READ^TIUU("EA","Press RETURN to continue...")
 ELSE  D
 . I $G(TIUVSIT)>0,'$P($G(^TIU(8925,+TIUDA,0)),U,3) S TIUERR=$$UPDVST(TIUDA,TIUVSIT)
 S CHNG=1
 Q
 ;
CHKVST(TIUDA) ;Check the visit associated with the document for key workload
 ;data elements.  Key data elements include provider, diagnosis,
 ;procedure and classifications.
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ; Output -- 0=No Key Workload Data Elements Exist
 ;           1=Key Workload Data Elements Exist
 ;           2=Unable to Determine if Key Workload Data Elements Exist
 N I,TIUCHKF,TIUD0,TIUDFN,TIUEDT,TIUHL,TIUVSIT,TIUVSITS,X
 ;
 ;Set variables, if the 0th node of the document is not defined quit
 S TIUD0=$G(^TIU(8925,+TIUDA,0)) I TIUD0="" S TIUCHKF=2 G CHKVSTQ
 S TIUDFN=$P(TIUD0,U,2),TIUVSIT=$P(TIUD0,U,3),TIUEDT=$P(TIUD0,U,7)
 S TIUHL=$P($G(^TIU(8925,+TIUDA,12)),U,11)
 ;
 ;Get data associated with the visit
 I $G(TIUVSIT)>0 D
 . D ENCEVENT^PXKENC(TIUVSIT)
 ELSE  D
 . S TIUVSITS=$$GETENC^PXAPI(TIUDFN,TIUEDT,TIUHL)
 . I TIUVSITS>0 S TIUVSIT=+TIUVSITS
 . I $P(TIUVSITS,U,2)'="" S TIUCHKF=2 ;multiple visits
 ;
 ;If a visit is not defined or multiple visits exist, quit
 I $G(TIUVSIT)'>0!($G(TIUCHKF)=2) G CHKVSTQ
 ;
 ;If a provider or diagnosis or procedure exists for the visit, set flag
 ;and quit
 I $D(^TMP("PXKENC",$J,TIUVSIT,"PRV"))!($D(^("CPT")))!($D(^("POV"))) S TIUCHKF=1 G CHKVSTQ
 ;
 ;If a classification exists for the visit, set flag and quit
 I $D(^TMP("PXKENC",$J,TIUVSIT,"VST",TIUVSIT,800)) S X=^(800) D
 . F I=1:1:6 I $P(X,U,I)'="" S TIUCHKF=1 Q
 ;
CHKVSTQ K ^TMP("PXKENC",$J)
 Q +$G(TIUCHKF)
 ;
UPDVST(TIUDA,TIUVSIT,ERROR) ;Update Visit in TIU Document file #8925
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIUVSIT  Visit file (#9000010) IEN
 ; Output -- 1=Successful and 0=Failure
 ;           ERROR    Error Message  (Optional)
 N DIERR,OKF,TIUFDA
 ;
 ;Quit if a visit is not defined
 G UPDVSTQ:$G(TIUVSIT)'>0
 ;
 ;Update document with visit
 S TIUFDA(8925,TIUDA_",",.03)=TIUVSIT
 L +^TIU(8925,TIUDA):1 I $T D
 . D FILE^DIE("","TIUFDA","") L -^TIU(8925,TIUDA)
 . S ERROR=$G(DIERR)
 . S OKF=$S(+$G(ERROR):0,1:1)
 ELSE  D
 . S OKF=0
UPDVSTQ Q +$G(OKF)
 ;
CHKWKL(TIUDA,TIUDPRM) ;Check if workload data should be entered
 ; Input  -- TIUDA    TIU Document file (#8925) IEN
 ;           TIUDPRM  TIU Document Parameters file (#8925.95) Array
 ; Output -- 1=Enter Workload and 0=Do Not Enter Workload
 N STATUS,TIUAPPTF,TIUD0,TIUDFN,TIUEDT,TIUHL,TIUVSIT,TIUWKLF,TIURES,TIUINC,TIUARRAY,TIUCNT
 ;
 ;Set variables, if the 0th node of the document is not defined quit
 S TIUD0=$G(^TIU(8925,+TIUDA,0)) G CHKWKLQ:TIUD0=""
 S TIUDFN=$P(TIUD0,U,2),TIUVSIT=$P(TIUD0,U,3),TIUEDT=$P(TIUD0,U,7)
 S TIUHL=$P($G(^TIU(8925,+TIUDA,12)),U,11)
 ;
 ;Check if an appointment is associated with the visit
 S:$$CHKAPPT(TIUVSIT,TIUDFN,TIUEDT,TIUHL)>0 TIUAPPTF=1
 ;
 ;If an appointment is not associated with the visit, assume
 ;the visit is new, set flag to enter workload and quit
 I '$G(TIUAPPTF) S TIUWKLF=1 G CHKWKLQ
 ;
 ;Check the parameter 'Ask Dx/CPT on All Opt Visits'.  If it is set to
 ;No, workload should not be entered for the appointment.
 I '$$BROKER^XWBLIB(),'$P($G(TIUDPRM(0)),U,16) G CHKWKLQ
 ;
 ;Get the status of the appointment
 S TIUARRAY(1)=TIUEDT_";"_TIUEDT
 S TIUARRAY(2)=TIUHL
 S TIUARRAY(4)=TIUDFN
 S TIUARRAY("SORT")="P"
 S TIUARRAY("FLDS")="22"
 S TIUARRAY("MAX")=1
 S TIUCNT=$$SDAPI^SDAMA301(.TIUARRAY)
 I TIUCNT=-1 K ^TMP($J,"SDAMA301") Q +$G(TIUWKLF)
 S STATUS=+$P($G(^TMP($J,"SDAMA301",TIUDFN,TIUEDT)),U,22)
 K ^TMP($J,"SDAMA301")
 ;Check the status of the appointment.  If the appointment can be
 ;checked-out, workload can be entered.
 I $D(^SD(409.63,"ACO",1,STATUS)) S TIUWKLF=1
 ;
CHKWKLQ Q +$G(TIUWKLF)
 ;
CHKAPPT(TIUVSIT,TIUDFN,TIUEDT,TIUHL) ;Check if an appointment is associated with the Visit
 ; Input  -- TIUVSIT  Visit file (#9000010) IEN
 ;           TIUDFN   Patient file (#2) IEN
 ;           TIUEDT   Episode Begin Date/Time
 ;           TIUHL    Hospital Location file (#44) IEN
 ; Output -- 0=Appointment is not associated with the Visit
 ;           1=Appointment is associated with the Visit
 N TIUAPPTF
 I $G(TIUVSIT),'$$BROKER^XWBLIB() D
 . S:$$VST2APPT^PXAPI(TIUVSIT)>0 TIUAPPTF=1
 ELSE  D
 . S:$$APPOINT^PXUTL1(TIUDFN,TIUEDT,TIUHL)>0 TIUAPPTF=1
 Q +$G(TIUAPPTF)
