DGWPT ; SLC/KCM/REV - Patient Lookup Functions ;3/20/02
 ;;5.3;Registration;**447,796**;Aug 13, 1993;Build 6
 ;
SELCHK(REC,DFN) ; Check for sensitive pt
 ; SENSITIVE
 S REC=$$EN1^DGQPT2(DFN)
 Q
DIEDON(VAL,DFN) ; Check for a date of death
 S VAL=+$G(^DPT(DFN,.35))
 Q
BYWARD(LST,WARD)        ; Return a list of patients in a ward
 N ILST,DFN
 I +$G(WARD)<1 S LST(1)="^No ward identified" Q
 S (ILST,DFN)=0
 S WARD=$P(^DIC(42,WARD,0),"^")   ;DBIA #36
 F  S DFN=$O(^DPT("CN",WARD,DFN)) Q:DFN'>0  D
 . S ILST=ILST+1,LST(ILST)=+DFN_U_$P(^DPT(+DFN,0),U)_U_$G(^DPT(+DFN,.101))
 I ILST<1 S LST(1)="^No patients found."
 Q
TOP(LST) ; Return top for all patients list (last selected for now)
 N IEN
 S IEN=$G(^DISV(DUZ,"^DPT("))
 I IEN S LST(1)=IEN_U_$P($G(^DPT(IEN,0)),U)
 Q
CLINRNG(LST) ; return date ranges for clinic appointments
 S LST(1)="T;T^Today"
 S LST(2)="T+1;T+1^Tomorrow"
 S LST(3)="T-1;T-1^Yesterday"
 S LST(4)="T-7;T^Past Week"
 S LST(5)="T-31;T^Past Month"
 S LST(6)="S^Specify Date Range..."
 Q
 ;
 N %,%H,X,SUNDAY,START
 S LST(1)=DT_";"_DT_"^Today",X=$$HTFM^XLFDT($H+1,1)
 S LST(2)=X_";"_X_"^Tomorrow"
 S X=+$H F  Q:X#7=3  S X=X-1                        ; $H#7=3 is Sunday
 S LST(3)=$$HTFM^XLFDT(X)_";"_$$HTFM^XLFDT(X+6)_"^This Week"
 S LST(4)=$$HTFM^XLFDT(X+7)_";"_$$HTFM^XLFDT(X+13)_"^Next Week"
 S LST(5)=$E(DT,1,5)_"01;"_$E(DT,1,5)_"31^This Month"
 S X=$E(DT,4,5)+1 S:X=13 X=1 S X=$E(DT,1,3)_$TR($J(X,2)," ",0)
 S LST(6)=X_"01;"_X_"31^Next Month"
 S LST(7)="^Specify Dates"
 Q
DFLTSRC(VAL) ; return default patient list source (T, W, C, P, S)
 N SRV S SRV=+$G(^VA(200,DUZ,5))
 S VAL=$$GET^XPAR("ALL^SRV.`"_SRV,"ORLP DEFAULT LIST SOURCE")
 Q
SAVDFLT(OK,X) ; save new default patient list settings (X=type^ien^sdt;edt)
 G SAVDFLT^DGWPT1
 ;
SELECT(REC,DFN) ; Selects patient & returns key information
 ;  1    2   3   4    5      6    7    8       9       10      11  12
 ; NAME^SEX^DOB^SSN^LOCIEN^LOCNM^RMBD^CWAD^SENSITIVE^ADMITTED^CONV^SC^
 ; 13  14  15  16
 ; SC%^ICN^AGE^TS
 N X
 K ^TMP("DGWPCE",$J) ; delete PCE 'cache' when switching patients
 S X=^DPT(DFN,0),REC=$P(X,U,1,3)_U_$P(X,U,9)_U_U_$G(^(.1))_U_$G(^(.101))
 S X=$P(REC,U,6) I $L(X) S $P(REC,U,5)=+$G(^DIC(42,+$O(^DIC(42,"B",X,0)),44))
 S $P(REC,U,8)=$$CWAD^DGQPT2(DFN)_U_$$EN1^DGQPT2(DFN)
 ; I $P(REC,U,9) D EN2^DGQPT2(DFN)  ;update DG security log ; DG249
 S X=$G(^DPT(DFN,.105)) I X S $P(REC,U,10)=$P($G(^DGPM(X,0)),U)
 S:'$D(IOST) IOST="P-OTHER"
 S $P(REC,U,11)=0
 D ELIG^VADPT S $P(REC,U,12)=$G(VAEL(3)) ;two pieces: SC^SC%
 I $L($T(GETICN^MPIF001)) S X=+$$GETICN^MPIF001(DFN) S:X>0 $P(REC,U,14)=X
 S $P(REC,U,15)=$$AGE(DFN,$P(REC,U,3))
 S $P(REC,U,16)=+$G(^DPT(DFN,.103)) ; treating specialty
 K VAEL,VAERR ;VADPT call to kill?
 S ^DISV(DUZ,"^DPT(")=DFN
 Q
 ;
AGE(DFN,BEG)    ; returns age based on date of birth and date of death (or DT)
 N END,X
 S END=+$G(^DPT(DFN,.35)),END=$S(END:END,1:DT)
 S X=$E(END,1,3)-$E(BEG,1,3)-($E(END,4,7)<$E(BEG,4,7))
 Q X
